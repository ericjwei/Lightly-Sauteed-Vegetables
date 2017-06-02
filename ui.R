library(shiny)
library(plotly)

map.panel <- tabPanel('Map', titlePanel('Map of Earthquakes'),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("magnitude", label = h3("Magnitude of Earthquake"),
                                      min = -1, max = 7, value = 2)
                        ),
                        mainPanel(
                          plotlyOutput('map')
                        )
                      )                      
)

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

documentation.panel <- tabPanel("Resources", titlePanel("About the Project"),
                                sidebarLayout(
                                  sidebarPanel(
                                    h2("Sources we used"),
                                    br(),
                                    br(),
                                    p("USGS Earthquake API obtained ",
                                      a("here.", href = "https://earthquake.usgs.gov/fdsnws/event/1/")),
                                    
                                    p("Address to latitude and longitude leveraged from ",
                                      a("stackoverflow.", href = "https://stackoverflow.com/questions/32504880/street-address-to-geolocation-lat-long")),
                                    
                                    p("To get an idea for the graphs used, visit ",
                                      a("plot.ly", herf = "https://plot.ly/r/")),
                                    
                                    p("To see our code, visit our github repository by clicking ",
                                      a("here", herf = "https://github.com/ericjwei/Lightly-Sauteed-Vegetables")),
                                    
                                    p("The R packages we used: shiny, plotly, dplyr, jsonlite, httr"),
                                    br()
                                  ),
                                  mainPanel(
                                    h1("About our Project"),
                                    p("We used information ",
                                      em("USGS Earthquakes"), " to create multiple graphs including a map, scatter plot, and bar graph. The U.S. map displays an overview of the earthquakes taking place and is used to
      introduce what the following graphs will be about. Next, the scatter plot displays information on what different events caused the earthquakes and their magnitude. The user is able to choose what specific event they
      want to have displayed as well as the time frame, which includes a start date and total amount of days to be displayed. Finally, the bar graph takes in user inputs such as location, a radius size from 0km to 500km, and
      the max number of earthquakes to be displayed. Through these user inputs the bar graph is able to display the magnitude of the earthquakes within distance from the location and how far away they took place."),
                                    br(),
                                    h1("Why?"),
                                    p("For our project, we wanted to use data that is both relevant to the us, since UW is near a fault line, but will also be of use to anyone in the United States since the data we used is nationwide. We also wanted to both inform and entertain
      the user by creating graphs that are very interactive and easy to understand."),
                                    br(),
                                    h1("About USGS"),
                                    p("The USGS website we obtained our information on the Earthquakes is sponsored by the ",
                                      em("USGS Earthquake Hazards Program"),
                                      " where their mission is to provide information that others can use, such as students, to reduce deaths, injuries, and property damage from earthquakes.
      Due to their reasons for providing the data, it is free to access and is used by many. In addition, the USGS is the only Federal agency with responsibility for recording
                                      and reporting earthquake activity nationwide."),
                                    br(),
                                    br(),
                                    p("Thank you. This has been a project created by Eric Wei, Melody Yu, and Fran Velazquez")
                                  )
                                )
)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    'USGS Earthquake Monitoring', 
    map.panel, scatter.panel, bar.panel))