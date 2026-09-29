##Homework Week_05 (Join-date)
#Mano'ike Delude

##This script is meant to:
  #Homogenize the date data between CondData and DepthData csvs
  #Round the dates to the nearest 10 second interval
    #Round again to the nearest minute for easier analysis
  #pivot the variables longer for easier analysis
  #summarise the means of those
  #plot three bar graphs that show how those values change over time (and depth)

##Libraries
library(tidyverse)
library(here)
library(lubridate)

##Functions
#NA

##Data
  #read in the .csv for the data and depth
cond_dat <- read_csv(here("Week_05", "data", "CondData.csv"))
depth_dat <- read_csv(here("Week_05", "data", "DepthData.csv"))

##Code

  #adding a new column to the dataframes of the fixed (codable) dates as "datetime"
cd <- cond_dat |>
  #round to the nearest 10sec to match the seconds data in depth_dat
  mutate(datetime = mdy_hms(date), datetime = round_date(datetime, "10 sec")) |>
  select(-date) #drop the old date column
dd <- depth_dat |>
  mutate(datetime = ymd_hms(date)) |>
  select(-date) #drop the old dates here too

  #Joining the two dfs in a single one
cond_depth_dat <- inner_join(cd,dd, by = "datetime") |>
  select(-Serial) |> #This is the same number for everything, and is unnecessary for analysis
  mutate(datetime = round_date(datetime, "minute")) |> #rounding all the dates to the nearest minute
  #collapses the variables into longer table for easier analysis
  pivot_longer(cols = c(Depth, Temperature, Salinity),
               names_to = "Variables",
               values_to = "Values") |>
  drop_na() |> #drops NAs in any row
  group_by(datetime, Variables) |> #sort the data by time recorded and variable
  summarise(means_vals = mean(Values)) #average the values for each variable at every time interval

#cond_depth_dat
 #^left in for checking my work
  
cond_depth_plot <- cond_depth_dat |>
  #plot a bar graph of the difference variables over time
  ggplot(aes( x = datetime,
              y = means_vals,
              fill = Variables)) +
  #makes a bar chart that doesn't stack values of the same date
  geom_bar(stat = "identity",
           position = "dodge") +
  #splits the graph into 3 plots in one column (so it's easier to compart the timescale)
  facet_wrap(~Variables,
             scales = "free_y",
             ncol = 1) +
  theme(legend.position = "none") +
  #remove legend, unnecessary with facet_wrap labels
  labs(y = "Mean Values")
  #tidy up

cond_depth_plot

ggsave(here("Week_05/output", "Join_Date_hw.png"),
       width = 14, height = 7)

