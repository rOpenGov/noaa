# Retrieve Station IDs for a Given Dataset and Location

Queries the NOAA Climate Data Online (CDO) API to retrieve station
identifiers associated with a specified dataset, location, and date
range.

## Usage

``` r
get_stationid(
  noaa_token,
  datasetid,
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

  A valid dataset ID (e.g., "GHCND", "GSOM", etc.). Use `valid_ids()` to
  see supported values.

- locationid:

  Optional. A valid location ID (e.g., "FIPS:37", "CITY:US390029"). If
  `NULL`, all locations are considered.

- startdate:

  Start date (YYYY-MM-DD) for station data coverage.

- enddate:

  End date (YYYY-MM-DD) for station data coverage.

- n_results:

  Maximum number of station results to retrieve. Defaults to `Inf` to
  fetch all available.

## Value

A data frame containing metadata for the matching NOAA stations.

## Examples

``` r
if (nzchar(Sys.getenv("NOAA_TOKEN"))) {
  # Retrieve your NOAA API token from environment
  noaa_token <- Sys.getenv("NOAA_TOKEN")

  # Get stations for the GHCND dataset in Texas between 2020-01-01 and 2020-12-31
  stations <- get_stationid(
    noaa_token = noaa_token,
    datasetid = "GHCND",
    locationid = "FIPS:48",
    startdate = "2020-01-01",
    enddate = "2020-12-31"
  )
  head(stations)
}
```
