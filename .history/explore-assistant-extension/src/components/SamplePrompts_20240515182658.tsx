import { Box, Card, Heading, Paragraph } from '@looker/components'
import React from 'react'

interface SamplePromptsProps {
  handleSubmit: (prompt: string) => void
}
const SamplePrompts = ({ handleSubmit }: SamplePromptsProps) => {
  const categorizedPrompts = [
    {
      category: 'Business Analysis',
      prompt: 'What are the top 100 T-Mobile Stores by Growth Potential?',
      color: 'blue',
    },
    {
      category: 'Demographics',
      prompt:
        'What is the employeement rate by DMA?',
      color: 'green',
    },
    {
      category: 'Cohorting',
      prompt:
        'Which DMA has the highest concentration of pixel target audience male age between 20-40?',
      color: 'red',
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