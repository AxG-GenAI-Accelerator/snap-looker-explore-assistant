import React, { useEffect, useState } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import {
  AssistantState,
  resetChat,
  setIsChatMode,
  setQuery,
} from '../slices/assistantSlice'
import { RootState } from '../store'
import useSendVertexMessage from '../hooks/useSendVertexMessage'

interface QuestionsProps {
  insights: string
  // promptList: string[]
  // insights: string
  // dimensions: string[]
  // exploreGenerationExamples: string[]
}

const SuggestedQuestions = ({ insights }: QuestionsProps) => {
  const dispatch = useDispatch()
  // const {
  //   currentExplore: { modelName, exploreId },
  //   examples: { exploreSamples },
  // } = useSelector((state: RootState) => state.assistant as AssistantState)

  const [samples, setSamples] = useState([])
  const { sugQue } = useSendVertexMessage()

  const {
    isQuerying,
    query,
    currentExploreThread,
    currentExplore,
    examples,
    semanticModels,
  } = useSelector((state: RootState) => state.assistant as AssistantState)


  const exploreKey =
    currentExploreThread?.exploreKey || currentExplore.exploreKey

  const { dimensions } = semanticModels[exploreKey]

  const exploreGenerationExamples =
    examples.exploreGenerationExamples[exploreKey]

  useEffect(() => {
    const fetchQuestions = async () => {
      const response = await sugQue(query, currentExploreThread?.promptList, insights, 
        dimensions, exploreGenerationExamples)
      if (!response) {
        setSamples([])
      } else {
        setSamples(response)
      }
    }

    if(!isQuerying && insights !=='') {
      fetchQuestions()
    }
  }, [isQuerying])

  const handleSubmit = (prompt: string) => {
    // dispatch(resetChat())
    dispatch(setQuery(prompt))
    dispatch(setIsChatMode(true))
  }

  if (!samples) return <></>  

  return (
    <>
      {!isQuerying && samples.length > 0 && (
        <div className="flex flex-wrap max-w-5xl">
          {samples.map((item, index: number) => (
            <div
              className="flex flex-col bg-blue-200/50 hover:bg-blue-200 rounded-lg cursor-pointer text-sm p-4 m-2"
              style={{ minHeight: '10rem', width: '10rem' }}
              key={index}
              onClick={() => {
                handleSubmit(item)
              }}
            >
              <div className="flex-grow font-light line-camp-5">
                {item}
              </div>
            </div>
          ))}
        </div>
      )}
    </>
  )
}

export default SuggestedQuestions
