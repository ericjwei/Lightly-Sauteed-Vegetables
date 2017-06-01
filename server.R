library(shiny)
library(plotly)
library(dplyr)

source('./scripts/TypeOfEvent.r')
source('./scripts/Request.r')
source('./scripts/FranGraph.r')


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
   output$bar <- renderPlotly({
     return(BuildBarGraph(input$address, input$radius, input$number))
   })
})
