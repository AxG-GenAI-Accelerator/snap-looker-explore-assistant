# The name of this view in Looker is "Lookertestv8"
view: lookertestv8 {
  sql_table_name: oxjytxr-mss-mkt-genai-accel.explore_assistant.lookertestv8 ;;
  dimension: activation_count_5mi {
    type: number
    description: "Number of activations within a 5 mile radius of the store"
    sql: ${TABLE}.Activation_Count_5mi ;;
  }
  dimension: activation_count_per_store_5mi {
    type: number
    description: "Average number of activations per store within a 5 mile radius"
    sql: ${TABLE}.Activation_Count_Per_Store_5mi ;;
  }
  dimension: address {
    type: string
    description: "Street address of the store"
    sql: ${TABLE}.Address ;;
  }
  dimension: advocate_count {
    type: string
    description: "Number of advocates or salespeople in the store"
    sql: ${TABLE}.Advocate_Count ;;
  }
  dimension: all_partner_store_count_5mi {
    type: number
    description: "Number of partner stores from all carriers within a 5 mile radius"
    sql: ${TABLE}.All_Partner_Store_Count_5mi ;;
  }
  dimension: android_volume_5mi {
    type: number
    description: "Volume of Android devices within a 5 mile radius"
    sql: ${TABLE}.Android_Volume_5mi ;;
  }
  dimension: android_volume_per_store_5mi {
    type: number
    description: "Average Android device volume per store within a 5 mile radius"
    sql: ${TABLE}.Android_Volume_Per_Store_5mi ;;
  }
  dimension: apple_store_count_5mi {
    type: number
    description: "Number of Apple stores within a 5 mile radius"
    sql: ${TABLE}.Apple_Store_Count_5mi ;;
  }
  dimension: buying_power_percentile {
    type: number
    description: "Buying power percentile rank of the area"
    sql: ${TABLE}.Buying_Power_Percentile ;;
  }
  dimension: campaign_count_20_yy {
    type: number
    description: "Number of campaigns run in 2020"
    sql: ${TABLE}.Campaign_Count_20YY ;;
  }
  dimension: chain_name {
    type: string
    description: "Name of the store chain"
    sql: ${TABLE}.Chain_Name ;;
  }
  dimension: chain_type {
    type: string
    description: "Type of store (dealer or corporate)"
    sql: ${TABLE}.Chain_Type ;;
  }
  dimension: city {
    type: string
    description: "City the store is located in"
    sql: ${TABLE}.City ;;
  }
  dimension: date_range {
    type: string
    description: "Date range the data covers"
    sql: ${TABLE}.Date_Range ;;
  }
  dimension: daytime_population {
    type: number
    description: "Daytime population in the area"
    sql: ${TABLE}.Daytime_Population ;;
  }
  dimension: daytime_population_per_store {
    type: number
    description: "Average daytime population per store in the area"
    sql: ${TABLE}.Daytime_Population_Per_Store ;;
  }
  dimension: dma {
    type: string
    description: "Designated Market Area (DMA) the store is in"
    sql: ${TABLE}.DMA ;;
  }
  dimension: employment_rate_5mi {
    type: number
    description: "Employment rate within a 5 mile radius"
    sql: ${TABLE}.Employment_Rate_5mi ;;
  }
  dimension: field_team_coverage {
    type: string
    description: "Indicates if the store has field team coverage"
    sql: ${TABLE}.Field_Team_Coverage ;;
  }
  dimension: fit_percentile_3_p {
    type: number
    description: "3P carrier fit percentile rank (how well positioned the store is to sell Pixel)"
    sql: ${TABLE}.Fit_Percentile_3P ;;
  }
  dimension: footfall {
    type: number
    description: "Foot traffic volume in the store"
    sql: ${TABLE}.Footfall ;;
  }
  dimension: footfall_percentile {
    type: number
    description: "Foot traffic percentile rank compared to other stores"
    sql: ${TABLE}.Footfall_Percentile ;;
  }
  dimension: google_influence_non_scoring_signal {
    type: number
    description: "Google's influence in the area (non-scoring signal)"
    sql: ${TABLE}.Google_Influence_Non_Scoring_Signal ;;
  }
  dimension: gstore_sales_5mi {
    type: number
    description: "Google Store sales within a 5 mile radius"
    sql: ${TABLE}.Gstore_Sales_5mi ;;
  }
  dimension: gstore_sales_per_store_5mi {
    type: number
    description: "Average Google Store sales per store within a 5 mile radius"
    sql: ${TABLE}.Gstore_Sales_Per_Store_5mi ;;
  }
  dimension: i_phone_share {
    type: number
    description: "iPhone market share in the area"
    sql: ${TABLE}.iPhone_Share ;;
  }
  dimension: ice_store_id {
    type: string
    description: "Unique identifier for each store"
    sql: ${TABLE}.ICE_Store_ID ;;
  }
  dimension: latitude {
    type: number
    description: "Latitude coordinate of the store location"
    sql: ${TABLE}.Latitude ;;
  }
  dimension: location {
    type: location
    description: "Combined latitude and longitude of the store location"
    sql_latitude:${TABLE}.Latitude ;;
    sql_longitude:${TABLE}.Longitude ;;
  }
  dimension: longitude {
    type: number
    description: "Longitude coordinate of the store location"
    sql: ${TABLE}.Longitude ;;
  }
  dimension: lulu_store_count_5mi {
    type: number
    description: "Number of Lululemon stores within a 5 mile radius"
    sql: ${TABLE}.Lulu_Store_Count_5mi ;;
  }
  dimension: median_income_for_families_5mi {
    type: number
    description: "Median income for families within a 5 mile radius"
    sql: ${TABLE}.Median_Income_For_Families_5mi ;;
  }
  dimension: median_income_for_nonfamilies_5mi {
    type: number
    description: "Median income for non-families within a 5 mile radius"
    sql: ${TABLE}.Median_Income_For_Nonfamilies_5mi ;;
  }
  dimension: merch_display {
    type: string
    description: "Indicates if the store has a merchandising display"
    sql: ${TABLE}.Merch_Display ;;
  }
  dimension: number_of_reviews {
    type: number
    description: "Number of Google reviews for the store"
    sql: ${TABLE}.Number_Of_Reviews ;;
  }
  measure: total_number_of_reviews {
    type: sum
    description: "Total number of Google reviews across all stores"
    sql: ${number_of_reviews} ;;
  }
  measure: average_number_of_reviews {
    type: average
    description: "Average number of Google reviews per store"
    sql: ${number_of_reviews} ;;
  }
  dimension: number_of_stores_per_chain {
    type: number
    description: "Number of stores for each retail chain"
    sql: ${TABLE}.Number_Of_Stores_Per_Chain ;;
  }
  dimension: overall_rating {
    type: number
    description: "Overall Google review rating score for the store"
    sql: ${TABLE}.Overall_Rating ;;
  }
  dimension: partner {
    type: string
    description: "Name of the carrier partner"
    sql: ${TABLE}.Partner ;;
  }
  dimension: past_pixel_sales_percentile {
    type: number
    description: "Percentile rank of historical Pixel sales performance"
    sql: ${TABLE}.Past_Pixel_Sales_Percentile ;;
  }
  dimension: past_pixel_sales_unit {
    type: number
    description: "Number of Pixel units sold historically"
    sql: ${TABLE}.Past_Pixel_Sales_Unit ;;
  }
  dimension: persona_budget {
    type: number
    description: "Persona score for budget conscious customers"
    sql: ${TABLE}.Persona_Budget ;;
  }
  dimension: persona_foldable_fans {
    type: number
    description: "Persona score for foldable phone enthusiasts"
    sql: ${TABLE}.Persona_Foldable_Fans ;;
  }
  dimension: persona_minimalist {
    type: number
    description: "Persona score for minimalist phone users"
    sql: ${TABLE}.Persona_Minimalist ;;
  }
  dimension: persona_technophile {
    type: number
    description: "Persona score for technology enthusiasts"
    sql: ${TABLE}.Persona_Technophile ;;
  }
  dimension: persona_value_seekers {
    type: number
    description: "Persona score for value-seeking customers"
    sql: ${TABLE}.Persona_Value_Seekers ;;
  }
  dimension: pixel_awareness_percentile {
    type: number
    description: "Percentile rank of Pixel awareness in the area"
    sql: ${TABLE}.Pixel_Awareness_Percentile ;;
  }
  dimension: pixel_consideration_percentile {
    type: number
    description: "Percentile rank of Pixel consideration in the area"
    sql: ${TABLE}.Pixel_Consideration_Percentile ;;
  }
  dimension: pixel_fit_percentile {
    type: number
    description: "Percentile rank of Pixel fit (positioning to drive sales)"
    sql: ${TABLE}.Pixel_Fit_Percentile ;;
  }
  dimension: pixel_growth_potential_percentile {
    type: number
    description: "Percentile rank of Pixel growth potential"
    sql: ${TABLE}.Pixel_Growth_Potential_Percentile ;;
  }
  dimension: pixel_purchase_percentile {
    type: number
    description: "Percentile rank of Pixel purchases in the area"
    sql: ${TABLE}.Pixel_Purchase_Percentile ;;
  }
  dimension: pixel_search_5mi {
    type: number
    description: "Volume of Pixel searches within a 5 mile radius"
    sql: ${TABLE}.Pixel_Search_5mi ;;
  }
  dimension: pixel_search_per_store_5mi {
    type: number
    description: "Average Pixel search volume per store within a 5 mile radius"
    sql: ${TABLE}.Pixel_Search_Per_Store_5mi ;;
  }
  dimension: pixel_share {
    type: number
    description: "Pixel market share in the area"
    sql: ${TABLE}.Pixel_Share ;;
  }
  dimension: population_density_5mi {
    type: number
    description: "Population density within a 5 mile radius"
    sql: ${TABLE}.Population_Density_5mi ;;
  }
  dimension: rolling_all_partners_three_years_activations {
    type: number
    description: "Rolling 3 year activations across all carrier partners"
    sql: ${TABLE}.Rolling_All_Partners_Three_Years_Activations ;;
  }
  dimension: same_partner_store_count_5mi {
    type: number
    description: "Number of stores from the same carrier partner within a 5 mile radius"
    sql: ${TABLE}.Same_Partner_Store_Count_5mi ;;
  }
  dimension: samsung_share {
    type: number
    description: "Samsung market share in the area"
    sql: ${TABLE}.Samsung_Share ;;
  }
  dimension: samsung_store_count_5mi {
    type: number
    description: "Number of Samsung stores within a 5 mile radius"
    sql: ${TABLE}.Samsung_Store_Count_5mi ;;
  }
  dimension: segment_name {
    type: string
    description: "Name of the segment the store is assigned to (e.g. No Regrets, Potential Upside, etc)"
    sql: ${TABLE}.Segment_Name ;;
  }
  dimension: segment_number {
    type: number
    description: "Number corresponding to the segment the store is in"
    sql: ${TABLE}.Segment_Number ;;
  }
  dimension: segmentcolor{
    type: number
    description: "Number corresponding to the color of the segment the store is in"
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
  }
  dimension: sephora_store_count__5mi {
    type: number
    description: "Number of Sephora stores within a 5 mile radius"
    sql: ${TABLE}.Sephora_Store_Count__5mi ;;
  }
  dimension: smartphone_households_5mi {
    type: number
    description: "Number of households with smartphones within a 5 mile radius"
    sql: ${TABLE}.Smartphone_Households_5mi ;;
  }
  dimension: smartphone_households_per_store_5mi {
    type: number
    description: "Average number of households with smartphones per store within a 5 mile radius"
    sql: ${TABLE}.Smartphone_Households_Per_Store_5mi ;;
  }
  dimension: state {
    type: string
    description: "State the store is located in"
    sql: ${TABLE}.State ;;
  }
  dimension: store_performance_percentile {
    type: number
    description: "Percentile rank of overall store performance"
    sql: ${TABLE}.Store_Performance_Percentile ;;
  }
  dimension: store_review {
    type: number
    description: "Average review score for the store"
    sql: ${TABLE}.Store_Review ;;
  }
  dimension: store_review_percentile {
    type: number
    description: "Percentile rank of the store's review score"
    sql: ${TABLE}.Store_Review_Percentile ;;
  }
  dimension: strategic_tiering {
    type: string
    description: "Strategic tier the store falls into (e.g. Pyramid Tier 1, Pyramid Tier 2, etc.)"
    sql: ${TABLE}.Strategic_Tiering ;;
  }
  dimension: target_market_percentile {
    type: number
    description: "Percentile rank of the target market fit"
    sql: ${TABLE}.Target_Market_Percentile ;;
  }
  dimension: tier {
    type: string
    description: "Tier level of the store (Corporate, Dealer, etc.)"
    sql: ${TABLE}.Tier ;;
  }
  dimension: top_store_covered_30mi {
    type: number
    description: "Indicates if it is one of the top ranked stores covered within a 30 mile radius"
    sql: ${TABLE}.Top_Store_Covered_30mi ;;
  }
  dimension: top_stores_uncovered_30mi {
    type: number
    description: "Indicates if it is one of the top ranked stores not covered within a 30 mile radius"
    sql: ${TABLE}.Top_Stores_Uncovered_30mi ;;
  }
  dimension: user_volume_percentile {
    type: number
    description: "Percentile rank of user volume in the area"
    sql: ${TABLE}.User_Volume_Percentile ;;
  }
  dimension: zip {
    type: zipcode
    description: "ZIP code of the store's location"
    sql: ${TABLE}.Zip ;;
  }
  measure: count {
    type: count
    description: "Count of stores, can be used to get the number of stores in a segment, chain, etc."
    drill_fields: [segment_name, chain_name]
  }
}
