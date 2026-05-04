library(fredr)
library(tidyverse)

fredr_set_key("FRED KEY")

series_ids <- c(
  "ATNHPIUS12060Q", # Atlanta-Sandy Springs-Roswell, GA Metro Area (Full)
  "ATNHPIUS14454Q", # Boston (Proxy MSA for Boston-Cambridge-Newton, MA-NH Metro Area)
  "ATNHPIUS16984Q", #Chicago-Naperville-Evanston (proxy for Chicago-Naperville-Elgin, IL-IN Metro Area)
  "ATNHPIUS19124Q", #Dallas-Plano-Irving, TX (MSAD)(proxy for Dallas-Fort Worth-Arlington, TX Metro Area)
  "ATNHPIUS19740Q", #Denver (Full)
  "ATNHPIUS26420Q", #Houston (Full)
  "ATNHPIUS31084Q", #Los Angeles-Long Beach-Glendale, CA (MSAD) (proxy for Los Angeles-Long Beach-Anaheim)
  "ATNHPIUS35614Q", #New York-Jersey City-White Plains (proxy for New York-Newark-Jersey City, NY-NJ Metro Area)
  "ATNHPIUS36740Q", # Orlando (Full)
  "ATNHPIUS38060Q", # Phoenix (Full)
  "ATNHPIUS40140Q", # Riverside (Full)
  "ATNHPIUS40140Q", # San Diego (Full)
  "ATNHPIUS41884Q", # San Francisco-San Mateo-Redwood City (MSAD) (Proxy for San Francisco-Oakland-Fremont, CA Metro Area)
  "ATNHPIUS42644Q", # Seattle-Bellevue-Kent, WA (MSAD), (proxy for Seattle-Tacoma-Bellevue, WA Metro Area)
  "USSTHPI"       # USA (Full)
)

library(dplyr)
library(purrr)
library(readr)

fhfa_data <- map_dfr(series_ids, function(id) {
  fredr(
    series_id = id,
    observation_start = as.Date("2004-01-01"),
    observation_end = as.Date("2014-12-31")
  ) %>%
    mutate(series_id = id)
})

metro_names <- c(
  "Atlanta-Sandy Springs-Roswell, GA Metro Area", "Boston-Cambridge-Newton, MA-NH Metro Area", "Chicago-Naperville-Elgin, IL-IN Metro Area","Dallas-Fort Worth-Arlington, TX Metro Area", 
  "Denver-Aurora-Centennial, CO Metro Area", "Houston-Pasadena-The Woodlands, TX Metro Area", "Los Angeles-Long Beach-Anaheim, CA Metro Area", "New York-Newark-Jersey City, NY-NJ Metro Area", 
  "Orlando-Kissimmee-Sanford, FL Metro Area", "Phoenix-Mesa-Chandler, AZ Metro Area", "Riverside-San Bernardino-Ontario, CA Metro Area", "San Diego-Chula Vista-Carlsbad, CA Metro Area",
  "San Francisco-Oakland-Fremont, CA Metro Area", "Seattle-Tacoma-Bellevue, WA Metro Area", "USA"
)

fhfa_data <- fhfa_data %>%
  mutate(Region = rep(metro_names, each = nrow(fhfa_data) / length(metro_names)))

fhfa_clean <- fhfa_data %>%
  rename(hpi = value, Date = date) %>%
  arrange(Region, Date) %>%
  group_by(Region) %>%
  mutate(
    hpi_growth = (hpi - lag(hpi)) / lag(hpi),
    hpi_growth_pct = 100 * hpi_growth
  ) %>%
  ungroup()

fhfa_annual_clean <- fhfa_clean %>%
  mutate(Year = year(Date)) %>%
  group_by(Region, Year) %>%
  summarise(
    hpi = mean(hpi, na.rm = TRUE),
    .groups = "drop"
  )

full_msa <- c(
  "Atlanta-Sandy Springs-Roswell, GA Metro Area",
  "Denver-Aurora-Centennial, CO Metro Area",
  "Houston-Pasadena-The Woodlands, TX Metro Area",
  "Orlando-Kissimmee-Sanford, FL Metro Area",
  "Phoenix-Mesa-Chandler, AZ Metro Area",
  "Riverside-San Bernardino-Ontario, CA Metro Area",
  "San Diego-Chula Vista-Carlsbad, CA Metro Area",
  "USA"
)

fhfa_annual_grates_clean <- fhfa_annual_clean %>%
  arrange(Region, Year) %>%
  group_by(Region) %>%
  mutate(
    hpi_growth = (hpi - lag(hpi)) / lag(hpi),
    hpi_growth_pct = 100 * hpi_growth
  ) %>%
  ungroup() %>%
  mutate(
    Date = as.Date(paste0(Year, "-01-01")),
    Proxy_or_Full = ifelse(Region %in% full_msa, "Full", "Proxy")
  ) %>%
  filter(Year != 2004)

write_csv(fhfa_annual_grates_clean, "fhfa_hpigrowth_fullclean_Final.csv")


my_data <- read.csv("fhfa_hpigrowth_fullclean_Final.csv")
#Creating Summary Statistics


hpi_growth_by_region <- fhfa_annual_grates_clean %>%
  group_by(Region) %>%
  summarize(
    mean = mean(hpi_growth, na.rm = TRUE),
    median = median(hpi_growth, na.rm = TRUE),
    sd = sd(hpi_growth, na.rm = TRUE),
    min = min(hpi_growth, na.rm = TRUE),
    max = max(hpi_growth, na.rm = TRUE)
  )

hpi_growth_by_region

hpi_by_region <- fhfa_annual_grates_clean %>%
  group_by(Region) %>%
  summarize(
    mean = mean(hpi, na.rm = TRUE),
    median = median(hpi, na.rm = TRUE),
    sd = sd(hpi, na.rm = TRUE),
    min = min(hpi, na.rm = TRUE),
    max = max(hpi, na.rm = TRUE)
  )

hpi_by_region

summary_by_region <- fhfa_annual_grates_clean %>%
  group_by(Region) %>%
  summarize(
    'HPI Mean' = mean(hpi, na.rm = TRUE),
    'HPI Median' = median(hpi, na.rm = TRUE),
    'HPI SD' = sd(hpi, na.rm = TRUE),
    'HPI Min' = min(hpi, na.rm = TRUE),
    'HPI Max' = max(hpi, na.rm = TRUE),
    'HPI Growth Mean' = mean(hpi_growth_pct, na.rm = TRUE),
    'HPI Growth Max' = median(hpi_growth_pct, na.rm = TRUE),
    'HPI Growth SD' = sd(hpi_growth_pct, na.rm = TRUE),
    'HPI Growth Min' = min(hpi_growth_pct, na.rm = TRUE),
    'HPI Growth Max' = max(hpi_growth_pct, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(Region)

summary_by_region

library(knitr)
summary_by_region %>%
  mutate(across(where(is.numeric), ~ round(.x, 2))) %>%
  kable(
    caption = "Summary Statistics for FHFA HPI and Annual HPI Growth by Region"
  )

overall_growth_not_incl_usa <- fhfa_annual_grates_clean %>%
  filter(Region != "USA") %>%
  summarize(
    mean = mean(hpi_growth_pct, na.rm = TRUE),
    median = median(hpi_growth_pct, na.rm = TRUE),
    sd = sd(hpi_growth_pct, na.rm = TRUE),
    min = min(hpi_growth_pct, na.rm = TRUE),
    max = max(hpi_growth_pct, na.rm = TRUE)
  )

overall_growth_not_incl_usa %>%
  mutate(across(where(is.numeric), ~ round(.x, 2))) %>%
  kable(caption = "Overall HPI Growth Summary (Excluding USA)")


overall_hpi_not_incl_usa <- fhfa_annual_grates_clean %>%
  filter(Region != "USA") %>%
  summarize(
    mean = mean(hpi, na.rm = TRUE),
    median = median(hpi, na.rm = TRUE),
    sd = sd(hpi, na.rm = TRUE),
    min = min(hpi, na.rm = TRUE),
    max = max(hpi, na.rm = TRUE)
  )

overall_hpi_not_incl_usa %>%
  mutate(across(where(is.numeric), ~ round(.x, 2))) %>%
  kable(caption = "Overall HPI Summary (Excluding USA)")

