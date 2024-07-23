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
    type: string
    description: "Customer Lifetime Value tier based on historical vehicle purchase price"
    label: "LTV Tier"
    tags: ["ltv", "customer value", "tier"]
    sql:
    CASE
      WHEN ${TABLE}.CLTV_Tier = 1 THEN 'Low Value'
      WHEN ${TABLE}.CLTV_Tier = 2 THEN 'Average Value'
      WHEN ${TABLE}.CLTV_Tier = 3 THEN 'High Value'
      ELSE 'Unknown'
    END ;;
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
    type: string
    description: "Variable tracks the demographic segment. The numbers correlate to the following demographics: 1 'Retired', 2 'Urban Living', 3 'Family & Suburbs', 4 'Wealthy, Married, No Kids', 5 'Young & Single'."
    label: "Lifestyle Segment"
    tags: ["demographic", "lifestyle"]
    sql:
    CASE
      WHEN ${TABLE}.segment_lifestyle = 1 THEN 'Retired'
      WHEN ${TABLE}.segment_lifestyle = 2 THEN 'Urban Living'
      WHEN ${TABLE}.segment_lifestyle = 3 THEN 'Family & Suburbs'
      WHEN ${TABLE}.segment_lifestyle = 4 THEN 'Wealthy, Married, No Kids'
      WHEN ${TABLE}.segment_lifestyle = 5 THEN 'Young & Single'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_mindset {
    type: string
    description: "Mindset segment used to determine the right way to communicate to the customer"
    label: "Mindset Segment"
    tags: ["communication","demographic","user prefrence"]
    sql:
    CASE
      WHEN ${TABLE}.segment_mindset = 1 THEN 'Guide Me'
      WHEN ${TABLE}.segment_mindset = 2 THEN 'Show Me'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_trigger {
    type: string
    description: "Segmentation based on a trigger event that predicts the reason for why they are in market shopping"
    label: "Trigger Segment"
    tags: ["lifestyle","sales","demographic"]
    sql:
    CASE
      WHEN ${TABLE}.segment_trigger = 1 THEN 'New Home'
      WHEN ${TABLE}.segment_trigger = 2 THEN 'In Market Shopping'
      WHEN ${TABLE}.segment_trigger = 3 THEN 'Outlier Service'
      WHEN ${TABLE}.segment_trigger = 4 THEN 'Birth of Child'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_email_dow {
    type: string
    description: "Optimal day of the week to send email to the customer"
    label: "Email Day of Week"
    tags: ["communication", "email", "user prefrence", "day of the week"]
    sql:
    CASE
      WHEN ${TABLE}.segment_email_dow = 1 THEN 'Sunday'
      WHEN ${TABLE}.segment_email_dow = 2 THEN 'Monday'
      WHEN ${TABLE}.segment_email_dow = 3 THEN 'Tuesday'
      WHEN ${TABLE}.segment_email_dow = 4 THEN 'Wednesday'
      WHEN ${TABLE}.segment_email_dow = 5 THEN 'Thursday'
      WHEN ${TABLE}.segment_email_dow = 6 THEN 'Friday'
      WHEN ${TABLE}.segment_email_dow = 7 THEN 'Saturday'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_email_daypart {
    type: string
    description: "Optimal time of day to send email to customer"
    label: "Email Daypart"
    tags: ["communication", "email", "user prefrence", "time of day"]
    sql:
    CASE
      WHEN ${TABLE}.segment_email_daypart = 1 THEN '6 AM to 9 AM'
      WHEN ${TABLE}.segment_email_daypart = 2 THEN '9 AM to 12 PM'
      WHEN ${TABLE}.segment_email_daypart = 3 THEN '1 PM to 6 PM'
      WHEN ${TABLE}.segment_email_daypart = 4 THEN '6 PM or later'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_email_frequency {
    type: string
    description: "Number of emails sent per week over the last 12 months"
    label: "Email Frequency"
    tags: ["communication", "email", "user prefrence", "frequency"]
    sql:
    CASE
      WHEN ${TABLE}.segment_email_frequency = 1 THEN 'One Email a Week'
      WHEN ${TABLE}.segment_email_frequency = 2 THEN 'Two Emails a Week'
      WHEN ${TABLE}.segment_email_frequency = 3 THEN 'Three Emails a Week'
      WHEN ${TABLE}.segment_email_frequency = 4 THEN 'Four to Eight Emails a Week'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_life_cycle {
    type: string
    description: "Tracks the vehicle life cycle from new owner to back in market for a new car."
    label: "Life Cycle Segment"
    tags: ["customer journey", "vehicle"]
    sql:
    CASE
      WHEN ${TABLE}.segment_life_cycle = 1 THEN 'New Owner'
      WHEN ${TABLE}.segment_life_cycle = 2 THEN 'Bonding'
      WHEN ${TABLE}.segment_life_cycle = 3 THEN 'Experience'
      WHEN ${TABLE}.segment_life_cycle = 4 THEN 'Back In Market'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_channel {
    type: string
    description: "Identifies the best marketing channel for the customer"
    label: "Channel Segment"
    tags: ["communication", "channel", "user prefrence"]
    sql:
    CASE
      WHEN ${TABLE}.segment_channel = 1 THEN 'SMS'
      WHEN ${TABLE}.segment_channel = 2 THEN 'DM'
      WHEN ${TABLE}.segment_channel = 3 THEN 'EM'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_loe {
    type: string
    description: "Tracks the trend in engagement with marketing communications"
    label: "Level of Engagement"
    tags: ["communication", "engagement", "user prefrence"]
    sql:
    CASE
      WHEN ${TABLE}.segment_LOE = 1 THEN 'Declining'
      WHEN ${TABLE}.segment_LOE = 2 THEN 'Stable'
      WHEN ${TABLE}.segment_LOE = 3 THEN 'Increasing'
      ELSE 'Unknown'
    END ;;
  }

  dimension: segment_priority {
    type: string
    description: "Lists the customer's priority when buying a car and therefore also the best type of content to send to the customer to maximize engagement"
    label: "Priority Segment"
    tags: ["communication", "user prefrence", "content", "demographic"]
    sql:${TABLE}.segment_priority ;;
  }

  measure: count {
    type: count
    description: "Count of records"
    label: "Count"
    drill_fields: [pid, brand, vehicle, cltv_tier, pscore_service, pscore_tech, pscore_ppm, pscore_accessories, pscore_product, pscore_brand, segment_lifestyle, segment_mindset, segment_trigger, segment_email_dow, segment_email_daypart, segment_email_frequency, segment_life_cycle, segment_channel, segment_loe, segment_priority]
  }
}
