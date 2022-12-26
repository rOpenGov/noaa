library(httr)
library(jsonlite)
library(dplyr)

value <- "RwxSOFeVkuTygQpilLiTXWYgtSueUOaf"
url <- "https://www.ncei.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND&locationid=ZIP:28801&startdate=2010-05-01&enddate=2010-05-01&units=standard"
a <- GET(url, add_headers("token" = value))

b <- fromJSON(rawToChar(a$content), flatten = TRUE)

c <- b$results

url <- "https://www.ncei.noaa.gov/cdo-web/api/v2/stations/GHCND:USW00013872"


#TODO: Add date cleaner so all dates get formatted YYYY-MM-DD




get_weather_data <- function(token, zip, startdate, enddate, units) {
  base <- "https://www.ncei.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND"
  zip <- paste0("locationid=ZIP:", zip)
  startdate <- paste0("startdate=", startdate)
  enddate <- paste0("enddate=", enddate)
  units <- paste0("units=", units)
  api_call <- paste0(base, "&", zip, "&", startdate, "&", enddate, "&", units)
  print(api_call)
  response <- GET(api_call, add_headers("token" = token))

  content <- fromJSON(rawToChar(response$content), flatten = TRUE)
  results <- content$results

  results <- results %>%
    select(-attributes)

  return(results) }


get_weather_data("RwxSOFeVkuTygQpilLiTXWYgtSueUOaf", "28801", "2010-05-01", "2010-05-05", "standard")





