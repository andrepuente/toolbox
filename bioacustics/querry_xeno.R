#Codigo para descargar grabaciones de xenocanto automaticamente

library(suwo)
library(dplyr)
library(factoextra)
library(FactoMineR)
library(rgbif)


setwd("")



#Query xeno-canto  
################

Sys.setenv(xc_api_key = '#Tu llave API aquí')
query <-query_xenocanto("Especie para el querry", all_data=T, pb=T)
download_media(query)
metadata <-data.frame(query$key, query$species, query$date, query$time, 
                      query$country, query$locality, query$latitude, 
                      query$longitude, query$file_url, query$altitude, 
                      query$vocalization_type,query$sampling_rate)
write.csv(metadata, "file.csv")



