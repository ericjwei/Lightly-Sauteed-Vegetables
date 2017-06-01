library(httr)
library(jsonlite)
library(anytime)
library(dplyr)

request <- function(type = '', start.date = '', range = '', limit = '') {
  options(digits.secs = 3)
  options(scipen = 15, digits = 13)
  
  query <- 'earthquake'
  type <- 'earthquake'
  if(type == 'Chemical Explosion') {
    query <- "chemical%20explosion"
  } else if(type == "Explosion") {
    query <- "explosion"
  } else if(type == "Ice Quake") {
    query <- "ice%20quake"
  } else if(type == "Quarry Blast") {
    query <- "quarry%20blast"
  }
  start.date <- as.Date('2017-03-20')
  range <- 30
  limit <- 100
  base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
  var <- paste0("&eventtype=", query)
  end.date <- start.date + range  
  start.date <- paste0("&starttime=", start.date)
  end.date <- paste0("&endtime=", end.date)
  count <- paste0("&limit=", limit)
  url <- paste0(base.url, var, start.date, end.date, count)
  response <- GET(url)
  data <- fromJSON(content(response, "text"))$features %>% flatten()
  data$properties.time <- lapply(data$properties.time, function(x) anytime(x / 1000))
  data$properties.updated <- lapply(data$properties.updated, function(x) anytime(x / 1000))

  
  return(data)
}