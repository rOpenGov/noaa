# Retrieve NOAA Location IDs for a Given Category

Queries the NOAA Climate Data Online (CDO) API to retrieve location
identifiers for a specified category (e.g., state, city, county).

## Usage

``` r
get_locationid(noaa_token, category_id, n_results = Inf)
```

## Arguments

- noaa_token:

  A character string. Your NOAA API token used for authentication. You
  can request a token at https://www.ncdc.noaa.gov/cdo-web/token.

- category_id:

  A valid location category ID. Options: "ST", "CITY", "COUNTY", "ZIP",
  "CLIM_REG", "HYDROL_REG", "FIPS".

- n_results:

  Maximum number of results to retrieve. Defaults to Inf (all results).

## Value

A data frame of location IDs matching the given category.

## Examples

``` r
if (nzchar(Sys.getenv("NOAA_TOKEN"))) {
  # Retrieve token from environment variable
  noaa_token <- Sys.getenv("NOAA_TOKEN")

  # Get all U.S. state-level location IDs using category "FIPS"
  locations <- get_locationid(noaa_token = noaa_token, category_id = "FIPS")
  head(locations)
}
```
