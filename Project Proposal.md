#Project Proposal

##Project Description
Question: What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.
Dataset: Globally Earthquake Catalog 
Data collected by: International Federation of Digital Seismograph Networks (FDSN), a global organization that is responsible for installation and maintenance of seismographs globally
Data can be accessed from USFS United Geological Survey 
Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences
Government 
Scientists who study earthquake and seismic movements
What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.events with depth less than the specified maximum.
Where do those red-alert level and earthquake occurs within this 10 years?
Where do those earthquakes that have depths that has more than 300 km located?
Where do earthquake occur most frequently?


##Technical Description

	This project will take the form of a responsive website with the use of Shiny, allowing for the user to interact with the data visualizations. This website will have many pages, each one displaying a different relationship within the data. As the USGS Earthquake API is frequently update, an ambitious goal is to make the website continuously update in response to newest information. We will be using geoJson format and filtering for `eventtypes` of ÅgearthquakeÅh. Our base reshaping of our api is shown below:

```
base.url <- "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
var <- "&eventtype=earthquake" 
response <- GET(paste0(base.url,var)) 
response.data <- fromJSON(content(response, "text"))$features %>% flatten()
```

Some major libraries include ggplot2, plotly, knitr, httr, jsonlite, and perhaps map libraries for displaying earthquake locations. With this data, we could answer where frequent earthquakes are occuring and the effects of these earthquakes with regards to tsunamis and the earthquake source (mining, natural, volcanoes). The major challenge would be portraying this data onto a map that could be filtered by countries. This is ideal but not neccessarily viable with the libraries available. Furthermore, overlaying data on top of maps involve many steps that may prove to be too complex. 

[Github Repository](https://github.com/ericjwei/Lightly-Sauteed-Vegetables)


