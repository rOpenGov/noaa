# noaa: Accessing Current and Historic Weather Data by NOAA

[![](https://cranlogs.r-pkg.org/badges/noaa)](https://cran.r-project.org/package=noaa)
[![](https://cranlogs.r-pkg.org/badges/grand-total/noaa)](https://cran.r-project.org/package=noaa)
[![](https://www.r-pkg.org/badges/version/noaa)](https://CRAN.R-project.org/package=noaa)

If this project helped, consider supporting it:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00)](https://buymeacoffee.com/stephbuon)

National Oceanic and Atmospheric Administration (NOAA) maintains one of the largest climate data archives, the National Climatic Data Center (NCDC). NCDC's [Climate Data Online](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#stations) (CDO) offers web services that provide access to weather and climate data, which include (but is not limited to) minimum and maximum temperature in different zip codes by date, amount of precipitation, longitude and latitude of stations, and more. 

It is the only known R package that enables the user to search historical weather data by zip code. 

### Install

Install from CRAN:

```
install.packages("noaa")
```

Install from rOpenGov:

```
options(repos = c(
    ropengov = "https://ropengov.r-universe.dev",
    CRAN = "https://cloud.r-project.org"))

install.packages("noaa")
```

### Authentication Token

Accessing CDO data requires a token. 

Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address.

### Functions

### `get_climate_data()`

The `get_climate_data()` function allows you to retrieve climate and weather data from the [NOAA Climate Data Online (CDO) API](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#gettingStarted) for a wide range of dataset types. It supports pagination and can retrieve large numbers of records by iteratively querying the API.

```r
get_climate_data(noaa_token, datasetid, stationid = NULL, locationid = NULL, startdate, enddate, n_results = Inf)
```

### Arguments

| Argument       | Type       | Description |
|----------------|------------|-------------|
| `noaa_token`   | `string`   | Your NOAA API token, available by registering at [NOAA CDO](https://www.ncdc.noaa.gov/cdo-web/token). |
| `datasetid`    | `string`   | The dataset identifier. Must be one of the valid NOAA dataset IDs (see below). |
| `stationid`    | `string` or `NULL` | The station ID (e.g., `"USW00094728"`). Required for station-based datasets. |
| `locationid`   | `string` or `NULL` | The location ID (e.g., `"FIPS:48"` for Texas). Required for location-based datasets. |
| `startdate`    | `string`   | Start date for the query in `"YYYY-MM-DD"` format. |
| `enddate`      | `string`   | End date for the query in `"YYYY-MM-DD"` format. |
| `n_results`    | `numeric`  | Maximum number of results to return. Use `Inf` (default) to fetch all available records. |

Supported Dataset IDs: 

The function currently supports the following datasets:

- `GHCND` – Daily summaries  
- `GSOM` – Monthly summaries  
- `GSOY` – Yearly summaries  
- `NEXRAD2`, `NEXRAD3` – Radar data  
- `NORMAL_DLY`, `NORMAL_MLY`, `ANN`, `ANNUAL` – Climate normals  
- `PRECIP_15`, `PRECIP_HLY` – Precipitation data  
- `ISD` – Integrated Surface Data  
- `CLIMDIV` – Climate division data  
- `CPC` – Climate Prediction Center data  
- `LCD` – Local Climatological Data  
- `AGRMET` – Agricultural Meteorological data  
- `STORM_EVENTS` – Storm event data  

Example: 

```r
# Example: Get daily precipitation for Central Park, NY in January 2020
df <- get_climate_data(
  noaa_token = "YOUR_API_KEY",
  datasetid = "GHCND",
  stationid = "USW00094728",
  startdate = "2020-01-01",
  enddate = "2020-01-31",
  n_results = 1000
)
```


### `get_locationid()`

The `get_locationid()` function retrieves location identifiers from the NOAA Climate Data Online (CDO) API based on a specified category. It supports pagination to return large sets of location data.

```r
get_locationid(noaa_token, category_id, n_results = Inf)
```

### Arguments

| Argument       | Type       | Description |
|----------------|------------|-------------|
| `noaa_token`   | `string`   | NOAA API token used for authentication. |
| `category_id`  | `string`   | The location category identifier. Must be one of the valid location categories (see below). |
| `n_results`    | `numeric`  | Maximum number of results to retrieve. Defaults to `Inf` to fetch all available records. |

Supported Location Category IDs:

The function supports the following location categories:

- `ST` – U.S. States and territories (e.g., `"ST:TX"` for Texas)  
- `CITY` – Major U.S. cities with weather stations  
- `COUNTY` – U.S. counties (e.g., `"COUNTY:US36061"` for New York County, NY)  
- `ZIP` – ZIP Code areas  
- `CLIM_REG` – NOAA-defined climate regions (e.g., Southeast, Midwest)  
- `HYDROL_REG` – Hydrologic regions used for water resource planning  
- `FIPS` – Federal Information Processing Standards codes (e.g., `"FIPS:37"` for North Carolina)

Example:

```r
# Example: Retrieve a list of U.S. states
df <- get_locationid(
  noaa_token = "YOUR_API_KEY",
  category_id = "ST",
  n_results = 100
)
```

Returns: 

A data frame containing location metadata from the specified category. If no results are returned or the request fails, an error is thrown or an empty data frame is returned.

### `get_stationid()`

The `get_stationid()` function retrieves weather station metadata from the NOAA Climate Data Online (CDO) API for a given dataset and time range. It supports pagination and can return a large number of station records.

Function Overview:

```r
get_stationid(noaa_token, datasetid, locationid = NULL, startdate, enddate, n_results = Inf)
```

### Arguments

| Argument       | Type       | Description |
|----------------|------------|-------------|
| `noaa_token`   | `string`   | NOAA API token used for authentication. |
| `datasetid`    | `string`   | The dataset identifier. Must be one of the valid dataset IDs (see list used by `valid_ids()`). |
| `locationid`   | `string` or `NULL` | Optional location identifier to filter stations geographically (e.g., `"FIPS:48"` for Texas). |
| `startdate`    | `string`   | Start date in `"YYYY-MM-DD"` format. |
| `enddate`      | `string`   | End date in `"YYYY-MM-DD"` format. |
| `n_results`    | `numeric`  | Maximum number of station records to retrieve. Defaults to `Inf` to fetch all. |

Example:

```r
# Example: Get stations in Texas for the GHCND dataset during 2020
df <- get_stationid(
  noaa_token = "YOUR_API_KEY",
  datasetid = "GHCND",
  locationid = "FIPS:48",
  startdate = "2020-01-01",
  enddate = "2020-12-31",
  n_results = 1000
)
```

Returns:

A data frame containing weather station metadata, such as station IDs, names, geographic coordinates, and available coverage. If no results are returned or the request fails, an error is thrown or an empty data frame is returned.

A detailed list of NOAA acronyms can be found here: https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt
