import { useContext, useEffect, useRef } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import {
  setExploreGenerationExamples,
  setExploreRefinementExamples,
  setExploreSamples,
  ExploreSamples,
  setisBigQueryMetadataLoaded,
  setCurrenExplore,
  RefinementExamples,
  ExploreExamples,
  AssistantState
} from '../slices/assistantSlice'

import { ExtensionContext } from '@looker/extension-sdk-react'
import process from 'process'
import { useErrorBoundary } from 'react-error-boundary'
import { RootState } from '../store'

export const useBigQueryExamples = () => {
  const connectionName = process.env.BIGQUERY_EXAMPLE_PROMPTS_CONNECTION_NAME || ''
  const datasetName = process.env.BIGQUERY_EXAMPLE_PROMPTS_DATASET_NAME || 'explore_assistant'

  const dispatch = useDispatch()
  const { showBoundary } = useErrorBoundary()
  const { isBigQueryMetadataLoaded } = useSelector((state: RootState) => state.assistant as AssistantState)

  const { core40SDK } = useContext(ExtensionContext)

  const runSQLQuery = async (sql: string) => {
    try {
      return await retryOperation(async () => {
        const createSqlQuery = await core40SDK.ok(
          core40SDK.create_sql_query({
            connection_name: connectionName,
            sql: sql,
          }),
        );
        const { slug } = await createSqlQuery;
        if (slug) {
          return await core40SDK.ok(
            core40SDK.run_sql_query(slug, 'json'),
          );
        }
        return [];
      });
    } catch (error) {
      // Only show truly critical errors
      if (error.message.includes('critical') || error.message.includes('permission')) {
        showBoundary(error);
      }
      return [];
    }
  };

  const getExamplePrompts = async () => {
    const sql = `
      SELECT
          explore_id,
          examples
      FROM
        \`${datasetName}.explore_assistant_examples\`
    `
    return runSQLQuery(sql).then((response) => {
      if(response.length === 0 || !Array.isArray(response)) {
        console.log('No example prompts found');
        return
      }
      const generationExamples: ExploreExamples = {}
      response.forEach((row) => {
        if (row['examples']) {
          try {
            generationExamples[row['explore_id']] = JSON.parse(row['examples'])
          } catch (error) {
            console.error(`Error parsing examples for explore ${row['explore_id']}:`, error)
          }
        }
      })
      console.log('Generation Examples:', generationExamples);
      dispatch(setExploreGenerationExamples(generationExamples))
    }).catch((error) => showBoundary(error))
  }

  const getRefinementPrompts = async () => {
    const sql = `
    SELECT
        explore_id,
        examples
    FROM
      \`${datasetName}.explore_assistant_refinement_examples\`
  `
    return runSQLQuery(sql).then((response) => {
      if(response.length === 0 || !Array.isArray(response)) {
        console.log('No refinement prompts found');
        return
      }
      const refinementExamples: RefinementExamples = {}
      response.forEach((row) => {
        if (row['examples']) {
          try {
            refinementExamples[row['explore_id']] = JSON.parse(row['examples'])
          } catch (error) {
            console.error(`Error parsing refinement examples for explore ${row['explore_id']}:`, error)
          }
        }
      })
      console.log('Refinement Examples:', refinementExamples);
      dispatch(setExploreRefinementExamples(refinementExamples))
    }).catch((error) => showBoundary(error))
  }

  const getSamples = async () => {
    const sql = `
      SELECT
          explore_id,
          samples
      FROM
        \`${datasetName}.explore_assistant_samples\`
    `
    return runSQLQuery(sql).then((response) => {
      const exploreSamples: ExploreSamples = {}
      if(response.length === 0 || !Array.isArray(response)) {
        console.log('No samples found');
        return
      }
      response.forEach((row: any) => {
        try {
          exploreSamples[row['explore_id']] = JSON.parse(row['samples'])
        } catch (error) {
          console.error(`Error parsing samples for explore ${row['explore_id']}:`, error)
        }
      })
      console.log('Explore Samples:', exploreSamples);
      const exploreKey: string = response[0]['explore_id']
      const [modelName, exploreId] = exploreKey.split(':')
      dispatch(setExploreSamples(exploreSamples))
      dispatch(setCurrenExplore({
        exploreKey,
        modelName,
        exploreId
      }))
    }).catch((error) => showBoundary(error))
  }

  // Create a ref to track if the hook has already been called
  const hasFetched = useRef(false)

  // get the example prompts provide completion status
  useEffect(() => {
    if (hasFetched.current) return
    hasFetched.current = true

    // if we already fetch everything, return
    if(isBigQueryMetadataLoaded) return

    dispatch(setisBigQueryMetadataLoaded(false))
    Promise.all([getExamplePrompts(), getRefinementPrompts(), getSamples()])
      .then(() => {
        console.log('All BigQuery data loaded successfully');
        console.log('check 1')
        dispatch(setisBigQueryMetadataLoaded(true))
      })
      .catch((error) => {
        console.error('Error loading BigQuery data:', error);
        showBoundary(error)
        dispatch(setisBigQueryMetadataLoaded(false))
      })
  }, [showBoundary])
}