#' Retrieve Station IDs for a Given Dataset and Location
#'
#' Queries the NOAA Climate Data Online (CDO) API to retrieve station identifiers
#' associated with a specified dataset, location, and date range.
#'
#' @param noaa_token A character string. Your NOAA API token used for authentication. You can request a token at https://www.ncdc.noaa.gov/cdo-web/token.
#' @param datasetid A valid dataset ID (e.g., "GHCND", "GSOM", etc.). Use \code{valid_ids()} to see supported values.
#' @param locationid Optional. A valid location ID (e.g., "FIPS:37", "CITY:US390029"). If \code{NULL}, all locations are considered.
#' @param startdate Start date (YYYY-MM-DD) for station data coverage.
#' @param enddate End date (YYYY-MM-DD) for station data coverage.
#' @param n_results Maximum number of station results to retrieve. Defaults to \code{Inf} to fetch all available.
#'
#' @return A data frame containing metadata for the matching NOAA stations.
#'
#' @examples
#' if (nzchar(Sys.getenv("NOAA_TOKEN"))) {
#'   # Retrieve your NOAA API token from environment
#'   noaa_token <- Sys.getenv("NOAA_TOKEN")
#'
#'   # Get stations for the GHCND dataset in Texas between 2020-01-01 and 2020-12-31
#'   stations <- get_stationid(
#'     noaa_token = noaa_token,
#'     datasetid = "GHCND",
#'     locationid = "FIPS:48",
#'     startdate = "2020-01-01",
#'     enddate = "2020-12-31"
#'   )
#'   head(stations)
#' }
#'
#' @importFrom httr GET add_headers status_code content
#' @importFrom jsonlite fromJSON
#' @export
get_stationid <- function(noaa_token, datasetid, locationid = NULL, startdate, enddate, n_results = Inf) {

  stations_url <- "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations"
  valid_ids <- valid_ids()

  if (!(datasetid %in% valid_ids)) {
    stop(paste0(
      "Invalid datasetid: '", datasetid, "'.\n",
      "Valid options are: ", paste(valid_ids, collapse = ", "), "."))
  }

  all_results <- list()
  limit <- 1000
  offset <- 1
  total_records <- Inf
  total_fetched <- 0

  while (offset <= total_records && total_fetched < n_results) {
    this_limit <- min(limit, n_results - total_fetched)

    params <- list(
      datasetid = datasetid,
      locationid = locationid,
      startdate = startdate,
      enddate = enddate,
      limit = this_limit,
      offset = offset)

    response <- GET(
      url = stations_url,
      add_headers(token = noaa_token),
      query = params)

    if (status_code(response) != 200) {
      stop("API request failed with status: ", status_code(response))
    }

    data <- content(response, as = "text", encoding = "UTF-8")
    parsed <- fromJSON(data, flatten = TRUE)

    if (!"results" %in% names(parsed)) {
      break
    }

    all_results <- append(all_results, list(parsed$results))
    total_fetched <- total_fetched + nrow(parsed$results)

    if (is.infinite(total_records) && "metadata" %in% names(parsed)) {
      total_records <- parsed$metadata$resultset$count
    }

    offset <- offset + limit
  }

  stations_df <- do.call(rbind, all_results)
  return(stations_df)
}
