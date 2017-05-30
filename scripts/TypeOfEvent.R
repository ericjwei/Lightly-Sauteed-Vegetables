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

request <- function(type = '', date = '', limit = '') {
  base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson" 
  var <- paste0("&eventtype=", type) 
  count <- paste0("&limit=", 100)
  response <- GET(paste0(base.url, count))
  data <- data.frame(properties.time = as.Date(character()), properties.mag = double())
  data <- fromJSON(content(response, "text"))$features %>% flatten()
  data$properties.time <- lapply(data$properties.time, function(x) anytime(x / 1000))
  data$properties.updated <- lapply(data$properties.updated, function(x) anytime(x / 1000))
  
  
  
  return(data)
}


BuildScatter <- function(type = '', date = '', limit = '') {
  data <- request(type, date, limit)
  plot <- plot_ly(data = data, type = 'scatter', mode = 'markers', x = ~properties.time, y = ~properties.mag) %>% 
    layout(title = paste('Earthquake Magnitude for', type), xaxis = list(title = 'Time of Event'), yaxis = list(title = 'Magnitude'))
  
  return(plot)
}
  
  



