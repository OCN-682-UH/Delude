##This script is for analyzing the Palmer Penguin data for Week_03's classwork/homework

##Necessary Packages (skip if already installed)
#install.packages("palmerpenguins")

##Libraries
library(palmerpenguins)
library(tidyverse)
#glimpse(penguins)
library(here)

##Functions
  #NA for now

##Data
  #Already loaded in as "penguins"

##Code
  ##The old code from lecture 5, for reference.

#ggplot(data=penguins,
#       mapping = aes( x = bill_depth_mm,
#                      y = bill_length_mm,
#                      color = species)) +
#  geom_point() +
#    labs(title = "Bill depth and length",
#         subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
#         x = "Bill depth (mm)", y = "Bill length(mm)",
#         color = "Species",
#         caption = "Source: Palmer Station LTER / palmerpenguins package") +
#  scale_color_viridis_d()

  ##Follow along code from Lecture 6
ggplot(data = penguins,
      mapping = aes( x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
       labs(title = "Bill depth and length",
            subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
            x = "Bill depth (mm)", y = "Bill length(mm)",
            caption = "Source: Palmer Station LTER / palmerpenguins package") +
  +   scale_color_manual(values = beyonce_palette(18))

  ##Homework code starts here
