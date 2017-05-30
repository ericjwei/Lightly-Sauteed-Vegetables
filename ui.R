
library(shiny)
#"eventtypes":["acoustic noise","acoustic_noise","anthropogenic_event","building collapse","chemical explosion","chemical_explosion",
#"earthquake","experimental explosion","explosion","ice quake",
#"landslide","mine collapse","mine_collapse","mining explosion","mining_explosion","not reported",
#"not_reported","nuclear explosion","nuclear_explosion","other event","other_event","quarry",
#"quarry blast","quarry_blast","rock burst","rockslide","rock_burst","snow_avalanche","sonic boom","sonicboom","sonic_boom"]


map.panel <- tabPanel('Map')

eventtype = list("Chemical Explosion" = "chemical%20explosion", 
                 "Earthquake" = "earthquake",
                 "Explosion" = "explosion",
                 "Ice Quake" = "ice%20quake",
                 "Quarry Blast" = "quarry%20blast"
                 )

scatter.panel <- tabPanel('Scatter', titlePanel('Earthquake Magnitude by Source'),
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("type", label = h3("Source Type"),
                                           choices = eventtype, selected = "earthquake"),
                              dateRangeInput("dates", label = h3("Date Range")),
                              numericInput("num", label = h3("Numeric Input"), value = 100)
                            ),
                            mainPanel(
                              plotlyOutput('scatter')
                            )
                          )  
)


bar.panel <- tabPanel('Bar')


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    'USGS Earthquake Monitoring', 
    map.panel, scatter.panel, bar.panel))