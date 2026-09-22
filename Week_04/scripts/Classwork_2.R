### Today we are going to practice tidyr with biogeochemistry data from Hawaii ####
### Created by: Dr. Nyssa Silbiger #############
### Updated on: 2026-09-14 ####################

#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
ChemData <- read_csv(here("Week_04", "data", "chemicaldata_maunalua.csv"))
glimpse(ChemData)

ChemData_clean <- ChemData |>
  filter(complete.cases(ChemData)) # filters out everything that is not a complete row
ChemData_clean <- ChemData |>
  drop_na() |>
  separate_wider_delim(cols  = Tide_time,
                       delim = "_",
                       names = c("Tide", "Time"),
                       cols_remove = FALSE) |>
  mutate(Site_Zone = paste(Site, Zone, sep = "."))

head(ChemData_clean)

ChemData_long <- ChemData_clean |>
  pivot_longer(cols      = Temp_in:percent_sgd, # select columns to pivot
               names_to  = "Variables",         # new column for old column names
               values_to = "Values")            # new column for the values

ChemData_long |>
  group_by(Variables, Site, Zone, Tide) |>
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars  = var(Values,  na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))
ChemData_long |>
  ggplot(aes(x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(Tide~Variables, scales = "free")

ChemData_wide <- ChemData_long |>
  pivot_wider(names_from  = Variables,
              values_from = Values)


ChemDate_clean <- ChemData |>
  drop_na() |>
  separate_wider_delim(cols = Tide_time,
                       delim = "_",
                       names = c("Tide", "Time"),
                       cols_remove = FALSE) |>
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") |>
  group_by(Variables, Site, Time) |>
  summarise(means_vals = mean(Values, na.rm = TRUE)) |>
  pivot_wider(names_from = Variables,
              values_from = means_vals) |>
  write_csv(here("Week_04", "output", "summary.csv"))