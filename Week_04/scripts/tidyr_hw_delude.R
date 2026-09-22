##Homework 1 (dplyr)
#Mano'ike Delude

##This script is meant to
#Clean the chemistry data
  #Filter out a subset
  #Pivot longer or wider
  #Calculate summary stats
  #Export to csv
  #Plot data (not a boxplot), and export to .png

##Necessary Packages (skip if already installed)

##Libraries
library(tidyverse)
library(here)

##Functions
#NA for now

##Data
chem_dat <- read_csv(here("Week_04", "data", "chemicaldata_maunalua.csv"))
#Importing data into a dataframe (df)

##Code
##Homework code starts here
chem_dat_clean <- chem_dat |>
  #assigning a new df for easier workflow
  drop_na() |> #drops NAs
  separate_wider_delim(cols  = Tide_time,
                       delim = "_",
                       names = c("Tide", "Time"),
                       cols_remove = FALSE) |>
  #Splits Tide_time into two columns, while keeping the original around
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") |>
  #Pivots the columns with number data into a longer format for easier analysis
  filter_out(Site == "W") |>
  #Only looking at site BP
  group_by(Variables, Tide) |>
  #Grouping these together to get an idea of how different chemistry looks at different tidess
  summarize(means_vals = mean(Values),
            sd_vals = sd(Values)) |>
  #Summarizes the values columns into a means and standard deviation
  write_csv(here("Week_04", "output", "summary_hw.csv"))
  #Exports df as a new .csv

#Now it's time to plot
chem_dat_plot <- chem_dat_clean |>
  #Putting df into a new plot df to keep a cleaner workflow
  ggplot(aes(x = Variables,
             y = means_vals,
             fill = Tide)) +
  #plotting the Mean value of all varianbles against tide
  facet_wrap(~Variables,
             scales = "free") +
  #splitting the plots into something readable
  geom_bar(stat = "identity", position = "dodge")+
  #if you don't provide a stat for geom_bar, it'll do it for you (and fail). Dodge is how you make the bars not stack
  labs(y = "Mean Values",
       title = "Differences in chemistry between High and Low tide")
  #Labels so the output looks readable!

ggsave(here("Week_04/output", "tidyr_hw_plot.png"),
       width = 7, height = 7)
  #Generate a .png of the plot
chem_dat_plot
  #Look at it in the viewer to make sure it's alright!