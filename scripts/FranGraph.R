library(plotly)
library(shiny)
library(dplyr)
library(RJSONIO)
library(jsonlite)
library(httr)

latitude <- function(address) {
  url <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(url, address, "&sensor=false", sep = ""))
  response <- GET(url)
  x <- fromJSON(content(response, "text"))$results$geometry$location$lat
  if (is.null(x)) {
    x <- 47.6062
  }
  round(x, digits = 4)
}

longitude <- function(address) {
  url <- "http://maps.google.com/maps/api/geocode/json?address="
  url <- URLencode(paste(url, address, "&sensor=false", sep = ""))
  response <- GET(url)
  x <- fromJSON(content(response, "text"))$results$geometry$location$lng
  if (is.null(x)) {
    x <- -122.3321
  }
  round(x, digits = 4)
}

coordinates <- function(address) {
  combined <- c(latitude(address), longitude(address))
  return(combined)
}

requestTest <- function(address, radius, number) {
  base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&eventtype=earthquake&starttime=2010-01-01"
  var <- paste0("&latitude=", latitude(address), "&longitude=", longitude(address)) 
  radius <- paste0("&maxradiuskm=", radius)
  count <- paste0("&limit=", number)
  
  response <- GET(paste0(base.url, var, radius, count))
  info <- fromJSON(content(response, "text"))$features %>% flatten
  data <- as.data.frame(info)
  #View(info.df)
  return(data)
}
#address <- "Seattle"
#data <- requestTest(address)
#View(data)

#data.df <- data.frame(do.call('rbind', strsplit(as.character(data$properties.place),'of',fixed=TRUE)))
#within(data, data.df <- data.frame(do.call('rbind', strsplit(as.character(data$properties.place),'of',fixed=TRUE)))) %>% View()

BuildBarGraph <- function(address, radius, number) {
data <- requestTest(address, radius, number)

xAxis <- data$properties.place
yAxis <- data$properties.mag
text <- 
m <- list(
  b = 400 
)
p <- plot_ly(data, x = ~xAxis, y = ~yAxis, type = 'bar', text = text,
             marker = list(color = 'rgb(158,202,225)',
                           line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
  layout(title = paste("Earthquakes near", address),
         xaxis = list(title = "Place", tickangle = 90, face = "bold"),
         yaxis = list(title = "Magnitude"), autosize = F, width = 1200, height = 1000,
         margin = m)
return(p)
}

  
  
  
  
  
  
  
  
