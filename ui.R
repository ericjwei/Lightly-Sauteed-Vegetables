library(shiny)
library(plotly)

map.panel <- tabPanel('Map')

eventtype = list("Chemical Explosion" = "Chemical Explosion",
                 "Earthquake*" = "Earthquake",
                 "Explosion" = "Explosion",
                 "Ice Quake" = "Ice Quake",
                 "Quarry Blast" = "Quarry Blast"
                 )


scatter.panel <- tabPanel('Earthquake Magnitude by Source', titlePanel('Earthquake Magnitude by Source'),
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("type", label = h3("Source Type"),
                                           choices = eventtype, selected = "Earthquake"),
                              helpText(h5("*Large data points may result in longer plot times")),
                              dateInput("startDate", label = h3("Start Date"),
                                          value = as.character(Sys.Date() - 30),
                                          min = as.Date("1970-01-01"),
                                          max = Sys.Date(),
                                          format = "yyyy-mm-dd",
                                          startview = "year"
                              ),
                              sliderInput("range", label = h3("Day Range"), min = 0,
                                          max = 365, value = 120
                              ),
                              numericInput("num", label = h3("Numeric Input"), value = 1000)
                            ),
                            mainPanel(
                              plotlyOutput('scatter')
                            )
                          )
)

bar.panel <- tabPanel('Earthquake Magnitude by Location', titlePanel('Earthquake Magnitude by Location'),
                          sidebarLayout(
                            sidebarPanel(
                              textInput("address", label = h3("Location"),
                                           value = "Seattle"),
                              sliderInput("radius", label = h3("Radius"), min = 0,
                                           max = 500, value = 50),
                              sliderInput("number", label = h3("Number of Earthquakes"), min = 0,
                                          max = 1000, value = 50)
                            ),
                            mainPanel(
                              plotlyOutput('bar')
                            )

                           )
)
doc.panel <- tabPanel('Documentation', titlePanel('Documentation'),
                        sidebarLayout(
                          mainPanel(
                            
                          )
                        )
)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    'USGS Earthquake Monitoring', 
    map.panel, scatter.panel, bar.panel, doc.panel))

