T1 <- tibble(
  Site.ID = c("A", "B", "C", "D"),
  Temperature = c(14.1, 16.7, 15.3, 12.8)
)

T1
T2 <- tibble(
  Site.ID = c("A", "B", "D", "E"),
  pH = c(7.3, 7.8, 8.1, 7.9)
)

T2

left_join(T1, T2)

right_join(T1,T2)
T3 <- tibble(
  SiteID = c("A", "B", "C", "D"),  # Note: different name!
  Chlorophyll = c(2.3, 3.1, 1.9, 2.8)
)

T3

left_join(T1, T3, by = c("Site.ID" = "SiteID"))

T4 <- tibble(
  Site.ID = c("A", "A", "B", "B"),
  Year = c(2020, 2021, 2020, 2021),
  Biomass = c(12.5, 15.3, 18.2, 16.9)
)

T5 <- tibble(
  SiteID = c("A", "A", "B"),
  Year = c(2020, 2021, 2021),
  Nutrients = c(8.2, 7.9, 9.1)
)

left_join(T4, T5, by = c("Site.ID" = "SiteID", "Year" = "Year"))

T6 <- tibble(
  Site.ID = c("A", "B", "C"),
  Notes = c("pristine", "degraded", "moderately impaired")
)

T7 <- tibble(
  Site.ID = c("A", "B", "D"),
  Notes = c("sunny", "shaded", "partially shaded"),
  Quality = c("good", "fair", "poor")
)

# Don't specify how to join — creates ambiguity with 'Notes'
left_join(T6, T7, by = "Site.ID")

T6_renamed <- T6 |> 
  rename(Condition_Notes = Notes)

T7_renamed <- T7 |> 
  rename(Habitat_Notes = Notes)

left_join(T6_renamed, T7_renamed, by = "Site.ID")

datetimes <- c(
  "02/24/2021 22:22:20",
  "02/25/2021 11:21:10",
  "02/26/2021 8:01:52"
)

datetimes

datetimes <- mdy_hms(datetimes)

datetimes

CondData |>
  mutate(datetime = mdy_hms(date))

####


Site_Char <- read_csv(here("Week_05", "data", "site.characteristics.data.csv"))
Topt <- read_csv(here("Week_05", "data", "Topt_data.csv"))

full_df <- Site_Char |>
  pivot_wider(names_from = "parameter.measured",
              values_from = "values") |>
  full_join(Site_Char, Topt, by = "name")

full_df