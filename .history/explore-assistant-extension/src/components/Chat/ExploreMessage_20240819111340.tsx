import React from 'react'

import Message from './Message'
import { useContext } from 'react'
import { ExtensionContext } from '@looker/extension-sdk-react'
import { useDispatch } from 'react-redux'
import {
  openSidePanel,
  setSidePanelExploreUrl,
} from '../../slices/assistantSlice'
import { OpenInNew } from '@material-ui/icons'

interface ExploreMessageProps {
  exploreId: string
  modelName: string
  prompt: string
  queryArgs: string
}

const ExploreMessage = ({ modelName, exploreId, prompt, queryArgs }: ExploreMessageProps) => {
  const dispatch = useDispatch()
  const { extensionSDK } = useContext(ExtensionContext)
  const exploreHref = `/explore/${modelName}/${exploreId}?${queryArgs}`
  
  console.log('exploreID in explore message.tsx: ', exploreId)
  console.log('exploreHref in explore message.tsx: ', exploreHref)

  const openExplore = () => {
    extensionSDK.openBrowserWindow(exploreHref, '_blank')
  }
  
  return (
    <>
      <Message actor="system" createdAt={Date.now()}>
        <Box my={'u2'}>
          <Space between style={{ position: 'relative'}}>
            <Chip disabled>Explore</Chip>
            {prompt && (
              <Box position="absolute" right="-10px" top="0px" cursor='pointer'>
                <Tooltip content={prompt}>
                  <Icon color={'ui3'} size="xxsmall" icon={<Info />} />
                </Tooltip>
              </Box>
            )}
          </Space>
        </Box>
        <Section>
          <Paragraph>Here is the link to your explore:</Paragraph>
          <Box mb="u4">
            <Link href="#" onClick={openExplore} isExternal>
              Visit Explore
            </Link>
          </Box>
        </Section>
      </Message>
    </>
  )
}

export default ExploreMessage
