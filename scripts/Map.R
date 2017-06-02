library(dplyr)
library(plotly)
library(foreign)

map <- function(magnitude = '') {

  base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
  var <- "&eventtype=earthquake"
  count <- "&limit=100"
  magnitude <- paste0("&minmagnitude=", magnitude)
  response <- GET(paste0(base.url, var, count, magnitude))

  data <- fromJSON(content(response, "text"))$features %>% flatten()

  geom <- data$geometry.coordinates
  my.matrix <- do.call("rbind", geom)
  df <- as.data.frame(my.matrix, stringsAsFactors = FALSE, col.names = c("longitude", "latitude", "depth"))
  merged.data <- merge(data, df)
# data <- dget(file = "info")   
  g <- list(
    scope = 'world',
    projection = list(type = 'equirectangular'),
    showland = TRUE,
    landcolor = toRGB("gray95"),
    subunitcolor = toRGB("gray85"),
    countrycolor = toRGB("gray85"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  p <- plot_geo(merged.data, lat = ~V2, lon = ~V1) %>% 
    add_markers(
      text = ~paste(paste("Magnitude:", properties.mag), sep = "<br />"),
      color = "light blue", opacity = 0.3, symbol = I("circle"), size = ~properties.mag, hoverinfo = "text"
    ) %>% 
    layout(title = 'Earthquake', geo = g)
  return(p)
}
# write.dta(merged.data, file = "data.csv")
# 
# save(merged.data, file="data.rda")
# # 
# info <- load("data.rda")
# 
# hi <- dget(file='info')
