# histweatherdata: Accessing Historic Climate Data by NOAA

curl -H "token:RwxSOFeVkuTygQpilLiTXWYgtSueUOaf" "https://www.ncei.noaa.gov/cdo-web/api/v2/datatypes/CDSD"


curl -H "token:RwxSOFeVkuTygQpilLiTXWYgtSueUOaf" "https://www.ncei.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND&locationid=ZIP:28801&startdate=2010-05-01&enddate=2010-05-01&units=standard"

or replace standard w metric


system('curl -H "token:RwxSOFeVkuTygQpilLiTXWYgtSueUOaf" "https://www.ncei.noaa.gov/cdo-web/api/v2/data?datasetid=GHCND&locationid=ZIP:28801&startdate=2010-05-01&enddate=2010-05-01&units=standard"')
