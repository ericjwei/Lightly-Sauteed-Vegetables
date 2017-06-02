library(shiny)
library(plotly)

source('./scripts/TypeOfEvent.R')
source('./scripts/Request.R')
source('./scripts/FranGraph.R')
source('./scripts/Map.R')


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$map <- renderPlotly({
    return(map(input$magnitude))
  }) 
  output$scatter <- renderPlotly({
     data <- request(input$type, input$startDate, input$range, input$num) #requested data from api
     return(BuildScatter(data, input$type, input$startDate, input$range, input$num))
  })
  output$bar <- renderPlotly({
     return(BuildBarGraph(input$address, input$radius, input$number))
  })
})
