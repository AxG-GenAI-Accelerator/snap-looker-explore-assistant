view: snap_contentmoderation_data {
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.looker_sandbox.snap_contentmoderation_data` ;;

  dimension: creation_timestamp_hour_of_day {
    type: number
    sql: ${TABLE}.`Creation Timestamp Hour of Day` ;;
    label: "Creation Hour"
    tags: ["creation_hour","essential"]
    description: "Creation Hour of content in our Moderation tool. Helps analyze hourly trends."
  }

  dimension_group: creation_timestamp_time {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.`Creation Timestamp Time` ;;
    label: "Creation Time"
    tags: ["creation_timestamp"]
    description: "Creation Time down to seconds of content in our Moderation tool."
  }
  dimension: market {
    type: string
    sql: ${TABLE}.Market ;;
    label: "Market"
    tags: ["location", "market","essential"]
    description: "Market where the content was processed. Examples include English, Arabic markets."
  }

  dimension: workflow {
    type: string
    sql: ${TABLE}.Workflow ;;
    label: "Workflow"
    tags: ["process"]
    description: "Covers 18 different workflows. Used to analyze Workflow TAT, AHT, etc."
  }

  dimension: moderator_id {
    type: string
    sql: ${TABLE}.`Moderator ID` ;;
    label: "Moderator ID"
    tags: ["moderator_id","Agent"]
    description: "ID of ACN employee who processed the item. Helps analyze top contributors."
  }

  dimension: decision {
    type: string
    sql: ${TABLE}.Decision ;;
    label: "Decision"
    tags: ["content", "action"]
    description: "Decision on content: mark as violating or non-violating. Helps analyze action ratio."
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
    label: "Location"
    tags: ["location", "user","essential"]
    description: "Location from which the ACN employee is working. Used to analyze contributor trends."
  }

  dimension: language_skill {
    type: string
    sql: ${TABLE}.`Language Skill` ;;
    label: "Language Skill"
    tags: ["skill", "user"]
    description: "Primary Language Skill of ACN employee. Helps assess market contribution and AHT per skill."
  }

  dimension: duration_secs {
    type: number
    sql: ${TABLE}.`Duration Secs` ;;
    label: "Duration (Secs)"
    tags: ["time"]
    description: "Time taken to process content. Used to derive AHT and sum handle time."
  }

  dimension: num_tasks {
    type: number
    sql: ${TABLE}.`Num Tasks` ;;
    label: "Number of Tasks"
    tags: ["count"]
    description: "Number of content items processed in an interval. Used for volume analysis."
  }

  dimension: pending_hrs {
    type: number
    sql: ${TABLE}.`Pending hrs` ;;
    label: "Pending Hours"
    tags: ["time", "TAT"]
    description: "TAT or Turnaround Time: How long content remains before moderation. Used to analyze P90 TAT."
  }

  dimension: video_length {
    type: number
    sql: ${TABLE}.`Video Length` ;;
    label: "Video Length"
    tags: ["content", "media"]
    description: "Length of content (videos) requiring moderation. Helps assess delta between AHT and video length."
  }

  measure: count {
    type: count
    label: "Total Count"
    tags: ["aggregation", "count"]
    description: "Total count of content processed. Used for overall volume tracking."
  }

  measure: sum_pending_hrs {
    type: number
    sql: SUM(${pending_hrs}) ;;
    label: "Total Pending Hours"
    tags: ["aggregation", "TAT"]
    description: "Sum of pending hours before moderation. Used to assess overall TAT."
  }

  measure: avg_duration_secs{
    type: number
    sql:  AVG(${duration_secs});;
    label: "Average Duration"
    tags: ["performance", "AHT"]
    description: "Average time taken to moderate an item. Used for AHT analysis."
  }
  measure: sum_output{
    type: number
    sql:  SUM(${num_tasks});;
    label: "Total Number of Task"
    tags: ["Total Task","Agent Performance"]
    description: "Total Number of Task compeleted by agents"
  }
  measure: Total_agent{
    type: number
    sql:  Count(${moderator_id});;
    label: "Total Count Agent"
    tags: ["output_agent"]
    description: "Total Count of agent"
  }
  measure: target{
    type: number
    sql:  target = 6;;
    tags: ["target"]
    description: "set target"
  }

  measure: today_date {
    type: string
    sql: CURRENT_DATE() ;;
    label: "Today’s Date"
    tags: ["date", "system"]
    description: "Returns the current date from the system. Useful for comparisons and filters."
  }
}
