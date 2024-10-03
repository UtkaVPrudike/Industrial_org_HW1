library(tidyverse)
data <- read_csv("https://gs.statcounter.com/search-engine-market-share/all/russian-federation/chart.php?device=Desktop%20%26%20Mobile%20%26%20Tablet%20%26%20Console&device_hidden=desktop%2Bmobile%2Btablet%2Bconsole&multi-device=true&statType_hidden=search_engine&region_hidden=RU&granularity=monthly&statType=Search%20Engine&region=Russian%20Federation&fromInt=202301&toInt=202312&fromMonthYear=2023-01&toMonthYear=2023-12&csv=1")

# From monthly data compute share of each company for year 2023
data_yearly <- data %>%
  gather(var, val, 2:ncol(data)) %>%
  group_by(var) %>%
  summarise(share = mean(val) / 100)

# Compute HHI
data_yearly %>%
  summarise(HHI = sum(share^2))

# Compute I4
data_yearly %>%
  top_n(4, share) %>%
  summarise(I4 = sum(share))
