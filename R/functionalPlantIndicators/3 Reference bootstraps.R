#### running bootstraps - wetlands ####
colnames(NiN.wetland)
wetland.ref <- indBoot(sp=NiN.wetland[,1],abun=NiN.wetland[,2:46],ind=NiN.wetland[,47:51],
                          iter=1000,obl=6,rat=2/3,var.abun=T)


wetland.ref.cov <- indBoot.freq(sp=NiN.wetland.cov[,1],abun=NiN.wetland.cov[,2:46],ind=NiN.wetland.cov[,47:51],
                          iter=1000,obl=1,rat=2/3,var.abun=F)

### saving backups
#wetland.ref.backup <- wetland.ref
#wetland.ref.cov.backup <- wetland.ref.cov

### fixing NaN's
for (i in 1:length(wetland.ref) ) {
  for (j in 1:ncol(wetland.ref[[i]]) ) {
    v <- wetland.ref[[i]][,j]
    v[is.nan(v)] <- NA
    wetland.ref[[i]][,j] <- v
  }
}

for (i in 1:length(wetland.ref.cov) ) {
  for (j in 1:ncol(wetland.ref.cov[[i]]) ) {
    v <- wetland.ref.cov[[i]][,j]
    v[is.nan(v)] <- NA
    wetland.ref.cov[[i]][,j] <- v
  }
}





#### checking NiN-types with several species lists ####
str(wetland.ref.cov)

indID <- colnames(ind.dat[,c("Continentality", "Light", "Moisture", "Soil_reaction_pH", "Nitrogen")])
NiNID <- colnames(wetland.ref.cov[[1]])

for (i in indID) {
  
  dirOutput <- "C:/Users/joachim.topper/OneDrive - NINA/work/R projects/github/ecosystemCondition_PP&FPI/R/functionalPlantIndicators/testoutput"
  setwd(dirOutput)
  name <- paste('wetland',i,'.jpg',sep='')
  jpeg(filename=name,width=8000,height=4000,res=300)
  
  par(mfrow=c(5,9))
  for (j in NiNID) {
    plot(density(wetland.ref.cov[[i]][,j],na.rm=T),main=j,xlim=c(-2,10))
  }
  dev.off()
}

## omit V1-C1a & V1-C8a
#str(wetland.ref.cov)

#wetland.ref.cov <- lapply(wetland.ref.cov, function(x) x[!(names(x) %in% c("V1-C1a", "V1-C8a"))])
#wetland.ref <- lapply(wetland.ref, function(x) x[!(names(x) %in% c("V1-C1a", "V1-C8a"))])


#### storing reference lists ####
#rm(list= ls()[!(ls() %in% c('forest.ind.list','mire.ind.list','semiNat.ind.list','heath.ind.list','wetland.ref','ind.dat'))])
#rm(list= ls()[!(ls() %in% c('wetland.ref.backup','wetland.ref','wetland.ref.cov.backup','wetland.ref.cov','ind.dat'))])

# settings <- "iter=10000,obl=6,rat=1/3,var.abun=T"
#save.image("C:/Users/joachim.topper/OneDrive - NINA/work/R projects/projects/?kol tilst fjell 2021/input/reference/reference list/ref_lists_mount211123_10000.RData")

