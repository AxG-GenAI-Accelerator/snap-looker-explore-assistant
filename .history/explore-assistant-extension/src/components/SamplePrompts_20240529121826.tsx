import { Box, Card, Heading, Paragraph } from '@looker/components'
import React from 'react'

interface SamplePromptsProps {
  handleSubmit: (prompt: string) => void
}
const SamplePrompts = ({ handleSubmit }: SamplePromptsProps) => {
  const categorizedPrompts = [
    {
      category: 'Top Store Analysis',
      prompt: 'What are the top 100 T-Mobile Stores by Sales?',
      color: 'black',
    },
    {
      category: 'Detailed Drill-Down',
      prompt:
        'What is the employeement rate and income by tier?',

      color: 'black',
    },
    {
      category: 'Targeting Prioritization',
      prompt:
        'Which DMA has the highest concentration of pixel target audience male age between 20-40?',
      color: 'black',
    },
  ]
  return (
    <div>
      {categorizedPrompts.map((item, index: number) => (
        <Box
          cursor="pointer"
          key={index}
          onClick={() => {
            handleSubmit(item.prompt)
          }}
        >
          <Card border={'ui1'} fontSize={'small'} m="u1" px="u2" py="u4" style={{height:'auto'}}>
            <Heading
              fontSize={'small'}
              fontWeight={'semiBold'}
              style={{ color: `${item.color}` }}
            >
              {item.category}
            </Heading>
            <Paragraph mt="u2">{item.prompt}</Paragraph>
          </Card>
        </Box>
      ))}
    </div>
  )
}

export default SamplePrompts