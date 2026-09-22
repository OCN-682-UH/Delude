##Homework 1 (dplyr)
#Mano'ike Delude

##This script is meant to 
  #1. Calculate the mean and variance of the palmerpenguin data by
    #Species, Island, and Sex while excluding NAs.
  #2. Excludes male penguins, calculate log(body mass),
    #then plot only Species, Island, Sex, and log(body mass)

##Necessary Packages (skip if already installed)
#install.packages("palmerpenguins")

##Libraries
library(palmerpenguins)
library(tidyverse)
library(here)

##Functions
#NA for now

##Data
#loaded in as "penguins" by the palmerpenguins library

##Code
##Homework code starts here

#1
peng_mv <- penguins |> #Pipe, pipe, baby
#Pipes all the following into a new df titled peng_mv
  drop_na(species, island, sex) |>
  group_by(species, island, sex) |>
#Remove observations with NAs in species, sex, and island, then group the remaining observations together
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE), #probably don't need na.rm = TRUE, but leaving in case I need to pull this to a different script that might not drop all NAs first
              var_bill_length = var(bill_length_mm, na.rm = TRUE),
            mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE),
              var_bill_depth = var(bill_depth_mm, na.rm = TRUE),
            mean_flipper_length = mean(flipper_length_mm, na.rm = TRUE),
              var_flipper_length = var(flipper_length_mm, na.rm = TRUE),
            mean_body_mass = mean(body_mass_g, na.rm = TRUE),
              var_body_mass = var(body_mass_g, na.rm = TRUE))
#Makes 8 new columns that calculate the mean and variance of all the observation stats grouped by the species, island and sex
peng_mv
#Display the df to make sure it worked

#2
peng_logplot_df <- penguins |>
  filter_out(sex == "male") |>
  drop_na(species, island, sex) |>
#Constructing a dataframe without male penguins, no NAs in species,island,sex
  mutate(log_body_mass = log10(body_mass_g)) |>
#Adding a column with the log of body mass
  select(species, island, sex, log_body_mass)
#df will only have these columns

  

peng_logplot_plot <- peng_logplot_df |>
#Construct a df for the plotting
  ggplot(aes(x = island,
             y = log_body_mass,
             fill = species)) +
  geom_violin() +
  facet_wrap("island", scales = "free_x") +
#Splits the graph up by island, and freely allows empty x axises to drop
  labs(title = "Distribution of female penguin weight",
       subtitle = "Island",
       x = "Island", y = "Body Mass (log10(g))",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       fill = "Species",
       ) +
#Replacing df labels to proper capitalizations and credit
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
#Don't need the X labels when the Faceting gives us a copy
        plot.subtitle = element_text(hjust = 0.5),
#Our new X axis Title
        legend.justification = "top",
#It looks a little better by the top
        plot.background = element_rect(fill = "#FFFAF0"),
        panel.background = element_rect(fill = "linen"),
        legend.background = element_rect(fill = "#FFFAF0")) +
#Adding some non-white to keep it from hurting our eyes when we look at the screen in the dark
  scale_fill_viridis_d()
#Color-blind-friendly scale
peng_logplot_plot
#double check visualization

ggsave(here("Week_04/output", "Penguin_weight_graph_hw4.png"),
       width = 7, height = 7)
#Saves a .png of the plot as a square, for instagram
