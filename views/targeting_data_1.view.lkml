view: targeting_data_1 {
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.mri_s__demo.targeting_data_1` ;;

  dimension: pid {
    type: number
    description: "Unique identifier for the customer"
    label: "Customer ID"
    tags: ["customer"]
    sql: ${TABLE}.pid ;;
  }

  dimension: brand {
    type: string
    description: "Brand of the car or vehicle"
    label: "Brand"
    tags: ["brand"]
    sql: ${TABLE}.brand ;;
  }

  dimension: vehicle {
    type: string
    description: "Vehicle model"
    label: "Vehicle"
    tags: ["vehicle"]
    sql: ${TABLE}.vehicle ;;
  }

  dimension: cltv_tier {
    type: number
    description: "Customer Lifetime Value tier based on historical vehicle purchase price"
    label: "CLTV Tier"
    tags: ["cltv", "customer value"]
    sql: ${TABLE}.CLTV_Tier ;;
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

  dimension: pscore_service {
    type: number
    description: "Service propensity score"
    label: "Service Score"
    tags: ["propensity", "service"]
    sql: ${TABLE}.pscore_service ;;
  }

  dimension: pscore_tech {
    type: number
    description: "Technology propensity score"
    label: "Tech Score"
    tags: ["propensity", "technology"]
    sql: ${TABLE}.pscore_tech ;;
  }

  dimension: pscore_ppm {
    type: number
    description: "PPM propensity score"
    label: "PPM Score"
    tags: ["propensity", "ppm"]
    sql: ${TABLE}.pscore_ppm ;;
  }

  dimension: pscore_accessories {
    type: number
    description: "Accessories propensity score"
    label: "Accessories Score"
    tags: ["propensity", "accessories"]
    sql: ${TABLE}.pscore_accessories ;;
  }

  dimension: pscore_product {
    type: number
    description: "Product propensity score"
    label: "Product Score"
    tags: ["propensity", "product"]
    sql: ${TABLE}.pscore_product ;;
  }

  dimension: pscore_brand {
    type: number
    description: "Brand propensity score"
    label: "Brand Score"
    tags: ["propensity", "brand"]
    sql: ${TABLE}.pscore_brand ;;
  }

  dimension: segment_lifestyle {
    type: number
    description: "Demographic lifestyle segment"
    label: "Lifestyle Segment"
    tags: ["demographics", "lifestyle"]
    sql: ${TABLE}.segment_lifestyle ;;
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

  dimension: segment_mindset {
    type: number
    description: "Mindset segment used to determine the right way to communicate to the customer"
    label: "Mindset Segment"
    tags: ["communication", "marketing"]
    sql: ${TABLE}.segment_mindset ;;
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
    label: "Trigger Segment"
    tags: ["marketing", "sales"]
    sql: ${TABLE}.segment_trigger ;;
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

  dimension: segment_email_dow {
    type: number
    description: "Optimal day of the week to send email to the customer"
    label: "Email Day of Week"
    tags: ["email", "marketing"]
    sql: ${TABLE}.segment_email_dow ;;
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

  dimension: segment_email_daypart {
    type: number
    description: "Optimal time of day to send email"
    label: "Email Daypart"
    tags: ["email", "marketing"]
    sql: ${TABLE}.segment_email_daypart ;;
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

  dimension: segment_email_frequency {
    type: number
    description: "Number of emails sent per week over the last 12 months"
    label: "Email Frequency"
    tags: ["email", "marketing"]
    sql: ${TABLE}.segment_email_frequency ;;
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

  dimension: segment_life_cycle {
    type: number
    description: "Tracks the vehicle life cycle from new owner to back in market for a new car"
    label: "Life Cycle Segment"
    tags: ["customer journey", "vehicle"]
    sql: ${TABLE}.segment_life_cycle ;;
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
    label: "Channel Segment"
    tags: ["marketing", "channel"]
    sql: ${TABLE}.segment_channel ;;
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

  dimension: segment_loe {
    type: number
    description: "Tracks the trend in engagement with marketing communications"
    label: "Level of Engagement"
    tags: ["engagement", "marketing"]
    sql: ${TABLE}.segment_LOE ;;
    case: {
      when: {
        sql: ${TABLE}.segment_LOE = 1 ;;
        label: "Declining"
      }
      when: {
        sql: ${TABLE}.segment_LOE = 2 ;;
        label: "Stable"
      }
      when: {
        sql: ${TABLE}.segment_LOE = 3 ;;
        label: "Increasing"
      }
    }
  }

  dimension: segment_priority {
    type: string
    description: "Identifies the best type of content for the customer"
    label: "Priority Segment"
    tags: ["content", "marketing"]
    sql: ${TABLE}.segment_priority ;;
    case: {
      when: {
        sql: ${TABLE}.segment_priority = '1' ;;
        label: "Tech - Safety"
      }
      when: {
        sql: ${TABLE}.segment_priority = '2' ;;
        label: "Tech - Connected"
      }
      when: {
        sql: ${TABLE}.segment_priority = '3' ;;
        label: "Tech - Hybrid"
      }
      when: {
        sql: ${TABLE}.segment_priority = '4' ;;
        label: "Tech - Performance"
      }
    }
  }

  measure: count {
    type: count
    description: "Count of records"
    label: "Count"
    drill_fields: [pid, brand, vehicle, cltv_tier, pscore_service, pscore_tech, pscore_ppm, pscore_accessories, pscore_product, pscore_brand, segment_lifestyle, segment_mindset, segment_trigger, segment_email_dow, segment_email_daypart, segment_email_frequency, segment_life_cycle, segment_channel, segment_loe, segment_priority]
  }
}
