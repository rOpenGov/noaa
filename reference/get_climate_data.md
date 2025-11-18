# Retrieve Climate Data from the NOAA API

Queries the NOAA Climate Data Online (CDO) API to retrieve climate data
for a given dataset, station or location, and date range. Supports
automatic pagination to collect large datasets.

## Usage

``` r
get_climate_data(
  noaa_token,
  datasetid,
  stationid = NULL,
  locationid = NULL,
  startdate,
  enddate,
  n_results = Inf
)
```

## Arguments

- noaa_token:

  A character string. Your NOAA API token used for authentication. You
  can request a token at https://www.ncdc.noaa.gov/cdo-web/token.

- datasetid:

  A valid dataset ID (e.g., "GHCND", "GSOM", "GSOY"). Use `valid_ids()`
  to view supported datasets.

- stationid:

  Optional. A NOAA station ID (e.g., "GHCND:USW00094728"). Required for
  most station-based datasets.

- locationid:

  Optional. A NOAA location ID (e.g., "FIPS:37", "CITY:US390029"). Used
  for location-based datasets.

- startdate:

  Start date (YYYY-MM-DD) for the query range.

- enddate:

  End date (YYYY-MM-DD) for the query range.

- n_results:

  Maximum number of results to retrieve. Defaults to `Inf` (all
  available results).

## Value

A data frame of climate data observations returned by the NOAA API.

## Examples

``` r
if (nzchar(Sys.getenv("NOAA_TOKEN"))) {
  # Set your NOAA token
  noaa_token <- Sys.getenv("NOAA_TOKEN")

  # Example request: Daily summaries from Central Park, NY (GHCND:USW00094728)
  data <- get_climate_data(
    noaa_token = noaa_token,
    datasetid = "GHCND",
    stationid = "USW00094728",
    startdate = "2020-01-01",
    enddate = "2020-01-31"
  )
  head(data)
}
```
