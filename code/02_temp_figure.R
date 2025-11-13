here::i_am("code/02_temp_figure.R")

library(ggplot2)

nighttime_hourly <- readRDS(
  file = here::here("output/nighttime_hourly.rds")
)

night_temp <- ggplot(nighttime_hourly, aes(x = night_hour, y = mean_temp, color = month)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1.5) +
  scale_x_continuous(
    breaks = 0:12,
    labels = c("6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM",
               "12 AM", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM")
  ) +
  labs(
    title = "Average Nighttime Temperature by Hour (6 PM–6 AM)",
    x = "Hour of Night",
    y = "Mean Temperature (°C)",
    color = "Month"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    legend.position = "right"
  )

ggsave(
  here::here("output/temp_figure.png"),
  plot = night_temp,
  device = "png"
)