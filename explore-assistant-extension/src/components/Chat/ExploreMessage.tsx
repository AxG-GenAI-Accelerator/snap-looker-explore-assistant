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
  // explanation: string
  // insights: string
  explanation_n: string
  insights_n: string
}

const ExploreMessage = ({
  modelName,
  exploreId,
  prompt,
  queryArgs,
  // explanation,
  // insights,
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

  // console.log('Explanation & Insights coming from chatmasssage assistant====>', explanation_n, '======', insights_n )
  const jsonData = JSON.parse(explanation_n)

  // const insightsData = insights_n.split('\n')

  const convertToHTML = (text: string) => {
    const parts = text.split('\n')

    let temp = []
    parts.map((line, index) => temp.push(line.split('**')))
    return temp.slice(2).map((item, index) => (
      <>
        <li key={index}>
          {item.map((part, i) => (
            <span key={i}>
              {part != '* ' ? (
                i % 2 === 0 ? (
                  item.length !== 1 ? (
                    <>
                      <br /> {part}
                    </>
                  ) : (
                    part
                  )
                ) : (
                  <b>{part}</b>
                )
              ) : null}
            </span>
          ))}
        </li>{' '}
        <br />
      </>
    ))
  }

  const renderInsights = convertToHTML(insights_n)

  // const calculationLogicLines = jsonData['Calculation Logic'].split('\n')
  // const renderTemp = () => {
  //   let temp = []
  //   calculationLogicLines.map((line, index) => temp.push(line.split('**')))
  //   return temp.map((item, index) => (
  //     <li key={index}>
  //       {item.map((part, i) => (
  //         <span key={i}>{i % 2 === 0 ? part : <b>{part}</b>}</span>
  //       ))}
  //     </li>
  //   ))
  // }
  const renderTemp = (text) => {
    return (text.split('**').map((item, index) => (
      <span key={index}>{index % 2 === 0 ? item : <b>{item}</b>}</span>
    )))
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
    <>
      <Message actor="system" createdAt={Date.now()}>
        <div className="p-3" style={{ backgroundColor: 'white' }}>
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
              <div
                className="flex items-start justify-between"
                style={{ width: '28%' }}
              >
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
            <br />
            {renderInsights}
          </div>
          {/* <div
            className="bg-gray-400 text-white rounded-md p-4 my-2 shadow-lg hover:bg-gray-500 cursor-pointer"
            onClick={openSidePanelExplore}
          >
            <div className="flex flex-row text-md font-semibold">
              <div className="flex-grow">Explore</div>
            </div>
            <div className="text-xs mt-2 line-clamp-3">{prompt}</div>
          </div> */}
          <hr />
          <div
            className="mt-2 cursor-pointer text-sm flex items-center justify-between"
            style={{
              fontWeight: 600,
              fontSize: '18px',
              display: 'flex',
              padding: 5,
            }}
          >
            <div
              className="flex items-start justify-between"
              style={{ width: '60%' }}
            >
              {' '}
              <FiDatabase /> SQL Generation Logic
            </div>
            <div className="items-end" onClick={handleExpand}>
              {expanded ? (
                <ExpandLess fontSize={'small'} />
              ) : (
                <ExpandMore fontSize={'small'} />
              )}{' '}
            </div>
          </div>
          <div
            className={`hidden${expanded ? 'block' : ''}`}
            ref={expandedContentRef}
          >
            {expanded ? (
              <div>
                <br />
                <p>
                  <b>Data Source: </b> {jsonData['Data Source']}
                </p>
                <br />
                <p>
                  <b>Measures Used: </b> {renderTemp(jsonData['Measures Used'])}
                </p>
                <br />
                {jsonData['Filters'] !== '' ? (
                  <>
                    <p>
                      <b>Filters: </b> {renderTemp(jsonData['Filters'])}
                    </p>
                    <br />
                  </>
                ) : null}
                {jsonData['Sorting'] !== '' ? (
                  <>
                    <p>
                      <b>Sorting: </b> {renderTemp(jsonData['Sorting'])}
                    </p>
                    <br />
                  </>
                ) : null}
                {jsonData['Limit'] !== '' ? (
                  <p>
                    <b>Limit: </b> {renderTemp(jsonData['Limit'])}
                  </p>
                ) : null}
              </div>
            ) : (
              ''
            )}
          </div>
        </div>
      </Message>
      </>
  )
}

export default ExploreMessage