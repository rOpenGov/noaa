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

Accessing CDO data requires a token (like a unique signature that lets you use the service).

Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address. A token will be immediately sent. You can reuse the same token multiple times. 

### Accessing Historic Weather Data

histweatherdata makes it easy to access historic weather data within the R environment. 

`get_weather_data()` returns a dataframe describing weather phenomena. Fields are: 
- **date** in year-month-day format
- **datatype** for whether the corresponding value describes the temperature, amount of precipitation, snow, etc. (See below for a list of acronyms and their meanings)
- **station** for the unique ID assigned to a station
- **value** contains the numeric value for the corresponding datatype (e.g. temperature, amount of precipitation, and so forth).

`get_station_data()` returns a dataframe describing station informaion. with fields for:
- **elevation** the elevation of station
- **mindate** earliest date on record
- **maxdate** latest date on record
- **latitude** the latitude of the station
- **name** the city, state, and country of the station
- **datacoverage** the date range for which data exists
- **id** the unique ID assigned to a station
- **elevationUnit** whether the elevation value is in standard or metric units
- **longitude** the longitude of the station

#### Arguments

<table>
  <tr>
    <td colspan="2"><code>get_weather_data()</code></td>
  </tr>
  <tr>
    <td>token</td>
    <td>Unique token from <a href="https://www.ncdc.noaa.gov/cdo-web/token">www.ncdc.noaa.gov/cdo-web/token</a></td>
  </tr>
  <tr>
    <td>zip</td>
    <td>Zip code</td>
  </tr>
  <tr>
    <td>startdate</td>
    <td>First date to return data</td>
  </tr>
  <tr>
    <td>enddate</td>
    <td>Last date to return data</td>
  </tr>
  <tr>
    <td>units</td>
    <td>Choose between standard and metric</td>
  </tr>
  <tr>
    <td>limit</td>
    <td>Specify the number of results. Default is 25. Maximum is 1,000</td>
  </tr>
</table>

<table>
  <tr>
    <td colspan="2"><code>get_weather_data()</code></td>
  </tr>
  <tr>
    <td>token</td>
    <td>Unique token from <a href="https://www.ncdc.noaa.gov/cdo-web/token">www.ncdc.noaa.gov/cdo-web/token</a></td>
  </tr>
  <tr>
    <td>station_no</td>
    <td>Unique ID assigned to a station</td>
  </tr>
  <tr>
    <td>limit</td>
    <td>Specify the number of results. Default is 25. Maximum is 1,000</td>
  </tr>
</table>

#### Examples

Return weather data for zip code 28801 in standard units from the first of May 2010 through the fifth of May 2010. 

```
get_weather_data(token = "RwxSOFeVk", zip = "28801", startdate = "2010-12-01",
                 enddate = "2010-12-05", units = "standard")
```

Return station data. Supply the token with no other arguments to return all stations.

```
get_station_data(token = "RwxSOFeVk")
```

Pass a station ID for information on a specific station.

```
get_station_data(token = "RwxSOFeVk", station_no = "COOP:010008")
```

#### Acronyms 

| Name | Description |
|----|----|
| TMIN | Minimum Temperature |
| TMAX | Maximum Temperature |
| PRCP | Precipitation |
| SNOW | Snow |

A full list of acronyms can 

https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt

