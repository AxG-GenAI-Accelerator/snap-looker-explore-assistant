application: hpp_explore_assistant {
    label: "HPP Explore Assistant"
    #url: "https://localhost:8080/bundle.js"
    file: "bundle_explore_test.js"
    #file: "bundle-demo.js"
    entitlements: {
        core_api_methods: ["lookml_model_explore","create_sql_query","run_sql_query","run_query","create_query"]
      navigation: yes
      use_embeds: yes
      use_iframes: yes
      new_window: yes
      new_window_external_urls: ["https://developers.generativeai.google/*"]
      local_storage: yes
      # external_api_urls: ["cloud function url"]
    }
   }
