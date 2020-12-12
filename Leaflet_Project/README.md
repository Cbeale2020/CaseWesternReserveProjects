# leaflet-challenge
### Basic Visualization

Visualize an earthquake data set.
[https://cbeale2020.github.io/leaflet-challenge/] or you can pull the code locally using python -m http.server 8000 --bind 127.0.0.1

1. **Data Set**
   The USGS provides earthquake data in a number of different formats, updated every 5 minutes. Visit the [USGS GeoJSON Feed](http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php) page and pick a data set to visualize. When you click on a data set, for example 'All Earthquakes from the Past 7 Days', you will be given a JSON representation of that data. You will be using the URL of this JSON to pull in the data for our visualization.


2. **Imported & Visualize the Data**

   Created a map using Leaflet that plots all of the earthquakes from your data set based on their longitude and latitude.

   * Markers should reflect the magnitude of the earthquake by their size and and depth of the earth quake by color. Earthquakes with higher magnitudes should appear larger and earthquakes with greater depth should appear darker in color.

   * The depth of the earth can be found as the third coordinate for each earthquake.

  
