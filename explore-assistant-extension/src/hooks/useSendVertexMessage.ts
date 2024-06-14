import { ExtensionContext } from '@looker/extension-sdk-react'
import { useCallback, useContext } from 'react'
import { useSelector } from 'react-redux'
import { UtilsHelper } from '../utils/Helper'
import CryptoJS from 'crypto-js'
import { RootState } from '../store'
import process from 'process'

interface ModelParameters {
  max_output_tokens?: number
}

const generateSQL = (
  model_id: string,
  prompt: string,
  parameters: ModelParameters,
) => {
  const escapedPrompt = UtilsHelper.escapeQueryAll(prompt)
  const subselect = `SELECT '` + escapedPrompt + `' AS prompt`

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
  description?: string
  tags?: string[]
}) {
  let result = ''
  if (field.name) result += 'name: ' + field.name
  if (field.type) result += (result ? ', ' : '') + 'type: ' + field.type
  if (field.description)
    result += (result ? ', ' : '') + 'description: ' + field.description
  if (field.tags && field.tags.length)
    result += (result ? ', ' : '') + 'tags: ' + field.tags.join(',')

  return result
}

const useSendVertexMessage = () => {
  // cloud function
  const VERTEX_AI_ENDPOINT = process.env.VERTEX_AI_ENDPOINT || ''
  const VERTEX_CF_AUTH_TOKEN = process.env.VERTEX_CF_AUTH_TOKEN || ''

  // bigquery
  const VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME =
    process.env.VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME || ''
  const VERTEX_BIGQUERY_MODEL_ID = process.env.VERTEX_BIGQUERY_MODEL_ID || ''

  const { core40SDK } = useContext(ExtensionContext)
  const { dimensions, measures, messageThread, exploreName, modelName } =
    useSelector((state: RootState) => state.assistant)

  const { exploreGenerationExamples, exploreRefinementExamples } = useSelector(
    (state: RootState) => state.assistant.examples,
  )

  const vertextBigQuery = async (
    contents: string,
    parameters: ModelParameters,
  ) => {
    console.log('VERTEX BQ Connection:', VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME);
    console.log('VERTEX BQ Model:', VERTEX_BIGQUERY_MODEL_ID);
  
  
    try {
      const generatedSQL = generateSQL(VERTEX_BIGQUERY_MODEL_ID, contents, parameters);
      console.log('Generated SQL query:', generatedSQL);

      const createSQLQuery = await core40SDK.ok(
        core40SDK.create_sql_query({
          connection_name: VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME,
          sql: generatedSQL,
        }),
      );
  
      
      console.log('create_sql_query response:', createSQLQuery);
  
      if (createSQLQuery.slug) {
        console.log('create_sql_query slug:', createSQLQuery.slug);
  //something in here is throwing an error but it doesn't break stuff
        try {
          const runSQLQuery = await core40SDK.ok(
            core40SDK.run_sql_query(createSQLQuery.slug, 'json'),
          );
  
          console.log('run_sql_query response:', runSQLQuery);
          console.log('runSQLQuery[0] generated content - useSendVertexMessage:',runSQLQuery[0]['generated_content']);
          if (runSQLQuery.length > 0 && runSQLQuery[0]['generated_content']) {
            const exploreData = await runSQLQuery[0]['generated_content'];
            console.log('Explore data:', exploreData);
  
            // clean up the data by removing backticks
            const cleanExploreData = exploreData.replace(/```json/g, '').replace(/```/g, '').trim();
            console.log('Clean explore data:', cleanExploreData);
  //trying to force output
            return cleanExploreData;
          } else {
            console.error('Invalid run_sql_query response:', runSQLQuery);
            throw new Error('Failed to retrieve generated content from run_sql_query');
          }
        } catch (error) {
          console.error('Error running SQL query:', error);
          throw error;
        }
      } else {
        console.error('createSQLQuery.slug is undefined or empty');
        throw new Error('Failed to create SQL query');
      }
    } catch (error) {
      console.error('Error in vertextBigQuery:', error);
      throw error;
    }
  };
 /*og
  const vertextBigQuery = async (
    contents: string,
    parameters: ModelParameters,
  ) => {
    try {
      console.log('Generated SQL query:', generateSQL(VERTEX_BIGQUERY_MODEL_ID, contents, parameters));

      const createSQLQuery = await core40SDK.ok(
        core40SDK.create_sql_query({
          connection_name: VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME,
          sql: generateSQL(VERTEX_BIGQUERY_MODEL_ID, contents, parameters),
        }),
      );

      console.log('create_sql_query slug:', createSQLQuery.slug);

      if (createSQLQuery.slug) {
        const runSQLQuery = await core40SDK.ok(
          core40SDK.run_sql_query(createSQLQuery.slug, 'json'),
        );
       //THIS IS WHERE ERROR OCCURS IN RAW SCRIPT
      const exploreData = await runSQLQuery[0]['generated_content']

        // clean up the data by removing backticks
        const cleanExploreData = exploreData.replace(/```json/g, '').replace(/```/g, '').trim();
      console.log("clean explore data", cleanExploreData)

        return cleanExploreData;
      } else {
        console.error('createSQLQuery.slug is undefined or empty');
        throw new Error('Failed to create SQL query');
      }
      
     

      //const exploreData = 'https://accenture.looker.com/explore/lookertestv8/lookertestv8/ice_store_performance?fields\u003dlookertestv8.ice_store_id,lookertestv8.city,lookertestv8.latitude,lookertestv8.longitude\u0026sorts\u003dlookertestv8.past_pixel_sales__percentile_'
      //'https://accenture.looker.com/explore/lookertestv8/lookertestv8/stores?fields\u003dlookertestv8.ice_store_id,lookertestv8.city\u0026sorts\u003dlookertestv8.count%20desc\u0026limit\u003d5' /*await runSQLQuery[0]['generated_content']
      

      //const cleanExploreData = exploreData.replace(/```json/g, '').replace(/```/g, '').trim();
      //console.log("clean explore data", cleanExploreData)
    //return cleanExploreData
    } catch (error) {
      console.error('Error in vertextBigQuery:', error);
      throw error;
    }
  }
*/
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

  const summarizePrompts = useCallback(async (promptList: string[]) => {
    const contents = `
    
      Primer
      ----------
      A user is iteractively asking questions to generate an explore URL in Looker. The user is refining his questions by adding more context. The additional prompts he is adding could have conflicting or duplicative information: in those cases, prefer the most recent prompt. 

      Here are some example prompts the user has asked so far and how to summarize them:

${exploreRefinementExamples
  .map((item) => {
    const inputText = '"' + item.input.join('", "') + '"'
    return `- The sequence of prompts from the user: ${inputText}. The summarized prompts: "${item.output}"`
  })
  .join('\n')}

      Conversation so far
      ----------
      input: ${promptList.map((prompt) => '"' + prompt + '"').join('\n')}
    
      Task
      ----------
      Summarize the prompts above to generate a single prompt that includes all the relevant information. If there are conflicting or duplicative information, prefer the most recent prompt.
    
      Answer
      ----------
    
    `
    const response = await sendMessage(contents, {})

    return response
  }, [exploreRefinementExamples])

  const sendMessageWithThread = useCallback(
    async (prompt: string) => {
      const messageHistoryContents = messageThread
        .slice(-20)
        .map((message) => {
          if ('exploreUrl' in message) {
            return
          }
          return `${message.actor}: ${message.message}`
        })
        .join('\n')

      const contents = `

      Conversation so far
      ----------

      ${messageHistoryContents}

      Question
      ---------
      ${prompt}

      Answer
      ----------
    `

      const response = await sendMessage(contents, {})
      return response
    },
    [messageThread],
  )

  const isSummarizationPrompt = async (prompt: string) => {
    const contents = `
      Primer
      ----------

      A user is interacting with an agent that is translating questions to a structured URL query based on the provided LookML metadata. The user is refining their questions by adding more context. You are a very smart observer that will look at one such question and determine whether the user is asking for a data summary or whether they are continuing to refine their question.

      Instructions:

      Choose only the fields in the provided LookML metadata.
      Prioritize the field description, label, tags, and name for what field(s) to use for a given description.
      Generate only one answer, no more.
      Use the Examples for guidance on how to structure the Looker URL query.
      Never respond with SQL; always return a Looker explore URL as a single string.
      There will never be any mention of store_name as a dimension.
      All URLs should mention the lookertestv8 database followed by the desired dimension, for example, lookertestv8.footfall. It will always be lookertestv8.
      Some refinements can be filter changes, requests to sort in a new way, or requests to add more dimensions.
      If a change in visualization is requested, note that the new visualization might require necessary dimensions or the removal of dimensions for it to work properly.
      If a specific visualization is mentioned, prioritize that and adjust the URL query accordingly to ensure the visualization works.

      Task
      ----------
      Determine if the user is asking for a data summary or continuing to refine their question. If they are asking for a summary, they might say things like:
      
      - summarize the data
      - give me the data
      - data summary
      - tell me more about it
      - explain to me what's going on
      - summarization
      - summarize
      - summary
      
      The user said:

      ${prompt}

      Output
      ----------
      Return "data summary" if the user is asking for a data summary, and "refining question" if the user is continuing to refine their question. Only output one answer, no more. Only return one those two options. If you're not sure, return "refining question".

    `
    const response = await sendMessage(contents, {})
    return response === 'data summary'
  }

  const isDataQuestionPrompt = async (prompt: string) => {
    return false
  }

  const summarizeExplore = useCallback(
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

      // Iterate over the parameters to fill the query object
      params.forEach((value, key) => {
        if (key === 'fields') {
          queryParams.fields = value.split(',')
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

      // get the contents of the explore query
      const createQuery = await core40SDK.ok(
        core40SDK.create_query({
          model: modelName,
          view: exploreName,

          fields: queryParams.fields || [],
          filters: queryParams.filters || {},
          sorts: queryParams.sorts || [],
          limit: queryParams.limit || '1000',
        }),
      )

      const queryId = createQuery.id
      if (queryId === undefined || queryId === null) {
        return 'There was an error!!'
      }
      const result = await core40SDK.ok(
        core40SDK.run_query({
          query_id: queryId,
          result_format: 'md',
        }),
      )

      if (result.length === 0) {
        return 'There was an error!!'
      }

      const contents = `
      Data
      ----------

      ${result}
      
      Task
      ----------
      Summarize the data above
    
    `
      const response = await sendMessage(contents, {})

      const refinedContents = `
      The following text represents summaries of a given dashboard's data. 
        Summaries: ${response}

        Make this much more concise for a slide presentation using the following format. The summary should be a markdown documents that contains a list of sections, each section should have the following details:  a section title, which is the title for the given part of the summary, and key points which a list of key points for the concise summary. Data should be returned in each section, you will be penalized if it doesn't adhere to this format. Each summary should only be included once. Do not include the same summary twice.
        `

      const refinedResponse = await sendMessage(refinedContents, {})
      return refinedResponse
    },
    [exploreName, modelName],
  )

  const generateExploreUrl = useCallback(
    async (prompt: string) => {
      const contents = `
        Context
        ----------
    
        You are a developer who translates conversational questions into structured Looker URL queries based on the following instructions. The user can ask new questions or refine their previous questions by giving more context. This can require the addtion or removal of dimensions. You are a very smart observer that will look at one such question and determine whether the user is asking for a data summary or whether they are continuing to refine their question.
        
        Instructions:
        - Choose only the fields in the provided LookML metadata.
        - Prioritize the field description, label, tags, and name for what field(s) to use for a given description.
        - Generate only one answer, no more.
        - Use the Examples for guidance on how to structure the Looker URL query.
        - Never respond with SQL; always return a Looker explore URL as a single string.
        - There will never be any mention of store_name as a dimension.
        - All URLs should mention the lookertestv8 database followed by the desired dimension, for example, lookertestv8.footfall. It will always be lookertestv8.
        - Some refinements can be filter changes, requests to sort in a new way, or requests to add more dimensions.
        - If a change in visualization is requested, note that the new visualization might require necessary dimensions or the removal of dimensions for it to work properly.
        - If a specific visualization is mentioned, prioritize that and adjust the URL query accordingly to ensure the visualization works.
    
        LookML Metadata
        ----------
    
        Dimensions Used to group by information (follow the instructions in tags when using a specific field; if map used include a location or lat long dimension;):
          
      ${dimensions.map(formatContent).join('\n')}
          
        Measures are used to perform calculations (if top, bottom, total, sum, etc. are used include a measure):
      
      ${measures.map(formatContent).join('\n')}
    
        Example
        ----------
    
      ${exploreGenerationExamples
        .map(
          (item) =>
            `input: "${item.input}" ; output: ${item.output}`,
        )
        .join('\n')}

        Input
        ----------
        ${prompt}

    
        Output
        ----------
    `
      const parameters = {
        max_output_tokens: 2000,
      }
      console.log(contents)
      const response = await sendMessage(contents, parameters)

      const unquoteResponse = (response: string) => {
        return response.substring(response.indexOf("fields=")).replace(/^`+|`+$/g, '').trim()
      }
      const cleanResponse = unquoteResponse(response)
      console.log('Clean Response: ', cleanResponse)
      const newExploreUrl = cleanResponse + '&toggle=dat,pik,vis'
      console.log('newExploreUrl:', newExploreUrl)

      return newExploreUrl
    },
    [dimensions, measures, exploreGenerationExamples],
  )

  const sendMessage = async (message: string, parameters: ModelParameters) => {
    let response = ''
    if (VERTEX_AI_ENDPOINT) {
      response = await vertextCloudFunction(message, parameters)
    }

    if (VERTEX_BIGQUERY_LOOKER_CONNECTION_NAME && VERTEX_BIGQUERY_MODEL_ID) {
      response = await vertextBigQuery(message, parameters)
    }

    return response
  }

  return {
    generateExploreUrl,
    sendMessage,
    sendMessageWithThread,
    summarizePrompts,
    isSummarizationPrompt,
    isDataQuestionPrompt,
    summarizeExplore,
  }
}

export default useSendVertexMessage