here::i_am("code/01_summary_table.R")

library(dplyr)
library(gtsummary)

summer_evening_night_data <- readRDS(
  file = here::here("output/summer_evening_night_data.rds"))

  
# Summarize daily evening mean and max temperature + mean humidity
daily_summary_table <- summer_evening_night_data |>
  group_by(night_date, month) |>
  summarise(
    mean_temp = mean(celsius, na.rm = TRUE),
    mean_humidity = mean(humidity, na.rm = TRUE),

  ) |>
  ungroup()|>
  droplevels()

saveRDS(
  daily_summary_table,
  file = here::here("output/daily_summary_table.rds")
)

# Monthly summary table
monthly_summary_table <- tbl_summary(
  data = daily_summary_table,
  by = month,
  include = c(mean_temp, mean_humidity),
  statistic = list(
    all_continuous() ~ "{mean}±{sd} ({min}-{max})"
  ),
  digits = all_continuous() ~ 1,
  label = list(
    mean_temp ~ "Mean Night Temp (°C)", 
    mean_humidity ~ "Mean Night Humidity (%)"
  )
) |>
  bold_labels() |>
  modify_caption("**Table 1. Summary of Nighttime Temperature and Humidity in Beijing (May-September 2019)**")

saveRDS(
  monthly_summary_table,
  file = here::here("output/monthly_summary_table.rds")
)