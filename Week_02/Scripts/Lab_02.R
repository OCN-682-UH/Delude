#file.copy(from = "C:\\Users\\cesiu\\Desktop\\OCN682 R\\Classwork\\Lecture Folder\\Fall_2026\\Week_02\\data\\weightdata.csv", to = "C:\Users\cesiu\Desktop\OCN682 R\Classwork\Delude, R Classwork\Week_02\Data")
#Error: '\U' used without hex digits in character string (<input>:1:135)

### This is my first script.  I am learning how to import data
### Created by: Mano'ike Delude
### Created on: 2026-09-07
###############################################
### Load libraries ##########
library(tidyverse)
library(here)
### Read in data ###
WeightData <- read_csv(here("Week_02", "data", "weightdata.csv"))
### Data Analysis #####

head(WeightData) # Looks at the top 6 lines of the dataframe
tail(WeightData) # Looks at the bottom 6 lines of the dataframe

View(WeightData) # opens a new window to look at the entire dataframe
