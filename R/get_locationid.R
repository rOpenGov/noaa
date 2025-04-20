#' Retrieve NOAA Location IDs for a Given Category
#'
#' Queries the NOAA Climate Data Online (CDO) API to retrieve location identifiers
#' for a specified category (e.g., state, city, county).
#'
#' @param noaa_token A character string. Your NOAA API token used for authentication. You can request a token at https://www.ncdc.noaa.gov/cdo-web/token.
#' @param category_id A valid location category ID. Options: "ST", "CITY", "COUNTY", "ZIP", "CLIM_REG", "HYDROL_REG", "FIPS".
#' @param n_results Maximum number of results to retrieve. Defaults to Inf (all results).
#'
#' @return A data frame of location IDs matching the given category.
#'
#' @importFrom httr GET add_headers status_code content
#' @importFrom jsonlite fromJSON
#' @export
get_locationid <- function(noaa_token, category_id, n_results = Inf) {

  # ST	State	U.S. states and territories. Example: "ST:TX" for Texas.
  # CITY	U.S. Cities	Major U.S. cities with weather stations. Example: "CITY:US390029"
  # COUNTY	U.S. Counties	U.S. counties (e.g., "COUNTY:US36061" for New York County, NY).
  # ZIP	ZIP Code Areas	Geographic regions based on ZIP codes.
  # CLIM_REG	Climate Regions	NOAA-defined climate regions (e.g., Southeast, Midwest).
  # HYDROL_REG	Hydrologic Regions	Watershed-based hydrologic regions used for water resource planning.
  # FIPS	Federal Information Processing Standards	Standard geographic codes for states/counties (e.g., "FIPS:37" = North Carolina).

  valid_ids <- c("ST", "CITY", "COUNTY", "ZIP", "CLIM_REG", "HYDROL_REG", "FIPS")

  if (!(category_id %in% valid_ids)) {
    stop(paste0(
      "Invalid category_id: '", category_id, "'.\n",
      "Valid options are: ", paste(valid_ids, collapse = ", "), "."))
  }

  locations_url <- "https://www.ncdc.noaa.gov/cdo-web/api/v2/locations"
  all_results <- list()
  limit <- 1000
  offset <- 1
  total_records <- Inf
  total_fetched <- 0

  while (offset <= total_records && total_fetched < n_results) {
    this_limit <- min(limit, n_results - total_fetched)
    params <- list(locationcategoryid = category_id, limit = this_limit, offset = offset)

    response <- GET(
      url = locations_url,
      add_headers(token = noaa_token),
      query = params)

    if (status_code(response) != 200) {
      stop("API request failed with status: ", status_code(response))
    }

    data <- content(response, "text", encoding = "UTF-8")
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

  locations_df <- do.call(rbind, all_results)
  return(locations_df)
}
