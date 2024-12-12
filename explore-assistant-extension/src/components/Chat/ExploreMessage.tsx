import React, { useState } from 'react'
import Message from './Message'
import { useContext, useRef } from 'react'
import { ExtensionContext } from '@looker/extension-sdk-react'
import { useDispatch } from 'react-redux'
import {
  openSidePanel,
  setSidePanelExploreUrl,
} from '../../slices/assistantSlice'
import { ExpandLess, ExpandMore, OpenInNew } from '@material-ui/icons'
import { MdInsights } from 'react-icons/md'
import { FiDatabase } from 'react-icons/fi'

interface ExploreMessageProps {
  exploreId: string
  modelName: string
  prompt: string
  queryArgs: string
  explanation_n: string
  insights_n: string
}

const ExploreMessage = ({
  modelName,
  exploreId,
  prompt,
  queryArgs,
  explanation_n,
  insights_n,
}: ExploreMessageProps) => {
  const dispatch = useDispatch()
  const { extensionSDK } = useContext(ExtensionContext)
  const exploreHref = `/explore/${modelName}/${exploreId}?${queryArgs}`
  const openExplore = () => {
    extensionSDK.openBrowserWindow(exploreHref, '_blank')
  }
  const [expanded, setExpanded] = useState(false)
  const expandedContentRef = useRef<HTMLDivElement>(null)

  const jsonData = JSON.parse(explanation_n)

  // Parse insights_n into sections
  const parseInsights = (text: string) => {
    const sections = {
      keyTrends: [] as string[],
      notablePatterns: [] as string[],
      recommendations: [] as string[]
    }

    const lines = text.split('\n')
    let currentSection = ''

    lines.forEach(line => {
      const trimmedLine = line.trim()
      
      // Match markdown headers
      if (trimmedLine.startsWith('### 1. Key Trends')) {
        currentSection = 'keyTrends'
      } else if (trimmedLine.startsWith('### 2. Notable Patterns')) {
        currentSection = 'notablePatterns'
      } else if (trimmedLine.startsWith('### 3. Strategic Recommendations')) {
        currentSection = 'recommendations'
      } else if (trimmedLine.startsWith('*') && currentSection) {
        // Remove the markdown bullet point and trim
        const cleanLine = trimmedLine.substring(1).trim()
        if (cleanLine) {
          sections[currentSection].push(cleanLine)
        }
      }
    })

    return sections
  }

  const insightSections = parseInsights(insights_n)

  const renderMarkdown = (text: string) => {
    return text.split('**').map((part, index) => (
      <span key={index}>
        {index % 2 === 0 ? part : <b>{part}</b>}
      </span>
    ))
  }

  const handleExpand = () => {
    setExpanded(!expanded)
    if (expandedContentRef.current) {
      expandedContentRef.current.style.maxHeight = expanded ? '0px' : '300px'
    }
  }

  const openSidePanelExplore = () => {
    dispatch(setSidePanelExploreUrl(queryArgs))
    dispatch(openSidePanel())
  }

  return (
    <Message actor="system" createdAt={Date.now()}>
      <div className="p-3" style={{ backgroundColor: 'white' }}>
        {/* Insights Section */}
        <div className="mb-2">
          <div
            className="cursor-pointer text-sm flex items-start justify-between"
            style={{
              fontWeight: 600,
              fontSize: '18px',
              display: 'flex',
              padding: 5,
            }}
          >
            <div className="flex items-start justify-between" style={{ width: '28%' }}>
              <MdInsights /> Insights
            </div>
            <div
              className="hover:underline text-blue-500 items-end"
              onClick={openExplore}
            >
              visit <OpenInNew fontSize={'small'} />
            </div>
          </div>
          <hr />
          <div className="mt-4">
            {/* Key Trends */}
            {insightSections.keyTrends.length > 0 && (
              <div className="mb-4">
                <h3 className="font-semibold mb-2">Key Trends</h3>
                <ul className="list-disc pl-4">
                  {insightSections.keyTrends.map((trend, idx) => (
                    <li key={idx} className="mb-2">{renderMarkdown(trend)}</li>
                  ))}
                </ul>
              </div>
            )}
            
            {/* Notable Patterns */}
            {insightSections.notablePatterns.length > 0 && (
              <div className="mb-4">
                <h3 className="font-semibold mb-2">Notable Patterns</h3>
                <ul className="list-disc pl-4">
                  {insightSections.notablePatterns.map((pattern, idx) => (
                    <li key={idx} className="mb-2">{renderMarkdown(pattern)}</li>
                  ))}
                </ul>
              </div>
            )}
            
            {/* Strategic Recommendations */}
            {insightSections.recommendations.length > 0 && (
              <div className="mb-4">
                <h3 className="font-semibold mb-2">Strategic Recommendations</h3>
                <ul className="list-disc pl-4">
                  {insightSections.recommendations.map((rec, idx) => (
                    <li key={idx} className="mb-2">{renderMarkdown(rec)}</li>
                  ))}
                </ul>
              </div>
            )}
          </div>
        </div>

        <hr />

        {/* SQL Generation Logic Section */}
        <div
          className="mt-2 cursor-pointer text-sm flex items-center justify-between"
          style={{
            fontWeight: 600,
            fontSize: '18px',
            display: 'flex',
            padding: 5,
          }}
        >
          <div className="flex items-start justify-between" style={{ width: '60%' }}>
            <FiDatabase /> SQL Generation Logic
          </div>
          <div className="items-end" onClick={handleExpand}>
            {expanded ? <ExpandLess fontSize={'small'} /> : <ExpandMore fontSize={'small'} />}
          </div>
        </div>
        
        <div className={`overflow-hidden transition-max-height duration-300 ease-in-out${expanded ? ' max-h-96' : ' max-h-0'}`} ref={expandedContentRef}>
          {expanded && (
            <div className="mt-4 space-y-4">
              <p>
                <b>Data Source: </b> {renderMarkdown(jsonData['Data Source'])}
              </p>
              {jsonData['Measures Used'] && (
                <p>
                  <b>Measures Used: </b> {renderMarkdown(jsonData['Measures Used'])}
                </p>
              )}
              {jsonData['Filters'] && (
                <p>
                  <b>Filters: </b> {renderMarkdown(jsonData['Filters'])}
                </p>
              )}
              {jsonData['Sorting'] && (
                <p>
                  <b>Sorting: </b> {renderMarkdown(jsonData['Sorting'])}
                </p>
              )}
              {jsonData['Limit'] && (
                <p>
                  <b>Limit: </b> {renderMarkdown(jsonData['Limit'])}
                </p>
              )}
            </div>
          )}
        </div>
      </div>
    </Message>
  )
}

export default ExploreMessage
