library(shiny)
library(plotly)

source('./scripts/TypeOfEvent.R')
source('./scripts/Request.R')
source('./scripts/FranGraph.R')


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
