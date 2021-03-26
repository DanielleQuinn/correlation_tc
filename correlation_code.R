# ---- Set Up Workspace ----
library(dplyr)
library(ggplot2)
library(tidyr)
library(lubridate)
library(stringr)
library(gtrendsR)
library(scales)
source("functions.R")

# ---- Access Data ----
# 1. Choose two search terms
myWords <- c("vines", "tik tok")

# 2. Choose a country
## CA for Canada, US for United States
myCountry <- "CA"

# 3. Choose a time frame
## "yyyy-mm-dd yyyy-mm-dd" to specify a date range
## "now 1-H" to specify in the last hour
## "today 12-m" to specify the last year
## "today+5-y" to specify the last five years
myTime <- "2020-01-01 2020-12-31"

# 4. Choose a search type
## "youtube" for YouTube
## "web" for Google Search
## "images" for Google Images
mySearchType <- "youtube"

# 5. Get those results!
results <- gtrends(myWords, myCountry, myTime, mySearchType)

# ---- View Raw Data in a Table ----
rawTable(results)

# ---- Visualize Results Over Time ----
overtime(results)

# ---- Visualize Results Over Time (Scaled) ----
scaled_overtime(results)

# ---- Visualize Results Compared to Each Other ----
compare(results)

# ---- Calculate Correlation ----
correlation(results)
