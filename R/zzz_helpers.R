# USW00094728
# "2023-01-01"
# "2023-12-31"

#' @keywords internal
valid_ids <- function() {
  valid_ids <- c(
    "GHCND",        # Global Historical Climatology Network - Daily
    "GSOM",         # Global Summary of the Month
    "GSOY",         # Global Summary of the Year
    "ISD",          # Integrated Surface Data
    "LCD",          # Local Climatological Data
    "MLY",          # Monthly Observations
    "ANN",          # Annual Observations
    "NORMAL_DLY",   # Daily Climate Normals (30-year)
    "NORMAL_MLY",   # Monthly Climate Normals (30-year)
    "ANNUAL",       # Annual Climate Normals (30-year)
    "PRECIP_15",    # 15-minute Precipitation Data
    "PRECIP_HLY",   # Hourly Precipitation Data
    "NEXRAD2",      # NEXRAD Level II Radar
    "NEXRAD3",      # NEXRAD Level III Radar
    "STORM_EVENTS", # Severe Weather Events
    "AGRMET",       # Agricultural Meteorology
    "CPC",          # Climate Prediction Center indices/outlooks
    "CLIMDIV"       # Climate Division Data
  )
  return(valid_ids) }


#' @keywords internal
get_params_by_dataset <- function(datasetid, stationid = NULL, locationid = NULL, startdate, enddate) {
  params <- switch(
    datasetid,
    "GHCND" = get_GHCND(stationid, startdate, enddate),
    "GSOM"  = get_GSOM(stationid, startdate, enddate),
    "GSOY"  = get_GSOY(stationid, startdate, enddate),
    "NEXRAD2" = get_NEXRAD2(stationid, startdate, enddate),
    "NEXRAD3" = get_NEXRAD3(stationid, startdate, enddate),
    "NORMAL_DLY" = get_NORMAL_DLY(stationid, startdate, enddate),
    "NORMAL_MLY" = get_NORMAL_MLY(stationid, startdate, enddate),
    "ANN" = get_NORMAL_ANN(stationid, startdate, enddate),
    "PRECIP_15" = get_PRECIP_15(stationid, startdate, enddate),
    "PRECIP_HLY" = get_PRECIP_HLY(stationid, startdate, enddate),
    "ISD" = get_ISD(stationid, startdate, enddate),
    "CLIMDIV" = get_CLIMDIV(locationid, startdate, enddate),
    "CPC" = get_CPC(locationid, startdate, enddate),
    "LCD" = get_LCD(stationid, startdate, enddate),
    "AGRMET" = get_AGRMET(stationid, startdate, enddate),
    "ANNUAL" = get_ANNUAL(stationid, startdate, enddate),
    "STORM_EVENTS" = get_STORM_EVENTS(locationid, startdate, enddate))

  return(params) }


#' @keywords internal
get_GHCND <- function(stationid, startdate, enddate) {
  # 1. Observed Weather Data
  # Raw or lightly processed observations from ground stations.
  # Dataset ID	Description	Resolution
  # GHCND	Daily summaries	Daily
  # GSOM	Monthly summaries (from daily data)	Monthly
  # GSOY	Yearly summaries (from daily data)	Annual
  # ISD	Integrated Surface Data (hourly)	Hourly
  # LCD	Local Climatological Data (airport obs)	Hourly/Daily
  # MLY	Actual reported monthly observations	Monthly
  # ANN	Actual reported annual observations	Annual

  params <- list(
    datasetid = "GHCND",
    stationid = paste0("GHCND:", stationid),  # Central Park, NY
    startdate = startdate,
    enddate = enddate,
    datatypeid = "TMAX",              # Daily max temp
    units = "metric",
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }


#' @keywords internal
get_GSOM <- function(stationid, startdate, enddate) {

  params <- list(
    datasetid = "GSOM",
    stationid = paste0("GHCND:", stationid),  # Central Park, NY
    startdate = startdate,
    enddate = enddate,
    datatypeid = "TAVG",         # Monthly average temperature
    units = "metric",            # Or "standard"
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }


#' @keywords internal
get_GSOY <- function(stationid, startdate, enddate) {
  params <- list(
    datasetid = "GSOY",
    stationid = paste0("GHCND:", stationid),  # Central Park, NY
    startdate = startdate,
    enddate = enddate,
    datatypeid = "PRCP",
    units = "metric",
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

# KGRK
#' @keywords internal
get_NEXRAD2 <- function(stationid, startdate, enddate) {
  # Weather radar scans and derived products.
  # Dataset ID	Description	Resolution
  # NEXRAD2	Raw Level II radar scans	Sub-hourly
  # NEXRAD3	Processed Level III radar products	Sub-hourly
  params <- list(
    datasetid = "NEXRAD2",
    stationid = paste0("NEXRAD2:", stationid),  # Granger, TX (you can change this)
    startdate = startdate,
    enddate = enddate,
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

# KGRK
#' @keywords internal
get_NEXRAD3 <- function(stationid, startdate, enddate) {
  # 4. Radar Data
  # Weather radar scans and derived products.
  # Dataset ID	Description	Resolution
  # NEXRAD2	Raw Level II radar scans	Sub-hourly
  # NEXRAD3	Processed Level III radar products	Sub-hourly
  params <- list(
    datasetid = "NEXRAD3",
    stationid = paste0("NEXRAD3:", stationid),     # Granger, TX station
    startdate = startdate,
    enddate = enddate,
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

# :USW00094728
#' @keywords internal
get_NORMAL_DLY <- function(stationid, startdate, enddate) {
  # 2. Climate Normals (1981–2010 averages)
  # Long-term climatological averages calculated over 30 years.
  # Dataset ID	Description	Resolution
  # NORMAL_DLY	Daily normals	Daily
  # NORMAL_MLY	Monthly normals	Monthly
  # ANNUAL	Annual normals	Annual

  params <- list(
    datasetid = "NORMAL_DLY",
    stationid = paste0("GHCND", stationid),   # Central Park, NY
    startdate = startdate,           # Required fixed year for normals
    enddate = enddate,             # Should stay in same year
    #datatypeid = "DLY-TMAX-NORMAL",     # Optional: daily normal max temperature
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_NORMAL_MLY <- function(stationid, startdate, enddate) {
  # Climate Normals (1981–2010 averages)
  # Long-term climatological averages calculated over 30 years.
  # Dataset ID	Description	Resolution
  # NORMAL_DLY	Daily normals	Daily
  # NORMAL_MLY	Monthly normals	Monthly
  # ANNUAL	Annual normals	Annual

  params <- list(
    datasetid = "MLY",
    stationid = paste("GHCND:", stationid),        # Central Park, NY
    startdate = startdate,
    enddate = enddate,
    #datatypeid = "MLY-TAVG-AVG",            # Optional: average monthly temp
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_NORMAL_ANN <- function(stationid, startdate, enddate) {

  params <- list(
    datasetid = "ANN",
    stationid = paste("GHCND:", stationid),   # Example: Central Park, NY
    startdate = startdate,
    enddate = enddate,
    #datatypeid = "ANN-TAVG-AVG",       # Optional: average annual temp
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#045264
#' @keywords internal
get_PRECIP_15 <- function(stationid, startdate, enddate) {
  # High-Resolution Precipitation
  # Precipitation data with sub-hourly or hourly granularity.
  # Dataset ID	Description	Resolution
  # PRECIP_15	15-minute precipitation data	15 minutes
  # PRECIP_HLY	Hourly precipitation	Hourly
  params <- list(
    datasetid = "PRECIP_15",
    stationid = paste0("COOP:", stationid),        # Example COOP station ID
    startdate = startdate,
    enddate = enddate,
    datatypeid = "HPCP",              # Hourly Precipitation (can apply to 15-min)
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

# 048845

#' @keywords internal
get_PRECIP_HLY <- function(stationid, startdate, enddate) {
  # High-Resolution Precipitation
  # Precipitation data with sub-hourly or hourly granularity.
  # Dataset ID	Description	Resolution
  # PRECIP_15	15-minute precipitation data	15 minutes
  # PRECIP_HLY	Hourly precipitation	Hourly
  params <- list(
    datasetid = "PRECIP_HLY",
    stationid = paste0("COOP:", stationid),         # Example COOP station ID
    startdate = startdate,
    enddate = enddate,
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_ISD <- function(stationid, startdate, enddate) {
  params <- list(
    datasetid = "ISD",
    stationid = paste0("ISD:", stationid),     # Example: Central Park, NY
    startdate = startdate,
    enddate = enddate,
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_CLIMDIV <- function(locationid, startdate, enddate) {
  # Climate Indices and Forecasts
  # Climate predictions, drought indices, and regional aggregates.
  # Dataset ID	Description	Resolution
  # CLIMDIV	Climate Division-level data (e.g. PDSI, PRCP)	Monthly
  # CPC	Climate Prediction Center (e.g. drought indices)	Weekly/Monthly

  params <- list(
    datasetid = "CLIMDIV",
    locationid = paste0("FIPS:", locationid),           # Example: Texas
    startdate = "2023-01-01",
    enddate = "2023-12-31",
    datatypeid = "CLDD",              # Optional: Cooling Degree Days
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_CPC <- function(locationid, startdate, enddate) {
  # Climate Indices and Forecasts
  # Climate predictions, drought indices, and regional aggregates.
  # Dataset ID	Description	Resolution
  # CLIMDIV	Climate Division-level data (e.g. PDSI, PRCP)	Monthly
  # CPC	Climate Prediction Center (e.g. drought indices)	Weekly/Monthly

  params <- list(
    datasetid = "CPC",
    locationid = paste0("FIPS:", locationid),            # Example: Texas (FIPS code)
    startdate = "2023-01-01",
    enddate = "2023-12-31",
    datatypeid = "DSCI",               # Optional: Drought Severity and Coverage Index
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_LCD <- function(stationid, startdate, enddate) {
  params <- list(
    datasetid = "LCD",
    stationid = "LCD:USW00023183",     # Example: Los Angeles Intl Airport
    startdate = "2023-07-01",
    enddate = "2023-07-07",
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_AGRMET <- function(stationid, startdate, enddate) {
  # Agricultural Meteorology
  # Observations relevant to crop modeling, soil monitoring, etc.
  # Dataset ID	Description	Resolution
  # AGRMET	Soil temp, evapotranspiration, etc.	Sub-daily

  params <- list(
    datasetid = "AGRMET",
    stationid = "AGRMET:US1GAHR0005",      # Example AGRMET station in Georgia
    startdate = "2023-06-01",
    enddate = "2023-06-07",
    datatypeid = "SOILT",                  # Soil temperature
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

#' @keywords internal
get_ANNUAL <- function(stationid, startdate, enddate) {
  # Climate Normals (1981–2010 averages)
  # Long-term climatological averages calculated over 30 years.
  # Dataset ID	Description	Resolution
  # NORMAL_DLY	Daily normals	Daily
  # NORMAL_MLY	Monthly normals	Monthly
  # ANNUAL	Annual normals	Annual

  params <- list(
    datasetid = "ANNUAL",
    stationid = "GHCND:USW00094728",       # Central Park, NY
    startdate = "2010-01-01",
    enddate = "2010-12-31",
    datatypeid = "ANN-PRCP-NORMAL",        # Optional: change as needed
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }

# 48

#' @keywords internal
get_STORM_EVENTS  <- function(locationid, startdate, enddate) {
  # Severe Weather Events
  # Records of significant weather events, not continuous data.
  # Dataset ID	Description	Resolution
  # STORM_EVENTS	Tornadoes, hail, floods, hurricanes, etc	Event-based

  params <- list(
    datasetid = "STORM_EVENTS",
    locationid = paste0("FIPS:", locationid),       # Texas
    startdate = "2023-01-01",
    enddate = "2023-12-31",
    limit = 1000,
    sortfield = "date",
    sortorder = "asc")
  return(params) }


#' @importFrom utils modifyList
NULL



