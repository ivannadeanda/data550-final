here::i_am("final_data.Rmd")

data <- read.csv(
  file = here::here("raw_data/beijing.csv")
)

library(dplyr)
library(lubridate)

# Changing column name from 'shidu' (Mandarin word for humidity)
names(data)[names(data) == "shidu"] <- "humidity" 

names(data)[names(data) == "temp"] <- "celsius" 

# Converting character data to date format

data$date <- as.POSIXct(data$date, tz = "Asia/Shanghai", format = "%Y/%m/%d %H:%M")

# Isolating data to summer months
data <- data |>
  mutate(month = month(date, label = TRUE, abbr = TRUE))

summer_data <- data |>
  filter(month %in% c("May","Jun","Jul","Aug","Sep"))


# Isolating data to evening temperatures
summer_data <- summer_data |>
  mutate(
    hour = hour(date),
    period = if_else(hour >= 18 | hour < 6, "Night", "Day"),
    night_date = if_else(hour < 6, # Hours 0–5 belong to the previous day’s night
                         as.Date(date) - 1, 
                         as.Date(date)),     
    month = month(night_date, label = TRUE, abbr = TRUE)
  ) |>
  filter(month(night_date) >= 5 & month(night_date) <= 9)

summer_evening_night_data <- summer_data |>
  filter(period == "Night")


# Isolating nighttime hourly data

nighttime_hourly <- summer_data |>
  mutate(
    hour = hour(date),
    night_date = if_else(hour < 6, as.Date(date) - 1, as.Date(date)),
    month = month(date, label = TRUE, abbr = TRUE),
    night_hour = if_else(hour >= 18, hour - 18, hour + 6) 
  ) |>
  filter(month %in% c("May", "Jun", "Jul", "Aug", "Sep"),
         hour >= 18 | hour < 6) |>
  group_by(month, night_hour) |>
  summarise(mean_temp = mean(celsius, na.rm = TRUE), .groups = "drop")



# Saving data in output folder

saveRDS(
  summer_evening_night_data, 
  file = here::here("output/summer_evening_night_data.rds")
)

saveRDS(
  nighttime_hourly,
  file = here::here("output/nighttime_hourly.rds")
)