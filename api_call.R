library(httr)
library(jsonlite)
library(dplyr)
library(stringr)


# TODO: Add limit


get_weather_data <- function(token, zip, startdate, enddate, units, limit=25) {
  if(!(str_detect(startdate, "[0-9]{4}-[0-9]{2}-[0-9]{2}") & str_detect(enddate, "[0-9]{4}-[0-9]{2}-[0-9]{2}"))) {
    stop("Dates must be in YYYY-MM-DD format.") }

  base <- "https://www.ncei.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND"
  zip <- paste0("locationid=ZIP:", zip)
  startdate <- paste0("startdate=", startdate)
  enddate <- paste0("enddate=", enddate)
  units <- paste0("units=", units)
  limit <- paste0("limit=", limit)
  api_call <- paste0(base, "&", zip, "&", startdate, "&", enddate, "&", units, "&", limit)

  response <- GET(api_call, add_headers("token" = token))

  content <- fromJSON(rawToChar(response$content), flatten = TRUE)
  results <- content$results

  results <- results %>%
    select(-attributes)

  return(results) }



get_station_data <- function(token, station_no, limit=25) {
  base <- "https://www.ncei.noaa.gov/cdo-web/api/v2/stations/"
  limit <- paste0("limit=", limit)

  api_call <- paste0(base, station_no, "?", limit)
  response <- GET(api_call, add_headers("token" = token))
  results <- as.data.frame(fromJSON(rawToChar(response$content), flatten = TRUE))

  return(results) }


#Default is 25. Max is 1,000

get_weather_data(token = "RwxSOFeVkuTygQpilLiTXWYgtSueUOaf", zip = "28801", startdate = "2010-12-01",
                 enddate = "2010-12-05", units = "standard", limit = "10")


get_station_data(token = "RwxSOFeVkuTygQpilLiTXWYgtSueUOaf", station_no = "COOP:010008")


#https://www.ncei.noaa.gov/cdo-web/api/v2/stations

