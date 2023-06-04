library("tidyverse")
library("gapminder")
library("glue")
library("rnaturalearth")
library("sf")
library("leaflet")
library("leaflet.extras")

countries_sf <- countries110 %>%
  st_as_sf()

pop_palette <- colorNumeric("viridis",
                            domain = countries_sf$gdp_md_est)

countries_sf %>%
  filter(! name == "Antarctica") %>%
  leaflet() %>%
  # addProviderTiles(providers$Esri.WorldShadedRelief) %>%
  addPolygons(fillColor = ~pop_palette(gdp_md_est),
              color = "black",
              weight = 1,
              opacity = 1,
              fillOpacity = 0.7,
              popup = ~glue("Country: {name}", "<br>",
                           "Population: {pop_est}",
                           "<br>",
                           "GPD: {gdp_md_est}")) %>%
  addLegend(pal = pop_palette,
            values = ~gdp_md_est,
            opacity = 0.7,
            title = "GDP in $ (2009)", position = "bottomleft") %>%
  setMapWidgetStyle(style = list(background = "#aacbff"))

