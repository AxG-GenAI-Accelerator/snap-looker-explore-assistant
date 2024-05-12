application: explore_assistant {
    label: "Explore Assistant"
    #url: "https://localhost:8080/bundle.js"
    file: "bundle.js"
    entitlements: {
      core_api_methods: ["lookml_model_explore","create_sql_query","run_sql_query","run_query",
        "create_query","run_inline_query", "me", "all_looks", "run_look", "all_lookml_models",
  "lookml_model_explore", "use_iframes", "use_embeds",  "use_form_submit",
  "all_dashboards", "dashboard_dashboard_elements", "dashboard", "lookml_model"]
      navigation: yes
      use_embeds: yes
      use_iframes: yes
      new_window: yes
      new_window_external_urls: ["https://developers.generativeai.google/*"]
      local_storage: yes
      # external_api_urls: ["cloud function url"]
    }
   }
