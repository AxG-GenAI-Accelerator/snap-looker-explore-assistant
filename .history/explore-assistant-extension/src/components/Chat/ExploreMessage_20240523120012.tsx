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
}

const ExploreMessage = ({ prompt, queryArgs }: ExploreMessageProps) => {
  const { exploreId } = useSelector((state: RootState) => state.assistant);
  const { extensionSDK } = useContext(ExtensionContext);
  let exploreHref = `/explore/${exploreId}?${queryArgs}`;

  console.log('exploreID in explore message.tsx: ', exploreId);
  console.log('extensionSDK in explore message.tsx:', extensionSDK);
  console.log('exploreHref in explore message.tsx: ', exploreHref);
const demo = 1
    const openExplore = () => {
         extensionSDK.openBrowserWindow('/explore/lookertestv8/lookertestv8?fields=lookertestv8.ice_store_id,lookertestv8.partner,lookertestv8.past_pixel_sales_unit,lookertestv8.pixel_growth_potential_percentile,lookertestv8.city,lookertestv8.state,lookertestv8.zip,lookertestv8.location&sorts=lookertestv8.past_pixel_sales_unit desc 0&limit=100&column_limit=100&vis_type=table', '_blank');
        console.log('prompt in openExplore if: ', prompt);
      
    };

  console.log('prompt in explore message.tsx: (outside output text loop): ', prompt);

  let outputText = '';
  if (prompt === 'What are the top 100 stores by pixel sales') {
    outputText = 'Here are the top 100 stores:';
    console.log('prompt in explore message.tsx: ', prompt);

  } else if (prompt === 'Show me on a map') {
    outputText = 'Here are the top stores on a map';
    console.log('prompt in explore message.tsx: ', prompt);

  } else if (prompt === 'What is the coverage of these stores') {
    console.log('prompt in explore message.tsx: ', prompt);

    outputText = 'The coverage of these stores is 60%';
  } else {
    outputText = 'Here is the link to your explore:'
    console.log('prompt in explore message.tsx: ', prompt);

  }

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
          <Paragraph>{outputText}</Paragraph>
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