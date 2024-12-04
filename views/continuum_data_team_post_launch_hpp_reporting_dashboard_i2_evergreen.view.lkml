view: continuum_data_team_post_launch_hpp_reporting_dashboard_i2_evergreen {
  sql_table_name: `ace-tracker-421517-q9.HPP_sample_data.continuum_data_team_post_launch_hpp_reporting_dashboard_I2_Evergreen` ;;

  # Dimensions
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
    label: "Campaign ID"
    description: "Unique identifier for each marketing campaign"
    tags: ["campaign", "id", "identifier"]
  }

  dimension: campaign_description {
    type: string
    sql: ${TABLE}.campaign_description ;;
    label: "Campaign Description"
    description: "Detailed description of the marketing campaign, including the campaign type (pushup, middleslot, callout), short description, and date"
    tags: ["campaign", "description", "details"]
  }

  dimension: promo_id {
    type: string
    sql: ${TABLE}.promo_id ;;
    label: "Promotion ID"
    description: "Unique identifier for each promotional campaign"
    tags: ["promotion", "id", "identifier"]
  }

  dimension: hpp_format {
    type: string
    sql: ${TABLE}.hpp_format ;;
    label: "Home Page Promotion Format"
    description: "Format type of the campaign: pushup, callout, or middleslot"
    tags: ["promotion", "format", "homepage", "campaign"]
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
    label: "Device Type"
    description: "Type of device where the promotion was displayed"
    tags: ["device", "platform", "technical"]
  }

  dimension: metadata_countries {
    type: string
    sql: ${TABLE}.metadata_countries ;;
    label: "Metadata Countries"
    description: "2-character code for where the campaign was run"
    tags: ["geography", "metadata", "location"]
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country Name"
    description: "Name of the country where the campaign was run"
    tags: ["geography", "location", "country"]
  }

  dimension_group: begin_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.begin_date ;;
    label: "Campaign Begin"
    description: "Start date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Campaign Category"
    description: "Category classification of the campaign"
    tags: ["category", "classification", "campaign"]
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

  dimension: languages {
    type: string
    sql: ${TABLE}.languages ;;
    label: "Languages"
    description: "Languages the campaign was launched in"
    tags: ["language", "localization"]
  }

  dimension: cappa_link {
    type: string
    sql: ${TABLE}.cappa_link ;;
    label: "CAPPA Link"
    description: "Link to the campaign listing within Cappa"
    tags: ["link", "tracking", "cappa"]
  }

  dimension: accept {
    type: number
    sql: ${TABLE}.accept ;;
    label: "Accepts"
    description: "Number of times the promotion was accepted; count of users per day who click on the promo"
    tags: ["engagement", "metrics", "acceptance"]
  }

  dimension: impression {
    type: number
    sql: ${TABLE}.impression ;;
    label: "Impressions"
    description: "Number of times the promotion was viewed; count of users who view the promo for any amount of time"
    tags: ["engagement", "metrics", "views"]
  }

  dimension: dismiss {
    type: number
    sql: ${TABLE}.dismiss ;;
    label: "Dismissals"
    description: "Number of times the promotion was dismissed; count of users who exit out of a promo"
    tags: ["engagement", "metrics", "dismissal"]
  }

  dimension: region_ctr_2 {
    type: number
    sql: ${TABLE}.region_ctr_2 ;;
    label: "Region CTR"
    description: "Click-through rate for campaigns at the regional level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "regional", "performance"]
  }

  dimension: country_ctr_2 {
    type: number
    sql: ${TABLE}.country_ctr_2 ;;
    label: "Country CTR"
    description: "Click-through rate for campaigns at the country level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "country", "performance"]
  }

  dimension: category_ctr_2 {
    type: number
    sql: ${TABLE}.category_ctr_2 ;;
    label: "Category CTR"
    description: "Click-through rate for campaigns by category"
    value_format_name: percent_2
    tags: ["metric", "ctr", "category", "performance"]
  }

  dimension: global_ctr_2 {
    type: number
    sql: ${TABLE}.global_ctr_2 ;;
    label: "Global CTR"
    description: "Click-through rate for campaigns at the global level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "global", "performance"]
  }

  dimension: approved_copy {
    type: string
    sql: ${TABLE}.approved_copy ;;
    label: "Approved Copy"
    description: "Copy, or wording, of the promo that was approved and launched as"
    tags: ["content", "copy", "approval"]
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
    label: "Product"
    description: "Product category of the promo"
    tags: ["product", "category"]
  }

  dimension: mobileOS_mapping {
    type: string
    sql: ${TABLE}.mobileOS_mapping ;;
    label: "Mobile OS Mapping"
    description: "Mobile operating system targeting mapping, such as Mobile OS, Android, Desktop, etc."
    tags: ["mobile", "os", "desktop"]
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

  dimension: GRL {
    type: string
    sql: ${TABLE}.GRL ;;
    label: "GRL"
    description: "Indicates whether the campaign is targeted locally or globally"
    tags: ["identifier", "global", "resource"]
  }

  dimension: campaign_category_mapping {
    type: string
    sql: ${TABLE}.campaign_category_mapping ;;
    label: "Campaign Category Mapping"
    description: "Mapping of campaign to specific categories"
    tags: ["campaign", "category", "mapping"]
  }

  # Measures
  measure: total_impressions {
    type: sum
    sql: ${impression} ;;
    label: "Total Impressions"
    description: "Total number of times promotions were viewed"
    tags: ["sum", "impressions", "engagement"]
  }

  measure: total_accepts {
    type: sum
    sql: ${accept} ;;
    label: "Total Accepts"
    description: "Total number of promotion accepts"
    tags: ["sum", "accepts", "engagement"]
  }

  measure: total_dismissals {
    type: sum
    sql: ${dismiss} ;;
    label: "Total Dismissals"
    description: "Total number of promotion dismissals"
    tags: ["sum", "dismissals", "engagement"]
  }

  measure: acceptance_rate {
    type: number
    sql: SAFE_DIVIDE(${total_accepts}, ${total_impressions}) ;;
    value_format_name: percent_2
    label: "Acceptance Rate"
    description: "Percentage of impressions that resulted in accepts"
    tags: ["rate", "acceptance", "engagement"]
  }

  measure: dismissal_rate {
    type: number
    sql: SAFE_DIVIDE(${total_dismissals}, ${total_impressions}) ;;
    value_format_name: percent_2
    label: "Dismissal Rate"
    description: "Percentage of impressions that resulted in dismissals"
    tags: ["rate", "dismissal", "engagement"]
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, country_name]
    label: "Count of Campaigns"
    description: "Total number of campaign records"
    tags: ["count", "campaigns"]
  }
}
