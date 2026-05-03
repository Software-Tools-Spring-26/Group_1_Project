library(fredr)
library(tidyverse)

fredr_set_key("(Fred Key_")

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
  "USSTHPI"       # USA
)

library(dplyr)
library(purrr)

fhfa_data <- map_dfr(series_ids, function(id) {
  fredr(
    series_id = id,
    observation_start = as.Date("2005-01-01"),
    observation_end = as.Date("2014-12-31")
  ) %>%
    mutate(series_id = id)
})

metro_names <- c(
  "Atlanta-Sandy Springs-Roswell, GA Metro Area", "Boston-Cambridge-Newton, MA-NH Metro Area-Cambridge-Newton, MA-NH Metro Area", "Chicago-Naperville-Elgin, IL-IN Metro Area","Dallas-Fort Worth-Arlington, TX Metro Area", 
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

fhfa_annual_grates_clean <- fhfa_annual_clean %>%
  arrange(Region, Year) %>%
  group_by(Region) %>%
  mutate(
    hpi_growth = (hpi - lag(hpi)) / lag(hpi),
    hpi_growth_pct = 100 * hpi_growth
  ) %>%
  ungroup()

write_csv(fhfa_annual_grates_clean, "fhfa_hpigrowth_full_clean(proxies).csv")

#Added in a proxies column within excel to indicate which MSAs are MSAD proxies
#Adding data back in now

library(readr)
df <- read_csv("fhfa_hpigrowth_full_clean(proxies)_2_MAY_2026.csv")

df$date <- as.Date(paste0(df$Year, "-01-01"))

write.csv(df, "fhfa_hpigrowth_full_clean(proxies)_2_MAY_2026.csv", row.names = FALSE)
