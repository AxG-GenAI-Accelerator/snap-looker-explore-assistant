view: hpp_sample_full_data {
  sql_table_name: `ace-tracker-421517-q9.HPP_sample_data.hpp_sample_full_data` ;;

  # Keep as dimensions since they are ratios/percentages that are pre-calculated
  dimension: __dismiss_rate__1 {
    type: number
    sql: ${TABLE}.__dismiss_rate__1 ;;
    label: "Dismiss Rate"
    description: "Rate of promotion dismissals per impression"
    value_format_name: percent_2
    tags: ["rate", "dismissal", "engagement"]
  }

  dimension: __dismiss_to_accept_rate__1 {
    type: number
    sql: ${TABLE}.__dismiss_to_accept_rate__1 ;;
    label: "Dismiss to Accept Rate"
    description: "Ratio of dismissals to accepts for promotions"
    value_format_name: percent_2
    tags: ["rate", "dismissal", "acceptance", "engagement"]
  }

  # Convert to measure - represents count of acceptance events
  measure: accept {
    type: sum
    sql: ${TABLE}.accept ;;
    label: "Total Accepts"
    description: "Total number of times the promotion was accepted; sum of users per day who click on the promo"
    tags: ["engagement", "metrics", "acceptance"]
  }

  # Keep text/categorical fields as dimensions
  dimension: approved_copy {
    type: string
    sql: ${TABLE}.approved_copy ;;
    label: "Approved Copy"
    description: "Copy, or wording, of the promo that was approved and launched as"
    tags: ["content", "copy", "approval"]
  }

  dimension_group: begin_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    datatype: date
    sql: ${TABLE}.begin_date ;;
    label: "Campaign Begin"
    description: "Start date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

  # Keep categorical/mapping fields as dimensions
  dimension: campaign_category_mapping {
    type: string
    sql: ${TABLE}.campaign_category_mapping ;;
    label: "Campaign Category Mapping"
    description: "Mapping of campaign to specific categories"
    tags: ["campaign", "category", "mapping"]
  }

  dimension: campaign_description {
    type: string
    sql: ${TABLE}.campaign_description ;;
    label: "Campaign Description"
    description: "Detailed description of the marketing campaign, including the campaign type (pushup, middleslot, callout), short description, and date"
    tags: ["campaign", "description", "details"]
  }

  dimension: campaign_id {
    type: number
    primary_key: yes  # Added as this appears to be a unique identifier
    sql: ${TABLE}.campaign_id ;;
    label: "Campaign ID"
    description: "Unique identifier for each marketing campaign"
    tags: ["campaign", "id", "identifier"]
  }

  # Keep URL/text fields as dimensions
  dimension: cappa_link {
    type: string
    sql: ${TABLE}.cappa_link ;;
    label: "CAPPA Link"
    description: "Link to the campaign listing within Cappa"
    tags: ["link", "tracking", "cappa"]
  }

  dimension: cappa_product {
    type: string
    sql: ${TABLE}.cappa_product ;;
    label: "CAPPA Product"
    description: "Product classification in CAPPA system"
    tags: ["product", "classification", "cappa"]
  }

  dimension: cappa_product_area {
    type: string
    sql: ${TABLE}.cappa_product_area ;;
    label: "CAPPA Product Area"
    description: "Product area classification in CAPPA system"
    tags: ["product", "area", "cappa"]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Campaign Category"
    description: "Category classification of the campaign"
    tags: ["category", "classification", "campaign"]
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country Name"
    description: "Name of the country where the campaign was run"
    tags: ["geography", "location", "country"]
  }

  # Convert CTR to measure - can be calculated from accepts and impressions
  measure: ctr {
    type: average
    sql: ${TABLE}.ctr ;;
    label: "Click-Through Rate"
    description: "Click-through rate calculated as accepts divided by impressions"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance"]
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
    label: "Device Type"
    description: "Type of device where the promotion was displayed"
    tags: ["device", "platform", "technical"]
  }

  # Convert to measure - represents count of dismissal events
  measure: dismiss {
    type: sum
    sql: ${TABLE}.dismiss ;;
    label: "Total Dismissals"
    description: "Total number of times the promotion was dismissed; sum of users who exit out of a promo"
    tags: ["engagement", "metrics", "dismissal"]
  }

  dimension_group: end_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    datatype: date
    sql: ${TABLE}.end_date ;;
    label: "Campaign End"
    description: "End date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

  dimension: flag {
    type: string
    sql: ${TABLE}.flag ;;
    label: "Flag"
    description: "Flag indicator for campaign status or special conditions"
    tags: ["status", "indicator", "campaign"]
  }

  dimension: grl {
    type: string
    sql: ${TABLE}.GRL ;;
    label: "GRL"
    description: "Indicates whether the campaign is targeted locally or globally"
    tags: ["identifier", "global", "resource"]
  }

  dimension: hpp_format {
    type: string
    sql: ${TABLE}.hpp_format ;;
    label: "Home Page Promotion Format"
    description: "Format type of the campaign: pushup, callout, or middleslot"
    tags: ["promotion", "format", "homepage", "campaign"]
  }

  # Convert to measure - represents count of impression events
  measure: impression {
    type: sum
    sql: ${TABLE}.impression ;;
    label: "Total Impressions"
    description: "Total number of times the promotion was viewed; sum of users who view the promo for any amount of time"
    tags: ["engagement", "metrics", "views"]
  }

  dimension: metadata_countries {
    type: string
    sql: ${TABLE}.metadata_countries ;;
    label: "Metadata Countries"
    description: "2-character code for where the campaign was run"
    tags: ["geography", "metadata", "location"]
  }

  dimension: mobileOS_mapping {
    type: string
    sql: ${TABLE}.mobileOS_mapping ;;
    label: "Mobile OS Mapping"
    description: "Mobile operating system targeting mapping, such as Mobile OS, Android, Desktop, etc."
    tags: ["mobile", "os", "desktop"]
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
    label: "Product"
    description: "Product category of the promo"
    tags: ["product", "category"]
  }

  dimension: promo_id {
    type: number
    sql: ${TABLE}.promo_id ;;
    label: "Promotion ID"
    description: "Unique identifier for each promotional campaign"
    tags: ["promotion", "id", "identifier"]
  }

  dimension: properties {
    type: string
    sql: ${TABLE}.properties ;;
    label: "Properties"
    description: "Properties associated with the campaign"
    tags: ["properties", "attributes", "campaign"]
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
    description: "Geographic region where the campaign was targeted"
    tags: ["geography", "region", "location"]
  }

  dimension: targeted_properties {
    type: string
    sql: ${TABLE}.targeted_properties ;;
    label: "Targeted Properties"
    description: "Specific mediums/properties targeted by the promotional ad, such as Search HP"
    tags: ["targeting", "properties"]
  }

  # Additional useful measures
  measure: total_campaigns {
    type: count_distinct
    sql: ${campaign_id} ;;
    label: "Total Campaigns"
    description: "Total number of unique campaigns"
    tags: ["count", "campaigns"]
  }

  measure: average_campaign_duration {
    type: average
    sql: DATE_DIFF(${end_date_date}, ${begin_date_date}, DAY) ;;
    label: "Average Campaign Duration (Days)"
    description: "Average duration of campaigns in days"
    value_format_name: decimal_0
    tags: ["duration", "campaigns", "timing"]
  }

  measure: dismiss_rate {
    type: number
    sql: SAFE_DIVIDE(${dismiss}, ${impression}) ;;
    label: "Dismiss Rate"
    description: "Rate of dismissals per impression"
    value_format_name: percent_2
    tags: ["rate", "dismissal", "engagement"]
  }
  measure: region_ctr {
    type: number
    sql: ${TABLE}.region_ctr_2 ;;
    label: "Region CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the region level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "region", "benchmark"]
  }

  measure: country_ctr {
    type: number
    sql: ${TABLE}.country_ctr_2 ;;
    label: "Country CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the country level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "country", "benchmark"]
  }

  measure: category_ctr {
    type: number
    sql: ${TABLE}.category_ctr_2 ;;
    label: "Category CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the category level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "category", "benchmark"]
  }

  measure: global_ctr {
    type: number
    sql: ${TABLE}.global_ctr_2 ;;
    label: "Global CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the global level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "global", "benchmark"]
  }
}
