##Homework Week_05 (Join-date)
#Mano'ike Delude

##This script is meant to:
  #Homogenize the date data between CondData and DepthData csvs
  #Round the dates to the nearest 10 second interval
    #Round again to the nearest minute for easier analysis

##Libraries
library(tidyverse)
library(here)
library(lubridate)

##Functions
#NA

##Data
cond_dat <- read_csv(here("Week_05", "data", "CondData.csv"))
depth_dat <- read_csv(here("Week_05", "data", "DepthData.csv"))

##Code

cd <- cond_dat |>
  mutate(datetime = mdy_hms(date), datetime = round_date(datetime, "10 sec")) |>
  select(-date)
dd <- depth_dat |>
  mutate(datetime = ymd_hms(date)) |>
  select(-date)

cond_depth_dat <- inner_join(cd,dd, by = "datetime") |>
  select(-Serial) |>
  mutate(datetime = round_date(datetime, "minute")) |>
  pivot_longer(cols = c(Depth, Temperature, Salinity),
               names_to = "Variables",
               values_to = "Values") |>
  drop_na() |>
  group_by(datetime, Variables) |>
  summarise(means_vals = mean(Values))

cond_depth_dat
  
cond_depth_plot <- cond_depth_dat |>
  ggplot(aes( x = datetime,
              y = means_vals,
              fill = Variables)) +
  geom_bar(stat = "identity",
           position = "dodge") +
  facet_wrap(~Variables,
             scales = "free_y",
             ncol = 1) +
  theme(legend.position = "none")

cond_depth_plot

