# The name of this view in Looker is "Lookertestv8"
view: lookertestv8 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `oxjytxr-mss-mkt-genai-accel.lookertest.lookertestv8` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called " 3 P Fit Percentile " in Explore.

  dimension: _3_p_fit__percentile_ {
    type: number
    sql: ${TABLE}._3P_Fit__Percentile_ ;;
  }

  dimension: __of_reviews {
    type: number
    sql: ${TABLE}.__of_Reviews ;;
  }

  dimension: activation_count___5mi__ {
    type: number
    sql: ${TABLE}.Activation_Count___5mi__ ;;
  }

  dimension: activation_count___store___log_store_count_5mi_ {
    type: number
    sql: ${TABLE}.Activation_Count___Store___Log_Store_Count_5mi_ ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.Address ;;
  }

  dimension: advocate_count {
    type: string
    sql: ${TABLE}.Advocate_Count ;;
  }

  dimension: all_partner_store_count__5mi_ {
    type: number
    sql: ${TABLE}.All_Partner_Store_Count__5mi_ ;;
  }

  dimension: android_volume__5mi_ {
    type: number
    sql: ${TABLE}.Android_Volume__5mi_ ;;
  }

  dimension: android_volume___store___log_store_count_5mi__ {
    type: number
    sql: ${TABLE}.Android_Volume___Store___Log_Store_Count_5mi__ ;;
  }

  dimension: apple_store_count___5mi_ {
    type: number
    sql: ${TABLE}.Apple_Store_Count___5mi_ ;;
  }

  dimension: buying_power__percentile_ {
    type: number
    sql: ${TABLE}.Buying_Power__Percentile_ ;;
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

  dimension: daytime_population___store___log_store_count_ {
    type: number
    sql: ${TABLE}.Daytime_Population___Store___Log_Store_Count_ ;;
  }

  dimension: dma {
    type: string
    sql: ${TABLE}.DMA ;;
  }

  dimension: employment_rate__5mi_ {
    type: number
    sql: ${TABLE}.Employment_Rate__5mi_ ;;
  }

  dimension: field_team_coverage {
    type: string
    sql: ${TABLE}.Field_Team_Coverage ;;
  }

  dimension: footfall {
    type: number
    sql: ${TABLE}.Footfall ;;
  }

  dimension: footfall__percentile_ {
    type: number
    sql: ${TABLE}.Footfall__Percentile_ ;;
  }

  dimension: google_influence__non_scoring_signal_ {
    type: number
    sql: ${TABLE}.Google_Influence__Non_Scoring_Signal_ ;;
  }

  dimension: gstore_sales__5mi_ {
    type: number
    sql: ${TABLE}.Gstore_Sales__5mi_ ;;
  }

  dimension: gstore_sales___store___log_store_count_5mi_ {
    type: number
    sql: ${TABLE}.Gstore_Sales___Store___Log_Store_Count_5mi_ ;;
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

  dimension: longitude {
    type: number
    sql: ${TABLE}.Longitude ;;
  }

  dimension: lulu_store_count___5mi_ {
    type: number
    sql: ${TABLE}.Lulu_Store_Count___5mi_ ;;
  }

  dimension: median_income_for_families__5mi_ {
    type: number
    sql: ${TABLE}.Median_Income_For_Families__5mi_ ;;
  }

  dimension: median_income_for_nonfamilies__5mi_ {
    type: number
    sql: ${TABLE}.Median_Income_For_Nonfamilies__5mi_ ;;
  }

  dimension: merch_display {
    type: string
    sql: ${TABLE}.Merch_Display ;;
  }

  dimension: number_of_stores___chain {
    type: number
    sql: ${TABLE}.Number_Of_Stores___Chain ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_number_of_stores___chain {
    type: sum
    sql: ${number_of_stores___chain} ;;  }
  measure: average_number_of_stores___chain {
    type: average
    sql: ${number_of_stores___chain} ;;  }

  dimension: overall_rating {
    type: number
    sql: ${TABLE}.Overall_Rating ;;
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.Partner ;;
  }

  dimension: past_pixel_sales__percentile_ {
    type: number
    sql: ${TABLE}.Past_Pixel_Sales__Percentile_ ;;
  }

  dimension: past_pixel_sales__unit_ {
    type: number
    sql: ${TABLE}.Past_Pixel_Sales__Unit_ ;;
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

  dimension: pixel_awareness__percentile_ {
    type: number
    sql: ${TABLE}.Pixel_Awareness__Percentile_ ;;
  }

  dimension: pixel_consideration__percentile_ {
    type: number
    sql: ${TABLE}.Pixel_Consideration__Percentile_ ;;
  }

  dimension: pixel_fit__percentile_ {
    type: number
    sql: ${TABLE}.Pixel_Fit__Percentile_ ;;
  }

  dimension: pixel_growth_potential___percentile_ {
    type: number
    sql: ${TABLE}.Pixel_Growth_Potential___Percentile_ ;;
  }

  dimension: pixel_purchase__percentile_ {
    type: number
    sql: ${TABLE}.Pixel_Purchase__Percentile_ ;;
  }

  dimension: pixel_search__5mi_ {
    type: number
    sql: ${TABLE}.Pixel_Search__5mi_ ;;
  }

  dimension: pixel_search___store___log_store_count_5mi_ {
    type: number
    sql: ${TABLE}.Pixel_Search___Store___Log_Store_Count_5mi_ ;;
  }

  dimension: pixel_share {
    type: number
    sql: ${TABLE}.Pixel_Share ;;
  }

  dimension: population_density__5mi_ {
    type: number
    sql: ${TABLE}.Population_Density__5mi_ ;;
  }

  dimension: rolling_all_partners_three_years_activations {
    type: number
    sql: ${TABLE}.Rolling_All_Partners_Three_Years_Activations ;;
  }

  dimension: same_partner_store_count__5mi_ {
    type: number
    sql: ${TABLE}.Same_Partner_Store_Count__5mi_ ;;
  }

  dimension: samsung_share_ {
    type: number
    sql: ${TABLE}.Samsung_Share_ ;;
  }

  dimension: samsung_store_count___5mi_ {
    type: number
    sql: ${TABLE}.Samsung_Store_Count___5mi_ ;;
  }

  dimension: seg_no_ {
    type: number
    sql: ${TABLE}.Seg_No_ ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.Segment_Name ;;
  }

  dimension: sephora_store_count___5mi_ {
    type: number
    sql: ${TABLE}.Sephora_Store_Count___5mi_ ;;
  }

  dimension: smartphone_hh___store__log_store_count_5mi_ {
    type: number
    sql: ${TABLE}.Smartphone_HH___Store__Log_Store_Count_5mi_ ;;
  }

  dimension: smartphone_households__5mi_ {
    type: number
    sql: ${TABLE}.Smartphone_Households__5mi_ ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: store_performance__percentile_ {
    type: number
    sql: ${TABLE}.Store_Performance__Percentile_ ;;
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

  dimension: target_market__percentile_ {
    type: number
    sql: ${TABLE}.Target_Market__Percentile_ ;;
  }

  dimension: tier {
    type: string
    sql: ${TABLE}.Tier ;;
  }

  dimension: top_store_covered___30mi_ {
    type: number
    sql: ${TABLE}.Top_Store_Covered___30mi_ ;;
  }

  dimension: top_stores_uncovered___30mi_ {
    type: number
    sql: ${TABLE}.Top_Stores_Uncovered___30mi_ ;;
  }

  dimension: user_volume___percentile_ {
    type: number
    sql: ${TABLE}.User_Volume___Percentile_ ;;
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
