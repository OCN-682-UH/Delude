##This script is for analyzing the Palmer Penguin data for Week_03's classwork/homework

##Necessary Packages (skip if already installed)
#install.packages("palmerpenguins")

##Libraries
library(palmerpenguins)
library(tidyverse)
#glimpse(penguins)
library(here)
library(beyonce)
library(PNWColors)

##Functions
  #NA for now

##Data
  #loaded in as "penguins" by the palmerpenguins library

##Code
##Homework code starts here

#Goal: to plot the weights of penguin species on each island by sex
#to show species distribution and overall health, condensed for showing tourists in a pamphlet.

ggplot(data = subset(penguins, !is.na(sex)), #nb penguins banished from our dataset
       mapping = aes( x = island,
                      y = body_mass_g,
                      fill = species,
                      color = sex)) + 
  geom_violin() + #it's not a scatter plot if we cover it up with distributions
  labs(title = "Penguin weight by island",
       x = "Island", y = "Weight (g)",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       fill = "Species",
       color = NULL #removes the sex label from the legend box, ran out of time before figuring out how to capitalize the sexes
  ) +
  scale_fill_manual(values = pnw_palette("Sailboat", 3)) + #because islands are on the sea! Number is how many steps you use between the first and last pallete color
  scale_color_manual(values = c("salmon", "purple")) + #f penguins are out getting salmon
  theme(axis.title = element_text(size = 13),
        plot.background = element_rect(fill = "#FFFAF0"),
        panel.background = element_rect(fill = "linen"),
        legend.background = element_rect(fill = alpha("navy", 0.1)), #lightly fill in the legends so they're readable over the plot bg
        legend.position = c(1,1), #to put it in the (first if it were factored) plot
        legend.justification = c(1,1), #to keep it justified to the plot
        legend.box = "horizontal", #arranges multiple legends horizontally
        legend.box.just = c("top") #justifies the two legends to the top
  )
#legend positioning code from https://stackoverflow.com/questions/16251966/controlling-the-alpha-level-in-a-ggplot2-legend
#Export time!
ggsave(here("Week_03","output","penguin_homework.png"),
       width = 7, height = 7)


#Homework Code Ends Here
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
#plot1 <- ggplot(data = penguins,
#      mapping = aes( x = bill_depth_mm,
#                     y = bill_length_mm,
#                     color = species)) +
#  geom_point() +
#  geom_smooth(method = "lm") +
#       labs(title = "Bill depth and length",
#            subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
#            x = "Bill depth (mm)", y = "Bill length(mm)",
#            caption = "Source: Palmer Station LTER / palmerpenguins package") +
#  scale_color_manual(values = beyonce_palette(18)) +
#  theme(axis.title = element_text(size = 20,
#                                  color = "#5539CC"), #Blurple
#        panel.background = element_rect(fill = "linen"),
#        legend.background = element_rect(fill = "salmon"),
#        panel.border = element_rect(fill = "turquoise"))

#plot1

#ggsave(here("Week_03","output","penguin.png"),
#       width = 7, height = 5)