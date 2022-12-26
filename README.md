# histweatherdata: Accessing Weather Climate Data by NOAA


To use this 

In two steps:


### Step 1: Get an Authentication Token

Using Climate Data Online requires a token (which is like a unique signature that gives you access to the service).


Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address. A token will be sent immediately to the address.

### Step 2: Get Historic Weather Data



```
get_weather_data("<token>", "28801", "2010-05-01", "2010-05-05", "standard")
```