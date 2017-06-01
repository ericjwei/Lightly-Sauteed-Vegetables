library(plotly)
library(ggplot2)
library(dplyr)
library(anytime)

BuildScatter <- function(data, type = '', date = '', range = '', limit = '') {

  plot <- plot_ly(data = data, type = 'scatter', mode = 'markers', x = ~properties.time, y = ~properties.mag,
                  hoverinfo = 'text',
                  text = ~paste(paste("Location:", properties.place), paste("Time:", anytime(as.integer(properties.time))), paste("Magnitude:", properties.mag), sep = "<br />")) %>% 
    layout(title = paste('Earthquake Magnitude By', type), xaxis = list(title = 'Time of Event'), yaxis = list(title = 'Magnitude'))

  return(plot)
}
  