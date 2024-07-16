import { Box, Card, Heading, Paragraph } from '@looker/components'
import React from 'react'

interface SamplePromptsProps {
  handleSubmit: (prompt: string) => void
}
const SamplePrompts = ({ handleSubmit }: SamplePromptsProps) => {
  const categorizedPrompts = [
    {
      category: 'Audience Building',
      prompt: 'Show me who is in market for a new car',
      color: 'black',
    },
    {
      
      category: 'Detailed Drill-Down',
      prompt:
        'What is the customer lifestyle distribution?',
      color: 'black',
    },
    {
      category: 'Insight Generation',
      prompt:
        'What is the total number of tech-savvy customers?',
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