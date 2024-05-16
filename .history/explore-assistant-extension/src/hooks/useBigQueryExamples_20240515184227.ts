import { useContext, useEffect } from 'react'
import { useDispatch } from 'react-redux'
import {
  setExploreGenerationExamples,
  setExploreRefinementExamples,
} from '../slices/assistantSlice'
import { ExtensionContext } from '@looker/extension-sdk-react'
import process from 'process'

export const useBigQueryExamples = () => {
  const connectionName =
    process.env.BIGQUERY_EXAMPLE_PROMPTS_CONNECTION_NAME || ''
  const LOOKER_MODEL = process.env.LOOKER_MODEL || ''
  const LOOKER_EXPLORE = process.env.LOOKER_EXPLORE || ''
  const datasetName =
    process.env.BIGQUERY_EXAMPLE_PROMPTS_DATASET_NAME || 'explore_assistant'

  const dispatch = useDispatch()

  const { core40SDK } = useContext(ExtensionContext)

  const runExampleQuery = async (sql: string) => {
    const createSqlQuery = await core40SDK.ok(
      core40SDK.create_sql_query({
        connection_name: connectionName,
        sql: sql,
      }),
    )
    console.log('RunExample create_sql_query sql:', sql);

    const { slug } = await createSqlQuery
    if (slug) {
      const runSQLQuery = await core40SDK.ok(
        core40SDK.run_sql_query(slug, 'json'),
      )
      const examples = await runSQLQuery
      return examples
    }
    return []
  }
  
  
  const getExamplePrompts = async (): Promise<void> => {
    const sql = `
      SELECT examples
      FROM \`${datasetName}.explore_assistant_examples\`
      WHERE explore_id = '${LOOKER_MODEL}:${LOOKER_EXPLORE}'
    `;
  
    try {
      const response: Array<{ examples: string }> = await runExampleQuery(sql);
      console.log('Example query sql:', sql);
      console.log('Example query response:', response);
  
      if (response.length === 0) {
        console.log('No examples found for the specified model and explore.');
        return;
      }
  
      const generationExamples = response.map((row) => {
        try {
          return JSON.parse(row.examples);
        } catch (parseError) {
          console.error('Error parsing example JSON:', parseError);
          return null;
        }
      }).filter((example) => example !== null);
  
      dispatch(setExploreGenerationExamples(generationExamples));
    } catch (error) {
      console.error('Error fetching example prompts:', error);
    }
  };

  
  const getRefinementPrompts = async (): Promise<void> => {
    const sql = `
      SELECT examples
      FROM \`${datasetName}.explore_assistant_refinement_examples\`
      WHERE explore_id = '${LOOKER_MODEL}:${LOOKER_EXPLORE}'
    `
  ;
  try {
    const response: Array<{ examples: string }> = await runExampleQuery(sql);
    console.log('CONNECTION_NAME:', connectionName)
    console.log('Model ID:', LOOKER_MODEL)
    console.log('Explore ID:', LOOKER_EXPLORE)
    console.log('Refinement query sql:', sql);
    console.log('Refinement query response:', response);

    if (response.length === 0) {
      console.log('No examples found for the specified model and explore.');
      return;
    }

    const generationExamples = response.map((row) => {
      try {
        return JSON.parse(row.examples);
      } catch (parseError) {
        console.error('Error parsing example JSON:', parseError);
        return null;
      }
    }).filter((example) => example !== null);

    dispatch(setExploreGenerationExamples(generationExamples));
  } catch (error) {
    console.error('Error fetching example prompts:', error);
  }
};

  // get the example prompts
  useEffect(() => {
    getExamplePrompts()
    getRefinementPrompts()
  }, [])
}
