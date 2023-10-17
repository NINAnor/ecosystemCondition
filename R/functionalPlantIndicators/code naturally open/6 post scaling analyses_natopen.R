library(downloader)
library(sf)
library(tidyr)
library(plyr)
library(dplyr)
library(stringr)
library(tidyverse)
library(readxl)
library(tmap)
library(tmaptools)
library(lme4)
library(lmerTest)
library(betareg)
library(glmmTMB)

#### getting all the data from previous scripts in ####
load("P:/41201785_okologisk_tilstand_2022_2023/data/FPI_output large files for markdown/data_natopen.RData")
load("P:/41201785_okologisk_tilstand_2022_2023/data/FPI_output large files for markdown/ref_lists_natopen.RData")
load("P:/41201785_okologisk_tilstand_2022_2023/data/FPI_output large files for markdown/results.natopen.ANO.RData")
load("P:/41201785_okologisk_tilstand_2022_2023/data/FPI_output large files for markdown/results.natopen.GRUK.RData")




#### plotting scaled values by main ecosystem type ####
## continuing with 2-sided
res.natopen.ANO <- results.natopen.ANO[['2-sided']]
colnames(res.natopen.ANO)

# make long version of the scaled value part
res.natopen.ANO <-
  res.natopen.ANO %>% 
  pivot_longer(
    cols = c("CC1","CC2",
             "SS1","SS2",
             "RR1","RR2",
             "Light1","Light2",
             "Nitrogen1","Nitrogen2",
             "Soil_disturbance1","Soil_disturbance2"),
    names_to = "fp_ind",
    values_to = "scaled_value",
    values_drop_na = FALSE
  )

# add original values as well
res.natopen.ANO <- 
  res.natopen.ANO %>% add_column(original = results.natopen.ANO[['original']] %>% 
                                   pivot_longer(
                                     cols = c("CC1","CC2",
                                              "SS1","SS2",
                                              "RR1","RR2",
                                              "Light1","Light2",
                                              "Nitrogen1","Nitrogen2",
                                              "Soil_disturbance1","Soil_disturbance2"),
                                     names_to = NULL,
                                     values_to = "original",
                                     values_drop_na = FALSE
                                   ) %>%
                                   pull(original)
  )

summary(res.natopen.ANO$scaled_value)


#summary(res.natopen.ANO[,79:81])


# similarly for GRUK
res.natopen.GRUK <- results.natopen.GRUK[['2-sided']]
colnames(res.natopen.GRUK)

# make long version of the scaled value part
res.natopen.GRUK <-
  res.natopen.GRUK %>% 
  pivot_longer(
    cols = c("CC1","CC2",
             "SS1","SS2",
             "RR1","RR2",
             "Light1","Light2",
             "Nitrogen1","Nitrogen2",
             "Soil_disturbance1","Soil_disturbance2"),
    names_to = "fp_ind",
    values_to = "scaled_value",
    values_drop_na = FALSE
  )

# add original values as well
res.natopen.GRUK <- 
  res.natopen.GRUK %>% add_column(original = results.natopen.GRUK[['original']] %>% 
                                    pivot_longer(
                                      cols = c("CC1","CC2",
                                               "SS1","SS2",
                                               "RR1","RR2",
                                               "Light1","Light2",
                                               "Nitrogen1","Nitrogen2",
                                               "Soil_disturbance1","Soil_disturbance2"),
                                      names_to = NULL,
                                      values_to = "original",
                                      values_drop_na = FALSE
                                    ) %>%
                                    pull(original)
  )

#summary(res.natopen.GRUK[,52:54])

# making the plot, ANO, all indicators
ggplot(data=subset(res.natopen.ANO,!is.na(scaled_value)), aes(x=factor(kartleggingsenhet_1m2), y=scaled_value, fill=fp_ind)) + 
  geom_hline(yintercept=0.6, linetype="dashed") + 
  geom_violin(color=NA) +
  #  geom_boxplot(width=0.2, color="grey") +
  geom_point(size=1, shape=16, color="black") +
  facet_wrap(~factor(fp_ind,levels=c("CC1","SS1","RR1","Light1","Nitrogen1","Soil_disturbance1",
                                     "CC2","SS2","RR2","Light2","Nitrogen2","Soil_disturbance2")), ncol = 6) + 
  xlab("Basic ecosystem type") + 
  ylab("Scaled indicator value (ANO data)") 

# making the plot, ANO, CSR-indicators
ggplot(data=subset(res.natopen.ANO,!is.na(scaled_value) & fp_ind %in% c("CC1","SS1","RR1",
                                                                        "CC2","SS2","RR2")), 
       aes(x=factor(kartleggingsenhet_1m2), y=scaled_value, fill=fp_ind)) + 
  geom_hline(yintercept=0.6, linetype="dashed") + 
  geom_violin(color=NA) +
  #  geom_boxplot(width=0.2, color="grey") +
  geom_point(size=1, shape=16, color="black") +
  facet_wrap(~factor(fp_ind,levels=c("CC1","SS1","RR1",
                                     "CC2","SS2","RR2")), ncol = 3) + 
  xlab("Basic ecosystem type") + 
  ylab("Scaled indicator value (ANO data)") 

# making the plot, ANO, Tyler-indicators
ggplot(data=subset(res.natopen.ANO,!is.na(scaled_value) & fp_ind %in% c("Light1","Nitrogen1","Soil_disturbance1",
                                                                        "Light2","Nitrogen2","Soil_disturbance2")), 
       aes(x=factor(kartleggingsenhet_1m2), y=scaled_value, fill=fp_ind)) + 
  geom_hline(yintercept=0.6, linetype="dashed") + 
  geom_violin(color=NA) +
  #  geom_boxplot(width=0.2, color="grey") +
  geom_point(size=1, shape=16, color="black") +
  facet_wrap(~factor(fp_ind,levels=c("Light1","Nitrogen1","Soil_disturbance1",
                                     "Light2","Nitrogen2","Soil_disturbance2")), ncol = 3) + 
  xlab("Basic ecosystem type") + 
  ylab("Scaled indicator value (ANO data)") 



# making the plot, GRUK
ggplot(res.natopen.GRUK, aes(x=factor(Kartleggingsenhet), y=scaled_value, fill=fp_ind)) + 
  geom_hline(yintercept=0.6, linetype="dashed") + 
  geom_violin(color = NA) +
  #  geom_boxplot(width=0.2, color="grey") +
  geom_point(size=1, shape=16, color="black") +
  facet_wrap(~factor(fp_ind,levels=c("CC1","SS1","RR1","Light1","Nitrogen1","Soil_disturbance1",
                                     "CC2","SS2","RR2","Light2","Nitrogen2","Soil_disturbance2")), ncol = 6) + 
  xlab("Basic ecosystem type") + 
  ylab("Scaled indicator value (GRUK data)") 


#### relating scaled values to NiN condition variables ####

# ANO
ggplot(res.natopen.ANO, aes(x=fa_total_dekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.ANO, aes(x=vedplanter_total_dekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.ANO, aes(x=busker_dekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.ANO, aes(x=tresjikt_dekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.ANO, aes(x=slitasje, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

# GRUK
colnames(res.natopen.GRUK)[c(27,28,34,35,38)] <- c("driving","erosion","busksjiktsdekning","tresjiktsdekning","fremmedartsdekning")
ggplot(res.natopen.GRUK, aes(x=fremmedartsdekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.GRUK, aes(x=tresjiktsdekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.GRUK, aes(x=busksjiktsdekning, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.GRUK, aes(x=erosion, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")

ggplot(res.natopen.GRUK, aes(x=driving, y=scaled_value)) +
  geom_point() +
  facet_wrap(~fp_ind, scale="fixed")


plot.erosion.1 <- ggplot(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="RR2",], aes(x=erosion, y=original)) +
  geom_point() +
  xlab("Erosion score") + ylab("CSR-R value")


plot.alien.1 <- ggplot(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2",], aes(x=fremmedartsdekning, y=scaled_value)) +
  geom_point() +
  xlab("Alien species cover (%)") + ylab("Scaled Nitrogen2 value (GRUK data)")




# use beta-regression for analysis of response between 0 and 1
expit <- function(L) exp(L) / (1+exp(L))

res.natopen.GRUK <-
  res.natopen.GRUK %>%
  mutate(scaled_beta = replace(scaled_value, scaled_value == 0, 0.0001)) %>%
  mutate(scaled_beta = replace(scaled_beta, scaled_beta == 1, 0.9999)) %>%
  mutate(original_beta = replace(original, original == 0, 0.0001)) %>%
  mutate(original_beta = replace(original_beta, original_beta == 1, 0.9999)) %>%
  mutate(erosion_sc = scale(erosion)) %>%
  mutate(fremmedartsdekning_sc = scale(fremmedartsdekning))



### erosion vs. CSR-R
mod.GRUK.R2.erosion <- glmmTMB(scaled_value ~ erosion +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="RR2",])
summary(mod.GRUK.R2.erosion)

## remove all localities with aliens as reason for reduced condition
plot.R.erosion.1 <- 
  res.natopen.GRUK %>%
  filter(fp_ind=="RR2") %>%
  filter(tilstandsgrunn.x!="fremmedarter") %>%
  ggplot(aes(x=erosion, y=original)) +
  geom_point() +
  xlab("Erosion (%)") + ylab("CSR-R value")




mod.GRUK.R2.erosion <- glmmTMB(original_beta ~ erosion +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="RR2" & res.natopen.GRUK$tilstandsgrunn.x!="fremmedarter",])
summary(mod.GRUK.R2.erosion)

pred.l <- predict(mod.GRUK.R2.erosion,newdata=data.frame(erosion=0:100,Flate_ID=NA), re.form=NA, se.fit=T, type="link")
pred.ci <- data.frame(erosion=0:100,original=expit(pred.l$fit),up=expit(pred.l$fit+2*pred.l$se.fit),low=expit(pred.l$fit-2*pred.l$se.fit))

plot.R.erosion.1 +
  geom_ribbon(aes(x=erosion, ymin=low, ymax=up, fill='red',colour="red"), alpha=0.2, data = pred.ci) +
  geom_line(aes(x=erosion,y=original), data = pred.ci) +
  theme(legend.position = "none") +
  theme(axis.text=element_text(size=30),
        axis.title=element_text(size=32,face="bold"))


### erosion vs. lys


mod.GRUK.L2.erosion <- glmmTMB(scaled_beta ~ erosion +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Light2" & res.natopen.GRUK$tilstandsgrunn.x!="fremmedarter",])
summary(mod.GRUK.L2.erosion)

plot.L.erosion.1 <- 
  res.natopen.GRUK %>%
  filter(fp_ind=="Light2") %>%
  filter(tilstandsgrunn.x!="fremmedarter") %>%
  ggplot(aes(x=erosion, y=original)) +
  geom_point() +
  xlab("Erosion (%)") + ylab("Light value")


mod.GRUK.L2.erosion2 <- lmer(log(original) ~ erosion +(1|Flate_ID), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Light2" & res.natopen.GRUK$tilstandsgrunn.x!="fremmedarter",])
summary(mod.GRUK.L2.erosion2)

mod.GRUK.L2.erosion2 <- glmer(original ~ erosion_sc +(1|Flate_ID), family=Gamma(link='log'), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Light2" & res.natopen.GRUK$tilstandsgrunn.x!="fremmedarter",])
summary(mod.GRUK.L2.erosion2)

x <- ( (0:100)-attr(res.natopen.GRUK$erosion_sc,'scaled:center') ) / attr(res.natopen.GRUK$erosion_sc,'scaled:scale') 
y.m <- exp(predict(mod.GRUK.L2.erosion2,newdata=data.frame(erosion_sc=x),re.form=NA) )
# 95%-confidence interval
yv <- expand.grid(erosion_sc = x)  
# you need to define the fixed effects part of the model as it was specified above
X <- model.matrix(~ erosion_sc,data = yv)
yv$original <- X %*% fixef(mod.GRUK.L2.erosion2)
yv$SE <- sqrt(diag(X %*% vcov(mod.GRUK.L2.erosion2) %*% t(X)))
yv$lo <- yv$original - (1.96 * yv$SE )
yv$up <- yv$original + (1.96 * yv$SE )
yv$x_orig <- 0:100

plot.L.erosion.1 +
  geom_ribbon(aes(x=x_orig, ymin=exp(lo), ymax=exp(up), fill='red',colour="red"), alpha=0.2, data = yv) +
  geom_line(aes(x=x_orig,y=exp(original)), data = yv) +
  theme(legend.position = "none") +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold"))




### aliens

mod.GRUK.N2.alien <- glmmTMB(scaled_value ~ fremmedartsdekning +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2",])
summary(mod.GRUK.N2.alien)
pred.mean <- predict(mod.GRUK.N2.alien,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA, se.fit=F, type="response")
pred.mean <- data.frame(fremmedartsdekning=0:100,scaled_value=pred.mean)

pred.l <- predict(mod.GRUK.N2.alien,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA, se.fit=T, type="link")
pred.ci <- data.frame(fremmedartsdekning=0:100,scaled_value=expit(pred.l$fit),up=expit(pred.l$fit+2*pred.l$se.fit),low=expit(pred.l$fit-2*pred.l$se.fit))

plot.alien.1 +
  geom_ribbon(aes(x=fremmedartsdekning, ymin=low, ymax=up, fill='red',colour="red"), alpha=0.2, data = pred.ci) +
  geom_line(aes(x=fremmedartsdekning,y=scaled_value), data = pred.mean)

# pretty shitty model

## remove all localities with erosion as reason for reduced condition
plot.alien.1 <-
  res.natopen.GRUK %>%
  filter(fp_ind=="Nitrogen2") %>%
  filter(tilstandsgrunn.x!="slitasje") %>%
  ggplot(aes(x=fremmedartsdekning, y=scaled_value)) +
  geom_point() +
  xlab("Alien species cover (%)") + ylab("Scaled Nitrogen2 value (GRUK data)")

plot.alien.2 <-
  res.natopen.GRUK %>%
  filter(fp_ind=="Nitrogen2") %>%
  filter(tilstandsgrunn.x!="slitasje") %>%
  ggplot(aes(x=fremmedartsdekning, y=original)) +
  geom_point() +
  xlab("Alien species cover (%)") + ylab("Nitrogen value") #+ ggtitle("GRUK - Nitrogen vs. aliens")

mod.GRUK.N2.alien2 <- lmer(log(original) ~ fremmedartsdekning +(1|Flate_ID), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2" & res.natopen.GRUK$tilstandsgrunn.x!="slitasje",])
summary(mod.GRUK.N2.alien2)

mod.GRUK.N2.alien2 <- glmer(original ~ fremmedartsdekning_sc +(1|Flate_ID), family=Gamma(link='log'), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2" & res.natopen.GRUK$tilstandsgrunn.x!="slitasje",])
summary(mod.GRUK.N2.alien2)

pred.mean2 <- exp(predict(mod.GRUK.N2.alien2,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA))
pred.mean2 <- data.frame(fremmedartsdekning=0:100,scaled_value=pred.mean2)



x <- ( (0:100)-attr(res.natopen.GRUK$fremmedartsdekning_sc,'scaled:center') ) / attr(res.natopen.GRUK$fremmedartsdekning_sc,'scaled:scale') 
y.m <- exp(predict(mod.GRUK.N2.alien2,newdata=data.frame(fremmedartsdekning_sc=x),re.form=NA) )
# 95%-confidence interval
yv <- expand.grid(fremmedartsdekning_sc = x)  
# you need to define the fixed effects part of the model as it was specified above
X <- model.matrix(~ fremmedartsdekning_sc,data = yv)
yv$original <- X %*% fixef(mod.GRUK.N2.alien2)
yv$SE <- sqrt(diag(X %*% vcov(mod.GRUK.N2.alien2) %*% t(X)))
yv$lo <- yv$original - (1.96 * yv$SE )
yv$up <- yv$original + (1.96 * yv$SE )
yv$x_orig <- 0:100


with(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2" & res.natopen.GRUK$tilstandsgrunn.x!="slitasje",],
     plot(fremmedartsdekning,original))
points(x,y.m,type="l",col="red")
polygon(x=c(x,rev(x)),y=c(exp(yv$lo),rev(exp(yv$up))),col=rgb(0, 0, 1, alpha=0.3),border=rgb(0, 0, 1, alpha=0.3))
lines(x,exp(yv$fit),col="blue")


plot.alien.2 +
  geom_ribbon(aes(x=x_orig, ymin=exp(lo), ymax=exp(up), fill='red',colour="red"), alpha=0.2, data = yv) +
  geom_line(aes(x=x_orig,y=exp(original)), data = yv) +
  theme(legend.position = "none") +
  theme(axis.text=element_text(size=30),
        axis.title=element_text(size=32,face="bold"))





plot.alien.1 +
#  geom_ribbon(aes(x=fremmedartsdekning, ymin=low, ymax=up, fill='red',colour="red"), alpha=0.2, data = pred.ci) +
  geom_line(aes(x=fremmedartsdekning,y=scaled_value), data = pred.mean2)




mod.GRUK.N2.alien <- glmmTMB(scaled_value ~ fremmedartsdekning +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen2" & res.natopen.GRUK$tilstandsgrunn.x!="slitasje",])
summary(mod.GRUK.N2.alien)

pred.mean <- predict(mod.GRUK.N2.alien,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA, se.fit=F, type="response")
pred.mean <- data.frame(fremmedartsdekning=0:100,scaled_value=pred.mean)

pred.l <- predict(mod.GRUK.N2.alien,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA, se.fit=T, type="link")
pred.ci <- data.frame(fremmedartsdekning=0:100,scaled_value=expit(pred.l$fit),up=expit(pred.l$fit+2*pred.l$se.fit),low=expit(pred.l$fit-2*pred.l$se.fit))

plot.alien.1 +
  geom_ribbon(aes(x=fremmedartsdekning, ymin=low, ymax=up, fill='red',colour="red"), alpha=0.2, data = pred.ci) +
  geom_line(aes(x=fremmedartsdekning,y=scaled_value), data = pred.mean) +
  geom_line(aes(x=fremmedartsdekning,y=scaled_value), data = pred.mean2, linetype=2)

# better but still pretty shitty



### aliens vs. CSR-C
mod.GRUK.C2.alien <- glmmTMB(scaled_beta ~ fremmedartsdekning +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="SS2" & res.natopen.GRUK$tilstandsgrunn.x!="erosion",])
summary(mod.GRUK.C2.erosion)

## remove all localities with aliens as reason for reduced condition
plot.C.alien.1 <- 
  res.natopen.GRUK %>%
  filter(fp_ind=="CC2") %>%
  filter(tilstandsgrunn.x!="erosion") %>%
  ggplot(aes(x=fremmedartsdekning, y=original)) +
  geom_point() +
  xlab("Alien species cover (%)") + ylab("CSR-C value")




mod.GRUK.C2.alien <- glmmTMB(original_beta ~ fremmedartsdekning +(1|Flate_ID), family=beta_family(), data=res.natopen.GRUK[res.natopen.GRUK$fp_ind=="CC2" & res.natopen.GRUK$tilstandsgrunn.x!="erosion",])
summary(mod.GRUK.C2.alien)

pred.l <- predict(mod.GRUK.C2.alien,newdata=data.frame(fremmedartsdekning=0:100,Flate_ID=NA), re.form=NA, se.fit=T, type="link")
pred.ci <- data.frame(fremmedartsdekning=0:100,original=expit(pred.l$fit),up=expit(pred.l$fit+2*pred.l$se.fit),low=expit(pred.l$fit-2*pred.l$se.fit))

plot.C.alien.1 +
  geom_ribbon(aes(x=fremmedartsdekning, ymin=low, ymax=up, fill='red',colour="red"), alpha=0.2, data = pred.ci) +
  geom_line(aes(x=fremmedartsdekning,y=original), data = pred.ci) +
  theme(legend.position = "none") +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold"))





## scaled value violin plot for only CSR-R, Light and Nitrogen
res.natopen.GRUK %>%
  filter(fp_ind %in% c("RR1","Light1","Nitrogen1","RR2","Light2","Nitrogen2")) %>%
  filter(!is.na(scaled_value)) %>%
  ggplot(aes(x=factor(Kartleggingsenhet), y=scaled_value, fill=fp_ind)) + 
  geom_hline(yintercept=0.6, linetype="dashed") + 
  geom_violin(color = NA) +
  #  geom_boxplot(width=0.2, color="grey") +
  geom_point(size=1, shape=16, color="black") +
  facet_wrap(~factor(fp_ind,levels=c("RR1","Light1","Nitrogen1",
                                     "RR2","Light2","Nitrogen2"),
                     labels=c("CSR-R1","Light1","Nitrogen1",
                              "CSR-R2","Light2","Nitrogen2")), ncol = 3) + 
  xlab("Basic ecosystem type") + 
  ylab("Scaled indicator value") + 
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = -45, vjust = 0.5, hjust=0.2)) +
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=16,face="bold")) +
  theme(strip.text = element_text(
    size = 16))



#### scaled value maps ####
# keep wide format and add geometry again
res.natopen.ANO2 <- results.natopen.ANO[['2-sided']]
st_geometry(res.natopen.ANO2) <- st_geometry(ANO.natopen)

res.natopen.GRUK2 <- results.natopen.GRUK[['2-sided']]
st_geometry(res.natopen.GRUK2) <- st_geometry(GRUK.natopen)


#nor <- readRDS('P:/41201785_okologisk_tilstand_2022_2023/data/rds/norway_outline.RDS')%>%
#  st_as_sf() %>%
#  st_transform(crs = crs(ANO.geo))

nor <- st_read("data/outlineOfNorway_EPSG25833.shp")%>%
  st_as_sf() %>%
  st_transform(crs = st_crs(ANO.geo))

#reg <- st_read("P:/41201785_okologisk_tilstand_2022_2023/data/regioner/regNorway_wgs84 - MERGED.shp")%>%
#  st_as_sf() %>%
#  st_transform(crs = crs(ANO.geo))

reg <- st_read("data/regions.shp")%>%
  st_as_sf() %>%
  st_transform(crs = st_crs(ANO.geo))

# change region names to something R-friendly
reg$region
reg$region <- c("Northern Norway","Central Norway","Eastern Norway","Western Norway","Southern Norway")

regnor <- st_intersection(reg,nor)

## scaled value maps

# ANO
# CC2 (upper indicator)
tm_shape(regnor) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.ANO2) +
  tm_dots('CC2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Competition index (upper), natopen ANO",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.0 - 0.2", "0.2 - 0.4", "0.4 - 0.6", 
                           "0.6 - 0.8", "0.8 - 1.0", "NA"),
                title = "index values")



# RR1 (lower indicator)
tm_shape(regnor) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.ANO2) +
  tm_dots('RR1',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Ruderal index (lower), natopen ANO",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 6, plot = FALSE),'grey'),
                labels = c("0.4 - 0.5", "0.5 - 0.6", "0.6 - 0.7", 
                           "0.7 - 0.8", "0.8 - 0.9", "0.9 - 1.0", "NA"),
                title = "index values")



# GRUK
# CC2 (upper indicator)
tm_shape(regnor) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.GRUK2) +
  tm_dots('CC2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Competition index (upper), natopen GRUK",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.0 - 0.2", "0.2 - 0.4", "0.4 - 0.6", 
                           "0.6 - 0.8", "0.8 - 1.0", "NA"),
                title = "index values")



# RR2 (upper indicator)
tm_shape(regnor) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.GRUK2) +
  tm_dots('RR2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Ruderal index (upper), natopen GRUK",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 6, plot = FALSE),'grey'),
                labels = c("0.4 - 0.5", "0.5 - 0.6", "0.6 - 0.7", 
                           "0.7 - 0.8", "0.8 - 0.9", "0.9 - 1.0", "NA"),
                title = "index values")

# Nitrogen2 (upper indicator)
tm_shape(regnor) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.GRUK2) +
  tm_dots('Nitrogen2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Nitrogen index (upper), natopen GRUK",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE),'grey'),
                labels = c("0.3 - 0.4", "0.4 - 0.5", "0.5 - 0.6", "0.6 - 0.7", 
                           "0.7 - 0.8", "0.8 - 0.9", "0.9 - 1.0", "NA"),
                title = "index values")


# let's look at things by region
#ANO
res.natopen.ANO2 = st_join(res.natopen.ANO2, regnor, left = TRUE)
colnames(res.natopen.ANO2)

nrow(res.natopen.ANO2[is.na(res.natopen.ANO2$region),]) # no NA's for regions


#GRUK
res.natopen.GRUK2 = st_join(res.natopen.GRUK2, regnor, left = TRUE)
colnames(res.natopen.GRUK2)

nrow(res.natopen.GRUK2[is.na(res.natopen.GRUK2$region),]) # some points didn't get assigned to a region. Why?

boks <- st_bbox(c(xmin = 10.3, xmax = 10.8, ymax = 59.95, ymin = 59.4), crs = st_crs(4326))
tm_shape(regnor, bbox = boks) +
  tm_fill('GID_0', labels="", title="", legend.show = FALSE) + 
  tm_borders() +
  tm_shape(res.natopen.GRUK2[is.na(res.natopen.GRUK2$region),]) +
  tm_dots('Nitrogen2',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=2, legend.show = FALSE) + # 
  tm_layout(main.title = "Nitrogen index (upper), natopen GRUK",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE),'grey'),
                labels = c("0.3 - 0.4", "0.4 - 0.5", "0.5 - 0.6", "0.6 - 0.7", 
                           "0.7 - 0.8", "0.8 - 0.9", "0.9 - 1.0", "NA"),
                title = "index values")
# they seem to lie in water
# all sites but the southernmost one are in Eastern Norway, the remaining one in Southern Norway
summary(res.natopen.GRUK2[is.na(res.natopen.GRUK2$region),"y"])

res.natopen.GRUK2[is.na(res.natopen.GRUK2$region) & res.natopen.GRUK2$y<59.83,c("y","Flate_ID")] # site 123-4 is in Southern Norway
res.natopen.GRUK2[res.natopen.GRUK2$Flate_ID=="123-4","region"] <- "Southern Norway"
# and all the other region=NA observations are in Eastern Norway
res.natopen.GRUK2[is.na(res.natopen.GRUK2$region),"region"] <- "Eastern Norway"

nrow(res.natopen.GRUK2[is.na(res.natopen.GRUK2$region),]) # no NA's left

# simple means, inappropriate for 0-1 bound data
res.natopen.ANO2 %>% 
  group_by(as.factor(region)) %>% 
  mutate(CC1.reg.mean = mean(CC1,na.rm=T)) %>%
  mutate(CC2.reg.mean = mean(CC2,na.rm=T)) %>%
  mutate(SS1.reg.mean = mean(SS1,na.rm=T)) %>%
  mutate(SS2.reg.mean = mean(SS1,na.rm=T)) %>%
  mutate(RR1.reg.mean = mean(RR1,na.rm=T)) %>%
  mutate(RR2.reg.mean = mean(RR1,na.rm=T)) %>%
  mutate(Light1.reg.mean = mean(Light1,na.rm=T)) %>%
  mutate(Light2.reg.mean = mean(Light1,na.rm=T)) %>%
  mutate(Nitrogen1.reg.mean = mean(Nitrogen1,na.rm=T)) %>%
  mutate(Nitrogen2.reg.mean = mean(Nitrogen2,na.rm=T)) %>%
  mutate(Soil_disturbance1.reg.mean = mean(Soil_disturbance1,na.rm=T)) %>%
  mutate(Soil_disturbance2.reg.mean = mean(Soil_disturbance2,na.rm=T))

# and for GRUK
res.natopen.GRUK2 %>% 
  group_by(as.factor(region)) %>% 
  mutate(CC1.reg.mean = mean(CC1,na.rm=T)) %>%
  mutate(CC2.reg.mean = mean(CC2,na.rm=T)) %>%
  mutate(SS1.reg.mean = mean(SS1,na.rm=T)) %>%
  mutate(SS2.reg.mean = mean(SS1,na.rm=T)) %>%
  mutate(RR1.reg.mean = mean(RR1,na.rm=T)) %>%
  mutate(RR2.reg.mean = mean(RR1,na.rm=T)) %>%
  mutate(Light1.reg.mean = mean(Light1,na.rm=T)) %>%
  mutate(Light2.reg.mean = mean(Light1,na.rm=T)) %>%
  mutate(Nitrogen1.reg.mean = mean(Nitrogen1,na.rm=T)) %>%
  mutate(Nitrogen2.reg.mean = mean(Nitrogen2,na.rm=T)) %>%
  mutate(Soil_disturbance1.reg.mean = mean(Soil_disturbance1,na.rm=T)) %>%
  mutate(Soil_disturbance2.reg.mean = mean(Soil_disturbance2,na.rm=T))


# rather use beta-regression
expit <- function(L) exp(L) / (1+exp(L))
library(betareg)
library(glmmTMB)


indmean.beta <- function(df) {
  
  st_geometry(df) <- NULL
  colnames(df) <- c("y","ran")
  
  if ( nrow(df[!is.na(df[,1]),]) >= 2 ) {
    
    if ( length(unique(df[!is.na(df[,1]),2])) >=5 ) {
      
      mod1 <- glmmTMB(y ~ 1 +(1|ran), family=beta_family(), data=df)
      
      return(c(
        expit(summary( mod1 )$coefficients$cond[1]),
        
        expit( summary( mod1 )$coefficients$cond[1] + 
                 summary( mod1 )$coefficients$cond[2] )-
          expit( summary( mod1 )$coefficients$cond[1] ),
        
        nrow(df[!is.na(df$y),]),
        summary( mod1 )$coefficients$cond[1],
        summary( mod1 )$coefficients$cond[2]
      ))
      
    } else {
      
      mod2 <- betareg(y ~ 1, data=df)
      
      return(c(
        expit(summary( mod2 )$coefficients$mean[1]),
        expit( summary( mod2 )$coefficients$mean[1] + 
                 summary( mod2 )$coefficients$mean[2] )-
          expit( summary( mod2 )$coefficients$mean[1] ),
        nrow(df[!is.na(df$y),]),
        summary( mod2 )$coefficients$mean[1],
        summary( mod2 )$coefficients$mean[2]
      ))
      
    }
    
  } else {
    
    return(c(df$y,NA,1,NA,NA))
    
  }
  
}



indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway",c("CC1","ano_flate_id")])

indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Northern Norway",c("CC1","Flate_ID")])

res.natopen.ANO2$RR1[res.natopen.ANO2$RR1==1] <- 0.999
res.natopen.ANO2$RR1[res.natopen.ANO2$RR1==0] <- 0.001

res.natopen.ANO2$CC1[res.natopen.ANO2$CC1==1] <- 0.999
res.natopen.ANO2$CC1[res.natopen.ANO2$CC1==0] <- 0.001

regnor <- regnor %>%
  mutate(
    RR1.ANO.reg.mean = c(indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway",c("RR1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway",c("RR1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway",c("RR1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway",c("RR1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway",c("RR1","ano_flate_id")])[1]
    ),
    RR1.ANO.reg.se = c(indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway",c("RR1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway",c("RR1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway",c("RR1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway",c("RR1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway",c("RR1","ano_flate_id")])[2]*2
    ),
    RR1.ANO.reg.n = c(nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway" & !is.na(res.natopen.ANO2$RR1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway" & !is.na(res.natopen.ANO2$RR1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway" & !is.na(res.natopen.ANO2$RR1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway" & !is.na(res.natopen.ANO2$RR1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway" & !is.na(res.natopen.ANO2$RR1),])
    ),
    CC1.ANO.reg.mean = c(indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway",c("CC1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway",c("CC1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway",c("CC1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway",c("CC1","ano_flate_id")])[1],
                         indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway",c("CC1","ano_flate_id")])[1]
    ),
    CC1.ANO.reg.se = c(indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway",c("CC1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway",c("CC1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway",c("CC1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway",c("CC1","ano_flate_id")])[2]*2,
                       indmean.beta(df=res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway",c("CC1","ano_flate_id")])[2]*2
    ),
    CC1.ANO.reg.n = c(nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Northern Norway" & !is.na(res.natopen.ANO2$CC1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Central Norway" & !is.na(res.natopen.ANO2$CC1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Eastern Norway" & !is.na(res.natopen.ANO2$CC1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Western Norway" & !is.na(res.natopen.ANO2$CC1),]),
                      nrow(res.natopen.ANO2[res.natopen.ANO2$region=="Southern Norway" & !is.na(res.natopen.ANO2$CC1),])
    )
  )

# and adding the values for GRUK
res.natopen.GRUK2$Nitrogen2[res.natopen.GRUK2$Nitrogen2==1] <- 0.999
res.natopen.GRUK2$Nitrogen2[res.natopen.GRUK2$Nitrogen2==0] <- 0.001

res.natopen.GRUK2$RR2[res.natopen.GRUK2$RR2==1] <- 0.999
res.natopen.GRUK2$RR2[res.natopen.GRUK2$RR2==0] <- 0.001

regnor <- regnor %>%
  mutate(
    Nitrogen2.GRUK.reg.mean = c(indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Northern Norway",c("Nitrogen2","Flate_ID")])[1],
                                indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Central Norway",c("Nitrogen2","Flate_ID")])[1],
                                indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway",c("Nitrogen2","Flate_ID")])[1],
                                indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Western Norway",c("Nitrogen2","Flate_ID")])[1],
                                indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway",c("Nitrogen2","Flate_ID")])[1]
    ),
    Nitrogen2.GRUK.reg.se = c(indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Northern Norway",c("Nitrogen2","Flate_ID")])[2]*2,
                              indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Central Norway",c("Nitrogen2","Flate_ID")])[2]*2,
                              indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway",c("Nitrogen2","Flate_ID")])[2]*2,
                              indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Western Norway",c("Nitrogen2","Flate_ID")])[2]*2,
                              indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway",c("Nitrogen2","Flate_ID")])[2]*2
    ),
    Nitrogen2.GRUK.reg.n = c(0,
                             0,
                             nrow(res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway" & !is.na(res.natopen.GRUK2$Nitrogen2),]),
                             0,
                             nrow(res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway" & !is.na(res.natopen.GRUK2$Nitrogen2),])
    ),
    RR2.GRUK.reg.mean = c(indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Northern Norway",c("RR2","Flate_ID")])[1],
                          indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Central Norway",c("RR2","Flate_ID")])[1],
                          indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway",c("RR2","Flate_ID")])[1],
                          indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Western Norway",c("RR2","Flate_ID")])[1],
                          indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway",c("RR2","Flate_ID")])[1]
    ),
    RR2.GRUK.reg.se = c(indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Northern Norway",c("RR2","Flate_ID")])[2]*2,
                        indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Central Norway",c("RR2","Flate_ID")])[2]*2,
                        indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway",c("RR2","Flate_ID")])[2]*2,
                        indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Western Norway",c("RR2","Flate_ID")])[2]*2,
                        indmean.beta(df=res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway",c("RR2","Flate_ID")])[2]*2
    ),
    RR2.GRUK.reg.n = c(0,
                       0,
                       nrow(res.natopen.GRUK2[res.natopen.GRUK2$region=="Eastern Norway" & !is.na(res.natopen.GRUK2$RR2),]),
                       0,
                       nrow(res.natopen.GRUK2[res.natopen.GRUK2$region=="Southern Norway" & !is.na(res.natopen.GRUK2$RR2),])
    )
  )







# RR1 (lower indicator), mean
tm_shape(regnor) +
  tm_polygons(col="RR1.ANO.reg.mean", title="CSR-R (lower), mean", style="quantile", palette=rev(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("RR1.ANO.reg.n",col="black",bg.color="grey")

# RR1 (lower indicator), se
tm_shape(regnor) +
  tm_polygons(col="RR1.ANO.reg.se", title="CSR-R (lower)", style="quantile", palette=(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("RR1.ANO.reg.n",col="black",bg.color="grey")

# GRUK

# RR2 (upper indicator), mean
tm_shape(regnor) +
  tm_polygons(col="RR2.GRUK.reg.mean", title="RR (upper)", style="quantile", palette=rev(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("RR2.GRUK.reg.n",col="black",bg.color="grey")
# RR2 (upper indicator), se
tm_shape(regnor) +
  tm_polygons(col="RR2.GRUK.reg.se", title="RR (upper)", style="quantile", palette=(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("RR2.GRUK.reg.n",col="black",bg.color="grey")


# Nitrogen2 (upper indicator), mean
tm_shape(regnor) +
  tm_polygons(col="Nitrogen2.GRUK.reg.mean", title="Nitrogen (upper), mean", style="quantile", palette=rev(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("Nitrogen2.GRUK.reg.n",col="black",bg.color="grey")
# Nitrogen2 (upper indicator), se
tm_shape(regnor) +
  tm_polygons(col="Nitrogen2.GRUK.reg.se", title="Nitrogen (upper), 2 SE", style="quantile", palette=(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("Nitrogen2.GRUK.reg.n",col="black",bg.color="grey")


tm_shape(regnor) +
  tm_polygons(col="Nitrogen2.GRUK.reg.mean", title="Nitrogen (upper), mean", style="quantile", palette=rev(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("Nitrogen2.GRUK.reg.n",col="black",bg.color="grey")







#### how many observations are there? ####
# total ANO
length(unique(ANO.geo$ano_flate_id))
length(unique(ANO.geo$ano_punkt_id))
# total natopen
length(unique(res.natopen.ANO2$ano_flate_id))
length(unique(res.natopen.ANO2$ano_punkt_id))
# by region
length(unique(res.natopen.ANO2$ano_flate_id[res.natopen.ANO2$region=="Northern Norway"]))
length(unique(res.natopen.ANO2$ano_flate_id[res.natopen.ANO2$region=="Central Norway"]))
length(unique(res.natopen.ANO2$ano_flate_id[res.natopen.ANO2$region=="Eastern Norway"]))
length(unique(res.natopen.ANO2$ano_flate_id[res.natopen.ANO2$region=="Western Norway"]))
length(unique(res.natopen.ANO2$ano_flate_id[res.natopen.ANO2$region=="Southern Norway"]))

length(unique(res.natopen.ANO2$ano_punkt_id[res.natopen.ANO2$region=="Northern Norway"]))
length(unique(res.natopen.ANO2$ano_punkt_id[res.natopen.ANO2$region=="Central Norway"]))
length(unique(res.natopen.ANO2$ano_punkt_id[res.natopen.ANO2$region=="Eastern Norway"]))
length(unique(res.natopen.ANO2$ano_punkt_id[res.natopen.ANO2$region=="Western Norway"]))
length(unique(res.natopen.ANO2$ano_punkt_id[res.natopen.ANO2$region=="Southern Norway"]))




#### continue here ####

#### distribution comparison, reference vs. field data ####

### ANO, CSR-R
summary(res.natopen.ANO[!is.na(res.natopen.ANO$original),]$kartleggingsenhet_1m2)
sort(unique(res.natopen.ANO$kartleggingsenhet_1m2))
# 8 NiN-types with data to plot

x11()
par(mfrow=c(3,3))

for ( i in sort(unique(res.natopen.ANO$kartleggingsenhet_1m2))[c(1,6,7,10,12,13,14,15)] ) {
  
  tryCatch({
    
    plot(density( as.matrix(natopen.ref.cov[['RR']][,i]) ,na.rm=T),
         xlim=c(0,1), ylim=c(0,10), type="l", main=i,xlab='CSR-R value')
    points(res.natopen.ANO[res.natopen.ANO$fp_ind=="RR1" & res.natopen.ANO$kartleggingsenhet_1m2==i,]$original,
           rep(0,length(res.natopen.ANO[res.natopen.ANO$fp_ind=="RR1" & res.natopen.ANO$kartleggingsenhet_1m2==i,]$original)),
           col="red")
    points(density(res.natopen.ANO[res.natopen.ANO$fp_ind=="RR1" & res.natopen.ANO$kartleggingsenhet_1m2==i,]$original,na.rm=T),
           type="l", col="red")
    
    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
}
plot(1,1,col="white",xlab='',ylab='',xaxt="n",yaxt="n",bty="n")

legend("center", legend=c("reference","field data"), pch=c(NULL,1), lty=1, col=c("black","red"),bty="n", cex=1.5)



### GRUK, Nitrogen
# only two NiN types in GRUK, T2-C-7 and T2-C-8
x11()
par(mfrow=c(1,2))

for ( i in unique(res.natopen.GRUK$Kartleggingsenhet) ) {
  
  tryCatch({
    
    plot(density( as.matrix(natopen.ref.cov[['Nitrogen']][,i]) ,na.rm=T),
         xlim=c(1,9), ylim=c(0,2), type="l", main=i,xlab='Nitrogen value')
    points(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen1" & res.natopen.GRUK$Kartleggingsenhet==i,]$original,
           rep(0,length(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen1" & res.natopen.GRUK$Kartleggingsenhet==i,]$original)),
           col="red")
    points(density(res.natopen.GRUK[res.natopen.GRUK$fp_ind=="Nitrogen1" & res.natopen.GRUK$Kartleggingsenhet==i,]$original,na.rm=T),
           type="l", col="red")
    
    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  
}
legend("topright", legend=c("reference","field data"), pch=c(NA,1), lty=1, col=c("black","red"), cex=1.5)



