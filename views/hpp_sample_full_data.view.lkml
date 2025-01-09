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
    label: "Accepts"
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
    sql: DATE(${TABLE}.begin_date) ;;
    label: "Begin"
    description: "Start date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

  dimension: campaign_description {
    type: string
    sql: ${TABLE}.campaign_description ;;
    label: "Description"
    description: "Detailed description of the marketing campaign, including the campaign type (pushup, middleslot, callout), short description, and date"
    tags: ["campaign", "description", "details"]
  }

  dimension: campaign_id {
    type: number
    primary_key: yes  # Added as this appears to be a unique identifier
    sql: ${TABLE}.campaign_id ;;
    label: "Campaign ID"
    description: "Unique identifier for each marketing campaign"
    value_format: "0"
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
    suggestions: ["AI", "About", "Account", "Ads Marketing", "Android", "Arts and Culture", "Be Internet Awesome", "Career Certificates", "Chrome", "Chromebook", "Civics", "Devices and Services", "Digital Responsibility", "Digital Wellbeing", "Digital Workshop", "Diversity & Inclusion", "Doodles", "Drive", "Economic Opportunity", "Education", "Family Link", "Fitbit", "Gemini Basic", "Google (GSA)", "Google Analytics", "Google Business Profile", "Google Cloud Platform", "Google Fi", "Google Lens", "Google Maps", "Google Nest", "Google One", "Google Photos", "Google Play Gift Cards", "Google Pixel", "Google Play", "Google Research", "Google Search", "Google Shopping", "Google Store", "Google TV", "Google Wifi", "Google Workspace", "Google.org", "Growth", "GwG", "Kids & Family", "Learning", "Merchant Center", "My Ad Center", "Nest Renew", "Other", "Payments", "Privacy", "Privacy B2B", "SMB", "Security", "Sustainability", "The Keyword", "Think With Google", "Translate", "Wallet"]
  }

  dimension: cappa_product_area {
    type: string
    sql: ${TABLE}.cappa_product_area ;;
    label: "CAPPA Product Area"
    description: "Product area classification in CAPPA system"
    tags: ["product", "area", "cappa"]
    suggestions: ["Ads/B2B", "Brand & Reputation", "Consumer Apps Marketing", "Google Cloud", "Grow with Google", "HPP Initiatives", "Non-PA: Account", "Non-PA: Growth", "Platforms & Devices", "YouTube"]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Category"
    description: "Category classification of the campaign"
    tags: ["category", "classification", "campaign"]
    suggestions: ["Brand Perception - Brand Awareness", "Brand Perception - Celebrations & Commerations", "Brand Perception - Community Initiatives", "Critical Information - Civics & Politics", "Critical Information - Health & Safety", "Critical Information - SOS & Public Alerts", "Other", "Product Updates - Business Apps", "Product Updates - Consumer Apps", "Product Updates - Devices & Services", "Product Updates - Other", "Product Updates - Security & Trust", "Product Updates - YouTube"]
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country"
    description: "Name of the country where the campaign was run"
    tags: ["geography", "location", "country"]
  }

  measure: ctr {
    type: number
    sql: SAFE_DIVIDE(SUM(${TABLE}.accept), SUM(${TABLE}.impression)) ;;    # Use the pre-calculated CTR from table
    label: "CTR"
    description: "Average CTR across filtered campaigns"
    value_format_name: percent_2
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
    label: "Device"
    description: "Type of device where the promotion was displayed"
    tags: ["device", "platform", "technical"]
    suggestions: ["Desktop", "Mobile"]
  }

  # Convert to measure - represents count of dismissal events
  measure: dismiss {
    type: sum
    sql: ${TABLE}.dismiss ;;
    label: "Dismissals"
    description: "Total number of times the promotion was dismissed; sum of users who exit out of a promo"
    tags: ["engagement", "metrics", "dismissal"]
  }

  dimension_group: end_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    datatype: date
    sql: DATE(${TABLE}.end_date) ;;
    label: "End"
    description: "End date of the campaign"
    tags: ["date", "campaign", "timing"]
  }

  dimension: flag {
    type: string
    sql: ${TABLE}.flag ;;
    label: "Type"
    description: "Type indicator for campaign status or special conditions"
    tags: ["status", "indicator", "campaign"]
    suggestions: ["Evergreen", "Experiment", "Onetime"]
  }

  dimension: grl {
    type: string
    sql: ${TABLE}.GRL ;;
    label: "GRL"
    description: "Indicates whether the campaign is targeted locally or globally"
    tags: ["identifier", "global", "resource"]
    suggestions: ["Global","Local","Regional"]
  }

  dimension: hpp_format {
    type: string
    sql: ${TABLE}.hpp_format ;;
    label: "HPP Format"
    description: "Format type of the campaign: pushup, callout, or middleslot"
    tags: ["promotion", "format", "homepage", "campaign"]
    suggestions: ["Callout","Middle","Pushup"]
  }

  # Convert to measure - represents count of impression events
  measure: impression {
    type: sum
    sql: ${TABLE}.impression ;;
    label: "Impressions"
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
    suggestions: ["All Mobile OS", "Android and iOS", "Android only", "Desktop", "iOS only"]
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
    label: "Product"
    description: "Product category of the promo"
    tags: ["product", "category"]
    suggestions: ["CHROME", "GMAIL", "MY_ACCOUNT", "MY_ACTIVITY", "OTHER", "SEARCH", "SIGN_IN_WITH_GOOGLE", "UNKNOWN"]
  }

  dimension: promo_id {
    type: number
    sql: ${TABLE}.promo_id ;;
    label: "Promotion ID"
    description: "Unique identifier for each promotional campaign"
    value_format: "0"
    tags: ["promotion", "id", "identifier"]
  }

  dimension: properties {
    type: string
    sql: ${TABLE}.properties ;;
    label: "Properties"
    description: "Properties associated with the campaign"
    tags: ["properties", "attributes", "campaign"]
    suggestions: ["Calendar", "Calendar, Gmail, Inbox, Drive", "Catalog, Compare, Offers, Sites, Social Good, Play Games, Support Content (Help center), Play", "Chrome New Tab", "Docs", "Docs, Slides, Sheets", "Drive", "Drive, Docs, Sheets, Slides", "Drive, Docs, Slides, Sheets", "Drive, Gmail", "Drive, Gmail, Inbox, Calendar", "Drive, Sheets, Docs, Slides", "Gmail", "Gmail, Calendar, Inbox", "Gmail, Drive", "Maps", "Maps, Search HP, Search HP (image), Search HP (video)", "News (news.google.com), Search HP (news)", "Others", "Photos", "Play", "Search HP", "Search HP (image)", "Search HP (image), Search HP (video)", "Search HP (image), Search HP (video), Search HP", "Search HP (image), Search HP Search HP (video)", "Search HP (video), Search HP (image), Search HP", "Search HP (video), Search HP (image), Search HP, Gmail", "Search HP, Chrome New Tab", "Search HP, Search HP (image)", "Search HP, Search HP (image), Search HP (video)", "Search HP, Search HP (image), Search HP (video), Chrome New Tab", "Search HP, Search HP (image), Search HP (video), Drive, Gmail, Photos, Maps", "Search HP, Search HP (image), Search HP (video), Gmail", "Search HP Search HP (video), Search HP (image)", "Sheets", "Sheets, Slides, Docs, Drive", "Shopping HP, Maps, Search HP, Gmail, Chrome New Tab", "Slides", "Slides, Sheets, Docs, Drive", "Translate"]
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    label: "Region"
    description: "Geographic region where the campaign was targeted"
    tags: ["geography", "region", "location"]
    suggestions: ["APAC", "EMEA", "Global", "LATAM", "NORTHAM"]
  }

  dimension: targeted_properties {
    type: string
    sql: ${TABLE}.targeted_properties ;;
    label: "Targeted Properties"
    description: "Specific mediums/properties targeted by the promotional ad, such as Search HP"
    tags: ["targeting", "properties"]
    suggestions: ["Chrome New Tab", "Others", "Search HP"]
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
    label: "Dismissal Rate"
    description: "Rate of dismissals per impression"
    value_format_name: percent_2
    tags: ["rate", "dismissal", "engagement"]
  }
  measure: region_ctr {
    type: average
    sql: ${TABLE}.region_ctr_2 / 100.0;;
    label: "Region CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the region level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "region", "benchmark"]
  }

  measure: country_ctr {
    type: average
    sql: ${TABLE}.country_ctr_2 / 100.0;;
    label: "Country CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the country level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "country", "benchmark"]
  }

  measure: category_ctr {
    type: average
    sql: ${TABLE}.category_ctr_2 / 100.0;;
    label: "Category CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the category level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "category", "benchmark"]
  }

  measure: global_ctr {
    type: average
    sql: ${TABLE}.global_ctr_2 / 100.0;;
    label: "Global CTR Benchmark"
    description: "Benchmark of click-through rate aggregated at the global level"
    value_format_name: percent_2
    tags: ["metric", "ctr", "performance", "global", "benchmark"]
  }
  dimension: day_of_week {
    type: string
    sql: CASE EXTRACT(DAYOFWEEK FROM ${begin_date_date})
          WHEN 1 THEN 'Sunday'
          WHEN 2 THEN 'Monday'
          WHEN 3 THEN 'Tuesday'
          WHEN 4 THEN 'Wednesday'
          WHEN 5 THEN 'Thursday'
          WHEN 6 THEN 'Friday'
          WHEN 7 THEN 'Saturday'
         END ;;
    label: "Day of Week"
    description: "The day of the week for the campaign begin date"
    tags: ["date", "campaign", "timing", "day_of_week"]
    order_by_field: day_of_week_index  # This will ensure proper day ordering
  }

  dimension: day_of_week_index {
    type: number
    sql: EXTRACT(DAYOFWEEK FROM ${begin_date_date}) ;;
    hidden: yes  # This dimension is just for sorting, not for display
  }
  measure: average_impressions {
    type: average
    sql: ${TABLE}.impression ;;
    label: "Average Impressions"
    description: "Average number of impressions per grouped dimension (e.g., per day of week)"
    value_format_name: decimal_0
    tags: ["engagement", "metrics", "views", "average"]
  }

  measure: average_accepts {
    type: average
    sql: ${TABLE}.accept ;;
    label: "Average Accepts"
    description: "Average number of accepts per grouped dimension (e.g., per day of week)"
    value_format_name: decimal_0
    tags: ["engagement", "metrics", "acceptance", "average"]
  }

  measure: average_dismissals {
    type: average
    sql: ${TABLE}.dismiss ;;
    label: "Average Dismissals"
    description: "Average number of dismissals per grouped dimension (e.g., per day of week)"
    value_format_name: decimal_0
    tags: ["engagement", "metrics", "dismissal", "average"]
  }


}
