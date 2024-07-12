# The name of this view in Looker is "Targeting Data 1"
view: targeting_data_1 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.mri_s__demo.targeting_data_1` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Brand" in Explore.

  dimension: brand {
    type: string
    description: "Brand of the car or vehicle."
    label: "Brand"
    tags: ["brand"]
    sql: ${TABLE}.brand ;;
  }

  dimension: cltv_tier {
    type: number
    description: "CLTV stand for Customer lifetime value, which is the projected total profit a customer generates during their entire relationship with a brand or company.  This metric determines what CLTV tier the customer is in."
    label: "CLTV Tier"
    tags: ["cltv", "customer lifetime value", "lifetime value"]
    sql: ${TABLE}.CLTV_Tier ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cltv_tier {
    type: sum
    description: ""
    label: "Total CLTV"
    tags: []
    sql: ${cltv_tier} ;;  }
  measure: average_cltv_tier {
    type: average
    description: ""
    label: "Average CLTV"
    tags: []
    sql: ${cltv_tier} ;;  }

  dimension: pid {
    type: number
    value_format_name: id
    description: "The unique user number used as an identifier for a customer."
    label: "PID"
    tags: []
    sql: ${TABLE}.pid ;;
  }

  dimension: pscore_accessories {
    type: number
    description: ""
    label: "Accessories P-score"
    tags: []
    sql: ${TABLE}.pscore_accessories ;;
  }

  dimension: pscore_brand {
    type: number
    description: ""
    label: "Brand P-score"
    tags: []
    sql: ${TABLE}.pscore_brand ;;
  }

  dimension: pscore_ppm {
    type: number
    description: ""
    label: "PPM P-score"
    tags: []
    sql: ${TABLE}.pscore_ppm ;;
  }

  dimension: pscore_product {
    type: number
    description: ""
    label: "Product P-score"
    tags: []
    sql: ${TABLE}.pscore_product ;;
  }

  dimension: pscore_service {
    type: number
    description: ""
    label: "Service P-score"
    tags: []
    sql: ${TABLE}.pscore_service ;;
  }

  dimension: pscore_tech {
    type: number
    description: ""
    label: "Tech P-score"
    tags: []
    sql: ${TABLE}.pscore_tech ;;
  }

  dimension: segment_channel {
    type: number
    description: ""
    label: "Channel"
    tags: []
    sql: ${TABLE}.segment_channel ;;
  }

  dimension: segment_email_daypart {
    type: number
    description: "Tracks the optimal time of day to send the email."
    label: "Email Daytime"
    tags: []
    sql: ${TABLE}.segment_email_daypart ;;
  }

  dimension: segment_email_dow {
    type: number
    description: "Tracks the optimal day of week to send email to the customer."
    label: "Email Day of Week"
    tags: []
    sql: ${TABLE}.segment_email_dow ;;
  }

  dimension: segment_email_frequency {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_email_frequency ;;
  }

  dimension: segment_life_cycle {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_life_cycle ;;
  }

  dimension: segment_lifestyle {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_lifestyle ;;
  }

  dimension: segment_loe {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_LOE ;;
  }

  dimension: segment_mindset {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_mindset ;;
  }

  dimension: segment_priority {
    type: string
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_priority ;;
  }

  dimension: segment_trigger {
    type: number
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.segment_trigger ;;
  }

  dimension: vehicle {
    type: string
    description: ""
    label: ""
    tags: []
    sql: ${TABLE}.vehicle ;;
  }
  measure: count {
    type: count

  }
}
