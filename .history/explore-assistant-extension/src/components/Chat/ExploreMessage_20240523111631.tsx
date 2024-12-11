import React from 'react';
import Message from './Message';
import {
  Box,
  Chip,
  Icon,
  Link,
  Paragraph,
  Section,
  Space,
  Tooltip,
} from '@looker/components';
import { useContext } from 'react';
import { ExtensionContext } from '@looker/extension-sdk-react';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { Info } from '@material-ui/icons';

interface ExploreMessageProps {
  prompt: string;
  queryArgs: string;
  option: number;
}

const ExploreMessage = ({ prompt, queryArgs, option }: ExploreMessageProps) => {
  const { exploreId } = useSelector((state: RootState) => state.assistant);
  const { extensionSDK } = useContext(ExtensionContext);
  const exploreHref = `/explore/${exploreId}?${queryArgs}`;

  console.log('exploreID in explore message.tsx: ', exploreId);
  console.log('extensionSDK in explore message.tsx:', extensionSDK);
  console.log('exploreHref in explore message.tsx: ', exploreHref);

  const openExplore = () => {
    extensionSDK.openBrowserWindow(exploreHref, '_blank');
  };

  return (
    <>
      <Message actor="system" createdAt={Date.now()}>
        <Box my={'u2'}>
          <Space between style={{ position: 'relative' }}>
            <Chip disabled>Explore</Chip>
            {prompt && (
              <Box position="absolute" right="-10px" top="0px" cursor="pointer">
                <Tooltip content={prompt}>
                  <Icon color={'ui3'} size="xxsmall" icon={<Info />} />
                </Tooltip>
              </Box>
            )}
          </Space>
        </Box>
        <Section>
          <Paragraph>
            {option === 1 ? 'Here is the link to your explore:' : 'TEST TEST'}
          </Paragraph>
          <Box mb="u4">
            <Link href="#" onClick={openExplore} isExternal>
              Visit Explore
            </Link>
          </Box>
        </Section>
      </Message>
    </>
  );
};

export default ExploreMessage;