library(plotly)
library(ggplot2)
library(dplyr)
library(anytime)
options(digits.secs = 3)

#"eventtypes":["acoustic noise","acoustic_noise","anthropogenic_event","building collapse","chemical explosion","chemical_explosion",
#"earthquake","experimental explosion","explosion","ice quake",
#"landslide","mine collapse","mine_collapse","mining explosion","mining_explosion","not reported",
#"not_reported","nuclear explosion","nuclear_explosion","other event","other_event","quarry",
#"quarry blast","quarry_blast","rock burst","rockslide","rock_burst","snow_avalanche","sonic boom","sonicboom","sonic_boom"]

options(scipen = 15, digits = 13)

request <- function(type = '', start.date = '', end.date = '', limit = '') {
#If no data appears... show no data
  base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson" 
  var <- paste0("&eventtype=", type)
  start.date <- paste0("&starttime=", start.date)
  end.date <- paste0("&endtime=", end.date)
print(var)
print(start.date)  
  count <- paste0("&limit=", limit)
print(paste0(base.url, var, start.date, count))
  response <- GET(paste0(base.url, var, start.date, count))
  data <- fromJSON(content(response, "text"))$features %>% flatten()
  data <- data.frame(properties.time = as.Date(character()), properties.mag = double())
  data$properties.time <- lapply(data$properties.time, function(x) anytime(x / 1000))
  data$properties.updated <- lapply(data$properties.updated, function(x) anytime(x / 1000))

  return(data)
}


BuildScatter <- function(type = '', date = '', limit = '') {
  query <- 'earthquake'
  if(type == 'Chemical Explosion') {
    query <- "chemical%20explosion"
  } else if(type == "Explosion") {
    query <- "explosion"
  } else if(type == "Ice Quake") {
    query <- "ice%20quake"
  } else if(type == "Quarry Blast") {
    query <- "quarry%20blast"
  }
  data <- request(query, date, limit)
  plot <- plot_ly(data = data, type = 'scatter', mode = 'markers', x = ~properties.time, y = ~properties.mag) %>% 
    layout(title = paste('Earthquake Magnitude By', type), xaxis = list(title = 'Time of Event'), yaxis = list(title = 'Magnitude'))
  
  return(plot)
}
