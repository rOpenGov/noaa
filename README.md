# noaa: Accessing Current and Historic Weather Data by NOAA

National Oceanic and Atmospheric Administration (NOAA) maintains one of the largest climate data archives, the National Climatic Data Center (NCDC). NCDC's [Climate Data Online](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#stations) (CDO) offers web services that provide access to weather and climate data, which include (but is not limited to) minimum and maximum temperature in different zip codes by date, amount of precipitation, longitude and latitude of stations, and more. 

It is the only known R package that enables the user to search historical weather data by zip code. 

### Install

Install from CRAN:

```
install.packages("noaa")
```

Install from GitHub:

```
require(devtools)
install_github("stephbuon/noaa")
```

### Authentication Token

Accessing CDO data requires a token. 

Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address.


## `get_climate_data()`

The `get_climate_data()` function allows you to retrieve climate and weather data from the [NOAA Climate Data Online (CDO) API](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#gettingStarted) for a wide range of dataset types. It supports pagination and can retrieve large numbers of records by iteratively querying the API.

### Function Overview

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

### Supported Dataset IDs

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

### Example

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



A full list of acronyms here: 

https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt

