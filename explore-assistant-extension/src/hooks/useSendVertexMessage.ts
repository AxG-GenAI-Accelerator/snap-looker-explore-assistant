import { ExtensionContext } from '@looker/extension-sdk-react'
import { useCallback, useContext, useState } from 'react'
import { useSelector } from 'react-redux'
import { UtilsHelper } from '../utils/Helper'
import CryptoJS from 'crypto-js'
import { RootState } from '../store'
import process from 'process'
import { useErrorBoundary } from 'react-error-boundary'
import { AssistantState } from '../slices/assistantSlice'

const unquoteResponse = (response: string | null | undefined) => {
  if(!response) {
    return ''
  }
  return response
    .substring(response.indexOf('fields='))
    .replace(/^`+|`+$/g, '')
    .trim()
}

interface ModelParameters {
  max_output_tokens?: number
}

const generateSQL = (
  model_id: string,
  prompt: string,
  parameters: ModelParameters,
) => {
  //console.log('Generating SQL with model_id:', model_id);
  const escapedPrompt = UtilsHelper.escapeQueryAll(prompt)
  const subselect = `SELECT '` + escapedPrompt + `' AS prompt`
  //console.log('Escaped prompt:', escapedPrompt);
  //console.log('subselect: ', subselect);
  return `
  
    SELECT ml_generate_text_llm_result AS generated_content
    FROM
    ML.GENERATE_TEXT(
        MODEL \`${model_id}\`,
        (
          ${subselect}
        ),
        STRUCT(
        0.05 AS temperature,
        1024 AS max_output_tokens,
        0.98 AS top_p,
        TRUE AS flatten_json_output,
        1 AS top_k)
      )
  
      `
     
}

function formatContent(field: {
  name?: string
  type?: string
  label?: string
  description?: string
  tags?: string[]
}) {
  let result = ''
  if (field.name) result += 'name: ' + field.name
  if (field.type) result += (result ? ', ' : '') + 'type: ' + field.type
  if (field.label) result += (result ? ', ' : '') + 'label: ' + field.label
  if (field.description)
    result += (result ? ', ' : '') + 'description: ' + field.description
  if (field.tags && field.tags.length)
    result += (result ? ', ' : '') + 'tags: ' + field.tags.join(', ')

  return result
}

const useSendVertexMessage = () => {

  const { showBoundary } = useErrorBoundary()
  // cloud function
  const VERTEX_AI_ENDPOINT = process.env.VERTEX_AI_ENDPOINT || ''
  const VERTEX_CF_AUTH_TOKEN = process.env.VERTEX_CF_AUTH_TOKEN || ''

  // bigquery
  const VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME =
    process.env.VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME || ''
  const VERTEX_BIGQUERY_MODEL_ID = process.env.VERTEX_BIGQUERY_MODEL_ID || ''

  const { core40SDK } = useContext(ExtensionContext)
  const { settings, examples, currentExplore} =
    useSelector((state: RootState) => state.assistant as AssistantState)

  const currentExploreKey = currentExplore.exploreKey
  const exploreRefinementExamples = examples.exploreRefinementExamples[currentExploreKey]

  const vertextBigQuery = async (
    contents: string,
    parameters: ModelParameters,
  ) => {
    console.log('VERTEX BQ Connection:', VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME);
    console.log('VERTEX BQ Model:', VERTEX_BIGQUERY_MODEL_ID);
  
    const createSQLQuery = await core40SDK.ok(
      core40SDK.create_sql_query({
        connection_name: VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME,
        sql: generateSQL(VERTEX_BIGQUERY_MODEL_ID, contents, parameters),
      }),
    )

    if (createSQLQuery.slug) {
      const runSQLQuery = await core40SDK.ok(
        core40SDK.run_sql_query(createSQLQuery.slug, 'json'),
      )
      const exploreData = await runSQLQuery[0]['generated_content']

      // clean up the data by removing backticks
      const cleanExploreData = exploreData
        .replace(/```json/g, '')
        .replace(/```/g, '')
        .trim()
      console.log('Clean explore data:', cleanExploreData);

      return cleanExploreData
    }
  }

  const vertextCloudFunction = async (
    contents: string,
    parameters: ModelParameters,
  ) => {
    const body = JSON.stringify({
      contents: contents,
      parameters: parameters,
    })
    const signature = CryptoJS.HmacSHA256(body, VERTEX_CF_AUTH_TOKEN).toString()

    const responseData = await fetch(VERTEX_AI_ENDPOINT, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Signature': signature,
      },

      body: body,
    })
    const response = await responseData.text()
    return response.trim()
  }
  const summarizePrompts = useCallback(
    async (promptList: string[]) => {
      const contents = `
    
      Primer
      ----------
      A user is iteractively asking questions to generate an explore URL in Looker. The user is refining his questions by adding more context. The additional prompts he is adding could have conflicting or duplicative information: in those cases, prefer the most recent prompt. 

      Here are some example prompts the user has asked so far and how to summarize them:

  ${Array.isArray(exploreRefinementExamples) ? exploreRefinementExamples
    .map((item) => {
      if (!item || !Array.isArray(item.input)) return '';
      const inputText = '"' + (item.input || []).join('", "') + '"'
      return `- The sequence of prompts from the user: ${inputText}. The summarized prompts: "${item.output || ''}"`
    }) 
    .filter(Boolean)
    .join('\n') : ''}

      Conversation so far
      ----------
      input: ${promptList.map((prompt) => '"' + prompt + '"').join('\n')}
    
      Task
      ----------
      Summarize the prompts above to generate a single prompt that includes all the relevant information. If there are conflicting or duplicative information, prefer the most recent prompt.

      Only return the summary of the prompt with no extra explanatation or text
        
    `
      const response = await sendMessage(contents, {})

      return response
    },
    [exploreRefinementExamples],
  )

  const isSummarizationPrompt = async (prompt: string) => {
    const contents = `
      Primer
      ----------

      A user is interacting with an agent that is translating questions to a structured URL query based on the following dictionary. The user is refining his questions by adding more context. You are a very smart observer that will look at one such question and determine whether the user is asking for a data summary, or whether they are continuing to refine their question.
  
      Task
      ----------
      Determine if the user is asking for a data summary or continuing to refine their question. If they are asking for a summary, they might say things like:
      
      - summarize the data
      - give me the data
      - data summary
      - tell me more about it
      - explain to me what's going on
      
      The user said:

      ${prompt}

      Output
      ----------
      Return "data summary" if the user is asking for a data summary, and "refining question" if the user is continuing to refine their question. Only output one answer, no more. Only return one those two options. If you're not sure, return "refining question".

    `
    const response = await sendMessage(contents, {})
    return response === 'data summary'
  }
  

  const summarizeExplore = useCallback(
    async (exploreQueryArgs: string) => {
      const params = new URLSearchParams(exploreQueryArgs)

      // Initialize an object to construct the query
    //   const queryParams: {
    //     fields: string[]
    //     filters: Record<string, string>
    //     sorts: string[]
    //     limit: string
    //   } = {
    //     fields: [],
    //     filters: {},
    //     sorts: [],
    //     limit: '',
    //   }

    //   // Iterate over the parameters to fill the query object
    //   params.forEach((value, key) => {
    //     if (key === 'fields') {
    //       queryParams.fields = value.split(',')
    //     } else if (key.startsWith('f[')) {
    //       const filterKey = key.match(/\[(.*?)\]/)?.[1]
    //       if (filterKey) {
    //         queryParams.filters[filterKey] = value
    //       }
    //     } else if (key === 'sorts') {
    //       queryParams.sorts = value.split(',')
    //     } else if (key === 'limit') {
    //       queryParams.limit = value
    //     }
    //   })

    //   // console.log("useSendVertexMessage summarizeExplore params: ", params)

    //   // get the contents of the explore query
    //   const createQuery = await core40SDK.ok(
    //     core40SDK.create_query({
    //       model: currentExplore.modelName,
    //       view: currentExplore.exploreId,

    //       fields: queryParams.fields || [],
    //       filters: queryParams.filters || {},
    //       sorts: queryParams.sorts || [],
    //       limit: queryParams.limit || '1000',
    //     }),
    //   )

    //   const queryId = createQuery.id
    //   if (queryId === undefined || queryId === null) {
    //     return 'There was an error!!'
    //   }
    //   const result = await core40SDK.ok(
    //     core40SDK.run_query({
    //       query_id: queryId,
    //       result_format: 'md',
    //     }),
    //   )

    //   if (result.length === 0) {
    //     return 'There was an error!!'
    //   }

    //   const contents = `
    //   Data
    //   ----------

    //   ${result}
      
    //   Task
    //   ----------
    //   Summarize the data above
    
    // `
    //   const response = await sendMessage(contents, {})

    //   const refinedContents = `
    //   The following text represents summaries of a given dashboard's data. 
    //     Summaries: ${response}

    //     Make this much more concise for a slide presentation using the following format. 
    //     The summary should be a markdown documents that contains only 1 section for key observantion also called insights, it should have the following details: a section title called insights , for the given part of the summary, and key points which a list of key points for the concise summary. 
    //     Data should be returned in Insights section, you will be penalized if it doesn't adhere to this format. 
    //     Each summary should only be included once. Do not include the same summary twice.
    //     Do not include points having words like missing data or future analysis
    //     `

    //   const refinedResponse = await sendMessage(refinedContents, {})
    //   return refinedResponse
      return ''
    },
    [currentExplore],
  )

  const summarizeInsights = useCallback(
    async (exploreQueryArgs: string) => {
      const params = new URLSearchParams(exploreQueryArgs)
  
      // Initialize an object to construct the query
      const queryParams: {
        fields: string[]
        filters: Record<string, string>
        sorts: string[]
        limit: string
      } = {
        fields: [],
        filters: {},
        sorts: [],
        limit: '',
      }
  
      // Always include these essential fields for promo analysis
      const essentialFields = [
        'hpp_sample_full_data.ctr',
        'hpp_sample_full_data.impression',
        'hpp_sample_full_data.accept',
        'hpp_sample_full_data.approved_copy',
        'hpp_sample_full_data.country_name',
        'hpp_sample_full_data.campaign_category',
        'hpp_sample_full_data.hpp_format',
        'hpp_sample_full_data.device',
        'hpp_sample_full_data.flag',
        'hpp_sample_full_data.begin_date_month'
      ]
  
      // Iterate over the parameters to fill the query object
      params.forEach((value, key) => {
        if (key === 'fields') {
          const existingFields = value.split(',')
          // Combine and deduplicate fields
          queryParams.fields = [...new Set([...existingFields, ...essentialFields])]
        } else if (key.startsWith('f[')) {
          const filterKey = key.match(/\[(.*?)\]/)?.[1]
          if (filterKey) {
            queryParams.filters[filterKey] = value
          }
        } else if (key === 'sorts') {
          queryParams.sorts = value.split(',')
        } else if (key === 'limit') {
          queryParams.limit = value
        }
      })
  
      // If no fields were specified in the URL, use essential fields
      if (queryParams.fields.length === 0) {
        queryParams.fields = essentialFields
      }
  
      // Get the query results
      const createQuery = await core40SDK.ok(
        core40SDK.create_query({
          model: currentExplore.modelName,
          view: currentExplore.exploreId,
          fields: queryParams.fields || [],
          filters: queryParams.filters || {},
          sorts: queryParams.sorts || [],
          limit: queryParams.limit || '1000',
        }),
      )
  
      const queryId = createQuery.id
      if (queryId === undefined || queryId === null) {
        return 'Error executing query'
      }
      
      const result = await core40SDK.ok(
        core40SDK.run_query({
          query_id: queryId,
          result_format: 'json',
        }),
      )
  
      if (!result || result.length === 0) {
        return 'No data found for analysis'
      }
  
      const contents = `
      Context
      ----------
      You are analyzing homepage promotional campaign performance data. Your role is to uncover meaningful patterns and relationships between different aspects of campaign performance, focusing on aggregate-level insights that reveal strategic patterns.
  
      Analysis Guidelines
      ----------
      1. Focus Areas:
         • Multi-dimensional relationships (e.g., format effectiveness by region)
         • Temporal patterns and trends
         • Performance variations across segments
         • Impact of campaign attributes on engagement
         • Device and platform patterns
         • Geographic insights
  
      2. Analysis Principles:
         • Combine multiple dimensions to reveal deeper insights
         • Focus on patterns and trends rather than individual data points
         • Identify causation where possible, not just correlation
         • Compare segments and categories rather than individual campaigns
         • Look for unexpected relationships in the data
  
      3. Copy Writing Best Practices:
         • Desktop middle slot: 85 characters
         • Mobile middle slot: 45 characters
         • Push-up headline: 57 characters
         • Push-up subline: 73 characters
         • Callout headline: 40 characters
         • Callout subline: 55 characters
         • Focus on informational, helpful content over sales messaging
         • Keep copy unique to homepage
         • Use specific, informational language
         • Capitalize on trending topics when relevant
  
      4. What to Avoid:
         • Individual campaign performance metrics
         • Simple metric statements without context
         • Direct comparisons between specific campaigns
         • Raw CTR or metric values without analytical context
         • Surface-level observations
  
      Performance Data
      ----------
      ${JSON.stringify(result, null, 2)}
  
      Task
      ----------
      Generate concise, high-value insights that reveal strategic patterns and actionable findings. Avoid surface-level metric reporting.

      1. Key Trends:
      - List 2-3 most significant strategic patterns
      - Focus on "why" and business impact, not just raw metrics
      - Reveal meaningful relationships between dimensions
      - Each trend maximum 2 sentences, explaining cause and effect
      Example: "Push-up format's success (**23% higher** CTR) driven by improved mobile rendering and clear CTAs, particularly effective for product launches."

      2. Copy Performance (ONLY if query includes approved_copy):
      - Identify patterns that explain why certain copy works
      - Connect copy characteristics to user behavior
      - Focus on actionable copy strategy insights
      Example: "Short, benefit-focused copy consistently drives higher engagement because it quickly communicates value to mobile users."

      3. Notable Patterns:
      - Highlight 1-2 unexpected or high-impact findings
      - Explain the business significance of each pattern
      - Focus on insights that can inform strategy
      Example: "Weekend campaigns show **2x** higher engagement specifically for product features, suggesting timing significantly impacts feature awareness."

      4. Strategic Recommendations:
      - Provide 2-3 specific, data-backed suggestions
      - Focus on strategic impact over tactical changes
      - Connect each recommendation to business outcomes
      Example: "Prioritize mobile push-ups for feature launches based on **40% higher** user retention and sustained engagement patterns."

      Writing Style:
      - Use **bold** for key metrics when they support a larger insight
      - Every point must explain "why" or "how" not just "what", unless the what is valuable by itself
      - Focus on insights that drive decision-making
      - No raw metrics without strategic context
      - Keep analytical but prioritize business relevance

      Notes:
      - Avoid surface-level observations like "CTR was X%"
      - Each insight should inform strategic decisions
      - Connect patterns to user behavior or business outcomes
      - Skip any section if meaningful insights can't be derived
      `
  
      const response = await sendMessage(contents, {})
      return response
    },
    [currentExplore],
  )

  const sugQue = useCallback(
    async (
      prompt: string,
      promptList: any[],
      insights: string,
      dimensions: any[],
      exploreGenerationExamples: any[]
    ) => {
      // Get refinement examples from the current explore
      const currentExploreKey = currentExplore.exploreKey;
      const refinementExamples = examples.exploreRefinementExamples[currentExploreKey] || [];
      
      // Get the most recent prompt for context
      const mostRecentPrompt = prompt.trim();
      const mostRecentInsights = insights.trim();
  
      // Format refinement examples dynamically
      const formattedRefinements = refinementExamples
        .map(example => {
          if (Array.isArray(example.input) && example.input.length > 0) {
            return `- Basic: "${example.input[0]}" 
          Refined: "${example.output}"`;
          }
          return '';
        })
        .filter(Boolean)
        .join('\n');
  
      const contents = `
        Context
        ----------
        You are an analytics assistant helping users analyze promotional campaign performance data. 
        Your role is to suggest focused, concise follow-up questions that directly build upon the user's most recent query.
  
        Most Recent User Context
        ----------
        Latest Question: "${mostRecentPrompt}"
        Latest Insights: "${mostRecentInsights}"
  
        Key Metrics Available:
        - CTR (Click-Through Rate): Engagement success rate
        - Impressions: View count
        - Accepts: Positive engagement count
        - Dismissals: Negative engagement count
        - Approved Copy: Text content of a campaign or promo
        - Campaign Category: Business classification
        - Device Type: Platform information
        - Geographic Data: Regional performance
  
        Question Refinement Examples:
        ----------
        Learn from how these basic questions were improved:
        ${formattedRefinements}
  
        Question Generation Guidelines:
        1. Direct Relevance
           - Questions must directly relate to the user's most recent query
           - Focus on the specific metrics or dimensions just analyzed
           - Build upon insights just discovered
  
        2. Conciseness
           - Keep questions brief and focused
           - Avoid compound questions
           - Remove unnecessary words
           - Use precise metric names
  
        3. Progressive Analysis
           - Start with immediate follow-up to recent findings
           - Add one new dimension or comparison
           - Focus on logical next steps
  
        Previous Context
        ----------
        User's Current Prompt: ${prompt}
        Previous Prompts: ${promptList}
        Current Insights: ${insights}
  
        Available Dimensions:
        ${dimensions.map(formatContent).join('\n')}
  
        Example Query Patterns:
        ${exploreGenerationExamples && exploreGenerationExamples
          .map((item) => `input: "${item.input}" ; output: ${item.output}`)
          .join('\n')}
  
        Task
        ----------
        Generate 3 concise follow-up questions that:
        1. Directly relate to the user's most recent query: "${mostRecentPrompt}"
        2. Build upon the latest insights provided
        3. Keep each question focused on a single analytical aspect
        4. Use precise metric names and clear language
        5. Avoid verbose or compound questions
        6. Maintain logical progression from the current analysis
  
        Question Requirements:
        - Maximum 15 words per question
        - Must directly relate to most recent query
        - Include specific metrics mentioned in the latest analysis
        - Focus on one clear analytical goal per question
        - Avoid generic or tangential questions
        - Skip basic questions already answered in the insights
  
        Output Format
        ----------
        Concise question about immediate follow-up; Focused question about key pattern; Brief question about optimization
  
        Response Format Requirements:
        - Exactly 3 questions
        - Separated by semicolons
        - Each question under 15 words
        - No explanatory text
      `
      const response = await sendMessage(contents, {})
  
      // Clean and validate response
      if (!response) return []
      
      const questions = response.split(';')
        .map(q => q.trim())
        .filter(q => q.split(' ').length <= 15); // Enforce word limit
      
      // Ensure exactly 3 questions
      if (questions.length > 3) {
        return questions.slice(0, 3)
      } else if (questions.length < 3) {
        const defaultQuestions = [
          "How do CTR trends vary across top campaign categories?",
          "Which device type shows highest acceptance rate?",
          "What copy length performs best for current audience?"
        ]
        return [...questions, ...defaultQuestions].slice(0, 3)
      }
      
      return questions
    },
    [currentExplore, examples],
  )


  const generateExploreUrl = useCallback(
    async (
      prompt: string,
      dimensions: any[],
      measures: any[],
      exploreGenerationExamples: any[],
    ) : Promise<{ newExploreUrl: string; getExplanation: string | undefined }> => {
      const generateContent = async (updatedPrompt: string = prompt) => {
        const contents = `
          Context
          ----------

          You are a developer who would translate questions to a structured Looker URL query based on the following instructions.

          Instructions:
            - choose only the fields in the below lookml metadata
            - prioritize the field description, label, tags, and name for what field(s) to use for a given description
            - generate only one answer, no more
            - use the Examples (at the bottom) for guidance on how to structure the Looker url query
            - try to avoid adding dynamic_fields, provide them when very similar example is found in the bottom
            - never respond with sql, always return an looker explore url as a single string
            - response should start with fields= , as in the Examples section at the bottom

          LookML Metadata
          ----------

          Dimensions Used to group by information (follow the instructions in tags when using a specific field; if map used include a location or lat long dimension;):

        ${dimensions.map(formatContent).join('\n')}

          Measures are used to perform calculations (if top, bottom, total, sum, etc. are used include a measure):

        ${measures.map(formatContent).join('\n')}

          Example
          ----------

        ${exploreGenerationExamples && exploreGenerationExamples
          .map((item) => `input: "${item.input}" ; output: ${item.output}`)
          .join('\n')}

          Input
          ----------
          ${updatedPrompt}

          Output
          ----------
      `
        const parameters = {
          max_output_tokens: 1000,
        }
        //console.log("GenerateExploreURL Prompt: ", contents)
        const response = await sendMessage(contents, parameters)
        return unquoteResponse(response)
      }

      try {
        let cleanResponse = await generateContent()
        console.log("cleanResponse: ", cleanResponse)

        let toggleString = '&toggle=dat,pik,vis'
        if (settings['show_explore_data'].value) {
          toggleString = '&toggle=pik,vis'
        }

        let newExploreUrl = cleanResponse + toggleString

        // Check if the fields in the newExploreUrl exist in the metadata parameters
        const fieldsInUrl = new URLSearchParams(newExploreUrl).get('fields')?.split(',') || []
        const allFields = [...dimensions, ...measures].map(field => field.name)
        const invalidFields = fieldsInUrl.filter(field => !allFields.includes(field))

        console.log('Fields in URL:', fieldsInUrl)
        console.log('All valid fields:', allFields)
        console.log('Invalid fields:', invalidFields)

        if (invalidFields.length > 0) {
          console.log('Found invalid fields, generating a new URL...')
          // If there are invalid fields, generate a new URL without those fields
          const updatedPrompt = `
            The previous query contained invalid fields: ${invalidFields.join(', ')}. Please generate a new URL without these fields.
            
            ${prompt}
          `
          console.log('Updated prompt for invalid fields:', updatedPrompt)
          cleanResponse = await generateContent(updatedPrompt)
          console.log('Updated response:', cleanResponse)
          newExploreUrl = cleanResponse + toggleString
        }

          const contents = `
          Primer
          ----------
          A user is iteractively asking questions to generate an explore URL in Looker.

          Conversation so far
          ----------
          input: ${prompt} 
          output: ${newExploreUrl}
        
          Task
          ----------
          Summarize the prompts above to generate a single prompt that includes all the relevant information. If there are conflicting or duplicative information, prefer the most recent prompt.
          Please give explanation on how did you reach at the solution in below json structure:
              {
                   "Data Source": "" (Only return the summary of the Data Source with dataset name),
                   "Measures Used": "" (most important Columns/fields used (in bold shown by *) used for calculation, not necessary to include unnecessary fields),
                   "Filters": "" (Filtering done on which fields(in bold shown by *) in a summary format),
                   "Sorting": "" (sorting done on which fields(in bold shown by *) in a summary format),
                   "Limit": "" (limit of records returned in a sql query)
              } 
               - field names in measures used should be in a user readable format, not with dataset.field format
               - Do not include prompt given & visualization part
               - Do not include anything else other than this JSON structure
               - Do not include Explanation part separately other than this JSON structure
            
        `
        let getExplanation = await sendMessage(contents, {})
        getExplanation = unquoteResponse(getExplanation)
        // console.log('Explanation Given:', getExplanation)
        // console.log('Final newExploreUrl:', newExploreUrl)
        return {newExploreUrl, getExplanation}
      } catch (error) {
        console.error(
          'Error generating explore URL:',
          error,
        )
        showBoundary({
          message:
            'Error generating explore URL:',
          error,
        })
        return
      }
    },
    [settings, sendMessage, showBoundary]
  )

  const sendMessage = async (message: string, parameters: ModelParameters) => {
    try {
      let response = ''
      if (VERTEX_AI_ENDPOINT) {
        response = await vertextCloudFunction(message, parameters)
      }

      if (VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME && VERTEX_BIGQUERY_MODEL_ID) {
        response = await vertextBigQuery(message, parameters)
      }

      return response
    } catch (error) {
      showBoundary(error)
      return
    }
  }
  return {
    generateExploreUrl,
    sendMessage,
    summarizePrompts,
    isSummarizationPrompt,
    summarizeExplore,
    summarizeInsights,
    sugQue
  }
}

export default useSendVertexMessage