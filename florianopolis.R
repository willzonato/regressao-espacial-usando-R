library(spdep)
library(maptools)

library(rgdal)

setwd("./shapefiles/Florianopolis_29092_SAD69/SHP")

shps <- dir(getwd(), "*.shp")

## Lê todos os shapefiles no diretório
for (shp in shps) assign(shp, readOGR(shp))

# (1) Load required libraries
library(sp)
library(rgeos)        # For its readWKT() function
library(latticeExtra) # For layer()

# (2) Prepare some example data
sp1 = readWKT("POLYGON((0 0,1 0,1 1,0 1,0 0))")
sp2 = readWKT("POLYGON((0 1,0.5 1.5,1 1,0 1))")
sp3 = readWKT("POLYGON((0.5 0,0.5 0.5,0.75 0.5,0.75 0, 0.5 0))")

# spplot provides "Plot methods for spatial data with attributes",
# so at least the first object plotted needs a (dummy) data.frame attached to it.
spdf1 <- SpatialPolygonsDataFrame(sp1, data=data.frame(1), match.ID=1)

# (3) Plot several layers in a single panel
spplot(spdf1, xlim=c(-0.5, 2), ylim=c(-0.5, 2), 
       col.regions="grey90", colorkey=FALSE) +
  layer(sp.polygons(sp2, fill="saddlebrown")) +
  layer(sp.polygons(sp3, fill="yellow"))
