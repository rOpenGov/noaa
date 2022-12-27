# histweatherdata: Accessing Historic Weather Data by NOAA

National Oceanic and Atmospheric Administration (NOAA) maintains one of the largest climate data archives, the National Climatic Data Center (NCDC). NCDC's Climate Data Online (CDO) offers web services that provide access to this data, which include (but is not limited to) minimum and maximum temperature in different zip codes by date, ENTER. 

### Authentication Token

Accessing CDO data requires a token (like a unique signature that lets you use the service).

Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address. A token will be immediately sent. You can use the same token multiple times. 

### Accessing Historic Weather Data

histweatherdata makes it easy to access historic weather data within the R environment. 

`get_weather_data()` returns a dataframe with fields for: 
- **date** in year-month-day format
- **datatype** for whether the corresponding value describes the minimum and maximum temperature, the amount of precipitation, snow, etc. (See below for a list of acronyms and their meanings).
- **station** for the unique ID assigned to a station
- **value** contains the numeric value for the corresponding datatype (e.g. temperature, amount of precipitation, and so forth).

`get_station_data()` returns a dataframe with fields for:
- **elevation** 
- **mindate**
- **maxdate**
- **latitude**
- **name** for the city, state, and country of the station
- **datacoverage**
- **id** for the unique ID assigned to a station
- **elevationUnit** metric? Standard?
- **longitude**

#### Arguments

<table>
  <tr>
    <td colspan="2">get_weather_data()</td>
  </tr>
  <tr>
    <td><Name></td>
    <td><Description></td>
  </tr>
    <td>token</td>
    <td></td>
</table>

get_weather_data(token = "RwxSOFeVk", 
                 zip = "28801", 
                 startdate = "2010-12-01",
                 enddate = "2010-12-05", 
                 units = "standard", 
                 limit = "10")

get_station_data(token = "RwxSOFeVk", 
                 station_no = "COOP:010008", 
                 limit = "100")

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
get_station_data(token = "RwxSOFeVk", station_no = c("COOP:010008", "GHCND:USW00013872"))
```

#### Acronyms: 

| Name | Description |
|----|----|
| TMIN | Minimum Temperature |
| TMAX | Maximum Temperature |
| PRCP | Precipitation |

