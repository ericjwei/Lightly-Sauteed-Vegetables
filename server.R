library(shiny)
library(plotly)
library(dplyr)
library(httr)
library(jsonlite)
library(anytime)
library(RJSONIO)

source('./scripts/TypeOfEvent.r')
source('./scripts/Request.r')
source('./scripts/FranGraph.r')


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
