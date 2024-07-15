view: targeting_data_1 {
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.mri_s__demo.targeting_data_1` ;;

  dimension: pid {
    type: number
    description: "User ID used to identify the customer"
    label: "Customer ID"
    tags: ["customerID"]
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
    description: "The type of vehicle"
    label: "Vehicle"
    tags: ["vehicle"]
    sql: ${TABLE}.vehicle ;;
  }

  dimension: cltv_tier {
    type: number
    description: "Customer Lifetime Value tier based on historical vehicle purchase price"
    label: "LTV Tier"
    tags: ["ltv", "customer value", "tier"]
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
    description: "Score that measures a customer's propensity or likelihood to engage with or require vehicle services.The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "Service Propensity Score"
    tags: ["propensity", "service"]
    sql: ${TABLE}.pscore_service ;;
  }

  dimension: pscore_tech {
    type: number
    description: "This score indicates a customer's inclination or likelihood to adopt or be interested in new technology features in vehicles. The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "Tech Propensity Score"
    tags: ["propensity", "technology"]
    sql: ${TABLE}.pscore_tech ;;
  }

  dimension: pscore_ppm {
    type: number
    description: "PPM indicate a customer's likelihood to engage in regular maintenance or their attention to vehicle performance details. The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "PPM Propensity Score"
    tags: ["propensity", "ppm"]
    sql: ${TABLE}.pscore_ppm ;;
  }

  dimension: pscore_accessories {
    type: number
    description: "This score indicates a customer's inclination to purchase or be interested in vehicle accessories.The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "Accessories Propensity Score"
    tags: ["propensity", "accessories"]
    sql: ${TABLE}.pscore_accessories ;;
  }

  dimension: pscore_product {
    type: number
    description: "This score indicates a customer's general interest in the product (vehicle) itself, likelihood to purchase new vehicles or upgrade their current one.The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "Product Propensity Score"
    tags: ["propensity", "product"]
    sql: ${TABLE}.pscore_product ;;
  }

  dimension: pscore_brand {
    type: number
    description: "This score indicates a customer's loyalty or affinity to a particular vehicle brand.The lower numbers mean they are less likely and the higher numbers mean they are more likely."
    label: "Brand Propensity Score"
    tags: ["propensity", "brand"]
    sql: ${TABLE}.pscore_brand ;;
  }

  dimension: segment_lifestyle {
    type: number
    description: "Variable tracks the demographic segment. The numbers correlate to the following demographics: 1 'Retired', 2 'Urban Living', 3 'Family & Suburbs', 4 'Wealthy, Married, No Kids', 5 'Young & Single'."
    label: "Lifestyle Segment"
    tags: ["demographic", "lifestyle"]
    sql: ${TABLE}.segment_lifestyle;;
  }

  dimension: segment_mindset {
    type: number
    description: "Mindset segment used to determine the right way to communicate to the customer"
    label: "Mindset Segment"
    tags: ["communication","demographic","user prefrence"]
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
    description: "Segmentation based on a trigger event that predicts the reason for why they are in market shopping"
    label: "Trigger Segment"
    tags: ["lifestyle","sales","demographic"]
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
    tags: ["communication", "email","user prefrence","day of the week"]
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
    description: "Optimal time of day to send email to customer"
    label: "Email Daypart"
    tags: ["communication", "email","user prefrence","time of day"]
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
    tags: ["communication", "email","user prefrence","frequency"]
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
    description: "Tracks the vehicle life cycle from new owner to back in market for a new car."
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
    tags: ["communication","channel","user prefrence"]
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
    tags: ["communication","engagement","user prefrence"]
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
    description: "Lists the customer's priority when buying a car and therefore also the best type of content to send to the customer to maxmize engagement"
    label: "Priority Segment"
    tags: ["communication","user prefrence","content","demographic"]
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
