view: final_hpp_schema_small {
  sql_table_name: `ace-tracker-421517-q9.HPP_sample_data.Final_HPP_Schema_Small` ;;

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

  dimension: accept {
    type: number
    sql: ${TABLE}.accept ;;
    label: "Accepts"
    description: "Number of times the promotion was accepted; count of users per day who click on the promo"
    tags: ["engagement", "metrics", "acceptance"]
  }

  dimension: approved_copy {
    type: string
    sql: ${TABLE}.approved_copy ;;
    label: "Approved Copy"
    description: "Copy, or wording, of the promo that was approved and launched as"
    tags: ["content", "copy", "approval"]
  }

  dimension_group: begin_date {
    type: time
    datatype: date
    sql: ${TABLE}.begin_date ;;
    label: "Campaign Begin"
    description: "Start date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

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
    sql: ${TABLE}.campaign_id ;;
    label: "Campaign ID"
    description: "Unique identifier for each marketing campaign"
    tags: ["campaign", "id", "identifier"]
  }

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

  dimension: ctr {
    type: number
    sql: ${TABLE}.CTR ;;
    label: "Click-Through Rate"
    description: "Click-through rate for the campaign"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance"]
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
    label: "Device"
    description: "Type of device where the promotion was displayed"
    tags: ["device", "platform", "technical"]
  }

  dimension: dismiss {
    type: number
    sql: ${TABLE}.dismiss ;;
    label: "Dismissals"
    description: "Number of times the promotion was dismissed; count of users who exit out of a promo"
    tags: ["engagement", "metrics", "dismissal"]
  }

  dimension_group: end_date {
    type: time
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

  dimension: impression {
    type: number
    sql: ${TABLE}.impression ;;
    label: "Impressions"
    description: "Number of times the promotion was viewed; count of users who view the promo for any amount of time"
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

  measure: count {
    type: count
    drill_fields: [country_name]
    label: "Count of Campaigns"
    description: "Total number of campaign records"
    tags: ["count", "campaigns"]
  }
}
