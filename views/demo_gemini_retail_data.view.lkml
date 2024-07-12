view: demo_gemini_retail_data {
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.explore_assistant.demo_gemini_retail_data` ;;

  dimension: cltv_tier {
    type: number
    description: "Customer Lifetime Value tier based on historical vehicle purchase price"
    sql: ${TABLE}.CLTV_Tier ;;
    label: "CLTV Tier"
    tags: ["customer_value"]

    case: {
      when: {
        sql: ${TABLE}.CLTV_Tier = 1 ;;
        label: "Low Value"
      }
      when: {
        sql: ${TABLE}.CLTV_Tier = 2 ;;
        label: "Average Value"
      }
      when: {
        sql: ${TABLE}.CLTV_Tier = 3 ;;
        label: "High Value"
      }
    }
  }

  dimension: segment_lifestyle {
    type: number
    description: "Demographic lifestyle segment"
    sql: ${TABLE}.segment_lifestyle ;;
    label: "Lifestyle Segment"
    tags: ["demographics"]

    case: {
      when: {
        sql: ${TABLE}.segment_lifestyle = 1 ;;
        label: "Retired"
      }
      when: {
        sql: ${TABLE}.segment_lifestyle = 2 ;;
        label: "Urban Living"
      }
      when: {
        sql: ${TABLE}.segment_lifestyle = 3 ;;
        label: "Family & Suburbs"
      }
      when: {
        sql: ${TABLE}.segment_lifestyle = 4 ;;
        label: "Wealthy, Married, No Kids"
      }
      when: {
        sql: ${TABLE}.segment_lifestyle = 5 ;;
        label: "Young & Single"
      }
    }
  }

  dimension: segment_email_frequency {
    type: number
    description: "Number of emails sent per week over the last 12 months"
    sql: ${TABLE}.segment_email_frequency ;;
    label: "Email Frequency"
    tags: ["email", "marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_email_frequency = 1 ;;
        label: "One Email a Week"
      }
      when: {
        sql: ${TABLE}.segment_email_frequency = 2 ;;
        label: "Two Emails a Week"
      }
      when: {
        sql: ${TABLE}.segment_email_frequency = 3 ;;
        label: "Three Emails a Week"
      }
      when: {
        sql: ${TABLE}.segment_email_frequency = 4 ;;
        label: "Four to Eight Emails a Week"
      }
    }
  }

  dimension: segment_email_daypart {
    type: number
    description: "Optimal time of day to send email"
    sql: ${TABLE}.segment_email_daypart ;;
    label: "Email Daypart"
    tags: ["email", "marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_email_daypart = 1 ;;
        label: "6 AM to 9 AM"
      }
      when: {
        sql: ${TABLE}.segment_email_daypart = 2 ;;
        label: "9 AM to 12 PM"
      }
      when: {
        sql: ${TABLE}.segment_email_daypart = 3 ;;
        label: "1 PM to 6 PM"
      }
      when: {
        sql: ${TABLE}.segment_email_daypart = 4 ;;
        label: "6 PM or later"
      }
    }
  }

  dimension: segment_email_dow {
    type: number
    description: "Optimal day of the week to send email"
    sql: ${TABLE}.segment_email_dow ;;
    label: "Email Day of Week"
    tags: ["email", "marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_email_dow = 1 ;;
        label: "Sunday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 2 ;;
        label: "Monday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 3 ;;
        label: "Tuesday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 4 ;;
        label: "Wednesday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 5 ;;
        label: "Thursday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 6 ;;
        label: "Friday"
      }
      when: {
        sql: ${TABLE}.segment_email_dow = 7 ;;
        label: "Saturday"
      }
    }
  }

  dimension: segment_mindset {
    type: number
    description: "Mindset segment used to determine the right way to communicate to the customer"
    sql: ${TABLE}.segment_mindset ;;
    label: "Mindset Segment"
    tags: ["communication"]

    case: {
      when: {
        sql: ${TABLE}.segment_mindset = 1 ;;
        label: "Guide Me"
      }
      when: {
        sql: ${TABLE}.segment_mindset = 2 ;;
        label: "Show Me"
      }
    }
  }

  dimension: segment_trigger {
    type: number
    description: "Segmentation based on a trigger event that predicts likelihood to be in market shopping"
    sql: ${TABLE}.segment_trigger ;;
    label: "Trigger Segment"
    tags: ["marketing", "sales"]

    case: {
      when: {
        sql: ${TABLE}.segment_trigger = 1 ;;
        label: "New Home"
      }
      when: {
        sql: ${TABLE}.segment_trigger = 2 ;;
        label: "In Market Shopping"
      }
      when: {
        sql: ${TABLE}.segment_trigger = 3 ;;
        label: "Outlier Service"
      }
      when: {
        sql: ${TABLE}.segment_trigger = 4 ;;
        label: "Birth of Child"
      }
    }
  }

  dimension: segment_life_cycle {
    type: number
    description: "Tracks the vehicle life cycle from new owner to back in market for a new car"
    sql: ${TABLE}.segment_life_cycle ;;
    label: "Life Cycle Segment"
    tags: ["customer_journey"]

    case: {
      when: {
        sql: ${TABLE}.segment_life_cycle = 1 ;;
        label: "New Owner"
      }
      when: {
        sql: ${TABLE}.segment_life_cycle = 2 ;;
        label: "Bonding"
      }
      when: {
        sql: ${TABLE}.segment_life_cycle = 3 ;;
        label: "Experience"
      }
      when: {
        sql: ${TABLE}.segment_life_cycle = 4 ;;
        label: "Back In Market"
      }
    }
  }

  dimension: segment_channel {
    type: number
    description: "Identifies the best marketing channel for the customer"
    sql: ${TABLE}.segment_channel ;;
    label: "Channel Segment"
    tags: ["marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_channel = 1 ;;
        label: "SMS"
      }
      when: {
        sql: ${TABLE}.segment_channel = 2 ;;
        label: "DM"
      }
      when: {
        sql: ${TABLE}.segment_channel = 3 ;;
        label: "EM"
      }
    }
  }

  dimension: segment_priority {
    type: number
    description: "Identifies the best type of content for the customer"
    sql: ${TABLE}.segment_priority ;;
    label: "Priority Segment"
    tags: ["content", "marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_priority = 1 ;;
        label: "Tech - Safety"
      }
      when: {
        sql: ${TABLE}.segment_priority = 2 ;;
        label: "Tech - Connected"
      }
      when: {
        sql: ${TABLE}.segment_priority = 3 ;;
        label: "Tech - Hybrid"
      }
      when: {
        sql: ${TABLE}.segment_priority = 4 ;;
        label: "Tech - Performance"
      }
    }
  }

  dimension: segment_loe {
    type: number
    description: "Tracks the trend in engagement with marketing communications"
    sql: ${TABLE}.segment_loe ;;
    label: "Level of Engagement"
    tags: ["engagement", "marketing"]

    case: {
      when: {
        sql: ${TABLE}.segment_loe = 1 ;;
        label: "Declining"
      }
      when: {
        sql: ${TABLE}.segment_loe = 2 ;;
        label: "Stable"
      }
      when: {
        sql: ${TABLE}.segment_loe = 3 ;;
        label: "Increasing"
      }
    }
  }

  measure: count {
    type: count
    description: "Count of customers"
    drill_fields: [cltv_tier, segment_lifestyle, segment_email_frequency, segment_email_daypart, segment_email_dow, segment_mindset, segment_trigger, segment_life_cycle, segment_channel, segment_priority, segment_loe]
  }
}
