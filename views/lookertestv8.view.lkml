view: lookertestv8 {
  sql_table_name: oxjytxr-mss-mkt-genai-accel.explore_assistant.lookertestv8 ;;
  dimension: store_id {
    type: string
    description: "Unique identifier for each store"
    sql: ${TABLE}.ICE_Store_ID ;;
    label: "store_id"
    tags: ["store"]
  }
  dimension: dma {
    type: string
    description: "Designated Market Area (DMA) the store is in"
    sql: ${TABLE}.DMA ;;
    label: "dma"
    tags: ["geography"]
  }
  dimension: store_location {
    type: location
    description: "Combined latitude and longitude of the store location"
    sql_latitude:${TABLE}.Latitude ;;
    sql_longitude:${TABLE}.Longitude ;;
    label: "store_location"
    tags: ["geography", "store", "map"]
  }
  dimension: past_pixel_sales_unit {
    type: number
    description: "Number of Pixel units sold historically"
    sql: ${TABLE}.Past_Pixel_Sales_Unit ;;
    label: "past_pixel_sales_unit"
    tags: ["pixel", "sales"]
  }
  dimension: past_pixel_sales_percentile {
    type: number
    description: "Percentile rank of historical Pixel sales performance"
    sql: ${TABLE}.Past_Pixel_Sales_Percentile;;
    value_format_name: decimal_0
    label: "past_pixel_sales_percentile"
    tags: ["pixel", "sales", "percentile"]
  }
  dimension: store_overall_rating {
    type: number
    description: "Overall Google review rating score for the store"
    sql: ${TABLE}.Overall_Rating ;;
    label: "store_overall_rating"
    tags: ["rating","store"]
  }
  dimension: footfall {
    type: number
    description: "Foot traffic in the store"
    sql: ${TABLE}.Footfall ;;
    label: "footfall"
    tags: ["footfall"]
  }
  dimension: tier_color {
    type: number
    description: "Color corresponding to each possible tier a store could be in"
    case: {
      when: {
        sql: ${strategic_tiering} = "Pyramid Tier 1" ;;
        label: "1"
      }
      when: {
        sql:${strategic_tiering} = "Pyramid Tier 2" ;;
        label: "2"
      }
      when: {
        sql: ${strategic_tiering} = "Pyramid Tier 3" ;;
        label: "3"
      }
      when: {
        sql: ${strategic_tiering} = "Pyramid Tier 4" ;;
        label: "4"
      }
      when: {
        sql: ${strategic_tiering} = "Pyramid Tier 5" ;;
        label: "5"
      }
    }
    label: "tier_color"
    tags: ["tier", "color", "map"]
  }
  dimension: store_city {
    type: string
    description: "City the store is located in"
    sql: ${TABLE}.City ;;
    label: "store_city"
    tags: ["geography","store"]
  }
  dimension: store_zip {
    type: zipcode
    description: "ZIP code of the store's location"
    sql: ${TABLE}.Zip ;;
    label: "store_zip"
    tags: ["geography", "zip", "store"]
  }
  dimension: store_state {
    type: string
    description: "State the store is located in"
    sql: ${TABLE}.State ;;
    label: "store_state"
    tags: ["geography", "store"]
  }
  dimension: growth_potential_by_store {
    type: number
    description: "Growth potential per store"
    sql: ${TABLE}.Pixel_Growth_Potential_Percentile ;;
    label: "growth_potential_unit"
    tags: ["pixel", "growth_potential","by store", "percentile"]
  }
  dimension: strategic_tiering {
    type: string
    description: "Strategic tier the store falls into (e.g. Pyramid Tier 1, Pyramid Tier 2, etc.)"
    sql: CASE
        WHEN ${TABLE}.Strategic_Tiering != 'Pyramid Tier 6' THEN ${TABLE}.Strategic_Tiering
        ELSE NULL
      END ;;
    label: "strategic_tiering"
    tags: ["store", "tier"]
  }
  dimension: partner {
    type: string
    description: "Name of the carrier partner"
    sql:${TABLE}.Partner;;
    label: "partner"
    tags: ["partner"]
  }
  dimension: chain {
    type: string
    description: "Name of the store chain"
    sql: ${TABLE}.Chain_Name ;;
    label: "chain"
    tags: ["chain"]
  }
  dimension: chain_type {
    type: string
    description: "Type of store (dealer or corporate)"
    sql: ${TABLE}.Chain_Type ;;
    label: "chain_type"
    tags: ["chain"]
  }
  dimension: store_address {
    type: string
    description: "Street address of the store"
    sql: ${TABLE}.Address ;;
    label: "store_address"
    tags: ["geography","store"]
  }
  measure: count_true{
    type: sum
    description: "Count of stores that are covered"
    sql: CASE WHEN ${TABLE}.Field_Team_Coverage = 'Covered' THEN 1 ELSE 0 END ;;
    label: "count_true"
    tags: ["count"]
  }
  measure: coverage_percentage{
    type: number
    sql: ${count_true}/ ${count};;
    description: "Percentage of rows where coverage is true out of all the entries being looked at"
    value_format_name: percent_0
    label: "coverage_percentage"
    tags: ["percentage", "coverage"]
  }
  measure: sales_sum{
    type: sum
    sql: ${past_pixel_sales_unit};;
    description: "Sum of all the past_pixel_sales units which works as a sum of sales"
    value_format_name: decimal_0
    label: "sales_sum"
    tags: ["pixel", "sales", "sum"]
  }
  measure: growth_potential_average{
    type: average
    sql: ${growth_potential_by_store};;
    description: "Average growth percentage used when stating the growth potential for a group of entire"
    value_format_name: percent_0
    label: "growth_percentage_average"
    tags: ["pixel", "growth_potential", "average"]
  }
  measure: count {
    type: count
    description: "Count of stores, can be used to get the number of stores in a tier, partner, etc."
    label: "count"
    tags: ["count", "store"]
  }
  dimension: partner_group {
    type: string
    description: "Group of values associated to a distinct partner"
    sql: CASE
          WHEN ${TABLE}.Partner LIKE '%T-Mobile%' THEN 'T-Mobile'
          WHEN ${TABLE}.Partner LIKE '%Verizon%' THEN 'Verizon'
          WHEN ${TABLE}.Partner LIKE '%BestBuy%' THEN 'Best Buy'
          WHEN ${TABLE}.Partner LIKE '%ATT%' THEN 'AT&T'
          ELSE 'Other'
        END ;;
    label: "partner_group"
    tags: ["partner", "group"]
  }
}
