# Lightly-Sauteed-Vegetables


setup for USGS api, add variables as you wish

ase.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
var <- "&eventtype=earthquake"
response <- GET(paste0(base.url,var))
response.data <- fromJSON(content(response, "text"))$features %>% flatten()
