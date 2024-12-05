connection: "growth-lab"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: hpp_sample_full_data{
  view_name:  hpp_sample_full_data
  view_label: "Final HPP Performance Metrics"
}
