view: lookertestv8 {
  sql_table_name: oxjytxr-mss-mkt-genai-accel.explore_assistant.lookertestv8 ;;
  dimension: activation_count_5mi {
    type: number
    description: "Number of activations within a 5 mile radius of the store"
    sql: ${TABLE}.Activation_Count_5mi ;;
    label: "Activation Count (5mi)"
    tags: ["activation", "5_miles"]
  }
  dimension: activation_per_store_5mi {
    type: number
    description: "Number of activations per store within a 5 mile radius"
    sql: ${TABLE}.Activation_Count_Per_Store_5mi ;;
    label: "Activation Count per Store (5mi)"
    tags: ["activation", "5_miles", "per_store"]
  }
  dimension: store_address {
    type: string
    description: "Street address of the store"
    sql: ${TABLE}.Address ;;
    label: "Address"
    tags: ["geography","store"]
  }
  dimension: advocate_count {
    type: string
    description: "Number of advocates or salespeople in the store"
    sql: ${TABLE}.Advocate_Count ;;
    label: "Advocate Count"
    tags: ["count"]
  }
  dimension: all_partner_store_count_5mi {
    type: number
    description: "Number of partner stores from all carriers within a 5 mile radius"
    sql: ${TABLE}.All_Partner_Store_Count_5mi ;;
    label: "All Partner Store Count (5mi)"
    tags: ["5_miles", "partner", "count"]
  }
  dimension: android_volume_5mi {
    type: number
    description: "Volume of Android devices within a 5 mile radius"
    sql: ${TABLE}.Android_Volume_5mi ;;
    label: "Android Volume (5mi)"
    tags: ["5_miles", "android", "volume"]
  }
  dimension: android_volume_per_store_5mi {
    type: number
    description: "Android device volume per store within a 5 mile radius"
    sql: ${TABLE}.Android_Volume_Per_Store_5mi ;;
    label: "Android Volume per Store (5mi)"
    tags: ["5_miles", "android", "per_store", "volume"]
  }
  dimension: apple_store_count_5mi {
    type: number
    description: "Number of Apple stores within a 5 mile radius"
    sql: ${TABLE}.Apple_Store_Count_5mi ;;
    label: "Apple Store Count (5mi)"
    tags: ["5_miles", "apple", "count"]
  }
  dimension: buying_power_percentile {
    type: number
    description: "Buying power percentile rank of the area"
    sql: ${TABLE}.Buying_Power_Percentile ;;
    label: "Buying Power Percentile"
    tags: ["percentile", "budget"]
  }
  dimension: campaign_count_20_yy {
    type: number
    description: "Number of campaigns run in 2020"
    sql: ${TABLE}.Campaign_Count_20YY ;;
    label: "Campaign Count (2020)"
    tags: ["campaign", "count", "date"]
  }
  dimension: chain_name {
    type: string
    description: "Name of the store chain"
    sql: ${TABLE}.Chain_Name ;;
    label: "Chain Name"
    tags: ["chain"]
  }
  dimension: chain_type {
    type: string
    description: "Type of store (dealer or corporate)"
    sql: ${TABLE}.Chain_Type ;;
    label: "Chain Type"
    tags: ["chain"]
  }
  dimension: store_city {
    type: string
    description: "City the store is located in"
    sql: ${TABLE}.City ;;
    label: "City"
    tags: ["geography","store"]
  }
  dimension: date_range {
    type: string
    description: "Date range the data covers"
    sql: ${TABLE}.Date_Range ;;
    label: "Date Range"
    tags: ["date"]
  }
  dimension: daytime_population {
    type: number
    description: "Daytime population in the area"
    sql: ${TABLE}.Daytime_Population ;;
    label: "Daytime Population"
    tags: ["population"]
  }
  dimension: daytime_population_per_store {
    type: number
    description: "Daytime population per store in the area"
    sql: ${TABLE}.Daytime_Population_Per_Store ;;
    label: "Daytime Population per Store"
    tags: ["population", "per_store"]
  }
  dimension: dma {
    type: string
    description: "Designated Market Area (DMA) the store is in"
    sql: ${TABLE}.DMA ;;
    label: "DMA"
    tags: ["geography"]
  }
  dimension: employment_rate_5mi {
    type: number
    description: "Employment rate within a 5 mile radius"
    sql: ${TABLE}.Employment_Rate_5mi ;;
    label: "Employment Rate (5mi)"
    tags: ["5_miles", "budget"]
  }
  dimension: field_team_coverage {
    type: string
    description: "Indicates if the store has field team coverage"
    sql: ${TABLE}.Field_Team_Coverage ;;
    label: "Field Team Coverage"
    tags: ["coverage"]
  }
  dimension: fit_percentile_3_p {
    type: number
    description: "3P carrier fit percentile rank (how well positioned the store is to sell Pixel)"
    sql: ${TABLE}.Fit_Percentile_3P ;;
    label: "Fit Percentile (3P)"
    tags: ["3p", "fit", "percentile"]
  }
  dimension: footfall {
    type: number
    description: "Foot traffic in the store"
    sql: ${TABLE}.Footfall ;;
    label: "Footfall"
    tags: ["footfall"]
  }
  dimension: footfall_percentile {
    type: number
    description: "Foot traffic percentile rank compared to other stores"
    sql: ${TABLE}.Footfall_Percentile ;;
    label: "Footfall Percentile"
    tags: ["footfall", "percentile"]
  }
  dimension: google_influence_non_scoring_signal {
    type: number
    description: "Google's influence in the area (non-scoring signal)"
    sql: ${TABLE}.Google_Influence_Non_Scoring_Signal ;;
    label: "Google Influence (Non-Scoring Signal)"
    tags: ["gstore","google", "influence"]
  }
  dimension: gstore_sales_5mi {
    type: number
    description: "Google Store sales within a 5 mile radius"
    sql: ${TABLE}.Gstore_Sales_5mi ;;
    label: "Google Store Sales (5mi)"
    tags: ["5_miles", "gstore", "google", "sales"]
  }
  dimension: gstore_sales_per_store_5mi {
    type: number
    description: "Google Store sales per store within a 5 mile radius"
    sql: ${TABLE}.Gstore_Sales_Per_Store_5mi ;;
    label: "Google Store Sales per Store (5mi)"
    tags: ["5_miles", "gstore", "google", "sales", "per_store"]
  }
  dimension: iphone_share {
    type: number
    description: "iPhone market share in the area"
    sql: ${TABLE}.iPhone_Share ;;
    label: "iPhone Share"
    tags: ["share","apple"]
  }
  dimension: store_id {
    type: string
    description: "Unique identifier for each store"
    sql: ${TABLE}.ICE_Store_ID ;;
    label: "ICE Store ID"
    tags: ["store"]
  }
  dimension: store_latitude {
    type: number
    description: "Latitude coordinate of the store location"
    sql: ${TABLE}.Latitude ;;
    label: "Latitude"
    tags: ["geography","store"]
  }
  dimension: store_location {
    type: location
    description: "Combined latitude and longitude of the store location"
    sql_latitude:${TABLE}.Latitude ;;
    sql_longitude:${TABLE}.Longitude ;;
    label: "Location"
    tags: ["geography", "store", "map"]
  }
  dimension: store_longitude {
    type: number
    description: "Longitude coordinate of the store location"
    sql: ${TABLE}.Longitude ;;
    label: "Longitude"
    tags: ["geography", "store"]
  }
  dimension: lululemon_store_count_5mi {
    type: number
    description: "Number of Lululemon stores within a 5 mile radius"
    sql: ${TABLE}.Lulu_Store_Count_5mi ;;
    label: "Lululemon Store Count (5mi)"
    tags: ["5_miles", "lululemon", "count"]
  }
  dimension: median_income_for_families_5mi {
    type: number
    description: "Median income for families within a 5 mile radius"
    sql: ${TABLE}.Median_Income_For_Families_5mi ;;
    label: "Median Income for Families (5mi)"
    tags: ["5_miles", "family", "median_income", "budget"]
  }
  dimension: median_income_for_nonfamilies_5mi {
    type: number
    description: "Median income for non-families within a 5 mile radius"
    sql: ${TABLE}.Median_Income_For_Nonfamilies_5mi ;;
    label: "Median Income for Non-Families (5mi)"
    tags: ["5_miles", "nonfamily", "median_income", "budget"]
  }
  dimension: store_merch_display {
    type: string
    description: "Indicates if the store has a merchandising display"
    sql: ${TABLE}.Merch_Display ;;
    label: "Merch Display"
    tags: ["merch", "store"]
  }
  dimension: store_number_of_reviews {
    type: number
    description: "Number of Google reviews for the store"
    sql: ${TABLE}.Number_Of_Reviews ;;
    label: "Number of Reviews"
    tags: ["reviews", "count", "store"]
  }
  measure: total_number_of_reviews {
    type: sum
    description: "Total number of Google reviews across all stores"
    sql: ${TABLE}.Number_Of_Reviews ;;
    label: "Total Number of Reviews"
    tags: ["reviews", "count"]
  }
  measure: average_number_of_reviews {
    type: average
    description: "Average number of Google reviews per store"
    sql: ${TABLE}.Number_Of_Reviews;;
    label: "Average Number of Reviews"
    tags: ["reviews", "count", "average"]
  }
  dimension: number_of_stores_per_chain {
    type: number
    description: "Number of stores for each retail chain"
    sql: ${TABLE}.Number_Of_Stores_Per_Chain ;;
    label: "Number of Stores per Chain"
    tags: ["chain", "per_chain", "count"]
  }
  dimension: store_overall_rating {
    type: number
    description: "Overall Google review rating score for the store"
    sql: ${TABLE}.Overall_Rating ;;
    label: "Overall Rating"
    tags: ["rating","store"]
  }
  dimension: partner {
    type: string
    description: "Name of the carrier partner"
    sql: CASE
        WHEN ${partner} IN ('Best buy', 'T-mobile', 'Verizon', 'ATT') THEN ${partner}
        ELSE NULL
      END ;;
    label: "Partner"
  }
  dimension: past_pixel_sales_percentile {
    type: number
    description: "Percentile rank of historical Pixel sales performance"
    sql: ${TABLE}.Past_Pixel_Sales_Percentile ;;
    label: "Past Pixel Sales Percentile"
    tags: ["pixel", "sales", "percentile"]
  }
  dimension: past_pixel_sales_unit {
    type: number
    description: "Number of Pixel units sold historically"
    sql: ${TABLE}.Past_Pixel_Sales_Unit ;;
    label: "Past Pixel Sales Unit"
    tags: ["pixel", "sales"]
  }
  dimension: persona_budget {
    type: number
    description: "Persona score for budget conscious customers"
    sql: ${TABLE}.Persona_Budget ;;
    label: "Persona Budget"
    tags: ["persona", "budget"]
  }
  dimension: persona_foldable_fans {
    type: number
    description: "Persona score for foldable phone enthusiasts"
    sql: ${TABLE}.Persona_Foldable_Fans ;;
    label: "Persona Foldable Fans"
    tags: ["persona", "foldable_fans"]
  }
  dimension: persona_minimalist {
    type: number
    description: "Persona score for minimalist phone users"
    sql: ${TABLE}.Persona_Minimalist ;;
    label: "Persona Minimalist"
    tags: ["persona", "minimalist"]
  }
  dimension: persona_technophile {
    type: number
    description: "Persona score for technology enthusiasts"
    sql: ${TABLE}.Persona_Technophile ;;
    label: "Persona Technophile"
    tags: ["persona", "technophile"]
  }
  dimension: persona_value_seekers {
    type: number
    description: "Persona score for value-seeking customers"
    sql: ${TABLE}.Persona_Value_Seekers ;;
    label: "Persona Value Seekers"
    tags: ["persona", "value_seekers"]
  }
  dimension: pixel_awareness_percentile {
    type: number
    description: "Percentile rank of Pixel awareness in the area"
    sql: ${TABLE}.Pixel_Awareness_Percentile ;;
    label: "Pixel Awareness Percentile"
    tags: ["pixel", "awareness", "percentile"]
  }
  dimension: pixel_consideration_percentile {
    type: number
    description: "Percentile rank of Pixel consideration in the area"
    sql: ${TABLE}.Pixel_Consideration_Percentile ;;
    label: "Pixel Consideration Percentile"
    tags: ["pixel", "consideration", "percentile"]
  }
  dimension: pixel_fit_percentile {
    type: number
    description: "Percentile rank of Pixel fit (positioning to drive sales)"
    sql: ${TABLE}.Pixel_Fit_Percentile ;;
    label: "Pixel Fit Percentile"
    tags: ["pixel", "fit", "percentile"]
  }
  dimension: pixel_growth_potential_percentile {
    type: number
    description: "Percentile rank of Pixel growth potential"
    sql: ${TABLE}.Pixel_Growth_Potential_Percentile ;;
    label: "Pixel Growth Potential Percentile"
    tags: ["pixel", "growth_potential", "percentile"]
  }
  dimension: pixel_purchase_percentile {
    type: number
    description: "Percentile rank of Pixel purchases in the area"
    sql: ${TABLE}.Pixel_Purchase_Percentile ;;
    label: "Pixel Purchase Percentile"
    tags: ["pixel", "purchase_percentile", "percentile"]
  }
  dimension: pixel_search_5mi {
    type: number
    description: "Volume of Pixel searches within a 5 mile radius"
    sql: ${TABLE}.Pixel_Search_5mi ;;
    label: "Pixel Search (5mi)"
    tags: ["5_miles", "pixel", "search"]
  }
  dimension: pixel_search_per_store_5mi {
    type: number
    description: "Pixel search volume per store within a 5 mile radius"
    sql: ${TABLE}.Pixel_Search_Per_Store_5mi ;;
    label: "Pixel Search per Store (5mi)"
    tags: ["5_miles", "pixel", "search", "per_store"]
  }
  dimension: pixel_share {
    type: number
    description: "Pixel market share in the area"
    sql: ${TABLE}.Pixel_Share ;;
    label: "Pixel Share"
    tags: ["pixel", "share"]
  }
  dimension: population_density_5mi {
    type: number
    description: "Population density within a 5 mile radius"
    sql: ${TABLE}.Population_Density_5mi ;;
    label: "Population Density (5mi)"
    tags: ["5_miles", "population"]
  }
  dimension: rolling_all_partners_three_years_activations {
    type: number
    description: "Rolling 3 year activations across all carrier partners"
    sql: ${TABLE}.Rolling_All_Partners_Three_Years_Activations ;;
    label: "Rolling All Partners Three Years Activations"
    tags: ["activation", "partner", "rolling"]
  }
  dimension: same_partner_store_count_5mi {
    type: number
    description: "Number of stores from the same carrier partner within a 5 mile radius"
    sql: ${TABLE}.Same_Partner_Store_Count_5mi ;;
    label: "Same Partner Store Count (5mi)"
    tags: ["5_miles", "partner", "count"]
  }
  dimension: samsung_share {
    type: number
    description: "Samsung market share in the area"
    sql: ${TABLE}.Samsung_Share ;;
    label: "Samsung Share"
    tags: ["samsung", "share"]
  }
  dimension: samsung_store_count_5mi {
    type: number
    description: "Number of Samsung stores within a 5 mile radius"
    sql: ${TABLE}.Samsung_Store_Count_5mi ;;
    label: "Samsung Store Count (5mi)"
    tags: ["5_miles", "samsung", "count"]
  }
  dimension: segment_name {
    type: string
    description: "Name of the segment the store is assigned to (e.g. No Regrets, Potential Upside, etc)"
    sql: ${TABLE}.Segment_Name ;;
    label: "Segment Name"
    tags: ["segment"]
  }
  dimension: segment_number {
    type: number
    description: "Number corresponding to the segment the store is in"
    sql: ${TABLE}.Segment_Number ;;
    label: "Segment Number"
    tags: ["segment"]
  }
  dimension: tier_color {
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
    label: "Segment Color"
    tags: ["tier", "color", "map"]
  }
  dimension: sephora_store_count_5mi {
    type: number
    description: "Number of Sephora stores within a 5 mile radius"
    sql: ${TABLE}.Sephora_Store_Count__5mi ;;
    label: "Sephora Store Count (5mi)"
    tags: ["5_miles", "sephora", "count"]
  }
  dimension: smartphone_households_5mi {
    type: number
    description: "Number of households with smartphones within a 5 mile radius"
    sql: ${TABLE}.Smartphone_Households_5mi ;;
    label: "Smartphone Households (5mi)"
    tags: ["5_miles", "smartphone"]
  }
  dimension: smartphone_households_per_store_5mi {
    type: number
    description: "Number of households with smartphones per store within a 5 mile radius"
    sql: ${TABLE}.Smartphone_Households_Per_Store_5mi ;;
    label: "Smartphone Households per Store (5mi)"
    tags: ["5_miles", "smartphone", "per_store"]
  }
  dimension: store_state {
    type: string
    description: "State the store is located in"
    sql: ${TABLE}.State ;;
    label: "State"
    tags: ["geography", "store"]
  }
  dimension: store_performance_percentile {
    type: number
    description: "Percentile rank of overall store performance"
    sql: ${TABLE}.Store_Performance_Percentile ;;
    label: "Store Performance Percentile"
    tags: ["store", "percentile"]
  }
  dimension: store_review {
    type: number
    description: "Review score for the store"
    sql: ${TABLE}.Store_Review ;;
    label: "Store Review"
    tags: ["store", "review"]
  }
  dimension: store_review_percentile {
    type: number
    description: "Percentile rank of the store's review score"
    sql: ${TABLE}.Store_Review_Percentile ;;
    label: "Store Review Percentile"
    tags: ["store", "review", "percentile"]
  }
  dimension: strategic_tiering {
    type: string
    description: "Strategic tier the store falls into (e.g. Pyramid Tier 1, Pyramid Tier 2, etc.)"
    sql: CASE
        WHEN ${TABLE}.Strategic_Tiering != 'Pyramid Tier 6' THEN ${TABLE}.Strategic_Tiering
        ELSE NULL
      END ;;
    label: "Strategic Tiering"
    tags: ["store", "tier"]
  }
  dimension: target_market_percentile {
    type: number
    description: "Percentile rank of the target market fit"
    sql: ${TABLE}.Target_Market_Percentile ;;
    label: "Target Market Percentile"
    tags: ["percentile"]
  }
  dimension: tier {
    type: string
    description: "Tier level of the store (Corporate, Dealer, etc.)"
    sql: ${TABLE}.Tier ;;
    label: "Tier"
    tags: ["store", "tier"]
  }
  dimension: top_store_covered_30mi {
    type: number
    description: "Indicates if it is one of the top ranked stores covered within a 30 mile radius"
    sql: ${TABLE}.Top_Store_Covered_30mi ;;
    label: "Top Store Covered (30mi)"
    tags: ["store", "top_stores"]
  }
  dimension: top_stores_uncovered_30mi {
    type: number
    description: "Indicates if it is one of the top ranked stores not covered within a 30 mile radius"
    sql: ${TABLE}.Top_Stores_Uncovered_30mi ;;
    label: "Top Stores Uncovered (30mi)"
    tags: ["store", "top_stores"]
  }
  dimension: user_volume_percentile {
    type: number
    description: "Percentile rank of user volume in the area"
    sql: ${TABLE}.User_Volume_Percentile ;;
    label: "User Volume Percentile"
    tags: ["percentile", "volume"]
  }
  dimension: store_zip {
    type: zipcode
    description: "ZIP code of the store's location"
    sql: ${TABLE}.Zip ;;
    label: "ZIP Code"
    tags: ["geography", "zip", "store"]
  }
  measure: count {
    type: count
    description: "Count of stores, can be used to get the number of stores in a segment, chain, etc."
    drill_fields: [segment_name, chain_name]
    label: "Store Count"
    tags: ["count", "store"]
  }
}
