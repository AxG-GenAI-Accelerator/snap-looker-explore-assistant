# The name of this view in Looker is "Lookertestv8"
view: lookertestv8 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.explore_assistant.lookertestv8` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Activation Count 5mi" in Explore.

  dimension: activation_count_5mi {
    type: number
    sql: ${TABLE}.Activation_Count_5mi ;;
  }

  dimension: activation_count_per_store_5mi {
    type: number
    sql: ${TABLE}.Activation_Count_Per_Store_5mi ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.Address ;;
  }

  dimension: advocate_count {
    type: string
    sql: ${TABLE}.Advocate_Count ;;
  }

  dimension: all_partner_store_count_5mi {
    type: number
    sql: ${TABLE}.All_Partner_Store_Count_5mi ;;
  }

  dimension: android_volume_5mi {
    type: number
    sql: ${TABLE}.Android_Volume_5mi ;;
  }

  dimension: android_volume_per_store_5mi_ {
    type: number
    sql: ${TABLE}.Android_Volume_Per_Store_5mi_ ;;
  }

  dimension: apple_store_count_5mi {
    type: number
    sql: ${TABLE}.Apple_Store_Count_5mi ;;
  }

  dimension: buying_power_percentile {
    type: number
    sql: ${TABLE}.Buying_Power_Percentile ;;
  }

  dimension: campaign_count_20_yy {
    type: number
    sql: ${TABLE}.Campaign_Count_20YY ;;
  }

  dimension: chain_name {
    type: string
    sql: ${TABLE}.Chain_Name ;;
  }

  dimension: chain_type {
    type: string
    sql: ${TABLE}.Chain_Type ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: date_range {
    type: string
    sql: ${TABLE}.Date_Range ;;
  }

  dimension: daytime_population {
    type: number
    sql: ${TABLE}.Daytime_Population ;;
  }

  dimension: daytime_population_per_store {
    type: number
    sql: ${TABLE}.Daytime_Population_Per_Store ;;
  }

  dimension: dma {
    type: string
    sql: ${TABLE}.DMA ;;
  }

  dimension: employment_rate_5mi {
    type: number
    sql: ${TABLE}.Employment_Rate_5mi ;;
  }

  dimension: field_team_coverage {
    type: string
    sql: ${TABLE}.Field_Team_Coverage ;;
  }

  dimension: fit_percentile_3_p {
    type: number
    sql: ${TABLE}.Fit_Percentile_3P ;;
  }

  dimension: footfall {
    type: number
    sql: ${TABLE}.Footfall ;;
  }

  dimension: footfall_percentile {
    type: number
    sql: ${TABLE}.Footfall_Percentile ;;
  }

  dimension: google_influence_non_scoring_signal {
    type: number
    sql: ${TABLE}.Google_Influence_Non_Scoring_Signal ;;
  }

  dimension: gstore_sales_5mi {
    type: number
    sql: ${TABLE}.Gstore_Sales_5mi ;;
  }

  dimension: gstore_sales_per_store_5mi {
    type: number
    sql: ${TABLE}.Gstore_Sales_Per_Store_5mi ;;
  }

  dimension: i_phone_share {
    type: number
    sql: ${TABLE}.iPhone_Share ;;
  }

  dimension: ice_store_id {
    type: string
    sql: ${TABLE}.ICE_Store_ID ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.Latitude ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }


  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }

  dimension: lulu_store_count_5mi {
    type: number
    sql: ${TABLE}.Lulu_Store_Count_5mi ;;
  }

  dimension: median_income_for_families_5mi {
    type: number
    sql: ${TABLE}.Median_Income_For_Families_5mi ;;
  }

  dimension: median_income_for_nonfamilies_5mi {
    type: number
    sql: ${TABLE}.Median_Income_For_Nonfamilies_5mi ;;
  }

  dimension: merch_display {
    type: string
    sql: ${TABLE}.Merch_Display ;;
  }

  dimension: number_of_reviews {
    type: number
    sql: ${TABLE}.Number_Of_Reviews ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_number_of_reviews {
    type: sum
    sql: ${number_of_reviews} ;;  }
  measure: average_number_of_reviews {
    type: average
    sql: ${number_of_reviews} ;;  }

  dimension: number_of_stores_per_chain {
    type: number
    sql: ${TABLE}.Number_Of_Stores_Per_Chain ;;
  }

  dimension: overall_rating {
    type: number
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

  dimension: past_pixel_sales_percentile {
    type: number
    sql: ${TABLE}.Past_Pixel_Sales_Percentile ;;
  }

  dimension: past_pixel_sales_unit {
    type: number
    sql: ${TABLE}.Past_Pixel_Sales_Unit ;;
  }

  dimension: persona_budget {
    type: number
    sql: ${TABLE}.Persona_Budget ;;
  }

  dimension: persona_foldable_fans {
    type: number
    sql: ${TABLE}.Persona_Foldable_Fans ;;
  }

  dimension: persona_minimalist {
    type: number
    sql: ${TABLE}.Persona_Minimalist ;;
  }

  dimension: persona_technophile {
    type: number
    sql: ${TABLE}.Persona_Technophile ;;
  }

  dimension: persona_value_seekers {
    type: number
    sql: ${TABLE}.Persona_Value_Seekers ;;
  }

  dimension: pixel_awareness_percentile {
    type: number
    sql: ${TABLE}.Pixel_Awareness_Percentile ;;
  }

  dimension: pixel_consideration_percentile {
    type: number
    sql: ${TABLE}.Pixel_Consideration_Percentile ;;
  }

  dimension: pixel_fit_percentile {
    type: number
    sql: ${TABLE}.Pixel_Fit_Percentile ;;
  }

  dimension: pixel_growth_potential_percentile {
    type: number
    sql: ${TABLE}.Pixel_Growth_Potential_Percentile ;;
  }

  dimension: pixel_purchase_percentile {
    type: number
    sql: ${TABLE}.Pixel_Purchase_Percentile ;;
  }

  dimension: pixel_search_5mi {
    type: number
    sql: ${TABLE}.Pixel_Search_5mi ;;
  }

  dimension: pixel_search_per_store_5mi {
    type: number
    sql: ${TABLE}.Pixel_Search_Per_Store_5mi ;;
  }

  dimension: pixel_share {
    type: number
    sql: ${TABLE}.Pixel_Share ;;
  }

  dimension: population_density_5mi {
    type: number
    sql: ${TABLE}.Population_Density_5mi ;;
  }

  dimension: rolling_all_partners_three_years_activations {
    type: number
    sql: ${TABLE}.Rolling_All_Partners_Three_Years_Activations ;;
  }

  dimension: same_partner_store_count_5mi {
    type: number
    sql: ${TABLE}.Same_Partner_Store_Count_5mi ;;
  }

  dimension: samsung_share {
    type: number
    sql: ${TABLE}.Samsung_Share ;;
  }

  dimension: samsung_store_count_5mi {
    type: number
    sql: ${TABLE}.Samsung_Store_Count_5mi ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.Segment_Name ;;
  }

  dimension: segment_number {
    type: number
    sql: ${TABLE}.Segment_Number ;;
  }

  dimension: sephora_store_count__5mi {
    type: number
    sql: ${TABLE}.Sephora_Store_Count__5mi ;;
  }

  dimension: smartphone_households_5mi {
    type: number
    sql: ${TABLE}.Smartphone_Households_5mi ;;
  }

  dimension: smartphone_households_per_store_5mi {
    type: number
    sql: ${TABLE}.Smartphone_Households_Per_Store_5mi ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: store_performance_percentile {
    type: number
    sql: ${TABLE}.Store_Performance_Percentile ;;
  }

  dimension: store_review {
    type: number
    sql: ${TABLE}.Store_Review ;;
  }

  dimension: store_review_percentile {
    type: number
    sql: ${TABLE}.Store_Review_Percentile ;;
  }

  dimension: strategic_tiering {
    type: string
    sql: ${TABLE}.Strategic_Tiering ;;
  }

  dimension: target_market_percentile {
    type: number
    sql: ${TABLE}.Target_Market_Percentile ;;
  }

  dimension: tier {
    type: string
    sql: ${TABLE}.Tier ;;
  }

  dimension: top_store_covered_30mi {
    type: number
    sql: ${TABLE}.Top_Store_Covered_30mi ;;
  }

  dimension: top_stores_uncovered_30mi {
    type: number
    sql: ${TABLE}.Top_Stores_Uncovered_30mi ;;
  }

  dimension: user_volume_percentile {
    type: number
    sql: ${TABLE}.User_Volume_Percentile ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.Zip ;;
  }
  measure: count {
    type: count
    drill_fields: [segment_name, chain_name]
  }
}
