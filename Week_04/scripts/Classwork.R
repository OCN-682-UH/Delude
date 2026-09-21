#Classwork for R class week 04

#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)

#Code

penguins |>
  #filter(year %in% c(2008, 2009))
  #filter(island != "Dream")
  #filter(species %in% c("Adelie", "Gentoo"))
  mutate(body_mass_kg = body_mass_g / 1000,
         bill_length_depth = bill_length_mm / bill_depth_mm)
  
penguins |>
  mutate(total_mass = flipper_length_mm + body_mass_g,
         simple_mass = if_else(total_mass > 4000,
                               "big",
                               "small")) |>
  relocate(simple_mass, .after = island)
