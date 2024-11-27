connection: "growth-lab"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: Everygreen_Campaign{
  view_name:  continuum_data_team_post_launch_hpp_reporting_dashboard_i2_evergreen
  view_label: "Evergreen Campaign Performance Metrics"
}
