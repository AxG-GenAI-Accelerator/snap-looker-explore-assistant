# The name of this view in Looker is "Demo Gemini Retail Data"
view: demo_gemini_retail_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.explore_assistant.demo_gemini_retail_data` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Branch" in Explore.

  dimension: branch {
    type: string
    sql: ${TABLE}.Branch ;;
  }


  dimension: mapLocation {
    type: location
    sql_latitude:${TABLE}.Latitude ;;
    sql_longitude:${TABLE}.Longitude ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.COGS ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.Customer ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension: gross_margin {
    type: number
    sql: ${TABLE}.Gross_Margin ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_gross_margin {
    type: sum
    sql: ${gross_margin} ;;  }
  measure: average_gross_margin {
    type: average
    sql: ${gross_margin} ;;  }

  dimension: gross_margin_percent {
    type: number
    sql: ${TABLE}.Gross_Margin_Percent ;;
  }

  dimension: invoice_id {
    type: string
    sql: ${TABLE}.Invoice_ID ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }

  dimension: payment {
    type: string
    sql: ${TABLE}.Payment ;;
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.Product_Category ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }

  dimension: tax_5_ {
    type: number
    sql: ${TABLE}.Tax_5_ ;;
  }

  dimension: time {
    type: string
    sql: ${TABLE}.Time ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.Total ;;
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.Unit_Price ;;
  }
  measure: count {
    type: count
  }
}
