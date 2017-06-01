library(shiny)
library(plotly)

library(dplyr)

#"eventtypes":["acoustic noise","acoustic_noise","anthropogenic_event","building collapse","chemical explosion","chemical_explosion",
#"earthquake","experimental explosion","explosion","ice quake",
#"landslide","mine collapse","mine_collapse","mining explosion","mining_explosion","not reported",
#"not_reported","nuclear explosion","nuclear_explosion","other event","other_event","quarry",
#"quarry blast","quarry_blast","rock burst","rockslide","rock_burst","snow_avalanche","sonic boom","sonicboom","sonic_boom"]

source('./scripts/TypeOfEvent.r')
source('./scripts/Request.r')

base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson" 
var <- "&eventtype=explosion" 
count <- "&limit=200"
response <- GET(paste0(base.url, count)) 
data <- fromJSON(content(response, "text"))$features %>% flatten()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   output$scatter <- renderPlotly({
     data <- request(input$type, input$startDate, input$range, input$num)
     #validate(need(is.data.frame(data), "No data in this time range"))
     return(BuildScatter(data, input$type, input$startDate, input$range, input$num))
   })
})
