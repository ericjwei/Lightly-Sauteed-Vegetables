
library(shiny)


map.panel <- tabPanel('Map')


scatter.panel <- tabPanel('Scatter')


bar.panel <- tabPanel('Bar')


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    'USGS Earthquake Monitoring', 
    map.panel, scatter.panel, bar.panel))
  
#   fluidPage(
#   
#   # Application title
#   titlePanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#        sliderInput("bins",
#                    "Number of bins:",
#                    min = 1,
#                    max = 50,
#                    value = 30)
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#        plotOutput("distPlot")
#     )
#   )
# ))
