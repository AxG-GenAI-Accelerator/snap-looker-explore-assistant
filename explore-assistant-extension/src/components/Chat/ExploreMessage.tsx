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

interface ExploreMessageProps {
  exploreId: string
  modelName: string
  prompt: string
  queryArgs: string
  explanation: string
  insights: string
  explanation_n: string
  insights_n: string
  
}

  const ExploreMessage = ({ modelName, exploreId, prompt, queryArgs, explanation, insights, explanation_n, insights_n }: ExploreMessageProps) => {
  const dispatch = useDispatch()
  const { extensionSDK } = useContext(ExtensionContext)
  const exploreHref = `/explore/${modelName}/${exploreId}?${queryArgs}`
  const openExplore = () => {
    extensionSDK.openBrowserWindow(exploreHref, '_blank')
  }
  const [expanded, setExpanded] = useState(false)
  const expandedContentRef = useRef<HTMLDivElement>(null);

  console.log("ExploreHREF====>", exploreHref)
  console.log("Explanation & Insights coming from chatmasssage assistant====>", explanation_n, "======" ,insights_n)
  const jsonData = JSON.parse(explanation_n);
  // console.log("Explanation in ExploreMessage", explanation)

  const insightsData = insights_n.split("\n")
  // console.log("Insights in ExploreMessage", insights)

  const convertToHTML = (text: string) => {
    const parts = text.split('\n');

    let temp = []
    parts.map((line, index) => temp.push(line.split("**")))
    return temp.slice(2).map((item, index) => (
      <li key={index}>
        {item.map((part, i) => (
          <span key={i}>
            {part != "* " ? (i % 2 === 0 ? part : <b>{part}</b>) : null}
          </span>
        ))}
      </li>
    ));

  };

  const renderInsights = convertToHTML(insights_n)

  const renderIns = () => (
    <ul>
      {insightsData.slice(2).map((item, index) => {
        const parts = item.split('*')
        return (
          <li key={index}>
            <b>{parts[3]}</b> {parts[5]}
          </li>
        );
      })}
    </ul>
  )

  const calculationLogicLines = jsonData["Calculation Logic"].split('\n');
  const renderTemp = () => {
    let temp = []
    calculationLogicLines.map((line, index) => temp.push(line.split("**")))
    return temp.map((item, index) => (
      <li key={index}>
        {item.map((part, i) => (
          <span key={i}>
            {i % 2 === 0 ? part : <b>{part}</b>}
          </span>
        ))}
      </li>
    ));
  };


  const handleExpand = () => {
    setExpanded(!expanded);

    if (expandedContentRef.current) {
      expandedContentRef.current.style.maxHeight = expanded
        ? '0px' : '300px';
    }
  }

  const openSidePanelExplore = () => {
    dispatch(setSidePanelExploreUrl(queryArgs))
    dispatch(openSidePanel())
  }

  return (
    <>
      <Message actor="system" createdAt={Date.now()}>
        <div>
          <div className="mb-2"><div style={{ fontWeight: 'bold', fontSize: '20px' }}>Insights </div>
            {/* {renderIns()} */}
            {renderInsights}
          </div>
          <div
            className="bg-gray-400 text-white rounded-md p-4 my-2 shadow-lg hover:bg-gray-500 cursor-pointer"
            onClick={openSidePanelExplore}
          >
            <div className="flex flex-row text-md font-semibold">
              <div className="flex-grow">Explore</div>
            </div>
            <div className="text-xs mt-2 line-clamp-3">{prompt}</div>
          </div>
          <div className="cursor-pointer text-sm flex items-center justify-between">
            <div className="flex items-start" onClick={handleExpand}>
              <b> {expanded ? <ExpandLess fontSize={'small'} /> : <ExpandMore fontSize={'small'} />} SQL Generation Logic </b>
            </div>
            <div className="hover:underline text-blue-500 items-end"
              onClick={openExplore}>visit  <OpenInNew fontSize={'small'} /></div>
          </div>
          <div className={`hidden${expanded ? 'block' : ''}`} ref={expandedContentRef}>
            {expanded ? <div>
              <p><b>Data Source: </b> {jsonData["Data Source"]}</p>
              <p><b>Calculation Logic: </b></p>
              <ul>
                {renderTemp()}
              </ul>
            </div> : ''}
          </div>
        </div>
      </Message>
    </>
  )
}

export default ExploreMessage