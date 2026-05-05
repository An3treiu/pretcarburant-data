# Load the cumulative dataset directly from GitHub raw URL.
# Run with: Rscript load_r.R
# Requires: readr, dplyr (`install.packages(c('readr', 'dplyr'))`)
library(readr)
library(dplyr)

url <- 'https://raw.githubusercontent.com/An3treiu/pretcarburant-data/main/monthly/cumulative-latest.csv'
df <- read_csv(url, show_col_types = FALSE)

cat('Rows:', nrow(df), '\n')
cat('Date range:', as.character(min(df$date)), 'to', as.character(max(df$date)), '\n')
cat('Fuel types:', paste(unique(df$fuel_type), collapse = ', '), '\n\n')

# Last 5 rows
print(tail(df, 5))

# Monthly mean diesel price
diesel_monthly <- df %>%
  filter(fuel_type == 'motorina_standard') %>%
  mutate(month = format(date, '%Y-%m')) %>%
  group_by(month) %>%
  summarise(price_avg_mean = round(mean(price_avg, na.rm = TRUE), 3)) %>%
  tail(12)

cat('\nMonthly average diesel (motorina_standard), RON/L:\n')
print(diesel_monthly)
