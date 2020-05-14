################################################################################################
########                            Calidad del Aire Monterrey                          ########
########                        Autor Néstor Felipe Torres Pacheco                      ########
################################################################################################


#install.packages("jsonlite", repos="http://cran.r-project.org")
#install.packages("curl")
#install.packages("DT")
#library(jsonlite)
#library(curl)
#library(DT)

# Instalación de Librería JSON
install.packages("jsonlite", repos="http://cran.r-project.org")
require(jsonlite)
# Instalación de Librería httr
install.packages("httr")
require(httr)
#Estructura API
base <- "https://api.datos.gob.mx/v2/"
endpoint <- "sinaica"
stock <- "Monterrey"
callAPI_1 <- paste(base,endpoint,"?","city","=", stock, sep="")
#Llamada GET
get_data <- GET(callAPI_1)
get_data
#Conversión a Texto
data_text <- content(get_data,"text")
data_text
#Conversión JSON
air_quality_mty <- fromJSON(data_text, flatten=TRUE)
options(max.print=500000)
air_quality_mty
# Introducir los datos a un data frame
air_quality_mty_df <- as.data.frame(air_quality_mty)
#Paginación
pages <- air_quality_mty$pagination$total
pages
for(i in 2:pages){
  callAPI_2 <- paste(base,endpoint,"?","city","=", stock,"&","page=",i, sep="")
  get_data_2 <- GET(callAPI_2)
  data_text_2 <- content(get_data_2,"text")
  air_quality_mty_2 <- fromJSON(data_text_2, flatten=TRUE)
  air_quality_mty_df_2 <- as.data.frame(air_quality_mty_2)
  air_quality_mty_df <- rbind(air_quality_mty_df, air_quality_mty_df_2)
}
#Visualización Data Frame

View(air_quality_mty_df)











#
str(air_quality_mty)


  airquality_mty_df <- as.data.frame(airquality_mty)
adt <- as.data.frame.table(airquality_mty)

str(airquality_mty_df)

##Salida
rownum(airquality_mty_df)

data.frame(head(airquality_mty_df))



names(airquality_mty_df)[names(airquality_mty_df)=="results.parametro"] <- "parametro"



colnames(airquality_mty_df)
names(airquality_mty_df)[names(airquality_mty_df)=="results._id"] <- "id"
names(airquality_mty_df)[names(airquality_mty_df)=="results.date"] <- "fecha"
names(airquality_mty_df)[names(airquality_mty_df)=="results.city"] <- "ciudad"
names(airquality_mty_df)[names(airquality_mty_df)=="results.state"] <- "estado"
names(airquality_mty_df)[names(airquality_mty_df)=="results.valororig"] <- "valor_original"

