
library(shiny)
#"eventtypes":["acoustic noise","acoustic_noise","anthropogenic_event","building collapse","chemical explosion","chemical_explosion",
#"earthquake","experimental explosion","explosion","ice quake",
#"landslide","mine collapse","mine_collapse","mining explosion","mining_explosion","not reported",
#"not_reported","nuclear explosion","nuclear_explosion","other event","other_event","quarry",
#"quarry blast","quarry_blast","rock burst","rockslide","rock_burst","snow_avalanche","sonic boom","sonicboom","sonic_boom"]

#To Do: include date range widget, display empty dataframe when no data, include location label

map.panel <- tabPanel('Map')

eventtype = list("Chemical Explosion" = "Chemical Explosion",
                 "Earthquake" = "Earthquake",
                 "Explosion*" = "Explosion",
                 "Ice Quake" = "Ice Quake",
                 "Quarry Blast" = "Quarry Blast"
                 )

scatter.panel <- tabPanel('Earthquake by Source', titlePanel('Earthquake Magnitude by Source'),
                          sidebarLayout(
                            sidebarPanel(
                              radioButtons("type", label = h3("Source Type"),
                                           choices = eventtype, selected = "Earthquake"),
                              helpText(h5("*Large data points may result in longer plot times")),
                              dateInput("startDate", label = h3("Start date of 30 day range"),
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

  
bar.panel <- tabPanel('Bar')


# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    'USGS Earthquake Monitoring', 
    map.panel, scatter.panel, bar.panel))

date <- as.Date("1970-01-01")