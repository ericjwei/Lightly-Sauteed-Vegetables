library(shiny)
library(plotly)
library(httr)
library(jsonlite)
library(dplyr)

#"eventtypes":["acoustic noise","acoustic_noise","anthropogenic_event","building collapse","chemical explosion","chemical_explosion",
#"earthquake","experimental explosion","explosion","ice quake",
#"landslide","mine collapse","mine_collapse","mining explosion","mining_explosion","not reported",
#"not_reported","nuclear explosion","nuclear_explosion","other event","other_event","quarry",
#"quarry blast","quarry_blast","rock burst","rockslide","rock_burst","snow_avalanche","sonic boom","sonicboom","sonic_boom"]

source('./scripts/TypeOfEvent.r')

base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson" 
var <- "&eventtype=explosion" 
count <- "&limit=200"
response <- GET(paste0(base.url, count)) 
data <- fromJSON(content(response, "text"))$features %>% flatten()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$scatter <- renderPlotly({
    return(BuildScatter(input$type, input$dates, input$num))
  })
})

#############################################

source('./scripts/FranGraph.r')

shinyServer(function(input, output) {
  output$bar <- renderPlotly({
    return(BuildBarGraph(input$address, input$radius, input$number))
  })
})