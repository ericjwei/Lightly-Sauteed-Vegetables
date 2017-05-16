# Project Proposal

## Project Description
We are using Globally Earthquake Catalog dataset that is collected by International Federation of Digital Seismograph Networks (FDSN), a global organization that is responsible for international installation and maintenance of seismographs. It can be assessed from the USFS United Geological Survey. Our target audience is government and scientists who study earthquake and seismic movements. Questions that they may posed: Where do those red-alert level earthquake occur within these 10 years? Where do those earthquakes that have depths that has more than 300 km located? And what location do earthquakes occur most frequently?

## Technical Description

This project will take the form of a responsive website with the use of Shiny, allowing for the user to interact with the data visualizations. This website will have many pages, each one displaying a different relationship within the data. As the USGS Earthquake API is frequently update, an ambitious goal is to make the website continuously update in response to newest information. We will be using geoJson format and filtering for `eventtypes` of earthquakes. Our base reshaping of our api is shown below:

```
base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
var <- "&eventtype=earthquake" 
response <- GET(paste0(base.url,var)) 
response.data <- fromJSON(content(response, "text"))$features %>% flatten()
```

Some major libraries include ggplot2, plotly, knitr, httr, jsonlite, and perhaps map libraries for displaying earthquake locations. With this data, we could answer where frequent earthquakes are occuring and the effects of these earthquakes with regards to tsunamis and the earthquake source (mining, natural, volcanoes). The major challenge would be portraying this data onto a map that could be filtered by countries. This is ideal but not neccessarily viable with the libraries available. Furthermore, overlaying data on top of maps involve many steps that may prove to be too complex. 

[Github Repository](https://github.com/ericjwei/Lightly-Sauteed-Vegetables)


