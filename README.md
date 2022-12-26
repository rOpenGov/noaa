# histweatherdata: Accessing Historic Weather Data by NOAA


To use this 

In two steps:


### Authentication Token

Using Climate Data Online requires a token (which is like a unique signature that gives you access to the service).


Get a token by going to [www.ncdc.noaa.gov/cdo-web/token](https://www.ncdc.noaa.gov/cdo-web/token) and entering your email address. A token will be sent immediately to the address.

### Accessing Historic Weather Data


#### Usage

```
get_weather_data("<token>", "28801", "2010-05-01", "2010-05-05", "standard")
```