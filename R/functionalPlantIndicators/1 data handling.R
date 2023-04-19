library(downloader)
library(sf)
library(tidyr)
library(dplyr)
library(plyr)
library(stringr)
library(tidyverse)
library(readxl)

#### download from kartkatalogen to P-drive ####
# url <- "https://nedlasting.miljodirektoratet.no/naturovervaking/naturovervaking_eksport.gdb.zip"
download(url, dest="P:/41201785_okologisk_tilstand_2022_2023/data/naturovervaking_eksport.gdb.zip", mode="w") 
unzip ("P:/41201785_okologisk_tilstand_2022_2023/data/naturovervaking_eksport.gdb.zip", 
       exdir = "P:/41201785_okologisk_tilstand_2022_2023/data/naturovervaking_eksport.gdb2")

st_layers(dsn = "P:/41201785_okologisk_tilstand_2022_2023/data/naturovervaking_eksport.gdb2")

# SOMETHING NOT WORKING YET



#### upload data from P-drive ####
## ANO
st_layers(dsn = "P:/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb")
ANO.sp <- st_read("P:/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb",
                   layer="ANO_Art")
ANO.geo <- st_read("P:/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb",
                  layer="ANO_SurveyPoint")
head(ANO.sp)
head(ANO.geo)

## GRUK
excel_sheets("P:/41201785_okologisk_tilstand_2022_2023/data/GRUK/GRUKdata_2020-2022_GJELDENDE.xlsx")
GRUK.variables <- read_excel("P:/41201785_okologisk_tilstand_2022_2023/data/GRUK/GRUKdata_2020-2022_GJELDENDE.xlsx", 
                                 sheet = 2)
GRUK.species <- read_excel("P:/41201785_okologisk_tilstand_2022_2023/data/GRUK/GRUKdata_2020-2022_GJELDENDE.xlsx", 
                               sheet = 3)

# condition evaluation for 2021 data
excel_sheets("P:/41201785_okologisk_tilstand_2022_2023/data/GRUK/NNF_GRUK_GJELDENDE.xls")

GRUK2021.condition <- read_excel("P:/41201785_okologisk_tilstand_2022_2023/data/GRUK/NNF_GRUK_GJELDENDE.xls", 
                                 sheet = 1)

head(GRUK.variables)
head(GRUK.species)
head(GRUK2021.condition)





## ASO data





## Tyler indicator data
ind.Tyler <- read.table("P:/41201785_okologisk_tilstand_2022_2023/data/functional plant indicators/Tyler et al_Swedish plant indicators.txt",
                        sep = '\t', header=T, quote = '')
head(ind.Tyler)

## Grime CSR-values
ind.Grime <- read.csv("P:/41201785_okologisk_tilstand_2022_2023/data/functional plant indicators/Grime CSR.csv",sep=";",dec=",", header=T)
head(ind.Grime)

## generalized species lists NiN
load("P:/41201785_okologisk_tilstand_2022_2023/data/functional plant indicators//reference from NiN/Eco_State.RData")
str(Eco_State)

#### data handling - functional indicator data ####
# trimming away sub-species & co, and descriptor info
ind.Grime[,'species.orig'] <- ind.Grime[,'species']
ind.Grime[,'species'] <- word(ind.Grime[,'species'], 1,2)
names(ind.Tyler)[1] <- 'species'
ind.Tyler$species <- as.factor(ind.Tyler$species)
summary(ind.Tyler$species)
ind.Tyler <- ind.Tyler[!is.na(ind.Tyler$species),]
ind.Tyler[,'species.orig'] <- ind.Tyler[,'species']
ind.Tyler[,'species'] <- word(ind.Tyler[,'species'], 1,2)

# dealing with 'duplicates'
ind.Grime[duplicated(ind.Grime[,'species']),"species"]
ind.Grime.dup <- ind.Grime[duplicated(ind.Grime[,'species']),c("species")]
ind.Grime[ind.Grime$species %in% ind.Grime.dup,]
# getting rid of the duplicates
ind.Grime <- ind.Grime %>% filter( !(species.orig %in% list("Carex viridula brachyrrhyncha",
                                                            "Dactylorhiza fuchsii praetermissa",
                                                            "Medicago sativa varia",
                                                            "Montia fontana chondrosperma",
                                                            "Papaver dubium lecoqii",
                                                            "Sanguisorba minor muricata")
                                   ) )
ind.Grime[duplicated(ind.Grime[,'species']),"species"]

#ind.Tyler2 <- ind.Tyler
ind.Tyler <- ind.Tyler2
ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler.dup <- ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler[ind.Tyler$species %in% ind.Tyler.dup,c("Light","Moisture","Soil_reaction_pH","Nitrogen","species.orig","species")]
ind.Tyler <- ind.Tyler %>% filter( !(species.orig %in% list("Ammophila arenaria x Calamagrostis epigejos",
                                                            "Anemone nemorosa x ranunculoides",
                                                            "Armeria maritima ssp. elongata",
                                                            "Asplenium trichomanes ssp. quadrivalens",
                                                            "Calystegia sepium ssp. spectabilis",
                                                            "Campanula glomerata 'Superba'",
                                                            "Dactylorhiza maculata ssp. fuchsii",
                                                            "Erigeron acris ssp. droebachensis",
                                                            "Erigeron acris ssp. politus",
                                                            "Erysimum cheiranthoides L. ssp. alatum",
                                                            "Euphrasia nemorosa x stricta var. brevipila",
                                                            "Galium mollugo x verum",
                                                            "Geum rivale x urbanum",
                                                            "Hylotelephium telephium (ssp. maximum)",
                                                            "Juncus alpinoarticulatus ssp. rariflorus",
                                                            "Lamiastrum galeobdolon ssp. argentatum",
                                                            "Lathyrus latifolius ssp. heterophyllus",
                                                            "Medicago sativa ssp. falcata",
                                                            "Medicago sativa ssp. x varia",
                                                            "Monotropa hypopitys ssp. hypophegea",
                                                            "Ononis spinosa ssp. hircina",
                                                            "Ononis spinosa ssp. procurrens",
                                                            "Pilosella aurantiaca ssp. decolorans",
                                                            "Pilosella aurantiaca ssp. dimorpha",
                                                            "Pilosella cymosa ssp. gotlandica",
                                                            "Pilosella cymosa ssp. praealta",
                                                            "Pilosella officinarum ssp. peleteranum",
                                                            "Poa x jemtlandica (Almq.) K. Richt.",
                                                            "Poa x herjedalica Harry Sm.",
                                                            "Ranunculus peltatus ssp. baudotii",
                                                            "Sagittaria natans x sagittifolia",
                                                            "Salix repens ssp. rosmarinifolia",
                                                            "Stellaria nemorum L. ssp. montana",
                                                            "Trichophorum cespitosum ssp. germanicum")
) )
ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler.dup <- ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler[ind.Tyler$species %in% ind.Tyler.dup,c("Light","Moisture","Soil_reaction_pH","Nitrogen","species.orig","species")]
# getting rid of sect. for Hieracium
ind.Tyler <- ind.Tyler %>% mutate(species=gsub("sect. ","",species.orig))
ind.Tyler[,'species'] <- word(ind.Tyler[,'species'], 1,2)

ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler.dup <- ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]
ind.Tyler[ind.Tyler$species %in% ind.Tyler.dup,c("Light","Moisture","Soil_reaction_pH","Nitrogen","species.orig","species")]
# only hybrids left -> get rid of these
ind.Tyler <- ind.Tyler[!duplicated(ind.Tyler[,'species']),]
ind.Tyler[duplicated(ind.Tyler[,'species']),"species"]

ind.Tyler$species <- as.factor(ind.Tyler$species)
summary(ind.Tyler$species)
# no duplicates left

# merge indicator data
ind.dat <- merge(ind.Grime,ind.Tyler, by="species", all=T)
summary(ind.dat)
ind.dat[duplicated(ind.dat[,'species']),"species"]
ind.dat$species <- as.factor(ind.dat$species)
summary(ind.dat$species)
head(ind.dat)


#### data handling - ANO data ####
head(ANO.sp)
head(ANO.geo)

## fix NiN information
ANO.geo$hovedtype_rute <- substr(ANO.geo$kartleggingsenhet_1m2,1,3) # take the 3 first characters
ANO.geo$hovedtype_rute <- gsub("-", "", ANO.geo$hovedtype_rute) # remove hyphon
unique(as.factor(ANO.geo$hovedtype_rute))

## fix NiN-variables
colnames(ANO.geo)
colnames(ANO.geo)[42:47] <- c("groeftingsintensitet",
                              "bruksintensitet",
                              "beitetrykk",
                              "slatteintensitet",
                              "tungekjoretoy",
                              "slitasje")
head(ANO.geo)

# remove variable code in the data
ANO.geo$groeftingsintensitet <- gsub("7GR-GI_", "", ANO.geo$groeftingsintensitet) 
unique(ANO.geo$groeftingsintensitet)
ANO.geo$groeftingsintensitet <- gsub("X", "NA", ANO.geo$groeftingsintensitet)
unique(ANO.geo$groeftingsintensitet)
ANO.geo$groeftingsintensitet <- as.numeric(ANO.geo$groeftingsintensitet)
unique(ANO.geo$groeftingsintensitet)

ANO.geo$bruksintensitet <- gsub("7JB-BA_", "", ANO.geo$bruksintensitet) 
unique(ANO.geo$bruksintensitet)
ANO.geo$bruksintensitet <- gsub("X", "NA", ANO.geo$bruksintensitet)
unique(ANO.geo$bruksintensitet)
ANO.geo$bruksintensitet <- as.numeric(ANO.geo$bruksintensitet)
unique(ANO.geo$bruksintensitet)

ANO.geo$beitetrykk <- gsub("7JB-BT_", "", ANO.geo$beitetrykk) 
unique(ANO.geo$beitetrykk)
ANO.geo$beitetrykk <- gsub("X", "NA", ANO.geo$beitetrykk)
unique(ANO.geo$beitetrykk)
ANO.geo$beitetrykk <- as.numeric(ANO.geo$beitetrykk)
unique(ANO.geo$beitetrykk)

ANO.geo$slatteintensitet <- gsub("7JB-SI_", "", ANO.geo$slatteintensitet) 
unique(ANO.geo$slatteintensitet)
ANO.geo$slatteintensitet <- gsub("X", "NA", ANO.geo$slatteintensitet)
unique(ANO.geo$slatteintensitet)
ANO.geo$slatteintensitet <- as.numeric(ANO.geo$slatteintensitet)
unique(ANO.geo$slatteintensitet)

ANO.geo$tungekjoretoy <- gsub("7TK_", "", ANO.geo$tungekjoretoy) 
unique(ANO.geo$tungekjoretoy)
ANO.geo$tungekjoretoy <- gsub("X", "NA", ANO.geo$tungekjoretoy)
unique(ANO.geo$tungekjoretoy)
ANO.geo$tungekjoretoy <- as.numeric(ANO.geo$tungekjoretoy)
unique(ANO.geo$tungekjoretoy)

ANO.geo$slitasje <- gsub("7SE_", "", ANO.geo$slitasje) 
unique(ANO.geo$slitasje)
ANO.geo$slitasje <- gsub("X", "NA", ANO.geo$slitasje)
unique(ANO.geo$slitasje)
ANO.geo$slitasje <- as.numeric(ANO.geo$slitasje)
unique(ANO.geo$slitasje)

## check that every point is present only once
length(levels(as.factor(ANO.geo$ano_flate_id)))
length(levels(as.factor(ANO.geo$ano_punkt_id)))
summary(as.factor(ANO.geo$ano_punkt_id))
# there's many double presences, probably some wrong registrations of point numbers,
# but also double registrations (e.g. ANO0159_55)
# CHECK THIS when preparing ecosystem-datasets for scaling




# fix species names
ANO.sp$Species <- ANO.sp$art_navn
unique(as.factor(ANO.sp$Species))
#ANO.sp$Species <- sub(".*?_", "", ANO.sp$Species) # lose the Norwegian name in the front
ANO.sp[,'Species'] <- word(ANO.sp[,'Species'], 1,2) # lose subspecies
ANO.sp$Species <- str_to_title(ANO.sp$Species) # make first letter capital
#ANO.sp$Species <- gsub("_", " ", ANO.sp$Species) # replace underscore with space
ANO.sp$Species <- gsub("( .*)","\\L\\1",ANO.sp$Species,perl=TRUE) # make capital letters after hyphon to lowercase
ANO.sp$Species <- gsub("( .*)","\\L\\1",ANO.sp$Species,perl=TRUE) # make capital letters after space to lowercase

## merge species data with indicators
ANO.sp.ind <- merge(x=ANO.sp[,c("Species", "art_dekning", "ParentGlobalID")], 
                y= ind.dat[,c("species","CC", "SS", "RR","Continentality", "Light", "Moisture", "Soil_reaction_pH", "Nitrogen", "Grazing_mowing")],
                by.x="Species", by.y="species", all.x=T)
summary(ANO.sp.ind)


# checking which species didn't find a match
unique(ANO.sp.ind[is.na(ANO.sp.ind$Moisture),'Species'])
#unique(ANO.sp.ind[!is.na(ANO.sp.ind$Moisture),'Species'])

ANO.sp.ind[ANO.sp.ind$Species=="Taraxacum officinale",]
ind.dat[ind.dat$species=="Picea sitchensis",]
ind.Grime[ind.Grime$species=="Picea sitchensis",]
ind.Tyler[ind.Tyler$species=="Picea sitchensis",]
ANO.sp[ANO.sp$Species=="Picea sitchensis",]

# fix species name issues
ind.dat <- ind.dat %>% 
  mutate(species=str_replace(species,"Aconitum lycoctonum", "Aconitum septentrionale")) %>% 
  mutate(species=str_replace(species,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
  mutate(species=str_replace(species,"Carex myosuroides", "Kobresia myosuroides")) %>%
  mutate(species=str_replace(species,"Clinopodium acinos", "Acinos arvensis")) %>%
  mutate(species=str_replace(species,"Artemisia rupestris", "Artemisia norvegica")) %>%
  mutate(species=str_replace(species,"Cherleria biflora", "Minuartia biflora"))



ANO.sp <- ANO.sp %>% 
  mutate(Species=str_replace(Species,"Arctous alpinus", "Arctous alpina")) %>%
  mutate(Species=str_replace(Species,"Betula tortuosa", "Betula pubescens")) %>%
  mutate(Species=str_replace(Species,"Blysmopsis rufa", "Blysmus rufus")) %>%
  mutate(Species=str_replace(Species,"Cardamine nymanii", "Cardamine pratensis")) %>%
  mutate(Species=str_replace(Species,"Carex adelostoma", "Carex buxbaumii")) %>%
  mutate(Species=str_replace(Species,"Carex leersii", "Carex echinata")) %>%
  mutate(Species=str_replace(Species,"Carex paupercula", "Carex magellanica")) %>%
  mutate(Species=str_replace(Species,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
  mutate(Species=str_replace(Species,"Carex viridula", "Carex flava")) %>%
  mutate(Species=str_replace(Species,"Chamaepericlymenum suecicum", "Cornus suecia")) %>%
  mutate(Species=str_replace(Species,"Cicerbita alpina", "Lactuca alpina")) %>%
  mutate(Species=str_replace(Species,"Empetrum hermaphroditum", "Empetrum nigrum")) %>%
  mutate(Species=str_replace(Species,"Festuca prolifera", "Festuca rubra")) %>%
  mutate(Species=str_replace(Species,"Galium album", "Galium mollugo")) %>%
  mutate(Species=str_replace(Species,"Galium elongatum", "Galium palustre")) %>%
  mutate(Species=str_replace(Species,"Helictotrichon pratense", "Avenula pratensis")) %>%
  mutate(Species=str_replace(Species,"Helictotrichon pubescens", "Avenula pubescens")) %>%
  mutate(Species=str_replace(Species,"Hieracium alpina", "Hieracium Alpina")) %>%
  mutate(Species=str_replace(Species,"Hieracium alpinum", "Hieracium Alpina")) %>%
  mutate(Species=str_replace(Species,"Hieracium hieracium", "Hieracium Hieracium")) %>%
  mutate(Species=str_replace(Species,"Hieracium hieracioides", "Hieracium umbellatum")) %>%
  mutate(Species=str_replace(Species,"Hieracium murorum", "Hieracium Vulgata")) %>%
  mutate(Species=str_replace(Species,"Hieracium oreadea", "Hieracium Oreadea")) %>%
  mutate(Species=str_replace(Species,"Hieracium prenanthoidea", "Hieracium Prenanthoidea")) %>%
  mutate(Species=str_replace(Species,"Hieracium vulgata", "Hieracium Vulgata")) %>%
  mutate(Species=str_replace(Species,"Hieracium pilosella", "Pilosella officinarum")) %>%
  mutate(Species=str_replace(Species,"Hieracium vulgatum", "Hieracium umbellatum")) %>%
  mutate(Species=str_replace(Species,"Hierochloã« alpina", "Hierochloë alpina")) %>%
  mutate(Species=str_replace(Species,"Hierochloã« hirta", "Hierochloë hirta")) %>%
  mutate(Species=str_replace(Species,"Hierochloã« odorata", "Hierochloë odorata")) %>%
  mutate(Species=str_replace(Species,"Listera cordata", "Neottia cordata")) %>%
  mutate(Species=str_replace(Species,"Leontodon autumnalis", "Scorzoneroides autumnalis")) %>%
  mutate(Species=str_replace(Species,"Loiseleuria procumbens", "Kalmia procumbens")) %>%
  mutate(Species=str_replace(Species,"Mycelis muralis", "Lactuca muralis")) %>%
  mutate(Species=str_replace(Species,"Omalotheca supina", "Gnaphalium supinum")) %>%
  mutate(Species=str_replace(Species,"Omalotheca norvegica", "Gnaphalium norvegicum")) %>%
  mutate(Species=str_replace(Species,"Omalotheca sylvatica", "Gnaphalium sylvaticum")) %>%
  mutate(Species=str_replace(Species,"Oreopteris limbosperma", "Thelypteris limbosperma")) %>%
  mutate(Species=str_replace(Species,"Oxycoccus microcarpus", "Vaccinium microcarpum")) %>%
  mutate(Species=str_replace(Species,"Oxycoccus palustris", "Vaccinium oxycoccos")) %>%
  mutate(Species=str_replace(Species,"Phalaris minor", "Phalaris arundinacea")) %>%
  mutate(Species=str_replace(Species,"Pinus unicinata", "Pinus mugo")) %>%
  mutate(Species=str_replace(Species,"Poa alpigena", "Poa pratensis")) %>%
  mutate(Species=str_replace(Species,"Poa angustifolia", "Poa pratensis")) %>%
  mutate(Species=str_replace(Species,"Pyrola grandiflora", "Pyrola rotundifolia")) %>%
  mutate(Species=str_replace(Species,"Rumex alpestris", "Rumex acetosa")) %>%
  mutate(Species=str_replace(Species,"Syringa emodi", "Syringa vulgaris")) %>%
  mutate(Species=str_replace(Species,"Taraxacum crocea", "Taraxacum officinale")) %>%
  mutate(Species=str_replace(Species,"Taraxacum croceum", "Taraxacum officinale")) %>%
  mutate(Species=str_replace(Species,"Trientalis europaea", "Lysimachia europaea")) %>%
  mutate(Species=str_replace(Species,"Trifolium pallidum", "Trifolium pratense"))

## merge species data with indicators
ANO.sp.ind <- merge(x=ANO.sp[,c("Species", "art_dekning", "ParentGlobalID")], 
                    y= ind.dat[,c("species","CC", "SS", "RR","Continentality","Light", "Moisture", "Soil_reaction_pH", "Nitrogen", "Grazing_mowing")],
                    by.x="Species", by.y="species", all.x=T)
summary(ANO.sp.ind)
# checking which species didn't find a match
unique(ANO.sp.ind[is.na(ANO.sp.ind$Moisture),'Species'])
# don't find synonyms for these in the ind lists

## adding information on ecosystem and condition variables
ANO.sp.ind <- merge(x=ANO.sp.ind, 
                y=ANO.geo[,c("GlobalID","ano_flate_id","ano_punkt_id","ssb_id","aar",
                             "hovedoekosystem_punkt","hovedtype_rute","kartleggingsenhet_1m2",
                             "vedplanter_total_dekning","busker_dekning","tresjikt_dekning","roesslyng_dekning")], 
            by.x="ParentGlobalID", by.y="GlobalID", all.x=T)
# trimming away the points without information on NiN, species or cover
ANO.sp.ind <- ANO.sp.ind[!is.na(ANO.sp.ind$Species),]
ANO.sp.ind <- ANO.sp.ind[!is.na(ANO.sp.ind$art_dekning),]

#rm(ANO.sp)

#ANO.sp <- ANO.sp[!is.na(ANO.sp$Hovedoekosystem_rute),] # need to check
unique(as.factor(ANO.sp.ind$hovedoekosystem_punkt))
unique(as.factor(ANO.sp.ind$hovedtype_rute))
unique(as.factor(ANO.sp.ind$kartleggingsenhet_1m2))

summary(ANO.sp.ind)
head(ANO.sp.ind)




#### data handling - GRUK data ####
head(GRUK.variables)
head(GRUK.species)
head(GRUK2021.condition)

colnames(GRUK.species)[5] <- "art_dekning"

# fix species names
GRUK.species <- as.data.frame(GRUK.species)

GRUK.species$Species <- GRUK.species$Navn
unique(as.factor(GRUK.species$Species))
GRUK.species$Species <- sub(".*?_", "", GRUK.species$Species) # lose the Norwegian name in the front
GRUK.species$Species <- gsub("_", " ", GRUK.species$Species) # replace underscore with space
GRUK.species$Species <- str_to_title(GRUK.species$Species) # make first letter capital
GRUK.species$Species <- gsub("( .*)","\\L\\1",GRUK.species$Species,perl=TRUE) # make capital letters after hyphon to lowercase
GRUK.species$Species <- gsub("( .*)","\\L\\1",GRUK.species$Species,perl=TRUE) # make capital letters after space to lowercase
GRUK.species[,'Species'] <- word(GRUK.species[,'Species'], 1,2) # lose subspecies




## merge species data with indicators
GRUK.species.ind <- merge(x=GRUK.species[,c("Species", "art_dekning", "ParentGlobalID")], 
                    y= ind.dat[,c("species","CC", "SS", "RR", "Light", "Moisture", "Soil_reaction_pH", "Nitrogen", "Grazing_mowing")],
                    by.x="Species", by.y="species", all.x=T)
summary(GRUK.species.ind)


# checking which species didn't find a match
unique(GRUK.species.ind[is.na(GRUK.species.ind$Moisture & 
                                is.na(GRUK.species.ind$RR)),'Species'])



# fix species name issues
ind.dat <- ind.dat %>% 
#  mutate(species=str_replace(species,"Aconitum lycoctonum", "Aconitum septentrionale")) %>% 
#  mutate(species=str_replace(species,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
#  mutate(species=str_replace(species,"Carex myosuroides", "Kobresia myosuroides")) %>%
#  mutate(species=str_replace(species,"Clinopodium acinos", "Acinos arvensis")) %>%
#  mutate(species=str_replace(species,"Artemisia rupestris", "Artemisia norvegica")) %>%
  mutate(species=str_replace(species,"Rosa vosagica", "Rosa vosagiaca"))



GRUK.species <- GRUK.species %>% 
    mutate(Species=str_replace(Species,"Arabis wahlenbergii", "Arabis hirsuta")) %>%
  #  mutate(Species=str_replace(Species,"Arctous alpinus", "Arctous alpina")) %>%
#  mutate(Species=str_replace(Species,"Betula tortuosa", "Betula pubescens")) %>%
#  mutate(Species=str_replace(Species,"Blysmopsis rufa", "Blysmus rufus")) %>%
#  mutate(Species=str_replace(Species,"Cardamine nymanii", "Cardamine pratensis")) %>%
#  mutate(Species=str_replace(Species,"Carex adelostoma", "Carex buxbaumii")) %>%
#  mutate(Species=str_replace(Species,"Carex leersii", "Carex echinata")) %>%
  mutate(Species=str_replace(Species,"Carex paupercula", "Carex magellanica")) %>%
#  mutate(Species=str_replace(Species,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
  mutate(Species=str_replace(Species,"Carex viridula", "Carex flava")) %>%
#  mutate(Species=str_replace(Species,"Chamaepericlymenum suecicum", "Cornus suecia")) %>%
#  mutate(Species=str_replace(Species,"Cicerbita alpina", "Lactuca alpina")) %>%
    mutate(Species=str_replace(Species,"Cotoneaster scandinavicus", "Cotoneaster integerrimus")) %>%
  mutate(Species=str_replace(Species,"Cotoneaster symondsii", "Cotoneaster integrifolius")) %>%
  mutate(Species=str_replace(Species,"Cyanus montanus", "Centaurea montana")) %>%
  #  mutate(Species=str_replace(Species,"Empetrum hermaphroditum", "Empetrum nigrum")) %>%
    mutate(Species=str_replace(Species,"Erysimum virgatum", "Erysimum strictum")) %>%
  #  mutate(Species=str_replace(Species,"Festuca prolifera", "Festuca rubra")) %>%
    mutate(Species=str_replace(Species,"Festuca trachyphylla", "Festuca brevipila")) %>%
  mutate(Species=str_replace(Species,"Galium album", "Galium mollugo")) %>%
#  mutate(Species=str_replace(Species,"Galium elongatum", "Galium palustre")) %>%
  mutate(Species=str_replace(Species,"Helictotrichon pratense", "Avenula pratensis")) %>%
  mutate(Species=str_replace(Species,"Helictotrichon pubescens", "Avenula pubescens")) %>%
#  mutate(Species=str_replace(Species,"Hieracium alpina", "Hieracium Alpina")) %>%
#  mutate(Species=str_replace(Species,"Hieracium alpinum", "Hieracium Alpina")) %>%
#  mutate(Species=str_replace(Species,"Hieracium hieracium", "Hieracium Hieracium")) %>%
#  mutate(Species=str_replace(Species,"Hieracium hieracioides", "Hieracium umbellatum")) %>%
  mutate(Species=str_replace(Species,"Hieracium murorum", "Hieracium Vulgata")) %>%
#  mutate(Species=str_replace(Species,"Hieracium oreadea", "Hieracium Oreadea")) %>%
#  mutate(Species=str_replace(Species,"Hieracium prenanthoidea", "Hieracium Prenanthoidea")) %>%
#  mutate(Species=str_replace(Species,"Hieracium vulgata", "Hieracium Vulgata")) %>%
#  mutate(Species=str_replace(Species,"Hieracium pilosella", "Pilosella officinarum")) %>%
#  mutate(Species=str_replace(Species,"Hieracium vulgatum", "Hieracium umbellatum")) %>%
#  mutate(Species=str_replace(Species,"Hierochloã« alpina", "Hierochloë alpina")) %>%
#  mutate(Species=str_replace(Species,"Hierochloã« hirta", "Hierochloë hirta")) %>%
#  mutate(Species=str_replace(Species,"Hierochloã« odorata", "Hierochloë odorata")) %>%
    mutate(Species=str_replace(Species,"Hylotelephium maximum", "Sedum telephium")) %>%
  #  mutate(Species=str_replace(Species,"Listera cordata", "Neottia cordata")) %>%
#  mutate(Species=str_replace(Species,"Leontodon autumnalis", "Scorzoneroides autumnalis")) %>%
    mutate(Species=str_replace(Species,"Lepidotheca suaveolens", "Matricaria discoidea")) %>%
  #  mutate(Species=str_replace(Species,"Loiseleuria procumbens", "Kalmia procumbens")) %>%
    mutate(Species=str_replace(Species,"Malus ×domestica", "Malus domestica")) %>%
  #  mutate(Species=str_replace(Species,"Mycelis muralis", "Lactuca muralis")) %>%
#  mutate(Species=str_replace(Species,"Omalotheca supina", "Gnaphalium supinum")) %>%
#  mutate(Species=str_replace(Species,"Omalotheca norvegica", "Gnaphalium norvegicum")) %>%
#  mutate(Species=str_replace(Species,"Omalotheca sylvatica", "Gnaphalium sylvaticum")) %>%
#  mutate(Species=str_replace(Species,"Oreopteris limbosperma", "Thelypteris limbosperma")) %>%
#  mutate(Species=str_replace(Species,"Oxycoccus microcarpus", "Vaccinium microcarpum")) %>%
#  mutate(Species=str_replace(Species,"Oxycoccus palustris", "Vaccinium oxycoccos")) %>%
#  mutate(Species=str_replace(Species,"Phalaris minor", "Phalaris arundinacea")) %>%
#  mutate(Species=str_replace(Species,"Pinus unicinata", "Pinus mugo")) %>%
#  mutate(Species=str_replace(Species,"Poa alpigena", "Poa pratensis")) %>%
  mutate(Species=str_replace(Species,"Poa angustifolia", "Poa pratensis")) %>%
  mutate(Species=str_replace(Species,"Poa humilis", "Poa pratensis")) %>%
  #  mutate(Species=str_replace(Species,"Pyrola grandiflora", "Pyrola rotundifolia")) %>%
    mutate(Species=str_replace(Species,"Rosa dumalis", "Rosa vosagiaca")) %>%
  #  mutate(Species=str_replace(Species,"Rumex alpestris", "Rumex acetosa")) %>%
#  mutate(Species=str_replace(Species,"Syringa emodi", "Syringa vulgaris")) %>%
#  mutate(Species=str_replace(Species,"Taraxacum crocea", "Taraxacum officinale")) %>%
#  mutate(Species=str_replace(Species,"Taraxacum croceum", "Taraxacum officinale")) %>%
#  mutate(Species=str_replace(Species,"Trientalis europaea", "Lysimachia europaea")) %>%
  mutate(Species=str_replace(Species,"Trifolium pallidum", "Trifolium pratense"))

## merge species data with indicators
GRUK.species.ind <- merge(x=GRUK.species[,c("Species", "art_dekning", "ParentGlobalID")], 
                    y= ind.dat[,c("species","CC", "SS", "RR", "Light", "Moisture", "Soil_reaction_pH", "Nitrogen", "Grazing_mowing")],
                    by.x="Species", by.y="species", all.x=T)
summary(GRUK.species.ind)
# checking which species didn't find a match
unique(GRUK.species.ind[is.na(GRUK.species.ind$Moisture & 
                                is.na(GRUK.species.ind$RR)),'Species'])


### merge GRUK.variables and GRUK2021.condition
GRUK.variables <- as.data.frame(GRUK.variables)
GRUK2021.condition <- as.data.frame(GRUK2021.condition)

head(GRUK.variables)
head(GRUK2021.condition)

## fixing site-ID in the condition-data
GRUK2021.condition$Flate_ID <- GRUK2021.condition$områdenavn
unique(as.factor(GRUK2021.condition$Flate_ID))
GRUK2021.condition$Flate_ID <- gsub("_", " ", GRUK2021.condition$Flate_ID) # replace underscore with space
unique(as.factor(GRUK2021.condition$Flate_ID))
GRUK2021.condition$Flate_ID <- sub(" .*", "", GRUK2021.condition$Flate_ID) # remove everything after space
unique(as.factor(GRUK2021.condition$Flate_ID))

#GRUK2021.condition$Flate_ID <- gsub(" ", "-", GRUK2021.condition$Flate_ID) # replace space with hyphon
#GRUK2021.condition$Flate_ID <- gsub("[^0-9\\-]", "", GRUK2021.condition$Flate_ID) # remove all non-numerics except '-'
#GRUK2021.condition$Flate_ID <- gsub("--", "-", GRUK2021.condition$Flate_ID) # remove double hyphons
#GRUK2021.condition$Flate_ID <- substr(GRUK2021.condition$Flate_ID, 1, nchar(GRUK2021.condition$Flate_ID)-1) # remove the last character ('-' for all)


colnames(GRUK.variables)
colnames(GRUK2021.condition)

GRUK.variables <- merge(x=GRUK.variables, 
                          y=GRUK2021.condition[,c("tilstandsvurdering","tilstandsgrunn","artsmangfoldvurdering","lokalitetskvalitet","Flate_ID")], 
                          by.x="Flate_ID", by.y="Flate_ID", all.x=T)



## adding information on ecosystem and condition variables to species data
GRUK.species.ind <- merge(x=GRUK.species.ind, 
                    y=GRUK.variables[,c("GlobalID","year","Flate_ID","Punkt_ID",
                                        "Total dekning % av karplanter registert","Dekning % av karplanter i feltsjikt","Dekning % av moser",
                                        "Dekning % av lav","Dekning % av strø","Dekning % av bar jord/grus/stein/berg",
                                        "Kartleggingsenhet",
                                        "Spor etter ferdsel med tunge kjøretøy (%)","Spor etter slitasje og slitasjebetinget erosjon (%)","Dekning % av nakent berg","Menneskeskapte objekter i sirkelen?",
                                        "Total dekning % av vedplanter i feltsjikt","Dekning % av busker i busksjikt","Dekning % av tresjikt","Dekning % av problemarter","Total dekning % av fremmede arter",
                                        "x","y")], 
                    by.x="ParentGlobalID", by.y="GlobalID", all.x=T)
# trimming away the points without information on NiN, species or cover
GRUK.species.ind <- GRUK.species.ind[!is.na(GRUK.species.ind$Species),]
GRUK.species.ind <- GRUK.species.ind[!is.na(GRUK.species.ind$art_dekning),]

#rm(GRUK.species)
#rm(GRUK.variables)


summary(GRUK.species.ind)
head(GRUK.species.ind)



#### data handling - ASO data ... NOT DONE YET ####




#### data handling - reference data ####
# generalized species lists from NiN
str(Eco_State)

# sp
Eco_State$Concept_Data$Species$Species_List$species
# env
t(Eco_State$Concept_Data$Env$Env_Data)
# abun
t(Eco_State$Concept_Data$Species$Species_Data)

# transposing abundance data for bootstrapping
NiN.sp <- t(Eco_State$Concept_Data$Species$Species_Data)
NiN.sp <- as.data.frame(NiN.sp)
NiN.sp$sp <- as.factor(as.vector(Eco_State$Concept_Data$Species$Species_List$species))
# only genus and species name
NiN.sp$sp <- word(NiN.sp$sp, 1,2)
NiN.sp$spgr <- as.factor(as.vector(Eco_State$Concept_Data$Species$Species_List$art.code))
# trimming to desired species groups (for forests eg. removing trees)
#all.dat <- all.dat[all.dat$spgr!="a1a",]

# environment data
NiN.env <- Eco_State$Concept_Data$Env$Env_Data

# merging with indicator values
NiN.sp.ind <- merge(NiN.sp,ind.dat, by.x="sp", by.y="species", all.x=T)
summary(NiN.sp.ind)

NiN.sp.ind[NiN.sp.ind==999] <- NA

# checking which species didn't find a match
unique(NiN.sp.ind[is.na(NiN.sp.ind$Moisture) & NiN.sp.ind$spgr %in% list("a1a","a1b","a1c"),'sp'])

# fix species name issues
ind.dat <- ind.dat %>% 
  mutate(species=str_replace(species,"Aconitum lycoctonum", "Aconitum septentrionale")) %>% 
  mutate(species=str_replace(species,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
  mutate(species=str_replace(species,"Carex myosuroides", "Kobresia myosuroides")) %>%
  mutate(species=str_replace(species,"Clinopodium acinos", "Acinos arvensis")) %>%
  mutate(species=str_replace(species,"Artemisia rupestris", "Artemisia norvegica")) %>%
  mutate(species=str_replace(species,"Cherleria biflora", "Minuartia biflora"))



NiN.sp <- NiN.sp %>% 
  mutate(sp=str_replace(sp,"Aconitum lycoctonum", "Aconitum septentrionale")) %>% 
  mutate(sp=str_replace(sp,"Anagallis minima", "Lysimachia minima")) %>% 
  mutate(sp=str_replace(sp,"Arctous alpinus", "Arctous alpina")) %>%
  mutate(sp=str_replace(sp,"Betula tortuosa", "Betula pubescens")) %>%
  mutate(sp=str_replace(sp,"Blysmopsis rufa", "Blysmus rufus")) %>%
  mutate(sp=str_replace(sp,"Cardamine nymanii", "Cardamine pratensis")) %>%
  mutate(sp=str_replace(sp,"Carex adelostoma", "Carex buxbaumii")) %>%
  mutate(sp=str_replace(sp,"Carex leersii", "Carex echinata")) %>%
  mutate(sp=str_replace(sp,"Carex paupercula", "Carex magellanica")) %>%
  mutate(sp=str_replace(sp,"Carex simpliciuscula", "Kobresia simpliciuscula")) %>%
  mutate(sp=str_replace(sp,"Carex _vacillans", "Carex vacillans")) %>%
  mutate(sp=str_replace(sp,"Carex viridula", "Carex flava")) %>%
  mutate(sp=str_replace(sp,"Chamaepericlymenum suecicum", "Cornus suecia")) %>%
  mutate(sp=str_replace(sp,"Cornus suecia", "Cornus suecica")) %>%
  mutate(sp=str_replace(sp,"Cicerbita alpina", "Lactuca alpina")) %>%
  mutate(sp=str_replace(sp,"Dactylorhiza sphagnicola", "Dactylorhiza majalis")) %>%
  mutate(sp=str_replace(sp,"Diphasiastrum complanatum", "Lycopodium complanatum")) %>%
  mutate(sp=str_replace(sp,"Elymus alaskanus", "Elymus kronokensis")) %>%
  mutate(sp=str_replace(sp,"Empetrum hermaphroditum", "Empetrum nigrum")) %>%
  mutate(sp=str_replace(sp,"Erigeron eriocephalus", "Erigeron uniflorus")) %>%
  mutate(sp=str_replace(sp,"Festuca prolifera", "Festuca rubra")) %>%
  mutate(sp=str_replace(sp,"Galium album", "Galium mollugo")) %>%
  mutate(sp=str_replace(sp,"Galium elongatum", "Galium palustre")) %>%
  mutate(sp=str_replace(sp,"Glaux maritima", "Lysimachia maritima")) %>%
  mutate(sp=str_replace(sp,"Helictotrichon pratense", "Avenula pratensis")) %>%
  mutate(sp=str_replace(sp,"Helictotrichon pubescens", "Avenula pubescens")) %>%
  mutate(sp=str_replace(sp,"Hieracium alpina", "Hieracium Alpina")) %>%
  mutate(sp=str_replace(sp,"Hieracium alpinum", "Hieracium Alpina")) %>%
  mutate(sp=str_replace(sp,"Hieracium aurantiacum", "Pilosella aurantiaca")) %>%
  mutate(sp=str_replace(sp,"Hieracium hieracium", "Hieracium Hieracium")) %>%
  mutate(sp=str_replace(sp,"Hieracium hieracioides", "Hieracium umbellatum")) %>%
  mutate(sp=str_replace(sp,"Hieracium lactucella", "Pilosella lactucella")) %>%
  mutate(sp=str_replace(sp,"Hieracium murorum", "Hieracium Vulgata")) %>%
  mutate(sp=str_replace(sp,"Hieracium oreadea", "Hieracium Oreadea")) %>%
  mutate(sp=str_replace(sp,"Hieracium prenanthoidea", "Hieracium Prenanthoidea")) %>%
  mutate(sp=str_replace(sp,"Hieracium vulgata", "Hieracium Vulgata")) %>%
  mutate(sp=str_replace(sp,"Hieracium pilosella", "Pilosella officinarum")) %>%
  mutate(sp=str_replace(sp,"Hieracium vulgatum", "Hieracium umbellatum")) %>%
  mutate(sp=str_replace(sp,"Hierochloã« alpina", "Hierochloë alpina")) %>%
  mutate(sp=str_replace(sp,"Hierochloã« hirta", "Hierochloë hirta")) %>%
  mutate(sp=str_replace(sp,"Hierochloã« odorata", "Hierochloë odorata")) %>%
  mutate(sp=str_replace(sp,"Huperzia appressa", "Huperzia selago")) %>%
  mutate(sp=str_replace(sp,"Hylotelephium maximum", "Hylotelephium telephium")) %>%
  mutate(sp=str_replace(sp,"Lappula myosotis", "Lappula squarrosa")) %>%
  mutate(sp=str_replace(sp,"Lepidotheca suaveolens", "Matricaria discoidea")) %>%
  mutate(sp=str_replace(sp,"Listera cordata", "Neottia cordata")) %>%
  mutate(sp=str_replace(sp,"Leontodon autumnalis", "Scorzoneroides autumnalis")) %>%
  mutate(sp=str_replace(sp,"Loiseleuria procumbens", "Kalmia procumbens")) %>%
  mutate(sp=str_replace(sp,"Logfia arvensis", "Filago arvensis")) %>%
  mutate(sp=str_replace(sp,"Mentha _verticillata", "Mentha verticillata")) %>%
  mutate(sp=str_replace(sp,"Minuartia rubella", "Sabulina rubella")) %>%
  mutate(sp=str_replace(sp,"Minuartia stricta", "Sabulina stricta")) %>%
  mutate(sp=str_replace(sp,"Mycelis muralis", "Lactuca muralis")) %>%
  mutate(sp=str_replace(sp,"Omalotheca supina", "Gnaphalium supinum")) %>%
  mutate(sp=str_replace(sp,"Omalotheca norvegica", "Gnaphalium norvegicum")) %>%
  mutate(sp=str_replace(sp,"Omalotheca sylvatica", "Gnaphalium sylvaticum")) %>%
  mutate(sp=str_replace(sp,"Ononis arvensis", "Ononis spinosa")) %>%
  mutate(sp=str_replace(sp,"Oreopteris limbosperma", "Thelypteris limbosperma")) %>%
  mutate(sp=str_replace(sp,"Oxycoccus microcarpus", "Vaccinium microcarpum")) %>%
  mutate(sp=str_replace(sp,"Oxycoccus palustris", "Vaccinium oxycoccos")) %>%
  mutate(sp=str_replace(sp,"Phalaris minor", "Phalaris arundinacea")) %>%
  mutate(sp=str_replace(sp,"Phalaroides arundinacea", "Phalaris arundinacea")) %>%
  mutate(sp=str_replace(sp,"Pinus unicinata", "Pinus mugo")) %>%
  mutate(sp=str_replace(sp,"Platanthera montana", "Platanthera chlorantha")) %>%
  mutate(sp=str_replace(sp,"Poa alpigena", "Poa pratensis")) %>%
  mutate(sp=str_replace(sp,"Poa angustifolia", "Poa pratensis")) %>%
  mutate(sp=str_replace(sp,"Poa laxa", "Poa flexuosa")) %>%
  mutate(sp=str_replace(sp,"Poa _herjedalica", "Poa herjedalica")) %>%
  mutate(sp=str_replace(sp,"Poa _jemtlandica", "Poa jemtlandica")) %>%
  mutate(sp=str_replace(sp,"Poa lindebergii", "Poa arctica")) %>%
  mutate(sp=str_replace(sp,"Pyrola grandiflora", "Pyrola rotundifolia")) %>%
  mutate(sp=str_replace(sp,"Rhamnus catharticus", "Rhamnus cathartica")) %>%
  mutate(sp=str_replace(sp,"Rumex alpestris", "Rumex acetosa")) %>%
  mutate(sp=str_replace(sp,"Salix _fragilis", "Salix fragilis")) %>%
  mutate(sp=str_replace(sp,"Saxifraga _opdalensis", "Saxifraga opdalensis")) %>%
  mutate(sp=str_replace(sp,"Spergularia salina", "Spergularia marina")) %>%
  mutate(sp=str_replace(sp,"Syringa emodi", "Syringa vulgaris")) %>%
  mutate(sp=str_replace(sp,"Taraxacum crocea", "Taraxacum officinale")) %>%
  mutate(sp=str_replace(sp,"Taraxacum croceum", "Taraxacum officinale")) %>%
  mutate(sp=str_replace(sp,"Taraxacum erythrospermum", "Taraxacum officinale")) %>%
  mutate(sp=str_replace(sp,"Taraxacum hamatum", "Taraxacum officinale")) %>%
  mutate(sp=str_replace(sp,"Trientalis europaea", "Lysimachia europaea")) %>%
  mutate(sp=str_replace(sp,"Trifolium pallidum", "Trifolium pratense")) %>%
  mutate(sp=str_replace(sp,"Vicia orobus", "Vicia cassubica"))


## merge species data with indicators
NiN.sp.ind <- merge(NiN.sp,ind.dat, by.x="sp", by.y="species", all.x=T)
summary(NiN.sp.ind)

NiN.sp.ind[NiN.sp.ind==999] <- NA

# checking which species didn't find a match
unique(NiN.sp.ind[is.na(NiN.sp.ind$Moisture) & 
                    is.na(NiN.sp.ind$RR) & 
                    NiN.sp.ind$spgr %in% list("a1a","a1b","a1c")
                  ,'sp'])
# ok now


#### matching with NiN ecosystem types - wetlands ####
# NB! beware of rogue spaces in the 'Nature_type' & 'Sub_Type' variables, e.g. "Spring_Forest "
NiN.wetland <- NiN.sp.ind[,c("sp",paste(NiN.env[NiN.env$Nature_Type=="Mire","ID"]),colnames(ind.dat)[19:23])]   # Continentality, Light, Moisture, Soil_reaction_pH, Nitrogen
NiN.wetland[1,]
names(NiN.wetland)

#NiN.wetland <- NiN.wetland[,c(1:41,46:48,59:69)]
cbind(colnames(NiN.wetland),
      c("",
        'V3-C1a','V3-C1b','V3-C1c','V3-C1d','V3-C1e',
        'V1-C1a','V1-C1b','V1-C1c','V1-C1d','V1-C1e',
        'V1-C2a','V1-C2b','V1-C2c','V1-C2d',
        'V1-C3a','V1-C3b','V1-C3c','V1-C3d',
        'V1-C4a','V1-C4b','V1-C4c','V1-C4d',
        'V1-C4e','V1-C4f','V1-C4g','V1-C4h',
        'V3-C2','V1-C5',
        'V1-C6a','V1-C6b',
        'V1-C7a','V1-C7b',
        'V1-C8a','V1-C8b',
        'V2-C1a','V2-C1b',
        'V2-C2a','V2-C2b',
        'V2-C3a','V2-C3b',
        "V4-C4","V4-C5",
        "V4-C2","V4-C3",
        'V8-C1','V8-C2','V8-C3',
        rep("",10),
        rep("",5)
      )
)

NiN.wetland <- NiN.wetland[,c(1:43,46:48,59:63)]
colnames(NiN.wetland)[2:46] <- c('V3-C1a','V3-C1b','V3-C1c','V3-C1d','V3-C1e',
                              'V1-C1a','V1-C1b','V1-C1c','V1-C1d','V1-C1e',
                              'V1-C2a','V1-C2b','V1-C2c','V1-C2d',
                              'V1-C3a','V1-C3b','V1-C3c','V1-C3d',
                              'V1-C4a','V1-C4b','V1-C4c','V1-C4d',
                              'V1-C4e','V1-C4f','V1-C4g','V1-C4h',
                              'V3-C2','V1-C5',
                              'V1-C6a','V1-C6b',
                              'V1-C7a','V1-C7b',
                              'V1-C8a','V1-C8b',
                              'V2-C1a','V2-C1b',
                              'V2-C2a','V2-C2b',
                              'V2-C3a','V2-C3b',
                              'V4-C2','V4-C3',
                              'V8-C1','V8-C2','V8-C3'
)
head(NiN.wetland)


# translating the abundance classes into %-cover
coverscale <- data.frame(orig=0:6,
                         cov=c(0,1/32,1/8,3/8,0.6,4/5,1)
)

NiN.wetland.cov <- NiN.wetland
colnames(NiN.wetland.cov)
for (i in 2:46) {
  NiN.wetland.cov[,i] <- coverscale[,2][ match(NiN.wetland[,i], 0:6 ) ]
}

summary(NiN.wetland)
summary(NiN.wetland.cov)


#### matching with NiN ecosystem types - semi-natural ####
# NB! beware of rogue spaces in the 'Nature_type' & 'Sub_Type' variables, e.g. "Spring_Forest "
NiN.seminat <- NiN.sp.ind[,c("sp",paste(NiN.env[NiN.env$Nature_Type=="Coastal_Heath" | NiN.env$Sub_Type=="SemiNatMeadow" | NiN.env$Sub_Type=="Field" | NiN.env$Sub_Type=="WetMeadow","ID"]),colnames(ind.dat)[c(3:5,19:27,29)])]   # CSR, ..., Continentality, Light, Moisture, Soil_reaction_pH, Nitrogen, Phosphorus, Salinity, Grazing_mowing, Soil_disturbance, ..., Pollinator_dependence

NiN.seminat[1,]
names(NiN.seminat)
# checking heathland types
names(NiN.seminat)[c(1:5,7:10,13,16)]
cbind(colnames(NiN.seminat)[c(1:5,7:10,13,16)],
      c('',
        'T34-C1','T34-C2a','T34-C2b','T34-C2c',
        'T34-C3','T34-C4a','T34-C4b','T34-C4c',
        'T34-C5','T34-C6')
)

# checking meadow types
names(NiN.seminat)[c(1,19:37)]
cbind(colnames(NiN.seminat)[c(1,19:37)],
      c('',
        'T32-C1C2','T32-C3C4','T32-C5C20a','T32-C7C8',
        'T32-C5C20b','T32-C9a','T32-C9b','T32-C15',
        'T32-C21C6a','T32-C21C6b','T32-C10a','T32-C10b',
        'T32-C16',
        'T41a','T41b','T45-C1C2','T45-C3',
        'V10-C1C2','V10-C3')
)

#checking all
names(NiN.seminat)[c(1:5,7:10,13,16,19:37)]
cbind(colnames(NiN.seminat)[c(1:5,7:10,13,16,19:37)],
      c('',
        'T34-C1','T34-C2a','T34-C2b','T34-C2c',
        'T34-C3','T34-C4a','T34-C4b','T34-C4c',
        'T34-C5','T34-C6',
        'T32-C1C2','T32-C3C4','T32-C5C20a','T32-C7C8',
        'T32-C5C20b','T32-C9a','T32-C9b','T32-C15',
        'T32-C21C6a','T32-C21C6b','T32-C10a','T32-C10b',
        'T32-C16',
        'T41a','T41b','T45-C1C2','T45-C3',
        'V10-C1C2','V10-C3')
)

NiN.seminat <- NiN.seminat[,c(1:5,7:10,13,16,19:37,38:50)]
colnames(NiN.seminat)[1:30] <- c('',
                                 'T34-C1','T34-C2a','T34-C2b','T34-C2c',
                                 'T34-C3','T34-C4a','T34-C4b','T34-C4c',
                                 'T34-C5','T34-C6',
                                 'T32-C1C2','T32-C3C4','T32-C5C20a','T32-C7C8',
                                 'T32-C5C20b','T32-C9a','T32-C9b','T32-C15',
                                 'T32-C21C6a','T32-C21C6b','T32-C10a','T32-C10b',
                                 'T32-C16',
                                 'T41a','T41b','T45-C1C2','T45-C3',
                                 'V10-C1C2','V10-C3')
colnames(NiN.seminat)

# translating the abundance classes into %-cover
coverscale <- data.frame(orig=0:6,
                         cov=c(0,1/32,1/8,3/8,0.6,4/5,1)
)

NiN.seminat.cov <- NiN.seminat
colnames(NiN.seminat.cov)
for (i in 2:30) {
  NiN.seminat.cov[,i] <- coverscale[,2][ match(NiN.seminat[,i], 0:6 ) ]
}

summary(NiN.seminat)
summary(NiN.seminat.cov)
