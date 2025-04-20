#' Retrieve Climate Data from the NOAA API
#'
#' Queries the NOAA Climate Data Online (CDO) API to retrieve climate data for a given dataset,
#' station or location, and date range. Supports automatic pagination to collect large datasets.
#'
#' @param noaa_token A character string. Your NOAA API token used for authentication. You can request a token at https://www.ncdc.noaa.gov/cdo-web/token.
#' @param datasetid A valid dataset ID (e.g., "GHCND", "GSOM", "GSOY"). Use \code{valid_ids()} to view supported datasets.
#' @param stationid Optional. A NOAA station ID (e.g., "GHCND:USW00094728"). Required for most station-based datasets.
#' @param locationid Optional. A NOAA location ID (e.g., "FIPS:37", "CITY:US390029"). Used for location-based datasets.
#' @param startdate Start date (YYYY-MM-DD) for the query range.
#' @param enddate End date (YYYY-MM-DD) for the query range.
#' @param n_results Maximum number of results to retrieve. Defaults to \code{Inf} (all available results).
#'
#' @return A data frame of climate data observations returned by the NOAA API.
#'
#' @importFrom httr GET add_headers status_code content http_status
#' @importFrom jsonlite fromJSON
#' @export
get_climate_data <- function(noaa_token, datasetid, stationid = NULL, locationid = NULL, startdate, enddate, n_results = Inf) {

  base_url <- "https://www.ncdc.noaa.gov/cdo-web/api/v2/data"
  valid_ids <- valid_ids()

  if (!(datasetid %in% valid_ids)) {
    stop(paste0(
      "Invalid datasetid: '", datasetid, "'.\n",
      "Valid options are: ", paste(valid_ids, collapse = ", "), ".")) }

  params <- switch(
    datasetid,
    "GHCND"      = get_GHCND(stationid, startdate, enddate),
    "GSOM"       = get_GSOM(stationid, startdate, enddate),
    "GSOY"       = get_GSOY(stationid, startdate, enddate),
    "NEXRAD2"    = get_NEXRAD2(stationid, startdate, enddate),
    "NEXRAD3"    = get_NEXRAD3(stationid, startdate, enddate),
    "NORMAL_DLY" = get_NORMAL_DLY(stationid, startdate, enddate),
    "NORMAL_MLY" = get_NORMAL_MLY(stationid, startdate, enddate),
    "ANN"        = get_NORMAL_ANN(stationid, startdate, enddate),
    "PRECIP_15"  = get_PRECIP_15(stationid, startdate, enddate),
    "PRECIP_HLY" = get_PRECIP_HLY(stationid, startdate, enddate),
    "ISD"        = get_ISD(stationid, startdate, enddate),
    "CLIMDIV"    = get_CLIMDIV(locationid, startdate, enddate),
    "CPC"        = get_CPC(locationid, startdate, enddate),
    "LCD"        = get_LCD(stationid, startdate, enddate),
    "AGRMET"     = get_AGRMET(stationid, startdate, enddate),
    "ANNUAL"     = get_ANNUAL(stationid, startdate, enddate),
    "STORM_EVENTS" = get_STORM_EVENTS(locationid, startdate, enddate))

  all_results <- list()
  limit <- 1000
  offset <- 1
  total_records <- Inf
  total_fetched <- 0

  while (offset <= total_records && total_fetched < n_results) {
    this_limit <- min(limit, n_results - total_fetched)
    query_params <- modifyList(params, list(limit = this_limit, offset = offset))

    response <- GET(url = base_url,
                    add_headers(token = noaa_token),
                    query = query_params)

    if (status_code(response) != 200) {
      stop(
        paste0("NOAA API request failed [Status ", status_code(response), "]: ",
               http_status(response)$message))
    }

    data <- content(response, as = "text", encoding = "UTF-8")
    parsed <- fromJSON(data, flatten = TRUE)

    if (!"results" %in% names(parsed)) break
    if (!is.data.frame(parsed$results)) break

    all_results <- append(all_results, list(parsed$results))
    total_fetched <- total_fetched + nrow(parsed$results)

    if (is.infinite(total_records) && "metadata" %in% names(parsed)) {
      total_records <- parsed$metadata$resultset$count
    }

    offset <- offset + this_limit
  }

  if (length(all_results) == 0) return(NULL)

  df <- do.call(rbind, all_results)
  return(df)
}
