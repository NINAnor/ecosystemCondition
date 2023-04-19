#### distribution comparison, reference vs. data ####
summary(results.wetland[['original']]$kartleggingsenhet_1m2) #V1-C1 & V1-C5 are the most abundant ecosystem types


x11()
par(mfrow=c(2,2))
hist(wetland.ref.cov[['Moisture']][,8],
     xlim=c(4,10),
     main='NiN reference V1-C1',xlab='Moisture value')
hist(wetland.ref.cov[['Moisture']][,28],
     xlim=c(4,10),
     ,main='NiN reference V1-C5',xlab='Moisture value')

hist(results.wetland[['original']][results.wetland[['original']]$kartleggingsenhet_1m2=="V1-C-5",'Moist1'],
     xlim=c(4,10),
     main='ANO data V1-C1',xlab='Moisture value')
hist(results.wetland[['original']][results.wetland[['original']]$kartleggingsenhet_1m2=="V1-C-5",'Moist1'],
     xlim=c(4,10),
     main='ANO data V1-C5',xlab='Moisture value')


#### regressions vs. ANO variables ####


head(results.wetland[['original']])
colnames(results.wetland[['original']])[c(42:47,54:56)]

with(results.wetland[['original']],plot(tresjikt_dekning,Cont1))
with(results.wetland[['original']],plot(tresjikt_dekning,Light1))
with(results.wetland[['original']],plot(tresjikt_dekning,Moist1))
with(results.wetland[['original']],plot(tresjikt_dekning,pH1))
with(results.wetland[['original']],plot(tresjikt_dekning,Nitrogen1))

with(results.wetland[['original']],plot(groeftingsintensitet,Cont1))
with(results.wetland[['original']],plot(groeftingsintensitet,Light1))
with(results.wetland[['original']],plot(groeftingsintensitet,Moist1))
with(results.wetland[['original']],plot(groeftingsintensitet,pH1))
with(results.wetland[['original']],plot(groeftingsintensitet,Nitrogen1))

with(results.wetland[['original']],plot(slitasje,Cont1))
with(results.wetland[['original']],plot(slitasje,Light1))
with(results.wetland[['original']],plot(slitasje,Moist1))
with(results.wetland[['original']],plot(slitasje,pH1))
with(results.wetland[['original']],plot(slitasje,Nitrogen1))

df <- results.wetland[['scaled']][results.wetland[['scaled']]$hovedtype_rute!='V2',]
df <- df[df$hovedtype_rute!='V8',]
with(df,plot(tresjikt_dekning,Moist1,xlim=c(0,100)))
with(results.wetland[['scaled']][results.wetland[['scaled']]$hovedtype_rute=='V8',],points(tresjikt_dekning,Moist1,col='blue'))
with(results.wetland[['scaled']][results.wetland[['scaled']]$hovedtype_rute=='V2',],points(tresjikt_dekning,Moist1,col='blue'))
with(df,points(tresjikt_dekning,Moist1, pch=16))

summary(lm(Moist1~tresjikt_dekning, data=df ))
points(0:100,predict(lm(Moist1~tresjikt_dekning, data=df ),
                     newdata=data.frame(tresjikt_dekning=0:100) ),
       type='l', lty=2, lwd=3)


library(betareg)
summary( betareg(Moist1 ~ tresjikt_dekning, data=df[!is.na(df$Moist1),]) )

#with(results.wetland[['scaled']],plot(busker_dekning,Light1))
#summary(lm(Light1~busker_dekning, data=results.wetland[['scaled']]))
#points(0:100,predict(lm(Light1~busker_dekning, data=results.wetland[['scaled']]),
#                     newdata=data.frame(busker_dekning=0:100) ),
#       type='l', col='red', lwd=2)

#with(results.wetland[['scaled']],plot(groeftingsintensitet,Moist1))
#summary(lm(Moist1~groeftingsintensitet, data=results.wetland[['scaled']]))
#points(1:5,predict(lm(Moist1~groeftingsintensitet, data=results.wetland[['scaled']]),
#                     newdata=data.frame(groeftingsintensitet=1:5) ),
#       type='l', col='red', lwd=2)


#### maps ####
# libraries
library(tidyverse)
library(dplyr)
library(broom)
library(sf)
library(RColorBrewer)
library("gridExtra") 
library(ggridges)
library(ggplot2)
library(tmap)
library(knitr)
library(raster)
library(stars)
st_geometry(results.wetland[['2-sided_Ellenberg']]) <- st_geometry(ANO.wetland)
st_geometry(results.wetland[['original']]) <- st_geometry(ANO.wetland)


nor <- readRDS('P:/41201785_okologisk_tilstand_2022_2023/data/rds/norway_outline.RDS')%>%
  st_as_sf()

# Moisture value map
tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(results.wetland[['original']]) +
  tm_dots('Moist1',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, ,legend.show = FALSE) + 
  tm_layout(main.title = "Moisture values, wetland",legend.position = c("right", "bottom")) + 
  tm_add_legend(type = "fill", 
                col = tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE),
                labels = c("4", "...", "...", 
                           "...", "...", "...", "10"),
                title = "Moisture values")

# scaled value maps
tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(results.wetland[['2-sided_Ellenberg']]) +
  tm_dots('Moist1',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, legend.show = FALSE) + # 
  tm_layout(main.title = "Moisture index (lower), wetland",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.4", "...", "...", 
                           "...", "1", "NA"),
                title = "index values")


tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(results.wetland[['2-sided_Ellenberg']]) +
  tm_dots('Moist2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, legend.show = FALSE) + # 
  tm_layout(main.title = "Moisture index (upper), wetland",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.4", "...", "...", 
                           "...", "1", "NA"),
                title = "index values")
