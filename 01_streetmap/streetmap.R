# Based on https://ggplot2tutor.com/streetmaps/streetmaps/

# Install if necessary
if(!require("osmdata")) install.packages("osmdata")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("sf")) install.packages("sf")

library(magrittr)
library(ggplot2)
library(sf)
library(osmdata) # OpenStreetMap 

# Disable proxy
Sys.unsetenv("http_proxy")

# Get data ----
## Get New york's highways
available_tags("highway") # see available road types

main_streets <- getbb("New York City") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "secondary", "tertiary", "trunk")) %>% # play with different combs of road types depending on how densely packed you want your image
  osmdata_sf()

## Get New york's small streets
small_streets <- getbb("New York City") %>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street", "pedestrian", "unclassified", "service", "footway")) %>% # play again here for density
  osmdata_sf()

## Get rivers
# rivers <- getbb("New York City")%>%
#   opq()%>%
#   add_osm_feature(key = "waterway", value = "river") %>%
#   osmdata_sf()

# Plot ----
p <- ggplot() +
  geom_sf(data = main_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .7) +
  theme_void() +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(-74.12, -73.9), # play around with xlim and ylim to choose your favourite frame
           ylim = c(40.57, 40.85),
           expand = FALSE)

pdf("NYC_streetmap.pdf") # save it as pdf to keep vectorial properties
print(p)
dev.off()