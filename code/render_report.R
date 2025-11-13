here::i_am("code/render_report.R")

library(rmarkdown)

render(
  "final_data.Rmd",
  output_file = "toolkit_final_report.html"
)