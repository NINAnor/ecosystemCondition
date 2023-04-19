# Alien species {#alien-species}

*Author and date:* 

Anders L. Kolstad

March 2023






|Ecosystem                                                           |Økologisk.egenskap                      |ECT.class                              |
|:-------------------------------------------------------------------|:---------------------------------------|:--------------------------------------|
|Våtmark, Naturlig åpne områder under skoggrensa, Semi-naturlig mark |Funksjonelt viktige arter og strukturer |B1 Compositional state characteristics |

<hr/>

## Introduction
This indicator represent the the ecological on-site effect from  alien species. Whilst the introduction of alien species is best considered a pressure variable, the relative abundance of alien species on a given location is seen here as a manifestation of this negative anthropogenic impact, and is therefore a valid condition indicator.

A related variable has been used previously for [alpine](https://ninanor.github.io/IBECA/faktaark.html#Frav%C3%A6r_av_fremmede_arter) and forest ecosystems in Norway. These indicators were based on ANO, a national monitoring program, where alien species cover was estimated to the closest whole %. The upper and lower reference levels that was used back then was 0 or 100% of the species composition made up of alien species, respectively. The threshold value between good and reduced condition was defined as 5%. In this approach, the indicator represented the relative area with an absence of alien species. It is in a way the flip-side of _alien species abundance_. The latter was said to be a pressure variable, whilst the former reacts as direct and linear consequence of changes to this variable, and was therefore accepted as a condition indicator. We do not make this distinction here. 

This time we are using the [nature type mapping dataset](#naturtype) which records the assumed _effect_ of alien species, rather than a direct measure of abundance such as % cover. The recording scale is called R7 (Fig. \@ref(fig:R7)) and is an ordinal scale which has a non-linear relationship with %cover recorded in ANO (Fig. \@ref(fig:fremmedart-prosentVSinnslag)). In order to combine these two data sets, we must convert one of these scales to match the other.

Here I base the indicator on the R7 scale, since this is, presumably, the bigger data set. I therefore convert %cover into R7 classes based on what I can interpret from Fig. \@ref(fig:fremmedart-prosentVSinnslag).

Upper reference value is then 1, and lower reference value is 7, on the R7 scale.
For the threshold value I will set this to value 4 on the R7 scale. 
This is based on interpretation by the author and based of the definition of this value in Fig. \@ref(fig:R7). 
Step 4 on the R7 scale is the step that, concordantly, best matches the 5% threshold in the old approach, as seen from Fig. \@ref(fig:fremmedart-prosentVSinnslag).



```r
knitr::include_graphics("images/R7 scale.PNG")
```

<div class="figure">
<img src="images/R7 scale.PNG" alt="The R7 scale used when recording the effect of alien species in the nature type monitoring program" width="722" />
<p class="caption">(\#fig:R7)The R7 scale used when recording the effect of alien species in the nature type monitoring program</p>
</div>


```r
knitr::include_graphics("images/fremmedart_prosentVSinnslag.PNG")
```

<div class="figure">
<img src="images/fremmedart_prosentVSinnslag.PNG" alt="Comparing the R7 scale (x axis) which is used in the nature type monitoring program with %cover (y-axis), which is how alien species is recorded in ANO. I am assuming the x axis is shifted downwards compared to the original R7 scale which range from 1 to 7, so that a value of 0 here equals an R7 value of 1. Cropped from Evju et al (2022)." width="323" />
<p class="caption">(\#fig:fremmedart-prosentVSinnslag)Comparing the R7 scale (x axis) which is used in the nature type monitoring program with %cover (y-axis), which is how alien species is recorded in ANO. I am assuming the x axis is shifted downwards compared to the original R7 scale which range from 1 to 7, so that a value of 0 here equals an R7 value of 1. Cropped from Evju et al (2022).</p>
</div>


Since the nature type data is not sampled in a systematic or random way, we must take extra care not to over-extrapolate in space. We delineate _homogeneous impact areas_ (HIA) based on four classes of increasing infrastructure intersected with municipality borders, and we say that if we have more than _n_ data points than this field data is representative inside the entire HIA. In [a related indicator](#slitasje-og-kjørespor) we used the accounting areas to define the HIA (5 accounting areas in Norway), in addition to the infrastructure classes. For this indicator, we expect more gradients also inside accounting areas, and therefore we define HIAs based on municipalities. This means that there will be more missing data in our final indicator maps, since not all municipalities will have sufficient data points to estimate indicator values.

We then calculate an area weighted mean (and error) indicator value for each HIA, as long as there is more than _n_ data points for a given combination of HIA and municipality.     

Here a general workflow for the calculation of the indicator.

1.  Import [Nature type data](#NTM2) data set (incl. GRUK) and [ANO data
    set](#ANO-import2)

2.  Identify the [relevant](#naturtype) nature types and [subset](#NTM)
    the data

3.  Convert [ANO points to polygons](#ANO-points-to-poly)

5.  [Combine](#combine-nt-ano) data sets

6.  [Scale](#scale-alien-ind) the `alien species` variable based on
    reference values.

7.  Define [homogeneous impact areas](#HIA) (HIA) based on an infrastructure index and municipalities

8.  [Aggregate and spread](#spread-slitasje) indicator value across HIAs
    (and municipalities)

9.  Confirm relationship between infrastructure index and indicator
    values to justify the extrapolation

10. TO DO: Prepare ecosystem delineation maps and us ethese to mask the extrapolated indicator maps

11. Spatial aggregation of indicator values and uncertainties to accounting areas

12. Export indicator maps and regional extrapolated maps

## About the underlying data

The indicator uses a data set from a standardised field survey of nature
types. You can read more about this data set from my preliminary analyses
[here](#naturtype). See also the [official
site](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/naturkartlegging/naturtyper/)
of the Environment Agency. I also import a data set called
[ANO](#ANO-import2), which you can read about
[here](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/miljoovervaking/overvakingsprogrammer/natur-pa-land/arealrepresentativ-naturovervakning-ano/).

### Representativity in time and space

The nature type mapping is not random and cannot be said to be area
representative. The ANO data set however, is area representative. The
data is from 2018 to present. The data from one field season usually
becomes available early the following year.

### Original units

The variables are recorded on a unitless seven-step ordinal scale (Fig.
\@ref(fig:R7)) or a as a % cover of alien species.

### Temporal coverage

The data goes back to 2018. I therefore bulk all the data from 2018 to 2022 into one time step. I then use the mean date for the raw data,
and define the variable as belonging to the year 2020 (read more
[here](#scaled-alien-variable)).

### Aditional comments about the dataset

For a run through of the nature type data set, see [here](#naturtype).

## Ecosystem characteristic

### Norwegain standard

The indicator is tagged to the *Økologisk egenskap* called
**Funksjonelt viktige arter og strukturer** (Functionally important species and structures). This emphasises the negaivte effect that alien species has on for example supressing or excluding native species. In some cases, alien species can also affect nutrient cycling or recruitment.

### UN standard

The indicator is tagged as a **B1 Compositional state characteristics**
indicator. 

## Collinearities with other indicators

_Alien species_ is not thought to exhibit collinearity with any other indicator at
the present.

## Reference condition and values

### Reference condition

The reference condition is one with minimal negative human impact. This
is also true for semi-natural ecosystems. In a sense, the reference condition is pre 1800s,
since alien species are defined as species established post 1800. 

### Reference values, thresholds for defining *good ecological condition*, minimum and/or maximum values


* Upper = 1 (R7 scale), corresponding to 0% alien species

* Threshold = 4 (R7 scale), corresponding to about 5-30% alien species cover.

* Lower = 7 (R7 scale), corresponding to 100% alien species cover.

Read about the normalisation [here](##scaled-alien-variable).

## Uncertainties

Uncertainties/errors are estimated for aggregated indicator values by
bootstrapping individual indicator values 1000 times and calculating a
distribution of area weighted means. This uncertainty is different from 
the spatial variation which we could get more straight forward without 
bootstrapping. When aggregating a second time,
from homogeneous impact areas to accounting areas, we assume a normal
distribution around the indicator values, with the already mentioned
errors, and sample _n_ times from these and combine the resamples into an
a new, area weighted, distribution. The errors for the accounting areas
thus represents both the spatial variation, and the precision, of the
indicator values within the accounting areas.

## References

[Nature type data](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/naturkartlegging/naturtyper/)

[ANO](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/miljoovervaking/overvakingsprogrammer/natur-pa-land/arealrepresentativ-naturovervakning-ano/)

Evju, M., Skrindo, A.B. & Solstad, H. (red.) 2022. Overvåking av åpen grunnlendt kalkmark 2021‒2024. Årsrapport 2022. NINA Rapport 2195. Norsk institutt for naturforskning.

## Analyses

### Data sets

#### Nature type mapping {#NTM2}

This indicator uses the data set
`Naturtyper etter Miljødirektoratets Instruks`, which can be found
[here](https://kartkatalog.geonorge.no/metadata/naturtyper-miljoedirektoratets-instruks/eb48dd19-03da-41e1-afd9-7ebc3079265c).
See also [here](#naturtype) for a detailed description of the data set.

We also have a separate [summary file](##exp-natureType-summary) where
the nature types are manually mapped to the NiN variables and to the correct NiN-main types. 
We can use this to find the nature types of interest.


```r
naturetypes_summary_import <- readRDS("data/naturetypes/natureType_summary.rds")
```

We are only interested in a mapping units that include our target variables. The variable _fremmedartsinnslag_ is coded as 7FA.


```r
myVars <- '7FA'
```



```r
naturetypes_summary <- naturetypes_summary_import %>%
  rowwise() %>%
  mutate(keepers = sum(c_across(
    all_of(myVars))>0, na.rm=T)) %>%
  filter(keepers >0) %>%
  select(Nature_type, NiN_mainType, Year)
```

This deleted 30 nature types and left us with these 24 nature types where 7FA was recorded:


```r
DT::datatable(naturetypes_summary)
```

```{=html}
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-931d600fc8702f2631c4" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-931d600fc8702f2631c4">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"],["Slåttemyr","Hagemark","Naturbeitemark","Semi-naturlig eng","Eng-aktig sterkt endret fastmark","Åpen flomfastmark","Strandeng","Nakent tørkeutsatt kalkberg","Kystlynghei","Boreal hei","Semi-naturlig våteng","Slåttemark","Sanddynemark","Semi-naturlig strandeng","Rik åpen jordvannsmyr i mellomboreal sone","Åpen grunnlendt kalkrik mark i boreonemoral sone","Rik åpen sørlig jordvannsmyr","Øvre sandstrand uten pionervegetasjon","Kalkrik helofyttsump","Åpen grunnlendt kalkrik mark i sørboreal sone","Sørlig etablert sanddynemark","Rik åpen jordvannsmyr i nordboreal og lavalpin sone","Svært tørkeutsatt sørlig kalkberg","Lauveng"],["V9","T32","T32","T32","T41","T18","T12","T1","T34","T31","V10","T32","T21","T33","V1","T2","V1","T29","L4","T2","T21","V1","T1","T32"],["2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2022"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Nature_type<\/th>\n      <th>NiN_mainType<\/th>\n      <th>Year<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

Importing and sub-setting the main data file, fix duplicate _hovedøkosystem_, calculate area, split one column in two, make numeric, and select target variables:

```r
naturetypes <- sf::st_read(dsn = path) %>%
  filter(naturtype %in% naturetypes_summary$Nature_type) %>%
  mutate(hovedøkosystem = case_match(hovedøkosystem,
                                  "naturligÅpneOmråderILavlandet" ~ "naturligÅpneOmråderUnderSkoggrensa",
                                  .default = hovedøkosystem),
         area = st_area(.)) %>%
  separate_rows(ninBeskrivelsesvariable, sep=",") %>%
  separate(col = ninBeskrivelsesvariable,
           into = c("NiN_variable_code", "NiN_variable_value"),
           sep = "_",
           remove=F) %>%
  mutate(NiN_variable_value = as.numeric(NiN_variable_value)) %>%
  filter(NiN_variable_code %in% myVars)
#> Reading layer `Naturtyper_nin_0000_norge' from data source 
#>   `/data/R/GeoSpatialData/Habitats_biotopes/Norway_Miljodirektoratet_Naturtyper_nin/Original/Naturtyper_nin_0000_norge_25833_FILEGDB/Naturtyper_nin_0000_norge_25833_FILEGDB.gdb' 
#>   using driver `OpenFileGDB'
#> Simple feature collection with 117427 features and 36 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -74953.52 ymin: 6448986 xmax: 1075081 ymax: 7921284
#> Projected CRS: ETRS89 / UTM zone 33N
```


```r
ggplot(data = naturetypes, aes(x = naturtype, fill = hovedøkosystem))+
  geom_bar()+
  coord_flip()+
  theme_bw(base_size = 10)+
  theme(legend.position = "top",
        legend.title = element_blank(),
        legend.direction = "vertical")+
  guides(fill = "none")+
  xlab("")+
  ylab("Number of localities")+
  facet_wrap(.~hovedøkosystem, ncol=1, scale="free")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-8-1.png" alt="An overview of the naturetypes for which we will calculate the indicator." width="576" />
<p class="caption">(\#fig:unnamed-chunk-8)An overview of the naturetypes for which we will calculate the indicator.</p>
</div>

Note that there is a lot more data for semi-natural ecosystem compared to the other two.

Column names starting with a number is problematic, so adding a prefix


```r
naturetypes$NiN_variable_code <- paste0("var_", naturetypes$NiN_variable_code)
```

Removing NA's


```r
naturetypes <- naturetypes[!is.na(naturetypes$NiN_variable_value),]
```

Shift variable to start from 1 rather than from 0.


```r
naturetypes$NiN_variable_value <- naturetypes$NiN_variable_value+1
```



```r
ggplot(naturetypes, aes(x = NiN_variable_value))+
  geom_histogram(fill="grey",
           colour = "black",
           binwidth = 1)+
  theme_bw(base_size = 12)+
  labs(x = "Alien species variable score") +
  facet_wrap(.~hovedøkosystem, scales="free_y")
```

<div class="figure">
<img src="alien_species_files/figure-html/alien-naturetype-1.png" alt="Alien species variable scores in the nature type data set." width="672" />
<p class="caption">(\#fig:alien-naturetype)Alien species variable scores in the nature type data set.</p>
</div>

It appears most localities are in good condition, and most localities have no alien species at all.


#### GRUK

This variable is also recorded in
[GRUK](https://www.nina.no/Naturmangfold/Trua-natur/%C3%85pen-grunnlendt-kalkmark).
The nature type data set I'm working on here includes this data already
(presently only 2021 included). GRUK also records a related variable:
`% cover in 5m radii circles`, which is much more detailed. This data is
not published. In any case it is better to use the harmonized data set
in our case.

_NOTE: I'm not sure, but I wonder if the 2021 GRUK data was a pilot project and that most GRUK data, and all future GRUK data, will not be included in this data set._

#### ANO {#ANO-import2}

Arealrepresentativ Naturovervåking (ANO) consist of 1000 systematically
placed locations in Norway, each with 18 sample points. In each sample point a
circle of 250 m2 is visualised, and the main ecosystem is recorded.

The %cover of alien vascular plant is estimated, independent on main ecosystem type. 
In contrast to the nature type data set, ANO only looks at vascular plants, and then also only the three strictest categories
in the alien plant list (SE, HI, PH). It is therefore not completely unproblematic to combine these to data sets,
but we will do so anyway. We expect plants to be the by far most common species group to influence the 7FA variable as well.
And similarly, we expect the three strictest  alien plant categories to contain the most aggressive species which will
drive the 7FA variable more so than the other categories.



```r
ano_eco <- c("vaatmark", "naturlig_apne", "semi_naturlig_mark")
ano <- sf::st_read(paste0(pData, "Naturovervaking_eksport.gdb"),
                   layer = "ANO_SurveyPoint") %>%
  dplyr::filter(hovedoekosystem_punkt %in% ano_eco) %>%
   mutate(hovedoekosystem_punkt = case_match(hovedoekosystem_punkt,
                                       "vaatmark" ~ "våtmark",
                                       "naturlig_apne" ~ "naturligÅpneOmråderUnderSkoggrensa",
                                       "semi_naturlig_mark" ~ "semi-naturligMark",
                                       .default = hovedoekosystem_punkt))
#> Reading layer `ANO_SurveyPoint' from data source 
#>   `/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb' 
#>   using driver `OpenFileGDB'
#> Simple feature collection with 8974 features and 71 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -51950 ymin: 6467050 xmax: 1094950 ymax: 7923950
#> Projected CRS: ETRS89 / UTM zone 33N
```


```r
table(ano$aar)
#> 
#> 2019 2021 
#>  215  887
```

This data set only contains data from year 2019 and 2021. We need to
update this data set later. It is not clear why there is no data from
2020.

Each point/row here is 250 square meters. The data also contains
information about how big a proportion of this area is made up of the
dominant main ecosystem. However, there are
215
NA's here, which is 20% of the data.

It appears the proportion of each circle that is made up of the dominant
ecosystem was only recorded after year 2019. In fact, the main ecosystem
was not recorded at all in 2019:


```r
table(ano$hovedtype_250m2, ano$aar)
#>                             
#>                              2019 2021
#>   Åpen flomfastmark             0    1
#>   Åpen grunnlendt mark          0   90
#>   Åpen jordvannsmyr             0  417
#>   Boreal hei                    0   81
#>   Fjellhei leside og tundra     0    5
#>   Grøftet torvmark              0    5
#>   Helofytt-ferskvannssump       0    3
#>   Historisk skredmark           0    3
#>   Isinnfrysingsmark             0    1
#>   Kaldkilde                     0    3
#>   Kystlynghei                   0   26
#>   Løs sterkt endret fastmark    0    1
#>   Myr- og sumpskogsmark         0   51
#>   Nakent berg                   0   35
#>   Nedbørsmyr                    0   53
#>   Rasmark                       0   23
#>   Rasmarkhei og -eng            0    3
#>   Semi-naturlig eng             0   44
#>   Semi-naturlig myr             0   14
#>   Semi-naturlig våteng          0    2
#>   Skogsmark                     0    3
#>   Strandberg                    0    5
#>   Strandeng                     0    2
#>   Strandsumpskogsmark           0    2
#>   Våtsnøleie og snøleiekilde    0    6
```

I can remove the NA's, and thus the 2019 data.

> *All of 2019 ANO data is excluded because of missing information*


```r
ano <- ano[!is.na(ano$andel_hovedoekosystem_punkt),]
```

Let's look at the variation in the recorded proportion of ecosystem
cover


```r
par(mar=c(5,6,4,2))
plot(ano$andel_hovedoekosystem_punkt[order(ano$andel_hovedoekosystem_punkt)],
     ylab="Percentage of the 250 m2 area\ncovered by the main ecosystem")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-16-1.png" alt="Distribution of the ANO variable andel_hovedoekosystem_punkt." width="672" />
<p class="caption">(\#fig:unnamed-chunk-16)Distribution of the ANO variable andel_hovedoekosystem_punkt.</p>
</div>

The zero in there is an obvious mistake. Removing it:


```r
ano <- ano[ano$andel_hovedoekosystem_punkt>20,]
```

Here's another plot of the distribution of the same variable:


```r
ggplot(ano, aes(x = andel_hovedoekosystem_punkt))+
         geom_histogram(fill = "grey",
                        colour="black",
                        binwidth = 1)+
  theme_bw(base_size = 12)+
  xlab("Percentage cover of the main ecosystem\n in the 250m2 circle")+
  scale_x_continuous(limits = c(0,101),
                     breaks = seq(0,100,10))
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-18-1.png" alt="Percentage cover of the main ecosystem in the 250m2 circle" width="672" />
<p class="caption">(\#fig:unnamed-chunk-18)Percentage cover of the main ecosystem in the 250m2 circle</p>
</div>

We can see that people tend to record the variable in steps of 5%, and
that most sample points are 100% belonging to the same main ecosystem.

We want to use area weighting in this indicator, so we can use this
percentage cover data to calculate the area. Note that both data sets
use m^2^ as area units.


```r
ano$area <- (ano$andel_hovedoekosystem_punkt/100)*250
```

Let's now look at the distribution of the variable. It is coded as `fa_total_dekning`. 
First, there are 73 NA's in this column which we can remove.


```r
ano <- ano[!is.na(ano$fa_total_dekning),]
```

Let us plot the distribution of values.


```r
ggplot(ano, aes(x = fa_total_dekning))+
  geom_histogram(fill="grey",
           colour = "black",
           binwidth = 1)+
  theme_bw(base_size = 12)+
  labs(x = "% cover alien vascular plants") +
  facet_wrap(.~hovedoekosystem_punkt, scales="free_y")
```

<div class="figure">
<img src="alien_species_files/figure-html/ano-alien-dist-1.png" alt="Distribution of %cover of alien plants variable in the ANO data set" width="672" />
<p class="caption">(\#fig:ano-alien-dist)Distribution of %cover of alien plants variable in the ANO data set</p>
</div>

The ANO localities seemingly have less alien plants in them than the nature type localities. This can be du to sampling biases in the latter.

Now I will convert these %cover values into 7FA classes. This is a critical step, since there is no one-to-one mapping here, 
but rather there is considerable overlap, as can be seen in Fig. \@ref(fig:fremmedart-prosentVSinnslag).



```r
ano <- ano %>%
  mutate(var_7FA = case_when(
             fa_total_dekning>90 ~ 7,
             fa_total_dekning>25 ~ 6,
             fa_total_dekning>10 ~ 5,
             fa_total_dekning>5 ~ 4,
             fa_total_dekning>2 ~ 3,
             fa_total_dekning>1 ~ 2,
             fa_total_dekning<1 ~ 1))
```


```r
ggplot(ano, aes(x = var_7FA))+
  geom_histogram(fill="grey",
           colour = "black",
           binwidth = 1)+
  theme_bw(base_size = 12)+
  labs(x = "% cover alien vascular plants\n converted to the R7 scale") +
  facet_wrap(.~hovedoekosystem_punkt, scales="free_y")
#> Warning: Removed 6 rows containing non-finite values
#> (`stat_bin()`).
```

<div class="figure">
<img src="alien_species_files/figure-html/ano-alien-dist-R7-1.png" alt="Distribution of R7 values in the ANO data set" width="672" />
<p class="caption">(\#fig:ano-alien-dist-R7)Distribution of R7 values in the ANO data set</p>
</div>



##### Combine Naturtype data and ANO {#combine-nt-ano2}

We need to combine the nature type data set with the ANO data set. I
will add a column `origin` to show where the data comes from. I will
also add a column with the main ecosystem.


```r
ano$origin <- "ANO"
naturetypes$origin <- "Nature type mapping"
ano$hovedøkosystem <- ano$hovedoekosystem_punkt
ano$kartleggingsår <- ano$aar
```

Fix class


```r
naturetypes$kartleggingsår <- as.numeric(naturetypes$kartleggingsår)
naturetypes$area <- units::drop_units(naturetypes$area)
```

I use `dplyr::select` to reduce the number of columns to keep things a
bit more tidy.


```r
alien_data <- dplyr::bind_rows(select(ano,
                                  GlobalID,
                                  origin,
                                  kartleggingsår,
                                  hovedøkosystem,
                                  area,
                                  var_7FA,
                                  SHAPE), 
                           select(naturetypes,
                                  identifikasjon_lokalId,
                                  origin,
                                  hovedøkosystem,
                                  kartleggingsår,
                                  area,
                                  var_7FA = NiN_variable_value,
                                  SHAPE))
```

###### Points to polygons {#ANO-points-to-poly2}

The ANO data is point data and the nature type data is *multipolygon*:

```r
unique(st_geometry_type(alien_data))
#> [1] POINT        MULTIPOLYGON
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON ... TRIANGLE
```

Because later we will rasterize these data, we will  convert the points to polygons. I
use the area column to calculate a radii that gives that area.


```r
alien_data_points <- alien_data %>%
  mutate(g_type = st_geometry_type(.)) %>%
  filter(g_type =="POINT") %>%
  st_buffer(sqrt(alien_data$area/pi))
```

Checking now that the new polygons have the area corresponding to the
proportion of the point that was part of the same main ecosystem:


```r
alien_data_points$area2 <- st_area(alien_data_points)
plot(alien_data_points$area, alien_data_points$area2,
     xlab = "Target area",
     ylab = "Area of the new polygons")
abline(0,1)
```

<div class="figure">
<img src="alien_species_files/figure-html/new-area2-1.png" alt="Checking that the area of the new polygons fall in line with the proportion of each point which is part of the main ecosystem." width="672" />
<p class="caption">(\#fig:new-area2)Checking that the area of the new polygons fall in line with the proportion of each point which is part of the main ecosystem.</p>
</div>

The area calculation seems to have worked fine. Checking that the new
data set contains **only polygons**.


```r
alien_data_polygons <- alien_data %>%
  mutate(g_type = st_geometry_type(.)) %>%
  filter(g_type !="POINT")

alien_data <- bind_rows(alien_data_points, alien_data_polygons)

unique(st_geometry_type(alien_data))
#> [1] POLYGON      MULTIPOLYGON
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON ... TRIANGLE
```

Ok.

#### Distribution of 7FA scores


```r
temp <- as.data.frame(table(alien_data$var_7FA))
ggplot(temp, aes(x = Var1,
                 y = Freq))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "7FA score",
       y = "Number of localities")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-28-1.png" alt="7FA (alien species) scores (ANO Naturetype (and GRUK) data combined)." width="672" />
<p class="caption">(\#fig:unnamed-chunk-28)7FA (alien species) scores (ANO Naturetype (and GRUK) data combined).</p>
</div>

Let's see the proportion of data points (not area) originating from each
data set


```r
temp <- as.data.frame(table(alien_data$origin))

ggplot(temp, aes(x = Var1,
                 y = Freq))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "Data origin",
       y = "Number of localities")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-29-1.png" alt="Barplot showing the contribution (number of localities) of different data sets to the alien species indicator." width="384" />
<p class="caption">(\#fig:unnamed-chunk-29)Barplot showing the contribution (number of localities) of different data sets to the alien species indicator.</p>
</div>

So the ANO data is not very important here, but it can become more
important in the future so good to have them included in the workflow.

#### Outline of Norway and regions

These layers are used to crop out marine areas, and to define
accounting areas, respectively.


```r
outline <- sf::read_sf("data/outlineOfNorway_EPSG25833.shp")
```


```r
regions <- sf::read_sf("data/regions.shp", options = "ENCODING=UTF8")
unique(regions$region)
#> [1] "Nord-Norge" "Midt-Norge" "Østlandet"  "Vestlandet"
#> [5] "Sørlandet"
```

Municipalities


```r
path1 <- ifelse(dir == "C:", 
               "R:/",
               "/data/R/")

path <- paste0(path1, "GeoSpatialData/AdministrativeUnits/Norway_AdministrativeUnits/Original/Norway_Municipalities/Basisdata_0000_Norge_25833_Kommuner_FGDB.gdb")

# find the correct layer
#st_layers(path)
muni <- sf::read_sf(path, options = "ENCODING=UTF8", layer = "kommune")
```




There are some multi-surfaces in here that I will convert to multi-polygons before plotting.


```r
muni <- st_cast(muni, "MULTIPOLYGON")
tm_shape(muni)+
  tm_polygons(col="kommunenummer")+
  tm_layout(legend.outside = T)
```

<div class="figure">
<img src="alien_species_files/figure-html/kommuner-1.png" alt="Municipalities in Norway." width="672" />
<p class="caption">(\#fig:kommuner)Municipalities in Norway.</p>
</div>

### Scaled indicator values {#scale-alien-ind}

I can scale the indicator for each polygon, or I can chose to aggregate
them first. If the scaled value is representative and precise at the
polygon level, then I could scale at that level. I think they are.

However, the combined surveyed area is a very small fraction of the
total area of Norway, so that only producing indicator values for the
mapped areas leaves the indicator without much value for regional
assessments. But we cannot simply do an area weighting of the polygons
in each region. This is because we expect considerable sampling bias
and we can't assume that the
polygons are representative far outside of the mapped area. But perhaps
we can assume them to be representative inside *homogeneous ecological
areas,* or *Homoegeneous Impact Areas* (HIAs). That's where the
infrastructure index comes in. Here's the plan:

1.  normalise the indicators at the polygon level.

2.  take a simplified infrastructure index (vector data) and intersect this with municipality borders to produce a map of homogeneous impact areas (HIAs).

1.  extract the corresponding indicator values that intersect with a
    given HIA, and extrapolate the area weighted mean of those values to
    the entire HIA. Errors are
    calculated from bootstrapping.

3.  Take the new area weighted indicator values for the HIAs, rasterize it, and mask these
    with ecosystem occurrences. The errors are the same as for the HIAs.

4.  calculate an indicator value for a region (accounting area) by doing
    a weighted average based of the relative area of ecosystem
    occurrences. Errors should be carried somehow, perhaps via weighted
    resampling.

#### Scaled variable {#scaled-alien-variable}

I will use the same reference levels/values for all of Norway:


```r
low <- 1
high <- 7
threshold <- 4
```



```r
eaTools::ea_normalise(data = alien_data,
                      vector = "var_7FA",
                      upper_reference_level = high,
                      lower_reference_level = low,
                      break_point = threshold,
                      plot=T,
                      reverse = T
                      )
#> Warning: Removed 6 rows containing missing values
#> (`geom_point()`).
```

<div class="figure">
<img src="alien_species_files/figure-html/alien-normalise-1.png" alt="Performing a linear break-point type normalisation of the alien species variable." width="384" />
<p class="caption">(\#fig:alien-normalise)Performing a linear break-point type normalisation of the alien species variable.</p>
</div>

There is no point yet making this a time series, and I will
assign all the indicator value to the average year of the data.


```r
mean(alien_data$kartleggingsår)
#> [1] 2020.12
```

Assigning the indicator to year 2020.


```r
alien_data$i_2020 <- eaTools::ea_normalise(data = alien_data,
                      vector = "var_7FA",
                      upper_reference_level = high,
                      lower_reference_level = low,
                      break_point = threshold,
                      reverse = T
                      )
```

### Homogeneous impact areas {#HIA-alien}

I want to use the [Homogeneous Impact Areas](#HIA) (HIA) to define
smaller regions into which I can extrapolate the indicator values. This
data is generated by discretizing the Norwegian Infrastructure Index. I
refer to the ordinal values of the four HIA classes as their *Human
Impact Factor* (HIF). This is just to keep the approach separate from
the Norwegian Infrastructure Index.


```r
HIA <- readRDS(paste0(pData, "infrastrukturindeks/homogeneous_impact_areas.rds"))
```

I want to check that HIF is in fact a good predictor for *alien species*.

I also want to split these four HIA classes based on municipality. To do
this I need the two layers to have the same CRS.


```r
st_crs(HIA) == st_crs(muni)
#> [1] TRUE
```

Then we get the intersections (unique combinations)


```r
HIA_muni <- eaTools::ea_homogeneous_area(HIA,
                             muni,
                             keep1 = "infrastructureIndex",
                             keep2 = "kommunenummer")
saveRDS(HIA_muni, "P:/41201785_okologisk_tilstand_2022_2023/data/cache/HIA_muni.rds")
```




Create a new column by crossing municipality number and HIF


```r
HIA_muni <- HIA_muni %>%
  mutate(muni_HIF = paste("ID", kommunenummer, infrastructureIndex, sep="_"))
```

Here is a view of the data zooming in on Trondheim


```r
myBB <- st_bbox(c(xmin=260520.12, xmax = 278587.56,
                ymin = 7032142.5, ymax = 7045245.27),
                crs = st_crs(HIA_muni))
```

Cropping the raster to the bbox


```r
HIA_trd <- sf::st_crop(HIA_muni, myBB)
#> Warning: attribute variables are assumed to be spatially
#> constant throughout all geometries
```

Get map of major roads, for context


```r
hw_utm <- readRDS("data/cache/highways_trondheim.rds")
```


```r
(HIA_trd <- tm_shape(HIA_trd)+
  tm_polygons(col = "infrastructureIndex",
    title="Infrastructure index\n(modified 4-step scale)",
    palette = "-viridis",
    style="cat")+
  tm_layout(legend.outside = T)+
  tm_shape(hw_utm)+
  tm_lines(col="red")+
  tm_shape(outline)+
  tm_borders(col = "black", lwd=2))
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-45-1.png" alt="A closer look at the HIA designation over Trondheim" width="672" />
<p class="caption">(\#fig:unnamed-chunk-45)A closer look at the HIA designation over Trondheim</p>
</div>

See Fig. \@ref(fig:HIF-region) for a closer look at the distribution of HIA classes across Norway.


#### Validate

I now have 1350 HIAs (for each main ecosystem) that I will, given
there is data, extrapolate indicator values over. But first I want to validate the assumption that the HIF 
explains a considerable portion of the variation in the indicator values.

I will subset the `alien_data` into the three ecosystems.


```r
#make geometries valid 
alien_data <- st_make_valid(alien_data)

#subset
wetlands <- alien_data[alien_data$hovedøkosystem == "våtmark",]
seminat <- alien_data[alien_data$hovedøkosystem == "semi-naturligMark",]
natOpen <- alien_data[alien_data$hovedøkosystem == "naturligÅpneOmråderUnderSkoggrensa",]
```

Creating some summary statistics.


```r
wetland_stats <- ea_spread(indicator_data = wetlands,
          indicator = i_2020,
          regions = HIA_muni,
          groups = muni_HIF,
          summarise = TRUE)

seminat_stats <- ea_spread(indicator_data = seminat,
          indicator = i_2020,
          regions = HIA_muni,
          groups = muni_HIF,
          summarise = TRUE)

natOpen_stats <- ea_spread(indicator_data = natOpen,
          indicator = i_2020,
          regions = HIA_muni,
          groups = muni_HIF,
          summarise = TRUE)

wetland_stats <- wetland_stats %>%
  add_column(eco = "wetland")

seminat_stats <- seminat_stats %>%
  add_column(eco = "semi-natural")

natOpen_stats <- natOpen_stats %>%
  add_column(eco = "Naturally-open")

all_stats <- rbind(wetland_stats,
                   seminat_stats,
                   natOpen_stats)
all_stats <- all_stats %>%
  separate(muni_HIF,
           into = c("tempLink", "municipalityNumber", "HIF"),
           sep = "_")

#saveRDS(all_stats, "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/all_stats_alienSpecies.rds")
saveRDS(all_stats, "P:/41201785_okologisk_tilstand_2022_2023/data/cache/all_stats_alienSpecies.rds")

```



We have data from 277 out of 363 municipalities. This figure shows how many municipalities we have at least one data point for, specific for each human impact factor level: 


```r
all_stats %>%
  group_by(HIF, eco) %>%
  summarise(n = n()) %>%
  ggplot()+
  geom_bar(aes(x = HIF, y = n), stat ="identity")+
  theme_bw()+
  ylab("Number of municipalities")+
  facet_wrap(.~eco)
#> `summarise()` has grouped output by 'HIF'. You can override
#> using the `.groups` argument.
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-49-1.png" alt="Number of municipalities we have at least one data point for, specific for each human impact factor level." width="672" />
<p class="caption">(\#fig:unnamed-chunk-49)Number of municipalities we have at least one data point for, specific for each human impact factor level.</p>
</div>

If we say that we need 20 data points for each HIA and municipality combination in order to extrapolate to the entire HIA for that municipality, we get much less to work with:


```r
all_stats %>%
  filter(n>20) %>%
  group_by(HIF, eco) %>%
  summarise(n = n()) %>%
  ggplot()+
  geom_bar(aes(x = HIF, y = n), stat ="identity")+
  theme_bw()+
  ylab("Number of municipalities")+
  facet_wrap(.~eco)
#> `summarise()` has grouped output by 'HIF'. You can override
#> using the `.groups` argument.
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-50-1.png" alt="Number of municipalities we have at least 20 data points for, specific for each human impact factor level." width="672" />
<p class="caption">(\#fig:unnamed-chunk-50)Number of municipalities we have at least 20 data points for, specific for each human impact factor level.</p>
</div>





```r
all_stats %>%
  filter(n > 20) %>%
  ggplot(aes(x = HIF, y = w_mean))+
  geom_point(size=2, position = position_dodge2(.1))+
  geom_violin(alpha=0)+
  theme_bw()+
  labs(x = "Human impact factor",
       y = "Indicator value (area weighted means)")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-51-1.png" alt="Indicator-pressure relationship across all ecosystems." width="672" />
<p class="caption">(\#fig:unnamed-chunk-51)Indicator-pressure relationship across all ecosystems.</p>
</div>

There is a trend here, but not very strong perhaps.

Here is a similar figure, looking at the relative frequency of indicator level of polygons and within each HIA.


```r
corrCheck <- st_intersection(alien_data, HIA)
saveRDS(corrCheck, paste0(pData, "cache/corrCheck_alienSpecies.rds")
```


 


```r
ggplot(corrCheck, aes(x = factor(infrastructureIndex), fill = factor(round(i_2020,2))))+
  geom_bar(position="fill")+
  theme_bw(base_size = 12)+
  guides(fill = guide_legend("Alien species indicator"))+
  ylab("Fraction of data points")+
  xlab("HIF")+
  scale_fill_brewer(palette = "RdYlGn")+
  facet_wrap(.~hovedøkosystem)
```

<div class="figure">
<img src="alien_species_files/figure-html/alien-precentageplot-1.png" alt="Relative frequency plot showing the distribution of polygons with different indicator values." width="768" />
<p class="caption">(\#fig:alien-precentageplot)Relative frequency plot showing the distribution of polygons with different indicator values.</p>
</div>

The figure above I think supports the indicator-pressure relationship
and justifies using the HIA x municipality intersections as local reference
areas.

Let us look at the effect of sample size on the indicator uncertainty.


```r
all_stats %>%
  filter(n > 5) %>%
  ggplot(aes(x = n, y = sd))+
  geom_point(size=2, position = position_dodge2(.1))+
  theme_bw()+
    facet_wrap(.~eco, scales="free")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-54-1.png" alt="Sample size against indicator uncertainty." width="672" />
<p class="caption">(\#fig:unnamed-chunk-54)Sample size against indicator uncertainty.</p>
</div>

This shows that the uncertainty is really inflated with sample sizes less than about 50-100.


```r
DT::datatable(all_stats) %>%
  formatRound(columns=3:8, digits=2)
```

<div class="figure">

```{=html}
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-31daaad760a10391b71e" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-31daaad760a10391b71e">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274","275","276","277","278","279","280","281","282","283","284","285","286","287","288","289","290","291","292","293","294","295","296","297","298","299","300","301","302","303","304","305","306","307","308","309","310","311","312","313","314","315","316","317","318","319","320","321","322","323","324","325","326","327","328","329","330","331","332","333","334","335","336","337","338","339","340","341","342","343","344","345","346","347","348","349","350","351","352","353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377","378","379","380","381","382","383","384","385","386","387","388","389","390","391","392","393","394","395","396","397","398","399","400","401","402","403","404","405","406","407","408","409","410","411","412","413","414","415","416","417","418","419","420","421","422","423","424","425","426","427","428","429","430","431","432","433","434","435","436","437","438","439","440","441","442","443","444","445","446","447","448","449","450","451","452","453","454","455","456","457","458","459","460","461","462","463","464","465","466","467","468","469","470","471","472","473","474","475","476","477","478","479","480","481","482","483","484","485","486","487","488","489","490","491","492","493","494","495","496","497","498","499","500","501","502","503","504","505","506","507","508","509","510","511","512","513","514","515","516","517","518","519","520","521","522","523","524","525","526","527","528","529","530","531","532","533","534","535","536","537","538","539","540","541","542","543","544","545","546","547","548","549","550","551","552","553","554","555","556","557","558","559","560","561","562","563","564","565","566","567","568","569","570","571","572","573","574","575","576","577","578","579","580","581","582","583","584","585","586","587","588","589","590","591","592","593","594","595","596","597","598","599","600","601","602","603","604","605","606","607","608","609","610","611","612","613","614","615","616","617","618","619","620","621","622","623","624","625","626","627","628","629","630","631","632","633","634","635","636","637","638","639","640","641","642","643","644","645","646","647","648","649","650","651","652","653","654","655","656","657","658","659","660","661","662","663","664","665","666","667","668","669","670","671","672","673","674","675","676","677","678","679","680","681","682","683","684","685","686","687","688","689","690","691","692","693","694","695","696","697","698","699","700","701","702","703","704","705","706","707","708","709","710","711","712","713","714","715","716","717","718","719","720","721","722","723","724","725","726","727","728","729","730","731","732","733","734","735","736","737","738","739","740","741","742","743","744","745","746","747","748","749","750","751","752","753","754","755","756","757","758","759","760","761","762","763","764","765","766","767","768","769","770","771","772","773","774","775","776","777","778","779","780","781","782","783","784","785","786","787","788","789","790","791","792","793","794","795","796","797","798","799","800","801","802","803","804","805","806","807","808","809","810","811","812","813","814","815","816","817","818","819","820","821","822","823","824","825","826","827","828","829","830","831","832","833","834","835","836","837","838","839","840","841","842","843","844","845","846","847","848","849","850","851","852","853","854","855","856","857","858","859","860","861","862","863","864","865","866","867","868","869","870","871","872","873","874","875","876","877","878","879","880","881","882","883","884","885","886","887","888","889","890","891","892","893","894","895","896","897","898","899","900","901","902","903","904","905","906","907","908","909","910","911","912","913","914","915","916","917","918","919","920","921","922","923","924","925","926","927","928","929","930","931","932","933","934","935","936","937","938","939","940","941","942","943","944","945","946","947","948","949","950","951","952","953","954","955","956","957","958","959","960","961","962","963","964","965","966","967","968","969","970","971","972","973","974","975","976","977","978","979","980","981","982","983","984","985","986","987","988","989","990","991","992","993","994","995","996","997","998","999","1000","1001","1002","1003","1004","1005","1006","1007","1008","1009","1010","1011","1012","1013","1014","1015","1016","1017","1018","1019","1020","1021","1022","1023","1024","1025","1026","1027","1028","1029","1030","1031","1032","1033","1034","1035","1036","1037","1038","1039","1040","1041","1042","1043","1044","1045","1046","1047","1048","1049","1050","1051","1052","1053","1054","1055","1056","1057","1058","1059","1060","1061","1062","1063","1064","1065","1066","1067","1068","1069","1070","1071","1072","1073","1074","1075","1076","1077","1078","1079","1080","1081","1082","1083","1084","1085","1086","1087","1088","1089","1090","1091","1092","1093","1094","1095","1096","1097","1098","1099","1100","1101","1102","1103","1104","1105","1106","1107","1108","1109","1110","1111","1112","1113","1114","1115","1116","1117","1118","1119","1120","1121","1122","1123","1124","1125","1126","1127","1128","1129","1130","1131","1132","1133","1134","1135","1136","1137","1138","1139","1140","1141","1142","1143","1144","1145","1146","1147","1148","1149","1150","1151","1152","1153","1154","1155","1156","1157","1158","1159","1160","1161","1162","1163","1164","1165","1166","1167","1168","1169","1170","1171","1172","1173","1174","1175","1176","1177","1178","1179","1180","1181","1182","1183","1184","1185","1186","1187","1188","1189","1190","1191","1192","1193","1194","1195","1196","1197","1198","1199","1200","1201","1202","1203","1204","1205","1206","1207","1208","1209","1210","1211","1212","1213","1214","1215","1216","1217","1218","1219","1220","1221","1222","1223","1224","1225","1226","1227","1228","1229","1230","1231","1232","1233","1234","1235","1236","1237","1238","1239","1240","1241","1242","1243","1244","1245","1246","1247","1248","1249","1250","1251","1252","1253","1254","1255","1256","1257","1258","1259","1260","1261","1262","1263","1264","1265","1266","1267","1268","1269","1270","1271","1272","1273","1274","1275","1276","1277","1278","1279","1280","1281","1282","1283","1284","1285","1286","1287","1288","1289","1290","1291","1292","1293","1294","1295","1296","1297","1298","1299","1300","1301","1302","1303","1304","1305","1306","1307","1308","1309","1310","1311","1312","1313","1314","1315","1316","1317","1318","1319","1320","1321","1322","1323","1324","1325","1326","1327","1328","1329","1330","1331","1332","1333","1334","1335","1336","1337","1338","1339","1340","1341","1342","1343","1344","1345","1346","1347","1348","1349","1350","1351","1352","1353","1354","1355","1356","1357","1358","1359","1360","1361","1362","1363","1364","1365","1366","1367","1368","1369","1370","1371","1372","1373","1374","1375","1376","1377","1378","1379","1380","1381","1382","1383","1384","1385","1386","1387","1388","1389","1390","1391","1392","1393","1394","1395","1396"],["ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID"],["0301","0301","1101","1101","1103","1103","1106","1108","1108","1111","1112","1114","1114","1119","1119","1119","1120","1121","1121","1121","1122","1122","1124","1130","1130","1133","1133","1146","1146","1149","1149","1149","1151","1160","1505","1506","1506","1507","1507","1511","1511","1511","1515","1525","1525","1531","1532","1532","1563","1566","1573","1573","1577","1579","1579","1804","1804","1804","1811","1816","1818","1818","1818","1820","1820","1824","1824","1827","1827","1827","1828","1833","1833","1833","1834","1836","1838","1838","1838","1840","1840","1841","1841","1841","1848","1848","1853","1860","1860","1865","1865","1867","1870","1875","1875","1875","3001","3001","3002","3002","3003","3004","3004","3005","3005","3005","3011","3011","3012","3013","3013","3014","3014","3015","3017","3017","3018","3018","3019","3020","3020","3021","3021","3024","3025","3025","3025","3028","3028","3030","3030","3030","3034","3036","3038","3038","3040","3040","3041","3041","3041","3042","3042","3043","3043","3043","3044","3044","3044","3047","3048","3049","3049","3049","3052","3053","3053","3053","3054","3054","3401","3407","3411","3411","3411","3412","3412","3413","3413","3415","3415","3420","3420","3421","3421","3422","3423","3424","3424","3425","3427","3430","3432","3432","3435","3438","3438","3440","3440","3441","3442","3443","3443","3446","3446","3446","3448","3448","3449","3450","3450","3451","3451","3452","3452","3452","3453","3453","3454","3801","3803","3804","3805","3805","3806","3807","3807","3807","3811","3811","3813","3813","3814","3815","3815","3817","3820","3820","3820","3822","3822","3823","3823","3825","3825","4201","4202","4202","4203","4203","4204","4204","4204","4205","4206","4206","4207","4207","4213","4213","4214","4215","4216","4216","4222","4225","4225","4225","4601","4601","4612","4612","4613","4613","4613","4614","4614","4616","4616","4621","4621","4622","4622","4622","4624","4626","4626","4627","4627","4635","4640","4640","4642","4642","4644","4644","4645","4645","4647","4647","4647","4648","4649","4649","4649","5001","5001","5001","5006","5006","5006","5006","5014","5014","5021","5021","5021","5022","5022","5025","5025","5027","5027","5027","5031","5031","5032","5032","5032","5034","5035","5036","5036","5037","5037","5038","5038","5041","5041","5042","5042","5042","5045","5045","5052","5053","5053","5054","5054","5055","5055","5056","5056","5056","5058","5058","5059","5059","5059","5060","5060","5061","5061","5401","5401","5401","5401","5402","5402","5403","5403","5403","5404","5406","5406","5411","5411","5411","5412","5412","5412","5412","5416","5416","5416","5418","5418","5418","5419","5419","5421","5421","5421","5422","5422","5422","5425","5425","5426","5428","5429","5430","5432","5432","5432","5434","5435","5436","5436","5436","5437","5438","5441","5444","0301","0301","1101","1101","1101","1101","1103","1103","1103","1103","1106","1106","1106","1106","1108","1108","1108","1108","1111","1111","1111","1112","1112","1112","1114","1114","1114","1119","1119","1120","1120","1121","1121","1121","1122","1122","1122","1124","1124","1130","1130","1130","1130","1133","1133","1133","1134","1134","1134","1145","1145","1145","1146","1146","1146","1149","1149","1149","1149","1151","1151","1151","1160","1160","1160","1160","1505","1505","1505","1506","1506","1507","1507","1507","1511","1511","1511","1515","1515","1515","1515","1525","1525","1525","1528","1528","1531","1531","1531","1531","1532","1532","1532","1532","1539","1539","1554","1563","1563","1563","1566","1566","1566","1573","1573","1573","1576","1576","1577","1577","1579","1579","1579","1579","1804","1804","1804","1816","1816","1818","1818","1818","1818","1820","1820","1820","1827","1827","1827","1833","1833","1833","1834","1836","1836","1838","1838","1838","1840","1841","1848","1848","1848","1856","1859","1860","1860","1860","1860","1865","1865","1865","1867","1870","1870","1870","1874","1874","1875","1875","1875","3001","3002","3002","3002","3003","3003","3003","3004","3004","3004","3004","3005","3005","3005","3006","3006","3007","3007","3007","3011","3011","3011","3012","3013","3013","3014","3014","3014","3015","3015","3016","3016","3017","3017","3017","3018","3018","3019","3019","3019","3020","3020","3020","3021","3021","3021","3022","3022","3023","3023","3023","3024","3024","3024","3025","3025","3028","3028","3030","3030","3030","3031","3031","3032","3033","3033","3033","3034","3036","3036","3037","3038","3038","3039","3039","3040","3040","3040","3041","3041","3041","3042","3042","3042","3043","3043","3043","3044","3044","3044","3044","3045","3045","3045","3045","3046","3046","3046","3047","3047","3047","3048","3048","3049","3049","3049","3051","3051","3052","3052","3052","3053","3053","3054","3054","3054","3401","3401","3401","3403","3403","3403","3405","3405","3407","3411","3411","3411","3412","3412","3412","3412","3413","3413","3413","3418","3420","3420","3420","3421","3424","3426","3427","3427","3428","3430","3432","3432","3435","3435","3436","3436","3438","3438","3439","3439","3439","3440","3440","3442","3442","3442","3443","3443","3443","3443","3446","3446","3446","3448","3448","3449","3450","3450","3450","3451","3451","3451","3451","3452","3452","3452","3452","3453","3453","3453","3453","3454","3801","3801","3802","3802","3802","3803","3803","3803","3804","3804","3805","3805","3805","3805","3806","3807","3807","3808","3811","3811","3813","3813","3813","3814","3814","3815","3815","3815","3817","3818","3818","3818","3819","3819","3819","3820","3820","3820","3822","3822","3825","3825","3825","4201","4201","4201","4202","4202","4202","4203","4203","4203","4204","4204","4204","4204","4205","4205","4205","4205","4206","4206","4206","4207","4207","4207","4212","4213","4213","4213","4214","4215","4215","4215","4216","4219","4220","4221","4222","4222","4222","4223","4225","4225","4225","4227","4227","4228","4601","4601","4601","4611","4611","4612","4612","4612","4613","4613","4613","4613","4614","4614","4614","4615","4616","4616","4616","4616","4617","4621","4621","4621","4621","4622","4622","4622","4622","4623","4623","4624","4624","4626","4626","4626","4626","4627","4627","4627","4628","4630","4630","4631","4635","4635","4635","4640","4640","4640","4641","4642","4642","4642","4644","4644","4644","4645","4647","4647","4647","4649","4649","4649","4650","5001","5001","5001","5006","5006","5006","5006","5007","5007","5014","5014","5014","5014","5020","5020","5021","5021","5021","5021","5022","5022","5022","5025","5025","5025","5026","5026","5026","5027","5027","5027","5028","5028","5028","5029","5031","5031","5031","5031","5032","5032","5032","5035","5035","5036","5036","5036","5037","5037","5037","5037","5038","5038","5038","5038","5042","5042","5043","5044","5045","5045","5047","5052","5052","5052","5053","5053","5053","5054","5054","5054","5054","5055","5055","5055","5056","5056","5056","5057","5057","5057","5057","5058","5058","5058","5058","5059","5059","5059","5059","5060","5060","5060","5061","5061","5061","5401","5401","5401","5401","5402","5402","5402","5402","5403","5403","5403","5406","5406","5411","5411","5411","5411","5412","5412","5412","5412","5418","5418","5418","5419","5419","5421","5421","5421","5422","5422","5422","5423","5423","5423","5425","5425","5426","5426","5426","5430","5432","5432","5432","5433","5434","5436","5436","5437","5437","5437","5440","5440","5441","5443","5443","0301","1101","1101","1101","1103","1103","1108","1108","1112","1120","1121","1121","1122","1122","1124","1130","1133","1146","1149","1149","1160","1506","1507","1507","1511","1532","1532","1532","1554","1563","1563","1573","1573","1577","1579","1579","1579","1804","1804","1816","1818","1818","1818","1818","1820","1820","1820","1824","1824","1827","1827","1827","1833","1833","1834","1838","1838","1838","1845","1848","1848","1848","1859","1860","1860","1860","1865","1865","1867","1870","1870","1874","1875","1875","1875","3001","3002","3002","3003","3003","3003","3004","3004","3004","3004","3005","3005","3005","3007","3007","3011","3011","3011","3013","3014","3014","3015","3015","3016","3016","3017","3017","3018","3019","3019","3019","3021","3021","3022","3022","3023","3024","3024","3024","3025","3025","3028","3028","3030","3030","3030","3034","3034","3036","3036","3038","3038","3040","3041","3041","3042","3042","3044","3044","3044","3048","3048","3049","3049","3053","3054","3401","3407","3407","3411","3411","3413","3413","3413","3414","3415","3415","3427","3427","3428","3432","3432","3436","3436","3436","3438","3438","3439","3439","3439","3440","3440","3442","3442","3442","3443","3443","3446","3446","3446","3447","3447","3451","3451","3451","3451","3452","3801","3801","3802","3803","3803","3804","3804","3805","3805","3805","3806","3806","3807","3811","3811","3813","3813","3814","3815","3815","3820","3820","3823","3825","3825","4202","4202","4203","4203","4203","4204","4204","4205","4205","4205","4206","4206","4207","4213","4215","4215","4219","4225","4225","4227","4612","4612","4613","4613","4613","4613","4614","4614","4616","4621","4621","4624","4624","4626","4627","4627","4640","4644","4645","4645","4647","4647","5001","5006","5006","5007","5007","5007","5014","5014","5014","5021","5021","5022","5022","5025","5025","5025","5027","5027","5028","5028","5028","5031","5031","5032","5035","5036","5036","5036","5037","5037","5037","5038","5038","5042","5047","5053","5053","5053","5054","5054","5055","5055","5056","5056","5057","5057","5057","5058","5058","5060","5060","5401","5401","5401","5402","5403","5403","5403","5403","5406","5406","5406","5412","5412","5418","5418","5418","5419","5421","5422","5425","5425","5425","5426","5426","5426","5428","5430","5432","5432","5432","5436","5436","5436","5437","5437","5437","5441","5443"],["2","3","1","2","1","2","2","1","2","1","0","0","1","0","1","2","2","0","1","2","1","2","2","1","2","1","2","1","2","1","2","3","1","2","1","1","2","1","2","0","1","2","1","1","2","1","2","3","0","1","1","2","2","1","2","0","1","2","0","2","0","1","2","1","2","0","1","0","1","2","0","0","1","2","1","2","0","1","2","0","1","0","1","2","1","2","2","1","2","1","2","0","0","0","1","2","0","1","1","2","2","2","3","1","2","3","2","3","1","1","2","1","2","2","1","2","1","2","2","1","2","2","3","1","1","2","3","1","2","1","2","3","1","1","2","3","1","2","0","1","2","1","2","0","1","2","1","2","3","2","1","1","2","3","1","1","2","3","1","2","1","2","1","2","3","1","2","1","2","0","1","1","2","0","1","1","1","0","1","1","0","0","1","2","0","0","1","0","1","1","2","1","2","1","2","3","1","2","1","1","2","1","2","1","2","3","1","2","0","2","2","2","1","2","2","1","2","3","2","3","1","2","2","0","1","2","0","1","2","0","1","0","1","0","1","2","0","1","1","2","1","2","3","2","1","2","1","2","1","2","1","2","0","1","2","1","2","3","2","3","1","2","1","2","3","1","2","1","2","0","2","0","1","2","2","1","2","2","3","2","1","2","1","2","0","1","0","1","0","1","2","0","0","1","2","1","2","3","0","1","2","3","1","2","0","1","2","1","2","1","2","0","1","2","0","1","0","1","2","0","2","1","2","1","2","0","2","0","1","0","1","2","1","2","1","1","2","1","2","0","1","0","1","2","0","1","0","1","2","1","2","1","2","0","1","2","3","1","2","0","1","2","1","0","2","0","1","2","0","1","2","3","0","1","2","0","1","2","1","2","0","1","2","0","1","2","1","2","2","0","0","0","0","1","2","1","0","0","1","2","1","0","0","0","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","0","1","2","0","1","2","1","2","2","3","0","1","2","0","1","2","2","3","0","1","2","3","0","1","2","0","1","2","0","1","2","0","1","2","0","1","2","3","0","1","2","0","1","2","3","1","2","3","1","2","1","2","3","0","1","2","0","1","2","3","0","1","2","1","2","0","1","2","3","0","1","2","3","1","2","2","0","1","2","0","1","2","0","1","2","0","1","1","2","0","1","2","3","0","1","2","1","2","0","1","2","3","1","2","3","0","1","2","1","2","3","1","0","2","0","1","2","2","2","0","1","2","1","0","0","1","2","3","0","1","2","0","1","2","3","0","1","0","1","2","2","1","2","3","1","2","3","0","1","2","3","1","2","3","1","2","1","2","3","1","2","3","1","1","2","1","2","3","1","2","1","2","1","2","3","1","2","1","2","3","1","2","3","1","2","3","2","3","1","2","3","1","2","3","2","3","1","2","1","2","3","2","3","2","1","2","3","2","1","2","2","2","3","1","2","0","1","2","0","1","2","0","1","2","0","1","2","0","1","2","3","0","1","2","3","0","1","2","1","2","3","1","2","1","2","3","1","2","0","1","2","1","2","1","2","3","1","2","3","0","1","2","1","2","2","1","2","3","0","1","2","3","1","2","3","2","0","1","2","1","2","3","0","2","1","2","1","2","0","1","2","3","2","3","1","2","3","2","3","1","2","3","0","1","2","3","1","2","3","1","2","1","0","1","2","0","1","2","3","0","1","2","3","0","1","2","3","0","2","3","1","2","3","1","2","3","2","3","0","1","2","3","2","1","2","0","2","3","0","1","3","1","2","0","1","2","2","0","1","2","0","1","2","0","1","2","0","1","0","1","2","0","1","2","1","2","3","1","2","3","0","1","2","3","0","1","2","3","1","2","3","0","1","2","1","0","1","2","1","1","2","3","1","2","1","2","0","1","2","3","1","2","3","1","2","2","1","2","3","0","1","0","1","2","0","1","2","3","1","2","3","2","0","1","2","3","2","0","1","2","3","0","1","2","3","1","2","2","3","0","1","2","3","1","2","3","2","1","2","2","0","1","2","1","2","3","2","0","1","2","1","2","3","1","0","1","2","0","1","2","1","1","2","3","0","1","2","3","1","2","0","1","2","3","1","2","0","1","2","3","0","1","2","1","2","3","1","2","3","0","1","2","1","2","3","2","0","1","2","3","1","2","3","1","2","1","2","3","0","1","2","3","0","1","2","3","1","2","1","1","1","2","2","0","1","2","1","2","3","0","1","2","3","0","1","2","0","1","2","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","0","1","2","0","1","2","3","0","1","2","3","0","1","2","1","2","0","1","2","3","0","1","2","3","0","1","2","1","2","0","1","2","0","1","2","0","1","2","1","2","0","1","2","0","0","1","2","1","1","1","2","0","1","2","1","2","2","1","2","2","1","2","3","2","3","1","2","0","2","0","2","1","2","2","1","1","2","2","3","0","2","1","2","0","1","2","3","2","1","2","1","2","1","1","2","3","1","2","1","0","1","2","3","1","2","3","0","1","0","1","2","1","2","1","0","1","2","1","0","1","2","0","1","2","3","1","2","0","0","1","0","0","1","2","1","2","3","1","2","3","0","1","2","3","1","2","3","1","2","1","2","3","2","1","2","1","2","1","2","2","3","1","1","2","3","2","3","2","3","2","1","2","3","2","3","1","2","1","2","3","2","3","1","2","2","3","1","0","1","1","2","1","2","3","1","2","1","3","2","2","2","2","3","1","2","1","2","3","2","1","2","2","3","1","1","2","1","2","3","2","3","1","2","3","0","2","1","2","3","1","2","1","2","3","1","2","0","1","2","3","2","2","3","2","2","3","2","3","1","2","3","2","3","2","2","3","1","3","2","0","1","1","2","1","0","1","0","2","1","2","3","2","3","1","2","3","1","2","2","2","1","2","2","2","3","2","1","2","0","1","2","3","1","2","2","0","1","2","3","2","2","3","1","0","0","1","1","2","3","2","3","1","2","3","0","1","2","1","2","1","2","1","2","3","2","3","1","2","3","2","3","2","2","1","2","3","0","2","3","2","3","0","2","1","2","3","1","2","1","2","1","2","0","1","2","0","3","1","2","0","1","2","2","0","1","2","3","0","1","2","2","3","0","1","2","2","2","2","0","1","2","0","1","2","0","0","0","1","2","0","1","2","0","1","2","2","1"],[8.45788881232147,1121.56798701587,21998.3368372462,4966.10625112667,12535.199082854,18733.8596693607,144954.035548262,8328.52682931985,40315.9588372372,1726.00844453073,249.885784125822,23239.0821114073,951.597239382863,172.683067543912,21529.7271186675,73383.9023033977,95451.5467759911,1474.32612633733,57424.7745352518,40894.2453990393,6762.67007158184,8499.10985391579,21523.6491584933,5600.05558455569,2504.48665126394,149.93147047576,3526.18649745357,29292.1897694222,21616.1888387721,15385.2801669971,44403.2490888898,21696.2154190395,3065.18153391953,101494.472727203,9276.5220614212,1493.50191575033,3791.88430245034,53096.5750724545,66312.2265450278,437.300122219342,190.153263234242,4890.75583866809,1494.97293324455,7588.73306937158,509.968310814314,3672.85083955334,36089.2871855995,46880.4868639024,199.908627301913,78938.8129182915,34336.2096474036,10975.7955914523,6349.65770187927,4453.14556305925,12525.861013484,118929.261811326,436263.285090117,341972.523622492,187.414338092902,3458.74723153378,4405.64256688394,2037.4817131692,13425.3371132007,36044.0839644022,330255.787587286,1924.12053775943,174.920048884989,53293.5074713544,349204.276032444,27861.6536240524,674.691617137025,10828.2325040277,185005.306574883,74964.4372082261,412.311543802469,437.300122218221,4844.62765850322,93867.0416514367,40909.5736856898,3405.94323760361,499.771568248281,5570.02679043263,31998.9548990181,35140.5718625085,52595.9605669281,38613.3293211994,731.303467925522,121.680431681802,33691.4885718982,6831.54814855242,10786.1177735248,664.696185770037,249.885784125087,42974.0110003861,164137.161610706,33811.3589808566,249.885784126629,249.885784126629,89043.8113058785,138263.038761915,57060.5158693464,14450.4334340806,6620.50231566286,8396.47201853333,18644.7008533694,20382.0819555703,87314.9722875328,5603.81930764351,7792.84694476309,2494.63172872279,5161.49941442825,1118.93935796537,45924.3088637366,913.094059308321,1914.51545286606,36294.284286454,48736.0445324426,128253.876925224,1224.82450463307,299.86294095093,636.43889332097,6868.12301510944,18309.2812905213,21313.2616651286,901.969097136454,33358.2224007132,18982.5768317584,4724.41469122088,152950.624413578,2887.58063331444,251242.11010263,165859.983127645,249.885784126629,9535.70968227758,20646.2659875521,620.270303232974,1399.36039110024,612.220171105051,2399.48039544839,4658.87068310237,46734.1479875847,4620.89992593896,69923.3636411775,174.920048883701,33762.8412674067,14591.3210342221,9286.55263407609,32449.4073295838,24751.1403686147,477.296260359464,2782.5883034599,8024.91930363752,13432.4771529281,2094.18767714846,2853.81182821353,26490.5906276878,27779.5904747754,2104.08943238994,51640.4817484439,86192.4345940302,3202.97609087281,4123.9245507911,16034.331212955,72943.8089134093,11926.7453173682,50499.1754202121,12868.9492987758,149.931470475683,7354.55240808457,26015.3840841856,13270.2461503148,18986.4369695679,6818.21180492076,449.794411430412,2863.10814264065,199.908627302619,499.771568253258,3148.56087998411,224.89720570873,612.220171098641,2833.70479198115,949.565979674851,24089.000544788,25747.8533793726,199.908627301913,1649.24617523064,674.691617134886,2948.65225270596,424.805833010294,3148.56087999522,1966.96421282797,13971.9771338951,76845.8648693447,8051.22482916804,304781.707868662,10835.9076104032,33932.0998215429,174784.05196141,1574.28043998757,6718.17880558709,2014.14962308918,149036.709377632,186860.455479736,11519.3453598346,41496.0406472092,1153.68142478936,496.698212967895,35762.5968265076,837.117376821872,43866.4078816652,2732.28515362076,36822.2973070599,65242.7200516699,120337.197549589,8693.8887877422,3307.20862838787,4.88599207311199,10345.6620372778,5191.78733406286,855.315717144986,19852.4053144594,3472.19121950422,31253.8286767856,21122.8012059911,26098.438573378,25948.4611042117,740.266223015169,46680.3013630088,239.437374459238,449.794411428677,199.908627303066,1824.16622411296,1499.3147047578,2019.0771357366,12027.3325298709,4949.17617725709,287.368651743363,22665.6511307498,33451.5286781733,34591.0867412336,10955.4946239969,14299.6106169777,1995.34251852172,3173.26907050455,15137.9957187837,61359.9415650205,2837.50450165707,41531.164685958,5396.181475483,12371.5754050143,1225.0281324906,6083.26645656403,349.840097778957,1087.00316094485,7445.17219650021,11886.0296785271,53449.8903932048,39960.9111103325,17638.9580411803,3384.54773392261,2799.26779511772,3135.76785322892,23428.4428611021,10709.5690232545,3309.37105867087,16144.5067624287,13731.489487195,9349.50258817171,6389.59551093336,1149.47460697343,765.880859783807,25360.2897502633,47311.0854439319,17632.3883181151,2200.92602207945,225.222894765786,26436.2113347197,9800.81427921127,1875.07732651689,2897.43209185491,699.680195547029,174.920048884276,74330.9997616809,20114.7011611911,577.236161333101,237.39149492003,1032.02828842703,1311.9003666624,1384.36724405823,349.840097773023,2284.48730783884,174.920048884057,212.402916504604,2149.01774347526,972.055700247494,85064.1788523152,120402.73363817,760.172437892994,240272.379345447,226540.161513802,70637.4393516175,8890.0945099855,9671.40573222173,22295.2047842261,1174.46318538641,2425.16407638593,8191.02514852426,289072.362731442,37801.6269425015,27466.3640931909,16854.6693732525,5524.72525373685,8378.84843414999,3386.94395833253,24.8335261811735,16642.0354008329,24885.3503951293,66130.5788926718,5591.98175572237,3238.51976228364,2424.5083989664,8296.99210546225,16846.2223837279,65613.0044153662,30627.0749591028,37786.3339923735,11040.7053094574,2761.23791459738,2124.02916508001,3203.53575250298,462.288700634497,249.885784124621,2232.43827190716,170.180840012908,1706.76249665012,3459.9890109156,16.414072699903,83652.1086837812,63311.9814862041,819.625371933413,11026.6383378237,21182.5348263159,17585.3117495656,10647.3013576486,4173.09259488244,687.185906352388,16025.5339068142,126725.688962945,78638.1037629302,3829.16576115384,5752.59275908847,70707.9932960964,13332.360131302,21644.3836765331,42244.3579900978,138545.383905014,8992.62104054802,58029.3057269611,109003.443492723,8671.03952431868,61694.2207044738,71216.5808754068,1199.45176382901,857.108239568042,1162.63728621154,96002.03803919,307463.690558715,57584.7080002485,44514.8459265488,1147123.3473319,646178.944607589,29396.2800455409,25687.4457182481,35263.2102429904,77515.4383830306,236325.284497039,918918.61157915,121771.196228044,178023.304928772,1974.44919899502,88956.080069855,1005448.13949056,378879.147967106,24279.911022199,407727.691579743,146876.155114528,7680.83557836423,9315.00871345591,1837.13738858101,112.448602860153,242.389210610156,5917.29536819119,71221.60035605,303993.460654251,18245.2265652954,674.691617131641,174.920048889646,524.760146668938,11956.7826670714,876.676344020321,4437.95877896715,269.876646851466,3320.98207110266,749.657352383249,4343.29476237877,45821.7357045416,6665620.67747257,14577711.8276352,6330912.44598352,47720.5256461292,169980.606424325,7373472.37204611,4155051.84613579,131062.902979892,959182.665410186,9521226.1351305,6399290.46122149,91679.2650075648,1358769.48649262,9911241.64653851,4193463.69213234,174115.404919237,1277059.88160858,1292459.48199075,235491.899728477,1110600.52905673,1053342.88087483,96485.6087921168,2187390.23979271,5712411.87677837,380231.376996544,1149911.78332697,1119128.99948893,116679.458855289,1083.98098906456,1016502.1770133,1386934.27581497,73887.8096874294,4961584.33759195,8896093.03531639,762059.879470727,643395.15447923,307219.234997003,1267219.27824386,7835321.77458016,1888669.6621365,96329.6541317192,4147788.54571734,1890249.90560461,568797.468705942,664125.49034589,3000398.30814032,1802156.85999014,193647.341320334,1267829.87894675,721974.824104012,6020672.78375599,12234327.1839853,2158483.4645673,704660.053292637,17561035.6741696,5935522.82247694,448761.519623721,66806.7340610636,553683.866014874,513671.447345153,12716846.9672667,10335445.9447836,779212.306783664,27471.6617013296,1920256.15240616,2041944.51098555,192177.616882382,290014.907496872,108382.745456654,3886439.62947867,2528824.87446439,74157.9982563316,434752.96228224,687470.851071273,184582.409449091,1735367.03899228,4398842.32651572,4030714.92910318,139246.394639618,57917.1832071345,92697.1064196452,52933.478427975,27671.2558442143,51940.1169360078,1258412.9899028,4092844.16463448,725906.299867282,224063.703216911,41585.435698683,470747.515027466,1649384.35435187,258898.255646612,89526.5659653818,80991.9251637009,3186.75438131602,3001.62522280336,190136.903175845,210414.198083503,491850.57917927,1618105.3631615,73971.4631656591,4255777.51337686,9909011.83305127,4255959.05656209,514.348469187971,357685.620798859,84994.1881075172,290726.838539963,874614.780444411,6137995.08139176,4567975.28792148,112958.400338533,2178854.72341971,9219287.38098144,6179714.39004498,1933.25082650507,13553.4727924272,193480.580590713,111710.093213457,1383180.58084545,150578.193764997,273695.023797445,1022367.09863523,2557.90636594745,484224.570488881,1743310.41914168,822397.164580637,81805.485324923,141481.25531785,300.753161109726,1744.20277319936,1336.88894507273,362.334386977935,343792.022146579,1908515.41722417,2780068.88958938,149.931470476207,20186.5089745994,532253.258295598,1987437.61002803,1572858.22084315,140149.971642327,114786.741538598,170111.723981069,3376732.9181575,5619733.45246359,195533.648926991,252731.47700326,1339372.41268892,2545258.93938131,1386.86610189819,518812.893759478,34961.0843739025,87662.4179271426,77036.5964440778,43397.8226582548,279664.335754149,470395.305685724,347889.069455441,83022.1111879634,69115.4746039971,431877.685832326,22441.7750268634,177465.85884737,1477617.18394996,112285.899054336,81539.310068629,151727.639885244,992215.804478369,198440.555362411,49655.9181402852,470324.081728884,9768.5671408308,1492.5058129367,43566.8312599001,1806.8034192028,77122.9917398905,4636.33838630437,132523.652685942,2258032.99832632,230611.965820564,109628.919128436,700.509004174732,15962.6380854648,273150.998760543,2133721.63401683,24942.6234419351,5497.17194499937,90165.3505651449,14767.1288965647,22536.1519638392,1247.79167432056,371221.251604849,73176.8599377598,51362.2519436714,124937.555719585,2373.85159111138,237666.256160936,2409.65936467171,13968.4199798215,130053.615859825,3818.34637325846,1678.02600936545,135275.238459627,16461.7753250087,16399.7686762083,2888.68682381909,27452.2278592897,41176.6444341001,2485.25556227895,85537.3056145901,82235.9295130214,6098.36738777888,387600.494456685,100029.707745471,16463.6629912601,637847.435618252,466.93016456249,315685.899745904,49488.2775128176,14035.7381379249,7990.40291797416,9467.50857283292,52269.8397177846,129577.542023852,1754.52956670994,180129.52958757,67435.2173850119,141746.911662022,843.849258871749,193654.68826732,51116.4002553631,1817.04006261058,691.170208979158,1584282.78897914,3554158.55595506,2087761.35549265,10343574.7511834,10833777.7230831,7559790.20926362,50553.4521349094,1677281.40414095,3181393.16622564,2266704.50040905,10018060.4296479,2580905.48029381,674890.111674081,5053573.95083129,4547868.21907569,329925.304406681,1427171.3857691,3775557.48404428,3381032.00147918,3479.14317831758,1075703.22501198,1925068.34420059,518793.162805177,37626.0545107629,66762.9760496939,3286.23470194163,12245.2799717293,42139.4596741094,1470.98255144424,143089.870442603,38412.5298012822,458402.219320266,323366.282828362,796.283500002801,124447.811639238,421626.52194777,398922.692676801,1540331.88134103,72518.7989082743,1244591.31901713,22052.209193195,42651.2285777954,50646.6082482002,2719.86484823644,21401.2852907605,185482.572029707,145933.814971803,1418.8403210431,57.7795235577458,26003.0606487696,1057280.39917138,3408510.84109089,15047.5001771364,37.4349428298301,125184.184100956,211134.62615601,27990.2572881143,15652.9194720779,623403.88379199,5612.83357467095,281.499522798171,2648.39079325902,174972.730350072,4585.83396979934,13734.4630695172,472.979296663776,1388.03409953485,249.885784126192,14978.1803833657,36868.6588022695,1984.59114381485,61448.2720130952,73525.0708363505,487.277279045971,3485.90668855452,50367.1314488508,2630.03291604109,531237.572880879,61576.1647536559,4104.14705488208,496844.109674428,6124.41770808412,487968.368204186,66719.1175546488,45795.4237383407,719739.17266014,52353.7909685475,2106.99062729534,182699.022290798,487177.534217617,10052.3692875472,246370.02102864,2994635.15707865,299694.282886793,51812.6780195596,539854.572502938,724.668773962192,340395.512941992,798362.360033604,965530.134221969,2695024.8902063,27657130.1259753,15940685.3285082,233428.663646085,155102.806280642,5518948.16386488,10704410.7489283,42334.7079071756,2319329.95566014,4912174.24742006,1631507.02092758,39937.8673043112,199.908627302833,254866.714995574,24643.6452917412,6362.7962000454,362415.165216752,9571.10132642767,47731.5035186709,669625.026792677,60896.567964182,35441.9075604664,106197.112084893,16854.1140508742,115767.994625498,341310.020240146,154828.125846776,36639.1110946186,5312.59716079166,28044.8840451005,79.0818742197589,504931.294464859,448049.846016044,3857.92533826962,12217.4946564562,3071.38862944732,26027.1439968823,79727.2261221818,257.40261436408,27601.5361274639,12558.9198112265,6702.78753181557,302813.98136643,172879.822528779,192697.325565692,3405705.66221812,3422034.7831475,87308.8400754136,3398252.22830231,5218793.85886001,596891.30255551,1070.52606300614,3413.70792413113,3252186.77441044,9853462.54839246,2674077.48594386,381.215104285511,20325.3747792675,48898.4251001798,33379.4641872296,62236.8897359671,11166.7300218802,49953.548990813,192416.185060223,15686.1482518701,268808.043471042,17159.1500968236,1196749.00837186,48329.2883983135,1438900.74377528,18662342.2587068,7324568.15111885,12991.5482854048,3170364.53072726,4074128.01761964,24943.7975096201,911746.928820074,5201176.71675433,2247413.84815503,2162.73924393537,7250.48305131379,19000.2358429074,190372.920525382,7417.60557192337,5838.06915783579,674291.165967759,46164.4080882745,340.129221616575,4276.7953813005,15058.816122998,2495.04113060399,10051.8348889617,247546.739227211,208400.406928074,1366.8407150826,12669858.4986304,7266922.47826327,6227.31567509542,43122.8811311862,15954.8480968075,9171.41295474034,5937507.5905575,5509090.36688328,348853.506013172,3741.86875432986,1365.91111907392,4389202.48884939,14915165.755318,8048362.33284712,3936784.49519107,14204013.4057505,7045680.70114454,395586.28781799,482227.715896818,1204637.09656959,124209.529827145,16605.3889864045,15215.2137530898,112931.4892058,249914.289113755,16197.114712936,83576.5574126576,101038.898966758,1150675.05286625,260429.766338366,77106.9998883451,39082.0547800002,34920.6578701931,304511.097445035,3646.50777122277,12676.4579676199,55286.092066299,107766.794208338,79681.6845545968,9507485.16160696,23593876.0657903,33169916.3915732,464623.769239816,1138870.39484063,5057992.25704,1557541.27386265,1131.08199025474,7780.56376423888,24106.1960206322,9458.43786169129,67684.9224158097,3583032.5294545,1171511.19560687,68044.163577075,932474.775110305,77288.2525033257,1743.73287806132,118643.230217134,2194749.25261418,1626847.1370732,991739.961127283,1563456.61647438,152366.968493736,4538.92513962105,3120.65881578577,69666.8986700557,80550.2538066632,734.664205328668,749.65735237628,997.044278662784,93366.4125906646,33903.7252033282,1542325.24265333,15149.3418199182,677676.844534376,427619.526216001,286781.42702157,1312.08075183025,3546.2743033111,85981.9899848136,17988159.232968,22277377.1986032,9975732.51877334,4999.58956097723,198770.850425525,379066.612494131,15272.7832620125,1626106.14778438,1998149.19283084,36109.4207085075,4185.36511068878,560002.979725116,1185867.52077212,4136931.81883829,5533073.56111008,453769.035755505,3574.36577301345,68.0165516829293,1196.66504248488,114067.061096883,11121.60311699,12916.1810889558,8707.10330752909,177483.172930941,2615.6813275586,35512.8463786096,12.9471966028214,83025.8267545875,162723.59187046,5173.4331398258,413639.312552477,87385.05518536,5250.40327055799,143640.270166476,346909.794614301,11875.4310591007,339367.228375616,36940.7355734119,137333.281947179,161537.016304499,539760.627396223,40054.9798240218,5513.22957362514,191378.120621053,1377080.48178934,12182.7087883322,26256.664590115,36125.8338850483,1870.6172515091,114903.497570939,26140.1693739627,19536.5202148184,15619.8469873294,828974.14464791,1775883.17295403,89240.966579625,66000.1036981221,502336.362851705,11841.9378976887,33344.9076324078,1144832.3100865,2359950.57919944,112853.284648709,33880.7422473014,390253.785557179,21794.3595540248,5267247.89471471,24015695.6463188,21801298.1873642,4244979.33064737,10974584.9959055,8166027.69096926,237864.469231099,10901.5808391804,1988001.014101,8273.0815986247,2412.51394057268,7191585.13714296,2745393.62269555,792714.366910579,53944.9780073174,688564.90257232,8157343.36541365,4106292.5167921,27577.9144761293,195647.721982162,28825.8897005167,3188373.92124282,4171351.2515627,2144059.05168208,366523.911497329,466907.63271456,3557375.1476525,5678864.19704448,524523.706233322,230623.770152436,2343794.96256227,1908195.43972676,640385.99984201,609722.479099276,5000668.30603638,10488004.0693549,3557392.04778264,105798.997781243,12134.2513644232,3527089.26675952,3124040.95875226,155265.085805202,14944.8703664656,1611334.76907044,1071660.04787096,107396.220994991,193542.346588343,24356.7073028303,419508.908694235,1131955.81322657,1162101.92951959,4478685.24197853,3427675.34556162,75546.8205940011,1568408.0733157,493938.460512866,136146.787348345,37327.7458135584,42123.6796519614,866495.635756252,855032.244222575,449.794411420036,1706656.1960916,5295286.95300786,1236840.00788185,15400.6918178262,149.931470476236,1359250.27326347,965946.753415339,76696.8946302252,82791.4711945415,8292.13030221523,22467.1344842125,9627.51821054332,13321.9348240085,4381.3028672114,36603.7923653742,5288.54846410023,2933.16475615872,38355.8855979131,15953.1576402331,2922.61277235205,1040.01695300206,12839.7295768245,10516.0647627247,1661.7404644391,29123.7321599086,137.437181268583,1051.38708178228,36305.682287487,6095.56635886531,34940.3422188128,10422.7274440894,187.414338093499,3185.35916079901,4138.02794633591,1051.52143823798,3347.57897803536,3596.09832433041,1422.91372517993,46670.4535979664,149.931470475771,771.130018946071,14049.2606725688,1216.19305541397,478.791918866802,4609.14132721828,13905.8810481057,60538.0209214434,336.002427691186,6983.91275320925,889.539924292318,69082.3308971239,33090.8256445682,97124.9626250232,198451.01880628,594.675569982268,13578.3711916714,6719.94608677598,226038.518565186,21170.3057438683,5969.91778792619,80610.3547779791,3503.30515729788,1186.95747459697,749.657352378053,5463.30998925259,15360.9758306905,24926.0381345299,30439.0095275907,116947.656801654,412.311543802469,19306.6954522022,8483.36640067911,42978.8492216096,6749.73025769717,129942.322192409,504523.426278913,264237.157852735,51275.4158952199,43364.5886798448,95201.5340659391,14237.180601656,13779.4210700917,34446.3475117081,149.931470475276,187.414338092174,199.908627301687,19560.8321336024,27617.7368834167,331650.605590119,117131.828746616,199.908627302626,71282.040036053,3238.58903783152,8990.07296032034,404424.431655493,33853.6441180987,5440.78474507015,59717.0111330957,52901.2135975217,8374.56941648738,2462.99918058398,18745.9665575865,7689.97380075196,212.914622938028,5588.40456224066,3127.18857436744,163564.058540645,3983.05544566716,6802.04506793106,50606.3329469923,810437.843181997,88593.5221981628,564159.610741788,68762.7854904835,37855.031916818,27597.9870730289,3957.38120312981,8725.76895152646,1308.02832644375,7585.37431232035,579.661720902659,4051.34481430298,2374.97966555547,420.924279827042,14272.354946919,3058.92301262224,199.90862730168,50997.2345831485,34962.4221947347,28434.3289753707,65481.5670243166,1416.46218663361,3436.19570856556,7087.78418272713,65481.3207306719,29042.1905689301,238168.28929826,5805.19063314435,1696.37366520695,441.455297822919,17051.9616196875,25917.6201659535,4346.559312718,466.171129787283,692.526664413774,668.975347592437,1471.18360969116,11781.113794011,15475.9625066814,7234.93266646493,583.070170589787,939.644237896782,871.459728685479,2083.38950105521,23297.1136414955,83515.8470651487,16119.5205965727,32845.6511013336,8458.94171030044,7712.81037258916,49982.9586583861,7245.81102027759,57671.1951639988,1866.52772288409,168481.828218892,43424.8101655729,119649.118547847,4554.02932829114,384.697602258544,378.183143048256,48180.3096102597,257.044117322774,26610.8960564546,37391.8967315125,20364.8241566103,170767.308320254,0.365004761697492,3216.65948941879,157035.140255134,1204.13579670899,249.885784127575,1222.96700806275,55422.4912528524,364930.17114027,48231.650488243,2993.19729026299,3063.07960868417,7388.6533080102,35917.8920568149,1421.39986223286,176.400198771036,105.596065215766,2878.90031445998,18797.5647025541,55836.0944878017,8265.96844004165,1195.7596760937,32909.4337277323,20515.7907085435,701.00411779838,5518.22799617637,26436.2898513158,1003.46279388969,4827.53832980065,6306.80866569787,81067.3082882224,138217.103662519,2326.63254812457,3242.39326788142,12447.2070381624,42641.7948737763,116939.836710848,13089.3279418776,617.438255866844,22894.7623436719,499.771568243297,249.885784125494,22314.7499653909,8402.92247831479,149.931470476065,124.942892063969,1373.27274284474,312.357230157551,4977.68755939498,4299.15325228727,35625.5551766977,1126.28403555718,24273.3776902331,11053.7668313358,1959.61605230946,31469.7975545889,418.45713423835,16002.3574079688,37415.921811265,2523.628604942,19904.9225097022,254.966522476461,863.436972526542,334.933011411922,38488.5636548683,11640.7415985136,25497.7761541106,495.431346936399,3685.84897097776,2745.33318067339,16597.6234089874,16848.70343334,2944.50124963206,1315.18613413043,413.345085018535,1004.76318004553,499.771568251828,687.18590633882,3628.08813889105,1500.29543034767,1161.75807170437,596.176966448664,1132.82190178493,1315.04306167673,399.817254603053,2049.06342982633,449.79441142107,499.771568251144,325.448157776642,2144.13756580063,119945.454194837,370.351592707215,6532.69847175421,217067.100758702,67920.5140313756,4799.86252455624,23821.1807700865,35510.0474835303,13657.5749968822,61221.0008878644,6399.57337163479,642.972961835127,181275.604098303,208289.877246265,8932.93618164156,11106.158699678,6018.82824266757,24870.1912561713,296625.299752607,65268.3893347934,13920.7613946192,9468.04945012963,34995.207148327,14093.9425332872,3036.2569459735,34509.2189701923,2589.56014753181,11548.1960120409,63088.6949719237,30171.4092010303,123572.611852526,6298.82978309802,249.885784125785,16697.0788216572,8428.58027367251,150734.353838736,30268.2541498619,9007.91851601185,8844.67626165912,9430.46054314909,4848.19753136998,11200.9715631037,15436.3083030645,1913.29030726454,34009.2885901355,73804.4066435191,499.771568253993,900.417995268246,12193.214996048,16056.560473027,10802.5005659412,19801.4523920475,34311.2001325819,949.807020269567,83730.7903469859,634061.025190638,720125.896063183,2854.64965175977,15999.9000363891,526345.83819153,449285.973231584,7666.89236764039,3680.27947081195,514.132268105895,78057.396232297,17494.3191826982,542.251892969478,27809.3752607167,96180.5252376554,79.6617838241755,50385.357818245,25236.6331090745,287.997289666208,44005.1172008275,76554.6600659534,612.220171112014,562.243014284846,189212.962291879,389408.523532036,50461.3247113924,1224.44034222679,112133.207208697,219021.333980528,63613.5030839739,45720.6768644729,6265.61424570068,24013.7914357843,26934.2018278148],[1,1,8,7,3,7,29,2,4,1,1,1,1,1,10,10,8,6,5,11,7,1,3,2,2,1,2,5,2,5,12,6,2,2,2,1,2,7,12,2,1,1,2,4,1,1,10,3,1,3,2,3,1,1,3,18,74,53,1,2,3,1,7,7,30,10,1,5,12,6,3,15,60,15,2,2,3,16,14,16,2,1,14,7,10,13,1,1,6,2,1,4,1,3,18,9,1,1,16,19,5,4,2,3,3,9,5,5,3,2,2,1,7,2,3,12,3,9,1,2,1,5,3,4,1,17,16,4,23,2,12,11,1,2,2,1,6,3,1,2,13,4,5,1,11,2,3,17,8,1,3,2,6,2,1,11,12,1,10,20,1,2,8,38,3,1,2,1,4,3,1,3,2,2,10,1,2,14,1,3,14,5,9,4,1,7,3,12,2,13,2,4,8,3,51,5,3,33,7,1,2,23,28,4,10,1,1,12,4,4,2,1,5,6,1,5,1,4,3,1,3,1,12,8,9,2,5,14,1,2,1,8,6,10,10,3,2,7,8,19,4,6,1,2,2,3,3,18,2,3,1,5,2,5,1,1,20,8,3,3,1,2,4,5,2,3,10,4,6,6,1,8,10,4,1,1,4,5,2,2,4,1,5,6,3,1,5,6,6,2,1,1,1,10,4,17,15,2,27,42,14,3,6,10,7,2,5,11,12,4,4,5,15,1,1,6,11,15,5,14,1,2,3,23,13,11,5,12,10,15,2,1,1,1,1,4,1,32,29,4,8,3,13,8,20,3,10,40,22,8,3,4,3,6,18,32,2,23,43,9,30,24,5,4,2,18,49,11,10,90,55,4,1,3,2,44,136,44,4,2,10,81,74,5,58,22,2,2,3,1,1,26,11,30,13,4,1,3,2,2,1,2,15,4,3,17,37,222,230,12,2,206,427,30,6,199,282,10,10,147,178,13,17,33,13,5,14,3,33,75,24,63,61,12,1,17,37,14,64,179,62,66,34,25,164,175,12,70,77,89,22,152,112,3,23,18,17,304,102,10,334,256,54,4,10,11,123,168,55,4,22,119,19,21,22,60,122,8,6,12,5,15,45,84,9,1,11,7,4,10,5,30,9,17,2,8,43,9,3,5,2,1,30,22,9,18,8,169,538,398,1,6,19,41,105,370,317,27,47,255,420,2,3,27,21,125,25,25,73,1,34,120,74,27,35,1,7,6,2,16,78,158,1,3,38,133,143,3,1,18,161,304,28,6,73,140,7,6,1,4,1,1,18,69,55,14,23,121,7,18,193,19,5,30,134,25,18,36,6,1,10,1,24,3,5,268,84,38,2,8,24,160,5,3,32,3,14,1,84,31,12,25,3,56,1,2,44,2,1,23,5,6,3,10,21,4,10,30,4,101,77,7,84,2,28,4,5,1,6,9,12,1,8,22,17,1,93,28,3,4,39,95,135,106,213,348,4,83,198,11,130,74,8,145,305,55,14,53,73,1,8,15,19,6,12,1,5,5,2,31,5,21,17,2,13,19,31,131,21,251,7,10,13,3,3,22,1,2,1,3,68,540,6,1,4,34,11,2,90,3,1,2,5,2,3,1,1,1,5,3,1,18,19,2,14,5,1,25,7,3,62,3,25,1,6,229,23,1,27,76,1,32,596,64,11,112,3,7,23,62,69,610,914,56,6,158,439,10,19,81,183,17,1,53,7,3,35,5,13,98,9,15,21,3,23,91,29,5,4,9,1,98,90,2,3,1,3,37,1,7,3,2,25,19,12,9,24,31,103,343,75,1,3,53,175,127,1,8,19,7,15,3,21,107,7,3,13,61,9,10,209,223,5,86,202,7,6,145,174,1,3,13,39,1,3,91,9,1,2,2,1,1,21,36,1,196,400,3,14,10,2,44,108,33,2,4,24,132,254,34,161,224,71,32,105,12,2,3,20,40,1,25,11,71,40,5,10,19,41,2,8,20,12,20,25,251,749,51,7,116,70,1,1,2,1,1,53,45,12,122,13,1,11,147,146,33,119,28,2,2,9,7,3,3,4,2,15,107,4,17,59,64,1,1,1,183,476,601,4,3,8,4,83,185,7,5,74,106,30,125,33,2,2,2,22,3,15,1,32,2,6,1,12,27,2,14,26,3,25,51,4,56,11,9,21,84,15,1,16,140,4,5,2,1,4,6,4,1,43,58,13,18,112,7,4,174,350,22,5,23,6,101,422,638,90,501,411,15,2,12,4,2,36,100,94,3,24,171,215,5,12,7,116,312,140,36,9,109,278,57,25,154,162,36,44,140,339,215,5,1,116,170,25,8,144,137,13,16,8,96,217,10,89,87,2,64,38,23,10,8,56,98,2,55,171,80,4,1,39,47,7,11,2,3,3,2,1,5,3,5,22,3,3,1,7,9,8,11,1,1,10,7,4,7,1,1,4,3,3,2,1,21,1,1,4,3,1,4,15,4,1,2,3,29,3,20,53,1,6,4,58,10,6,11,3,5,3,2,13,10,13,24,2,6,4,26,1,5,29,29,1,14,40,9,6,21,1,1,1,1,18,76,48,1,40,5,4,64,24,2,14,29,10,2,22,7,1,2,3,75,6,1,12,66,5,24,3,12,12,4,2,1,3,1,3,2,1,5,3,1,66,40,27,53,1,3,1,13,8,18,1,1,1,12,9,4,2,1,1,2,13,14,4,1,1,2,1,7,8,2,15,4,6,22,2,10,2,4,5,7,2,1,1,5,1,1,7,4,14,1,1,14,1,1,3,4,21,7,2,3,2,22,6,1,1,3,7,19,2,1,17,15,2,5,14,1,4,5,42,31,8,2,6,36,47,3,1,14,3,1,5,4,1,1,2,2,4,2,5,1,4,7,1,14,2,1,4,2,11,1,1,1,5,3,4,1,1,5,13,23,6,1,2,1,2,4,6,2,3,1,2,1,2,10,2,2,1,2,24,1,2,10,5,3,19,24,12,19,14,4,22,20,3,8,3,2,29,6,4,12,7,13,3,31,4,22,26,10,27,3,1,1,8,75,30,2,6,12,5,17,21,1,9,32,3,1,18,12,8,4,18,2,12,108,64,1,10,114,57,5,3,2,34,17,1,24,8,1,34,10,1,11,5,3,3,34,40,19,5,18,26,6,9,3,8,1],[1,1,0.935773663550797,1,0.906187456974532,0.907715695646236,0.863076150814004,1,1,1,1,1,1,0.8,0.947767970421567,0.90872882246474,0.982317523636584,1,1,1,1,1,0.89951546108483,1,1,1,1,0.961819783777992,1,0.935891654292222,0.909918317343478,1,1,1,1,1,0.966869897479631,0.884760844028775,0.876443443687564,1,1,1,1,1,1,1,0.988265869856557,0.949268280907193,1,1,0.90582162318354,1,1,0.8,0.956754071590768,1,0.999467097920969,0.992629461993136,1,1,1,1,0.982871209005747,0.885975947153517,0.810319190262861,1,1,0.942464389417649,0.940460485230663,0.984262646388697,1,1,1,1,1,1,1,0.989956246898785,0.951404543444993,1,1,1,1,0.857414121779547,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.986905370935217,1,1,0.983034504923364,0.974033705147727,0.848183214506831,0.807737005780433,1,1,0.897196163755476,0.762979385100639,0.8,0.859986348482678,1,1,0.969546341100203,0.864156694974991,0.844885775813352,1,1,1,0.978426071322355,0.968394054067835,1,1,0.963876969576388,0.98117331083628,1,0.96577967115827,1,0.958761827545313,0.8848189500553,1,1,0.8,0.8,1,1,1,1,0.968461620744441,0.908520556219331,1,1,0.9925831935774,1,1,1,0.936857211371644,1,0.8,1,0.920124690859413,1,1,0.890088280606333,0.834497799792865,1,0.982170416390335,0.91092449921041,1,0.8,0.848271631465243,0.841875363673308,0.926692204156487,0.8,0.8,1,0.7078230215371,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.733800033383166,0.760517285201032,0.890111557309282,0.877680872718085,0.812047867817972,0.706522255232888,0.970538519632785,0.869434621521205,1,1,0.932436113064679,0.943534589335214,0.967045344755203,0.89513338322168,0.860930994197531,0.8,0.8,0.831313596576551,1,1,1,1,1,0.925153036932996,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.993579905091012,1,1,1,1,0.980655682759646,0.899972774579571,1,0.981314848940703,1,1,1,1,1,1,1,1,1,0.957101275967232,0.901944612005574,0.889118458435014,1,1,0.629091499314293,0.954210024003457,1,0.935449594016073,0.890550742863998,1,1,1,1,1,1,1,1,0.4,0.727728747727896,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.765993521904403,1,1,1,1,1,0.930401021650233,0.927957118467575,1,1,1,1,1,1,1,1,1,1,1,0.977175204644714,1,1,1,1,1,0.814704670648962,0.964221530942569,1,0.996585864558651,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.97517082771434,1,1,1,0.999998942005625,0.996846977196396,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.987188579625285,0.9982737606598,1,1,1,1,0.953671856478438,0.998316609510785,1,0.998058034293412,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.717780063214485,0.753599173328355,0.76879966598279,0.719233926185253,0.612771092497577,0.406300713548405,0.851326913921544,0.811030459584181,0.858513222881179,0.955079187156762,0.642989740444373,0.600169410846951,0.723288493416581,0.60061132520799,0.999445211376125,0.877526091605853,0.868432784135517,0.805840843800071,0.919946891395757,0.79794790947336,0.999677487638764,0.852087696256383,0.892000814865346,0.99707339265107,0.913844564124372,0.891550102519013,0.965618766154006,0.838607947056503,0.817777357325363,0.751198346985796,1,1,0.883569048990442,0.886364668783473,0.929842938301165,0.909307348690011,0.907064728193315,0.736171103982255,0.728500878269834,0.977588501284602,0.882614894102046,0.860427995274449,0.788211423256092,0.963452150230135,0.955819610815132,0.955448557914201,1,0.997823042043916,0.975196013662098,0.840888725164222,0.787205346401402,0.82796226813945,0.900390115334822,0.916917704500485,0.870060825020311,0.567686419391201,0.678576254218182,0.708649147101955,0.528872653176287,0.919325150138802,0.998012812442741,0.998931039188549,0.954906014362397,0.933710272466652,0.945718317984389,0.861970915138196,0.79438132028265,0.783365165929354,0.695173541429355,0.980724667638327,0.627262398212192,0.812037859050609,0.763431829092442,0.481709932662178,0.872427367517974,0.864954273073505,0.726605789021077,0.717883861820106,0.743342795634799,0.734755346933253,0.391978575240324,1,0.822332024394802,0.946144071378667,0.959818097910184,0.824716251938536,0.819234493651037,0.74720885387804,0.793416234635864,0.836159239574937,0.847927527774574,0.579587471881201,0.614424510153477,0.516829423830169,1,1,1,1,0.897174904695242,0.885362396086245,0.95583250437998,0.904131399916831,0.991215551781788,0.880327996722271,0.779600995068121,0.687153635657245,1,1,0.99999792699058,0.989654361621752,0.903381927924023,0.792136632926177,0.708703556188926,0.826205017294842,0.762175371515409,0.856159795427598,0.870666339399767,0.927735128569415,1,0.899339667807758,0.863803677121438,0.885576456615606,0.673603701823542,0.740045397249157,0.849544095466074,1,0.725795415131247,0.721447379843461,0.757663278841715,0.963347646267853,0.998438903225323,1,1,1,1,0.773227069005558,0.855946219904634,0.816866745477511,1,0.822926569760414,0.993533836751573,0.976035931925049,0.939757071932498,1,1,0.876175471112954,0.895553432957224,0.923295738247924,0.960419566975,1,0.965558304568089,0.882991696833013,1,1,1,1,1,1,1,0.993966847012645,0.998270628458305,0.973524492504843,0.967324133839752,0.821360261648534,0.781935990464378,0.942427221841047,0.87443661509528,0.992461808306889,0.803747635695199,0.960449002413609,0.97802910726214,0.838917573023219,0.857316313063144,0.816971605359872,0.771114076547067,1,0.8,1,0.938884568982749,0.8,0.808235584682403,0.95314519805055,0.936419684530346,1,0.8,0.938214763574276,0.952575919676273,0.918018591028004,1,0.910137261972569,0.954000094775434,1,0.988674298434698,1,0.942675279961151,0.851921716675673,0.9705703554786,0.76317149013775,0.95549299581272,0.863669147027985,0.8,0.825981131269517,0.807000240230553,0.8,1,0.963948556567834,0.833775766268499,0.838851569250839,0.884613772531251,0.926487416551917,0.821976077166604,0.903020291316211,0.854652335023714,0.924088325149499,0.753033619621481,0.834267603924349,0.749253914982513,0.956012484698905,0.864986250800719,1,0.982772266169194,0.991881818053369,0.84623537606371,1,1,0.873462053405729,0.769035971481434,0.8,0.862143924777113,0.955164091861743,0.914755073303946,1,0.80647524903668,0.811538182746278,0.823948269563291,0.822167406223427,0.981086834046717,0.989476893927921,0.959152346454645,0.853324478964166,0.907122697430314,0.932727387021272,0.962326929457649,0.99292837748014,0.979425343789283,1,0.979345023954538,0.974926469886832,0.997974404973084,0.953464562998885,0.91224106512306,0.851437891989057,1,0.999618141694413,0.991372676279515,1,1,0.999164837712799,0.99778611913946,0.8,0.800227127716214,0.8,0.973950360000204,0.8,1,0.91388770586786,0.901009860550765,0.999360436151567,0.982858740874457,1,1,1,0.824083005081347,0.73677511826716,0.979410795762332,0.802288015998489,0.803199947848505,0.977215411603905,0.946633696514391,0.887109873045151,1,0.991874740771453,0.8,0.8,0.8,0.796114504130804,0.79501072664713,0.773405326223402,0.804470388262465,1,0.998238683837656,0.68311010883703,0.797225730915447,0.600365719966594,0.724486603759725,0.8,0.6,1,0.980883756741812,0.669920302251007,1,1,1,1,0.87954310474655,1,1,1,1,1,1,0.885504500278155,0.8,0.980916393822643,0.893706360164653,0.907579638572973,0.922522666367485,1,1,1,0.751864539531051,0.779163219534969,0.792265029147363,1,0.81116466781393,0.764383308530079,0.8,0.73391536657334,0.745791397865532,0.787215226218271,0.957602019062093,0.840138349919307,1,1,0.99015702379557,0.904347604983136,0.954585882683113,0.949854573938785,0.93309789668259,0.730836352979704,1,0.991481003799307,0.975834995346551,0.694690406016463,1,0.99856075232065,0.9734000315468,0.817613093264811,1,0.875136350402952,0.949656243088388,1,0.971637063936514,0.995025292536688,0.903343763421648,0.907674923918058,0.831035065260069,0.940725640250587,0.946363979439496,1,0.972698717708939,0.96712904661555,0.918847293012684,0.995791217867624,1,0.981350185258717,1,0.870614758740551,0.885239775105123,1,1,0.6,1,0.933192639107719,1,1,1,0.614912350000019,0.999116523547643,0.991773272606807,0.974546299987811,1,1,1,1,1,0.999272807602166,1,1,0.960755678313721,0.965657635180642,0.996530542468792,1,1,0.949157427905491,1,0.888212401990232,0.860076168337834,0.99979258915424,0.920303499148205,0.956411294576758,1,0.883128622223466,0.935697630605836,0.969420353011668,0.840405572068894,0.801421024926981,0.757000504500094,0.832670110259897,0.813287345397766,0.814090461029768,0.937907611402752,0.801921290738228,0.833806422952179,0.949405727553938,1,1,0.899432803632105,0.880663966004072,0.8,1,0.963067360818413,0.839070893255612,1,1,1,1,1,0.983668247340743,0.978053739643544,0.4,0.957082612713107,0.960855835721297,1,0.969779903032304,1,1,0.773176850135638,0.750610421443919,0.667465293379536,1,1,0.77055214218048,0.745371909161815,0.738009910554724,0.723502087387749,0.759328629997955,0.716721005660639,0.768138057467618,0.914309616902707,0.844605379231374,0.910074160005764,1,1,0.998706026021226,0.977949393651319,1,0.810586019763196,1,1,1,1,0.990777118742154,0.907661405385183,0.924283563349708,0.802376778447047,0.923123441104468,0.959175202912666,0.893157970233679,0.865328508679834,0.795885147687267,0.715635490166011,0.673852706068709,0.651488823073078,0.823596890939076,0.865597982949405,0.867999695501938,1,1,1,0.8,1,0.882054278159446,0.902740321204729,0.945014950253994,0.830303949204865,0.682188180430893,1,0.972794036291545,0.993761534096229,0.952524781812836,1,0.995723236161991,0.998865070416043,0.8,1,1,1,1,1,1,1,0.945519456750406,0.968991708161538,0.983279223200591,1,0.946209406195326,0.971832646175837,1,0.8,0.8,0.811580780875843,0.797003835969993,0.762341405464667,0.835131534109201,0.718724495065228,0.635355526460728,1,1,0.994367504140394,0.867288660688753,1,1,0.998823224282102,1,0.98925251877518,0.942279365977653,1,1,1,1,1,0.987301393548485,1,0.907569863587184,0.957215849738713,1,1,0.964271835336909,0.922058716047322,0.972791893935824,1,0.979771845599304,1,0.985967387189042,0.929623500135987,0.704413653163531,0.685355432485276,0.765484861223362,1,0.972581007179159,0.877540759784281,0.805383816224821,1,0.900429657864564,0.942659494507534,0.807595322186716,1,0.951545500341355,1,1,1,1,1,1,0.949193296788921,0.872533470186074,0.942177287106347,0.90653975813293,0.900588632658318,1,0.999673492951197,0.976201006910291,0.905196585681938,1,0.978321959956173,0.922338530661863,0.619796768458847,0.708027733380089,0.64294824249173,0.992910881949286,0.892943395150675,0.721460506213288,0.604969828129546,1,0.621612996958183,0.968057556199799,0.851159357987041,1,0.99709019531454,0.931836377290939,0.642808276672007,0.997589468179011,0.888086172996184,0.848159968935573,1,1,1,1,0.999236224735042,0.990559929600172,0.934902099904459,1,0.999831006963916,0.956361527567363,0.937180597336003,1,1,0.990497819450733,1,1,1,0.999967955847517,0.999730223705689,1,1,0.999370303486591,0.999187469463031,0.945624693091273,1,0.998134194041709,0.997433274578195,1,1,1,1,0.991991656583421,1,0.999893712871439,0.98472380800002,1,0.997799065818194,1,1,0.991560757136787,1,0.990581236614434,0.992460782186903,1,1,0.99202916253473,0.951096082526387,1,1,0.999032828760043,0.996855854689899,1,1,1,1,1,1,1,1,0.8,1,0.895612094308114,0.675240466813423,0.521844507764703,1,0.947658059305081,0.914643868137011,1,0.811215190651061,1,1,1,0.982760866472957,0.787841703177684,1,1,1,0.768612004965338,0.942255178576824,1,1,1,0.859385110851948,1,0.6,0.826045217142973,0.899728066266337,1,1,0.907122304466821,0.757961754104213,1,1,1,0.995736623469777,0.996723260410077,0.724747898643237,0.855772153399614,1,1,1,0.99420514545246,1,0.971073512015012,0.95114051611194,1,1,1,0.429220094984342,0.960845934445873,0.968784175943589,1,1,1,0.891663921813107,1,1,1,1,0.923290049283539,0.90888934543599,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.856100421167993,0.756289669357808,1,0.904348908141983,0.978367898704716,0.810278977829949,0.966192027615381,0.966926761463547,0.815890032785801,0.899527145199847,0.859817131271432,0.876665824078479,1,0.878307988679491,0.851263936687003,0.714359079831151,0.87795659410484,1,0.979072753846401,0.986490150992682,0.912874294470064,0.880200794189725,0.975176728429603,0.882484098491815,0.893187365812278,0.900251908390425,1,1,0.314205594846504,0.8,0.855011914052342,0.757073780515289,1,0.921436925758047,0.601119709010339,null,0.725192655091247,0.60285144206461,0.768075360709093,0.834727005923154,1,1,1,0.966509549216694,0.96049574465784,0.915583176717937,1,1,1,0.846045905989088,0.903901814446921,1,1,1,1,1,1,0.975897174175287,0.918597486908848,0.8,1,1,1,0.8,0.811444773828911,1,0.762228787828232,0.881277927966706,0.807591456505822,0.78553391761401,0.6299791510475,0.818551919507277,0.8,0.975621528161225,0.920309563010098,0.989173563759584,1,1,1,1,1,1,0.994823944939747,0.843643806794469,0.982597851668994,0.8,1,0.893420644041838,1,1,1,0.8,0.597242937712226,0.647828187576804,1,0.850373928223307,0.810689921692326,0.791390472487766,0.650970746861535,1,1,1,0.978711541940635,0.994263197352541,0.8,0.8,0.860662468779487,0.971350818712468,0.8,0.58518994187239,0.825952627493571,1,0.982624758087703,0.964452310035452,0.886967891155788,0.815936612165912,0.805950634165789,0.471645480853546,1,0.781716033773957,0.846088514322909,0.967749137966979,0.8,0.86531735595281,1,1,1,1,1,1,1,1,0.824140017239156,1,0.928854815525128,1,0.714975147225964,0.633721418011845,1,0.651623519177386,1,0.8,0.8,1,0.953936310055445,1,1,1,0.822806538810044,1,1,1,1,0.894626684151005,0.854065231221476,0.676873024875371,0.608367643562345,0.8,0.620759950099558,1,1,1,0.947468979101917,0.896030572854864,0.869258124202943,1,0.845142455966606,1,1,1,1,1,1,0.787258984168541,0.905743535786601,1,1,0.564504505543421,0.925470836306679,1,1,0.985271469843742,1,1,1,1,1,1,1,0.897995043801067,0.80962340997954,0.604890675531981,0.662609160436057,0.717993279343916,1,0.946006965992368,0.977482719987871,0.983999939022105,0.847646258227694,0.954032698104637,1,1,0.911236743456355,1,0.818411543661632,1,1,1,0.966407357014844,0.968247059126121,0.997046479821302,1,0.531651066130462,1,0.97764979551321,1,1,1,1,0.987213095040408,1,1,0.995731784742966,0.991685579533762,1,1,0.97333550994253,1,1,0.990238714003879,1,1,1,0.985565546866992,0.98394090506742,1,1,1,1,0.995424010281209,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,0.971428571428571,1,0.933333333333333,0.971428571428571,0.917241379310345,1,1,1,1,1,1,0.8,0.96,0.94,0.95,1,1,1,1,1,0.933333333333333,1,1,1,1,0.96,1,0.96,0.9,1,1,1,1,1,0.9,0.885714285714286,0.916666666666667,1,1,1,1,1,1,1,0.96,0.933333333333333,1,1,0.9,1,1,0.8,0.933333333333333,1,0.997297297297297,0.988679245283019,1,1,1,1,0.971428571428571,0.828571428571429,0.824444444444444,1,1,0.96,0.933333333333333,0.933333333333333,1,1,1,1,1,1,1,0.9875,0.971428571428571,1,1,1,1,0.942857142857143,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,1,1,0.933333333333333,0.866666666666667,0.911111111111111,0.96,1,1,0.9,0.8,0.8,0.942857142857143,1,1,0.983333333333333,0.866666666666667,0.955555555555556,1,1,1,0.96,0.933333333333333,1,1,0.976470588235294,0.9875,1,0.982608695652174,1,0.95,0.963636363636364,1,1,0.8,0.8,1,1,1,1,0.969230769230769,0.95,1,1,0.981818181818182,1,1,1,0.975,1,0.8,1,0.966666666666667,1,1,0.909090909090909,0.866666666666667,1,0.96,0.91,1,0.8,0.825,0.852631578947368,0.866666666666667,0.8,0.8,1,0.75,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.7,0.8,0.8,0.866666666666667,0.87843137254902,0.72,0.933333333333333,0.872727272727273,1,1,0.9,0.921739130434783,0.942857142857143,0.9,0.82,0.8,0.8,0.833333333333333,1,1,1,1,1,0.966666666666667,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.989473684210526,1,1,1,1,0.9,0.933333333333333,1,0.959259259259259,1,1,1,1,1,1,1,1,1,0.95,0.933333333333333,0.8,1,1,0.8,0.92,1,0.933333333333333,0.88,1,1,1,1,1,1,1,1,0.4,0.8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.96,1,1,1,1,1,0.9,0.94,1,1,1,1,1,1,1,1,1,1,1,0.966666666666667,1,1,1,1,1,0.9,0.933333333333333,1,0.984615384615385,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.975,1,1,1,0.995,0.990909090909091,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.995454545454545,0.998529411764706,1,1,1,1,0.990123456790123,0.997297297297297,1,0.996551724137931,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.733333333333333,0.713725490196078,0.828828828828829,0.781981981981982,0.792463768115942,0.561111111111111,0.9,0.874433656957929,0.921779859484778,0.94,0.4,0.625125628140704,0.722222222222222,0.58,0.94,0.91156462585034,0.854307116104869,0.830769230769231,0.894117647058824,0.927272727272727,0.969230769230769,0.8,0.857142857142857,0.933333333333333,0.975757575757576,0.952,0.966666666666667,0.841269841269841,0.85792349726776,0.8,1,1,0.940540540540541,0.928571428571429,0.89375,0.920297951582868,0.919354838709677,0.735353535353535,0.745098039215686,0.976,0.945121951219512,0.925714285714286,0.85,0.991428571428571,0.979220779220779,0.964044943820225,1,0.996052631578947,0.992857142857143,0.866666666666667,0.826086956521739,0.944444444444444,0.631372549019608,0.933333333333333,0.879738562091503,0.56,0.631736526946108,0.73984375,0.624691358024691,0.95,0.98,0.981818181818182,0.978861788617886,0.966666666666667,0.952727272727273,0.95,0.9,0.833613445378151,0.726315789473684,0.914285714285714,0.693939393939394,0.87,0.798907103825137,0.725,0.9,0.9,0.72,0.893333333333333,0.857777777777778,0.803968253968254,0.466666666666667,1,0.927272727272727,0.942857142857143,0.95,0.88,0.88,0.906666666666667,0.733333333333333,0.847058823529412,0.9,0.525,0.730232558139535,0.659259259259259,1,1,1,1,0.88,0.9,0.977777777777778,0.933333333333333,0.975,0.938461538461538,0.812515489467162,0.725628140703518,1,1,0.989473684210526,0.980487804878049,0.926984126984127,0.843783783783784,0.806098843322818,0.814814814814815,0.965957446808511,0.956862745098039,0.931587301587302,0.9,1,0.866666666666667,0.942857142857143,0.878933333333333,0.757333333333333,0.722666666666667,0.842009132420091,1,0.73921568627451,0.779444444444444,0.838738738738739,0.985185185185185,0.994285714285714,1,1,1,1,0.8625,0.892307692307692,0.871308016877637,1,0.8,0.989473684210526,0.984962406015038,0.979020979020979,1,1,0.874074074074074,0.915113871635611,0.957894736842105,0.971428571428571,1,0.972602739726027,0.958571428571429,1,1,1,1,1,1,1,0.988405797101449,0.989090909090909,0.928571428571429,0.939130434782609,0.871625344352617,0.8,0.955555555555556,0.875993091537133,0.957894736842105,0.92,0.933333333333333,0.952238805970149,0.821333333333333,0.855555555555556,0.827777777777778,0.8,1,0.8,1,0.925,0.8,0.84,0.936567164179104,0.917460317460317,1,0.8,0.875,0.925,0.9175,1,0.933333333333333,0.94375,1,0.985714285714286,1,0.914285714285714,0.87741935483871,0.983333333333333,0.864,0.866666666666667,0.889285714285714,0.8,0.9,0.872727272727273,0.8,1,0.921739130434783,0.84,0.833333333333333,0.866666666666667,0.96,0.838095238095238,0.85,0.96,0.884444444444444,0.566666666666667,0.863366336633663,0.702164502164502,0.942857142857143,0.878571428571429,1,0.957142857142857,0.95,0.84,1,1,0.755555555555556,0.727777777777778,0.8,0.875,0.945454545454545,0.847058823529412,1,0.789247311827957,0.75952380952381,0.933333333333333,0.9,0.994871794871795,0.955789473684211,0.918518518518519,0.973584905660377,0.971830985915493,0.967816091954023,0.95,0.973493975903614,0.963636363636364,1,0.956923076923077,0.97027027027027,0.975,0.976551724137931,0.952131147540984,0.905454545454546,1,0.992452830188679,0.961643835616438,1,1,0.96,0.968421052631579,0.8,0.8,0.8,0.92,0.8,1,0.909677419354839,0.8,0.990476190476191,0.964705882352941,1,1,1,0.864516129032258,0.755725190839695,0.923809523809524,0.825763612217795,0.828571428571429,0.94,0.861538461538462,0.933333333333333,1,0.990909090909091,0.8,0.8,0.8,0.666666666666667,0.762745098039216,0.764938271604938,0.833333333333333,1,0.95,0.723529411764706,0.781818181818182,0.7,0.73037037037037,0.8,0.6,1,0.84,0.7,1,1,1,1,0.88,1,1,1,1,1,1,0.92,0.8,0.96,0.885714285714286,0.933333333333333,0.93010752688172,1,1,1,0.766666666666667,0.796506550218341,0.843478260869565,1,0.82962962962963,0.810526315789474,0.8,0.775,0.765436241610738,0.7625,0.927272727272727,0.832142857142857,1,1,0.991304347826087,0.880645161290323,0.971014492753623,0.948196721311475,0.904157549234136,0.782142857142857,1,0.946835443037975,0.888838268792711,0.66,1,0.980246913580247,0.907468123861567,0.835294117647059,1,0.909433962264151,0.942857142857143,1,0.937142857142857,0.96,0.938461538461538,0.916326530612245,0.82962962962963,0.946666666666667,0.920634920634921,1,0.956521739130435,0.945054945054945,0.903448275862069,0.96,1,0.933333333333333,1,0.891836734693878,0.871111111111111,1,1,0.6,1,0.893693693693694,1,1,1,0.8,0.984,0.978947368421053,0.983333333333333,1,1,1,1,1,0.997333333333333,1,1,0.99622641509434,0.991238095238095,0.981102362204724,1,1,0.915789473684211,1,0.804444444444444,0.711111111111111,0.990476190476191,0.917757009345794,0.942857142857143,1,0.876923076923077,0.930054644808743,0.911111111111111,0.9,0.851993620414673,0.802092675635277,0.84,0.811627906976744,0.866666666666667,0.942857142857143,0.933333333333333,0.952183908045977,0.953639846743295,1,1,0.938461538461538,0.948717948717949,0.8,1,0.949450549450549,0.911111111111111,1,1,1,1,1,0.971428571428571,0.972222222222222,0.4,0.971428571428571,0.969,1,0.985714285714286,1,1,0.813636363636364,0.846296296296296,0.721212121212121,1,1,0.733333333333333,0.778282828282828,0.816010498687664,0.809803921568627,0.839337474120083,0.798511904761905,0.842253521126761,0.95,0.902857142857143,0.9,1,1,0.99,0.975,1,0.848,1,1,1,1,0.98,0.957894736842105,0.985365853658537,0.9,0.925,0.95,0.8,0.85,0.72,0.612749003984064,0.658566978193146,0.709803921568627,0.914285714285714,0.898850574712644,0.897142857142857,1,1,1,0.8,1,0.950943396226415,0.955555555555556,0.966666666666667,0.895081967213115,0.784615384615385,1,0.963636363636364,0.989115646258503,0.968493150684931,1,0.99327731092437,0.992857142857143,0.8,1,1,1,1,1,1,1,0.973333333333333,0.953271028037383,0.9,1,0.979661016949153,0.959375,1,0.8,0.8,0.861930783242259,0.794117647058824,0.756738768718802,0.85,0.733333333333333,0.7,1,1,0.991351351351351,0.942857142857143,1,1,0.99811320754717,1,0.9872,0.945454545454545,1,1,1,1,1,0.96,1,0.94375,0.9,1,1,0.95,0.91358024691358,0.9,1,0.969230769230769,1,0.992,0.945098039215686,0.666666666666667,0.798809523809524,0.76969696969697,1,0.971428571428571,0.896825396825397,0.8,1,0.95,0.951428571428571,0.8,1,0.9,1,1,1,1,1,1,0.982758620689655,0.907692307692308,0.955555555555556,0.933928571428571,0.828571428571429,1,0.997701149425287,0.990666666666667,0.981818181818182,1,0.965217391304348,0.933333333333333,0.944554455445545,0.893364928909953,0.799059561128527,0.972592592592593,0.92228875582169,0.800973236009732,0.648888888888889,1,0.95,0.95,0.9,1,0.996,0.98936170212766,0.666666666666667,0.991666666666667,0.916959064327485,0.856744186046512,1,1,1,1,0.998717948717949,0.984285714285714,0.961111111111111,1,0.998165137614679,0.99136690647482,0.964912280701754,1,1,0.995061728395062,1,1,1,0.999410029498525,0.99906976744186,1,1,0.996551724137931,0.997647058823529,0.96,1,0.990277777777778,0.995620437956204,1,1,1,1,0.995391705069124,1,0.995505617977528,0.977011494252874,1,0.996875,1,1,0.98,1,0.996428571428571,0.989795918367347,1,1,0.989473684210526,0.9725,1,1,0.994871794871795,0.987234042553191,1,1,1,1,1,1,1,1,0.8,1,0.872727272727273,0.8,0.733333333333333,1,0.914285714285714,0.955555555555556,1,0.836363636363636,1,1,1,0.971428571428571,0.75,1,1,1,0.75,0.933333333333333,1,1,1,0.904761904761905,1,0.6,0.9,0.866666666666667,1,1,0.96,0.85,1,1,1,0.986206896551724,0.933333333333333,0.94,0.935849056603774,1,1,1,0.996551724137931,1,0.933333333333333,0.945454545454545,1,1,1,0.7,0.969230769230769,0.98,1,1,1,0.966666666666667,1,1,1,1,0.960919540229885,0.993103448275862,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.905,0.76,1,0.95625,0.958333333333333,0.9,0.928571428571429,0.937931034482759,0.86,0.9,0.884848484848485,0.838095238095238,1,0.9,0.866666666666667,0.901333333333333,0.9,1,0.966666666666667,0.96969696969697,0.92,0.916666666666667,0.866666666666667,0.883333333333333,0.783333333333333,0.85,1,1,0.511111111111111,0.8,0.866666666666667,0.7,1,0.84,0.622222222222222,null,0.734343434343434,0.585,0.827160493827161,0.732075471698113,1,1,1,0.969230769230769,0.925,0.922222222222222,1,1,1,0.866666666666667,0.888888888888889,1,1,1,1,1,1,0.985714285714286,0.9,0.8,1,1,1,0.8,0.95,1,0.893333333333333,0.9,0.833333333333333,0.790909090909091,0.7,0.76,0.8,0.95,0.92,0.971428571428571,1,1,1,1,1,1,0.971428571428571,0.9,0.971428571428571,0.8,1,0.823809523809524,1,1,1,0.8,0.761904761904762,0.638095238095238,1,0.866666666666667,0.9,0.790909090909091,0.633333333333333,1,1,1,0.971428571428571,0.957894736842105,0.8,0.8,0.929411764705882,0.973333333333333,0.8,0.72,0.871428571428571,1,0.95,0.96,0.880952380952381,0.864516129032258,0.85,0.6,1,0.809259259259259,0.818439716312057,0.866666666666667,0.8,0.928571428571429,1,1,1,1,1,1,1,1,0.9,1,0.96,1,0.75,0.838095238095238,1,0.752380952380952,1,0.8,0.8,1,0.927272727272727,1,1,1,0.84,1,1,1,1,0.88,0.892307692307692,0.707246376811594,0.6,0.8,0.7,1,1,1,0.966666666666667,0.7,0.933333333333333,1,0.9,1,1,1,1,1,1,0.7,0.966666666666667,1,1,0.753333333333333,0.88,1,1,0.975,1,1,1,1,1,1,1,0.925,0.866666666666667,0.6,0.740229885057471,0.833333333333333,1,0.933333333333333,0.971428571428571,0.984615384615385,0.866666666666667,0.974193548387097,1,1,0.969230769230769,1,0.874074074074074,1,1,1,0.95,0.981333333333333,0.993333333333333,1,0.811111111111111,1,0.96,1,1,1,1,0.9625,1,1,0.976470588235294,0.983333333333333,1,1,0.977777777777778,1,1,0.998148148148148,1,1,1,0.996491228070175,0.992982456140351,1,1,1,1,0.988235294117647,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[0,0,0.0266954024011995,0,0.0550020879069019,0.02694534776268,0.0229977728033692,0,0,0,0,0,0,0,0.0245497268638388,0.0299018815883302,0.0317001956208854,0,0,0,0,0,0.0541740543202632,0,0,0,0,0.0355381113363858,0,0.0363265359925388,0.0364810724407082,0,0,0,0,0,0.0709808303577683,0.0362935604295183,0.0530449640649996,0,0,0,0,0,0,0,0.0251588029398333,0.0530253033362848,0,0,0.0719269315589333,0,0,0,0.0529666658372238,0,0.00263963285302694,0.00612444582892198,0,0,0,0,0.0262615548111271,0.0883867242823032,0.0379073219693247,0,0,0.0351855598736701,0.0361197571846947,0.0625046856212676,0,0,0,0,0,0,0,0.0124151209812462,0.0183371577239825,0,0,0,0,0.0332143983459278,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0366663718251864,0,0,0.05527299515027,0.0533983171004297,0.0319792750395744,0.0370628554654826,0,0,0.0702490208111467,0.13869115052964,0,0.0345135667285945,0,0,0.016423306694468,0.0548788009517793,0.0271724182881146,0,0,0,0.0359465959133512,0.0540187850682646,0,0,0.0155443143545715,0.0118380536624276,0,0.0116975547623766,0,0.0244919685446037,0.0239327684463097,0,0,0,0,0,0,0,0,0.0204014939326142,0.0442356959569621,0,0,0.0176880725131809,0,0,0,0.0231177838888578,0,0,0,0.0296698738204872,0,0,0.0308483555887527,0.0272113162767127,0,0.0257283568917323,0.0265723858863236,0,0,0.0228279541459696,0.0139748827261163,0.05437745874101,0,0,0,0.0431699101358937,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0700118680058007,0.0695625542152453,0.0362359962250581,0.0529307461321709,0.020429913848129,0.0429726080782287,0.0550816221275964,0.0163628825060116,0,0,0.0695242664371486,0.0203506280272768,0.0198747893611507,0.0503703998115676,0.0347164345927232,0,0,0.0222082976894683,0,0,0,0,0,0.029959357781405,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0100194050282329,0,0,0,0,0.0681791639608348,0.0546842179886516,0,0.0400678140566227,0,0,0,0,0,0,0,0,0,0.0479027365833328,0.0546645669657065,0.0949011509449326,0,0,0.0997730658277306,0.0712223154511156,0,0.0541037120362415,0.0575214317895088,0,0,0,0,0,0,0,0,0,0.120153711613143,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,null,0,0.0371319967842451,0,0,0,0,0,0.0411754629856838,0.0300019285332746,0,0,0,0,0,0,0,0,0,0,0,0.0306584399462846,0,0,0,0,0,0.0700167290177308,0.053619353176209,0,0.0148275522595657,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0229363347213641,0,0,0,0.00509905632204386,0.00880793084449826,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.00460731183703534,0.00145490369868734,0,0,0,0,0.00471509435267164,0.00282050442969574,0,0.00342570362327477,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0551274798901513,0.0489115346372767,0.0352294705227637,0.0164330268923732,0.016479456996384,0.069737154215565,0.0688469309403106,0.0127452926689123,0.00581607782717257,0.0240510995324965,0.117784618277271,0.0203072307051748,0.0129714725970048,0.0516746540372538,0.0296391105952401,0.0128501875964162,0.0121381699798865,0.020578406354385,0.0390516335379853,0.0208480832802624,0.0203070996317844,0.0756016005253989,0.0482001353625416,0.0557508479391553,0.0114380719008619,0.0109772598387257,0.0185702811355285,0.022552968238377,0.022359350172579,0.0534243467671263,0,0,0.0148217899084959,0.0328397575229166,0.0187326830276235,0.0108344807551952,0.0183956605046801,0.0244378960731789,0.0331934123793542,0.0125935299657005,0.00751657635482856,0.00892429626348724,0.0488234501529787,0.00477987514377347,0.00696273719588281,0.0107897684455067,0,0.00226145627314217,0.00343071687664187,0.053106625264465,0.0287296700009207,0.0216377252528328,0.0780314516984464,0.00959143601325987,0.0201012441792854,0.0479722600857802,0.0141574095056263,0.0131402179387384,0.0330409403390595,0.0453477277977234,0.0189044909949932,0.0173520743115244,0.00563991652572612,0.00739310853060842,0.0123896409300645,0.0423796653601233,0.0274753597111853,0.0113643521698748,0.0306362117344197,0.0323224868451403,0.0424958336488654,0.0165892734283865,0.0177631633367687,0.076774959422942,0.0624899146573135,0.0369602407016791,0.0436555082824997,0.0377382469968798,0.0304147836422072,0.0247060040668638,0.0666136176351242,0,0.029890370702067,0.0350477309605957,0.0424131627726155,0.0425057777383398,0.0731291615860203,0.03284762649822,0.055245375894554,0.0399500989344024,0.0705328638641937,0.112525647727069,0.0444633884790071,0.0840262876431814,0,0,0,0,0.0319154259980791,0.0263283266481156,0.0209430053638727,0.0345266759276051,0.0235568312660956,0.00764663040258533,0.00823362394439552,0.0112223339916571,0,0,0.0105748787580628,0.00943838621239448,0.0141762840125354,0.0099603495582981,0.011650704292552,0.0282938421166373,0.0124305821362819,0.00707790073133104,0.00590281092894986,0.0695977287261865,0,0.0204874074203293,0.0309606848468029,0.0175036958817454,0.0457340416357675,0.0411441318352127,0.0219716641442218,0,0.0388094795482723,0.0211646096395616,0.021328562183529,0.0144913791150381,0.00586194464730855,0,0,0,0,0.0391971161428225,0.0175583503159332,0.0143547864442218,0,0.0943951234345138,0.00701498293717651,0.00537774073399692,0.00681488371207268,0,0,0.0592517563744675,0.0122173884316591,0.00641769936212637,0.0226422029190292,0,0.0100801248059333,0.0082802408732797,0,0,0,0,0,0,0,0.00896561777385263,0.00618915165108624,0.0323359233433821,0.0285948329207003,0.0157762730417009,0.058632095481739,0.0197200309421943,0.00957687461829374,0.0227448935668858,0.0445459980912533,0.0194992352601656,0.0107855909997873,0.047617148441655,0.032041477586334,0.022832448476225,0.0687469799945385,0,0,0,0.0260500732177086,0,0.0984878746925806,0.00866054709888572,0.017849706166247,0,0,0.0684128666284371,0.0260579173519948,0.010775948441544,0,0.0545831209704305,0.015741245511323,0,0.0134672141013489,0,0.0135952389509015,0.0266414925250571,0.0150424361722797,0.0471233626013511,0.0540576441917536,0.0235840987043351,0,0.0696451034922085,0.0301256933363664,0,0,0.0322861563685973,0.105312051676094,0.0733063316686025,0.052704627669473,0.0244070831052321,0.0373855130786349,0.0433453148139025,0.024759026826784,0.0346629393773791,0.118736142791225,0.0161218140445359,0.0238561472463387,0.0552677031258286,0.019920161001509,0,0.018362206839805,0.0425940636034442,0.0673448270153374,0,0,0.061605500621638,0.0613178110178608,0,0.0606702584076848,0.0326149273424251,0.0449430205928964,0,0.0177521515375242,0.0354931105241782,0.0535223543969992,0.0499442882813633,0.00513327179700551,0.00874534298699876,0.00833663021738601,0.00642640423580022,0.00477230200035749,0.00392866455772983,0.0440096222074996,0.00750069991003858,0.00551282394759698,0,0.00733127924360103,0.00839759136443716,0.0236232524868626,0.00529657340525748,0.0054202274456601,0.0189848681482658,0,0.00523711198106781,0.0107691499067709,0,0,0.0394150624399752,0.0300231748974041,0,0.0348536192492942,0,0.0437504800488464,0,0,0.023504117872843,0.0935948203181693,0.00884323632382508,0.0196109660116932,0,0,0,0.0242545377407885,0.0117520331035497,0.0316959063732362,0.011078108505424,0.0265551384756528,0.0286882312911517,0.0447120583539283,0.054679336406268,0,0.00916810882945686,0,0,0,0.110233248826861,0.016709489709112,0.00563022167855701,0.0302659402340215,0,0.0439787634163539,0.0207583203289713,0.0173400463128491,0.0727488996645475,0.0140018541516381,0,0,0,0.0894873308484636,0.0698701784872619,0,0,0,0,0.0718525461510473,0,0,0,0,0,0,0.0431126094906942,0,0.0200872969684699,0.0363782524979668,0.0554212591015835,0.0198103968664376,0,0,0,0.030235865141818,0.0106858032080044,0.0302817495656627,0,0.0172949104867171,0.0117019097126756,0,0.0301553135730121,0.00596911993331987,0.0171028802946682,0.0280384748770114,0.00896378726516846,0,0,0.00853753178590329,0.0122832268668146,0.00832376901056062,0.0036159086559462,0.00376208788790448,0.0102848536420762,0,0.00881148100816629,0.00660560542501405,0.0691456196495246,0,0.00658567999268563,0.00960561750971892,0.0184313499982949,0,0.0169181642186232,0.0349484425766942,0,0.015707918057786,0.0348129047673178,0.025374059512632,0.0131686577457471,0.0934678563108504,0.039026697055773,0.0417215319007226,0,0.0245354144295632,0.0106202908757286,0.0272261118421487,0.0351880405563907,0,0.0609300621407239,0,0.0115456388914847,0.0178556693848644,0,0,0,0,0.0367329587459714,0,0,0,0.142493172834014,0.0109315343132811,0.0144806737245947,0.0154907038687981,0,0,0,0,0,0.00258120789355396,0,0,0.00378677506647822,0.00485961239698965,0.00843223583304815,0,0,0.0221029775462188,0,0.0753726122677381,0.242326402899751,0.00931422958631679,0.0115611973712881,0.0346073384118685,0,0.0630451403306004,0.0211566955443519,0.0332175276756959,0.0417421946094214,0.0144203386560279,0.0124475755865917,0.0345101572142311,0.0261127512796134,0.0113353495182414,0.0328396984263179,0.0382866858680561,0.0114755557664632,0.00893298526416169,0,0,0.0317774153078925,0.0193521581422444,0,0,0.0154513454939017,0.0320763557203745,0,0,0,0,0,0.0208945616167014,0.0117948755069321,0,0.00542889075032619,0.0041319308564644,0,0.0135747510364808,0,0,0.022605347262658,0.0140612306931652,0.0338726324323036,0,0,0.0426589369375443,0.0217064152351544,0.0125722796913798,0.0347811997221888,0.0128669617382457,0.0141470012597099,0.0226497839979799,0.0156263525440626,0.0135886091070056,0.028931356903906,0,0,0.0100580845624336,0.0122499729320859,0,0.0322569702254897,0,0,0,0,0.0191196747347323,0.0184522348919347,0.00806533214434847,0.0722080605196124,0.0349993207427294,0.0193750171946063,0.045579326179475,0.0392814323940832,0.0496097581899289,0.0171209094255439,0.00982188135879886,0.0258494644252018,0.039390714172974,0.0119493112123503,0.0145766947917372,0,0,0,0,0,0.0158596836176613,0.0123833573853267,0.0221288076627056,0.0131305545500973,0.0355457511314703,0,0.0232340371360352,0.00416589651401094,0.00640657728025448,0,0.00318636731064613,0.00748320762477824,0,0,0,0,0,0,0,0,0.0170424032981515,0.0109575843395,0.0872158621272908,0,0.0102918385299152,0.0136576532548579,0,0,0,0.011427803935346,0.00984526715060974,0.0090970399147747,0.0438324227174506,0.0546059380941469,0.0497987692359702,0,0,0.00353759378569431,0.0341512210284562,0,0,0.0018601390514319,0,0.00435567194794535,0.0192956529096869,0,0,0,0,0,0.0281499994122798,0,0.0157862227853857,0.0698311276322127,0,0,0.0358041508067538,0.0318345215524754,0.0733015901814082,0,0.018267594444314,0,0.00779310441842508,0.0148544609807271,0.119017966658394,0.0273453521490796,0.0673766137065196,0,0.0209083165730674,0.0183612893019785,0.0330782525689498,0,0.0366119212351186,0.00834425575801554,0.0711347851452273,0,0.0701714616780499,0,0,0,0,0,0,0.00745225115944299,0.0286685670867906,0.019719329054461,0.0106684179554555,0.0773982140928927,0,0.00227315381501406,0.00336531246882367,0.0120354287734437,0,0.0199469352099424,0.0384535767706379,0.0118191318190826,0.00952412613362352,0.00830914258060144,0.0125462953475547,0.00810800951537357,0.013525333963995,0.0618691731773698,0,0.033533396119719,0.0446217559168294,0.0703131847091564,0,0.00275455687608435,0.00634819643071613,0.0543513125534922,0.00803548464362307,0.0101890269079934,0.0109974263649858,0,0,0,0,0.000975389824818602,0.00569135970122413,0.0174363520281928,0,0.00184126496791394,0.00253804190424202,0.0123951948505431,0,0,0.00381703763404234,0,0,0,0.000603804313608001,0.00093856408190978,0,0,0.00238439708098471,0.00164066988758646,0.0161753435122021,0,0.00478641024094254,0.00257422412128143,0,0,0,0,0.00237799307273777,0,0.0042940141160823,0.0107547546009882,0,0.00311524848647864,0,0,0.0191491067229855,0,0.00360678728604441,0.00528215705455607,0,0,0.00401942025680057,0.00841043573063723,0,0,0.00482510497113716,0.00711139055550947,0,0,0,0,0,0,0,0,0,0,0.0381013923139503,0.0943042827351262,0.143884044194377,0,0.0360086538732845,0.0276978184060242,0,0.0231171473515923,0,0,0,0.0265828031052245,0.0426166185446027,0,0,0,0.0822812719135266,0.0544054731719762,0,0,0,0.0312411722054846,0,0,0.0513594956925961,0.0534815674399471,0,0,0.0204882283478628,0.0790820078397353,0,0,0,0.0101166745201135,0.0536759101045131,0.0271122236762806,0.0162456006585867,0,0,0,0.00353863018582872,0,0.0389553129276891,0.0268177291274677,0,0,0,0.214903917353067,0.0192643888771221,0.0188242915923536,0,0,0,0.0310491123981676,0,0,0,0,0.0253766532092372,0.00660822869780035,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0197295268374391,0.0861823287791285,0,0.0100670611759699,0.0164145914909209,0.0713360977264585,0.0321899602435178,0.019419363165872,0.0408424596040261,0.0708792202543444,0.0401183171279197,0.0919561478169347,0,0.0713288006193697,0.0534393341004148,0.0189132178479739,0.0620462261432802,0,0.0217145142990202,0.0116762344953764,0.0446178299646089,0.0236568684572363,0.0549982052467,0.0279519066767303,0.105096996684232,0.0433732779628338,0,0,0.196871835230846,0,0.054120607454669,0.0715837567764799,0,0.103155763346075,0.176705070572173,null,0.0292780104743573,0.0319957436813842,0.0329789841110936,0.0285076576723884,0,0,0,0.0288593522332666,0.049452704121665,0.0281211872356398,0,0,0,0.0438555042120614,0.03220412625306,0,0,0,0,0,0,0.013905706555125,0.0505722013318339,0,0,0,0,0,0.0322940072289411,0,0.0406012514237274,0.0508674502751759,0.0317609628122127,0.0197894341593937,0.0693628229039245,0.037797791907373,0,0.0420919437865695,0.0425507246021047,0.0255197208862734,0,0,0,0,0,0,0.0272540415862085,0.0484223318544473,0.0184960851639173,0,0,0.0663643571608342,0,0,0,0,0.0226696774809189,0.0806020120638923,0,0.0543506577144563,0.071933054740949,0.0416622612020913,0.057517305766916,0,0,0,0.0260295119946255,0.0184715557787676,0,0,0.0376477930064429,0.0175492772696839,0,0.102673577240999,0.031807162292857,0,0.0415447465507489,0.0354090977603808,0.0210694004167094,0.0265085008903559,0.0456914881251102,0.141347016165814,0,0.0348600154443602,0.0321676250304072,0.0547879299921833,0,0.0333217360471395,0,0,0,0,0,0,0,0,0.0502440241418018,0,0.0349253458075905,0,0.130555753625816,0.100802055924047,0,0.0797204956138193,0,0,0,0,0.0394029851644259,0,0,0,0.0874409029660119,0,0,0,0,0.105778214347902,0.0402990756070747,0.0473891035851786,0.0822664167134708,0,0.0712547348408317,0,0,0,0.0298627714462637,0.213279624432805,0.0529332676084577,0,0.0715762751417197,0,0,0,0,0,0,0.209214748071953,0.0154372737402575,0,0,0.0914561196521142,0.106244660703152,0,0,0.0137223853398369,0,0,0,0,0,0,0,0.0334142785948464,0.0533273269891132,0.139576938359178,0.0408295634910135,0.101163726973707,0,0.0355261037617825,0.0266926391872872,0.0147694922463443,0.0548716665381831,0.0119234579460194,0,0,0.0139276857422285,0,0.0217221050338962,0,0,0,0.0312180868078738,0.00776726485271237,0.00661298036342652,0,0.113230484517667,0,0.035995751056119,0,0,0,0,0.0206886785430427,0,0,0.022436976233231,0.0157697871319237,0,0,0.0199726205651363,0,0,0.00177858916807999,0,0,0,0.00252589171873489,0.00472858559460231,0,0,0,0,0.0117697451375561,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],["wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>tempLink<\/th>\n      <th>municipalityNumber<\/th>\n      <th>HIF<\/th>\n      <th>total_area<\/th>\n      <th>n<\/th>\n      <th>w_mean<\/th>\n      <th>mean<\/th>\n      <th>sd<\/th>\n      <th>eco<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"targets":3,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":4,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":5,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":6,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":7,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":8,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"className":"dt-right","targets":[4,5,6,7,8]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":["options.columnDefs.0.render","options.columnDefs.1.render","options.columnDefs.2.render","options.columnDefs.3.render","options.columnDefs.4.render","options.columnDefs.5.render"],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-55)Summary statistics for the alien species indicator.</p>
</div>


### Aggregate and spread (extrapolate) {#spread-alien}

I now want to find the mean indicator value for each HIA (i.e. to
aggregate) and to _spread_ these out spatially to the entire HIA (i.e. to extrapolate).

I want to add a threshold so that we don't end up over extrapolating
based on too few data points. I will use 20 data points as a minimum.


```r
wetland_alien_extr <- ea_spread(indicator_data = wetlands,
                         indicator = i_2020,
                         regions = HIA_muni,
                         groups = muni_HIF,
                         threshold = 20)

seminat_alien_extr <- ea_spread(indicator_data = seminat,
                         indicator = i_2020,
                         regions = HIA_muni,
                         groups = muni_HIF,
                         threshold = 20)

natOpen_alien_extr <- ea_spread(indicator_data = natOpen,
                         indicator = i_2020,
                         regions = HIA_muni,
                         groups = muni_HIF,
                         threshold = 20)
```





It's easier to see what's happening if we zoom in a bit. I will look more closely at three example municipalities: 

Trondheim (municipality nr 5001), Nordre Follo (3020) and Målselv (5418).


```r
wetland_alien_extr <- wetland_alien_extr %>%
  separate(ID,
           into = c("ID", "municipalityNumber", "HIF"),
           sep = "_") %>%
  add_column(eco = "wetlands")

seminat_alien_extr <- seminat_alien_extr %>%
  separate(ID,
           into = c("ID", "municipalityNumber", "HIF"),
           sep = "_") %>%
  add_column(eco = "semi_natural")

natOpen_alien_extr <- natOpen_alien_extr %>%
  separate(ID,
           into = c("ID", "municipalityNumber", "HIF"),
           sep = "_") %>%
  add_column(eco = "naturally_open")

alien_extr <- rbind(
  wetland_alien_extr,
  seminat_alien_extr,
  natOpen_alien_extr
)
```



```r
alien_extr_trd_nf <- alien_extr %>%
  filter(municipalityNumber %in% c("5001", "3020", "5418"))
```




```r
myCol <- "RdYlGn"

tmap_arrange(
tm_shape(alien_extr_trd_nf)+
  tm_polygons(col = "w_mean",
    title="Alien species indicator",
    palette = myCol,
     style="fixed",
    breaks = seq(0,1,.1))+
  tm_layout(legend.outside = T)+
  tm_facets(by=c("eco", "municipalityNumber"))
,
tm_shape(alien_extr_trd_nf)+
  tm_polygons(col = "HIF",
    title="Human impact factor",
    palette = "-viridis",
    style="cont",
    breaks = c(0,1))+
  tm_layout(legend.outside = T)+
  tm_facets(by=c("municipalityNumber"))
,
ncol=1,
heights = c(1,0.3))
```

<div class="figure">
<img src="alien_species_files/figure-html/extrapolated-alien-1.png" alt="Alien species indicator extrapolated over Nordre Follo (3020), Trondheim (5001) and Målselv (5418). Note that the maps are not masked by ecosystem type, so the three ecosystem specific indicators are overlaping. The bottom row shows the location of the four human impact sones." width="672" />
<p class="caption">(\#fig:extrapolated-alien)Alien species indicator extrapolated over Nordre Follo (3020), Trondheim (5001) and Målselv (5418). Note that the maps are not masked by ecosystem type, so the three ecosystem specific indicators are overlaping. The bottom row shows the location of the four human impact sones.</p>
</div>

Figure \@ref(fig:extrapolated-alien) again indicates that this indicator will have a lot of missing data (see also [here](#alien-data-coverage)). For Nordre Follo and Trondheim for example, we do not have any indicator values tied to naturally open or wetland ecosystems, and for semi natural ecosystems we only have data for HIF class 2. This is, however, still a lot better than discarding the entire data set due to issues related to area representativity. The amount of missing data in the indicator maps is closely tied to the chosen threshold value for how many data points we must have in order to calculate an (area weighted) mean indicator value. We have used 20 as the threshold here. For Målselv (far right column), we ended up having enough data for wetlands in HIF class 0, and since most of the municipality is in this HIF class we get a lot of indicator coverage.

The following table contains the data values underlying Figure \@ref(fig:extrapolated-alien), including HIAs with <20 data points.


```r
all_stats %>%
  filter(municipalityNumber %in% c("5001", "3020", "5418")) %>%
  arrange(municipalityNumber, eco, HIF) %>%
  DT::datatable()%>%
  formatRound(columns=3:8, digits=2)
```

<div class="figure">

```{=html}
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-a30732a5ada2a7ae0986" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-a30732a5ada2a7ae0986">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21"],["ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID","ID"],["3020","3020","3020","3020","3020","5001","5001","5001","5001","5001","5001","5001","5418","5418","5418","5418","5418","5418","5418","5418","5418"],["1","2","3","1","2","3","1","2","3","1","2","3","0","1","2","0","1","2","0","1","2"],[13968.4199798215,130053.615859825,3818.34637325846,299.86294095093,636.43889332097,2144.13756580063,33903.7252033282,1542325.24265333,15149.3418199182,85064.1788523152,120402.73363817,760.172437892994,514.132268105895,78057.396232297,17494.3191826982,14944.8703664656,1611334.76907044,1071660.04787096,236325.284497039,918918.61157915,121771.196228044],[2,44,2,2,1,2,15,107,4,17,15,2,2,34,17,8,144,137,44,136,44],[0.825981131269517,0.807000240230553,0.8,1,1,0.787258984168541,0.945519456750406,0.968991708161538,0.983279223200591,1,0.765993521904403,1,1,1,0.995424010281209,1,0.998134194041709,0.997433274578195,0.987188579625285,0.9982737606598,1],[0.9,0.872727272727273,0.8,1,1,0.7,0.973333333333333,0.953271028037383,0.9,1,0.96,1,1,1,0.988235294117647,1,0.990277777777778,0.995620437956204,0.995454545454545,0.998529411764706,1],[0.0696451034922085,0.0301256933363664,0,0,0,0.209214748071953,0.0170424032981515,0.0109575843395,0.0872158621272908,0,0.0371319967842451,0,0,0,0.0117697451375561,0,0.00478641024094254,0.00257422412128143,0.00460731183703534,0.00145490369868734,0],["semi-natural","semi-natural","semi-natural","wetland","wetland","Naturally-open","semi-natural","semi-natural","semi-natural","wetland","wetland","wetland","Naturally-open","Naturally-open","Naturally-open","semi-natural","semi-natural","semi-natural","wetland","wetland","wetland"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>tempLink<\/th>\n      <th>municipalityNumber<\/th>\n      <th>HIF<\/th>\n      <th>total_area<\/th>\n      <th>n<\/th>\n      <th>w_mean<\/th>\n      <th>mean<\/th>\n      <th>sd<\/th>\n      <th>eco<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"targets":3,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":4,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":5,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":6,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":7,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"targets":8,"render":"function(data, type, row, meta) {\n    return type !== 'display' ? data : DTWidget.formatRound(data, 2, 3, \",\", \".\", null);\n  }"},{"className":"dt-right","targets":[4,5,6,7,8]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":["options.columnDefs.0.render","options.columnDefs.1.render","options.columnDefs.2.render","options.columnDefs.3.render","options.columnDefs.4.render","options.columnDefs.5.render"],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-61)Summary statistics for three example municipalities.</p>
</div>

Note that we can also show the uncertainties on maps:


```r
tm_shape(alien_extr_trd_nf[alien_extr_trd_nf$eco=="semi_natural",])+
  tm_polygons(col = "sd",
    title="SD(alien\nspecies indicator)",
    palette = "-viridis"
     )+
  tm_layout(legend.outside = T)+
  tm_facets(by="municipalityNumber")
```

<div class="figure">
<img src="alien_species_files/figure-html/sd-alien-1.png" alt="Map showing the uncertainties (spatial variation) around the indicator values for alien species in three example municipalities for Semi-natural ecosystems." width="672" />
<p class="caption">(\#fig:sd-alien)Map showing the uncertainties (spatial variation) around the indicator values for alien species in three example municipalities for Semi-natural ecosystems.</p>
</div>

### Exploring the indicator values 

Most HIAs have good condition:


```r
alien_extr %>%
  filter(!is.na(w_mean)) %>%
  ggplot()+
  geom_histogram(aes(x = w_mean))+
  theme_bw()+
  labs(x = "Area weighted indicator value",
       y = "Number of HIAs with >20 data points")
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-62-1.png" alt="Number of HIAs with &gt;20 data points (sum of all three ecosystems)" width="672" />
<p class="caption">(\#fig:unnamed-chunk-62)Number of HIAs with >20 data points (sum of all three ecosystems)</p>
</div>

#### Data coverage {#alien-data-coverage}

Let's see how big proportion of Norway we ended up having data for. Ideally I would do this after masking the indicator maps with ecosystem delineations, 
but I can also get a good feel for the data coverage like this as well.

The area of Norway is 

```r
(total_area <- st_area(outline))
#> 325694265348 [m^2]
```

And here is the total and relative area of the indicator maps

```r
alien_extr %>%
  filter(!is.na(w_mean)) %>%
  mutate(m2 = st_area(.)) %>%
  group_by(eco) %>%
  summarise(sum_area = sum(m2)) %>%
  add_column(total_area = total_area) %>%
  mutate(relative_area = units::drop_units(sum_area/total_area)) %>%
  ggplot()+
  geom_bar(aes(x = eco, y = relative_area),
           stat = "identity")+
  labs(x = "Ecosystem", y = "Relative indicator data coverage")+
  theme_bw()
```

<div class="figure">
<img src="alien_species_files/figure-html/relative-area-1.png" alt="Relative area cover of the indicator maps for the alien species indicator (i.e. value 1 means that all HIAs had &gt; 20 data points, and 0.2 means 20% of them did). If assuming the ecosystems are equally common where they are mapped and where they are not, this measure of data coverage is representative of the real indicator coverage after masking the maps with ecosystem delineations." width="672" />
<p class="caption">(\#fig:relative-area)Relative area cover of the indicator maps for the alien species indicator (i.e. value 1 means that all HIAs had > 20 data points, and 0.2 means 20% of them did). If assuming the ecosystems are equally common where they are mapped and where they are not, this measure of data coverage is representative of the real indicator coverage after masking the maps with ecosystem delineations.</p>
</div>

Figure \@ref(fig:relative-area) shows us that this indicator will provide indicator values for about 20% of the semi-natural ecosystem, and considerably less for the other two ecosystems. The data coverage is very sensitive to the threshold for minimum data points, set to >20 in this case. Also, with more nature type data accumulating over time, the data coverage will increase. Therefore I think this indicator is worth while, and that this is considerably better than the alternative to discard the entire data set.

#### Effect of latitude

Alien species tend to invade from the south. Let us see if there is an effect of latitude.

Extracting x and y coordinates


```r
temp <- alien_extr %>%
  filter(!is.na(w_mean)) %>%
  st_centroid() %>%
  st_coordinates()

temp2 <- alien_extr %>%
  filter(!is.na(w_mean))  %>%
  cbind(temp)
```



```r
temp2 %>%
  ggplot(aes(x = X, y = w_mean))+
  geom_point()+
  theme_bw()+
  geom_smooth(linewidth=2,
              method="loess",
              span=0.75)+
  labs(x = "Latitude (UTM with offset)",
       y = "Alien species indicator value\n(area weighted)")+
  facet_wrap(~eco)
```

<div class="figure">
<img src="alien_species_files/figure-html/lat-effect-1.png" alt="Effect of latitude on the alien species indicator values. The blue line is a loess smoother (span=0.75)." width="672" />
<p class="caption">(\#fig:lat-effect)Effect of latitude on the alien species indicator values. The blue line is a loess smoother (span=0.75).</p>
</div>



There is a quite clear association here between latitude and the on-site effect of alien species.


## Next steps

The next steps now are to

1. Prepare ecosystem delineation maps in EPSG:25833 and perfectly aligned to a master grid

2. Rasterize the extrapolated indicator map, using the ET map as a template 

3. and mask it using the perfectly aligned ET map.

4. Then, look at [Median Summer Temperature] for how to aggregate spatially to accounting areas (regions)


This workflow should be synchronized with the [slitasje](#slitasje-og-kjørespor) indicator. I will attempt a little proof of concept below.


## Masking with an ecosystem delineation - example {#masking-example}

Let's try steps 2 and 3 on a reduced data set. I'll work with wetlands in Gran municipality.


```r
gran <- wetland_alien_extr %>%
  filter(municipalityNumber == "3446")
```


```r
tm_shape(gran)+
  tm_polygons(col = "w_mean",
    title="Alien species indicator - wetlands",
    palette = myCol,
     style="fixed",
    breaks = seq(0,1,.1))+
  tm_layout(legend.outside = T,
            title = "Gran municipality")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-67-1.png" alt="Alien species indicator over wetlands in Gran municipality." width="672" />
<p class="caption">(\#fig:unnamed-chunk-67)Alien species indicator over wetlands in Gran municipality.</p>
</div>

Then I can import and crop the ecosystem delineation map.


```r
file <- "P:/41201785_okologisk_tilstand_2022_2023/data/Myrmodell/myrmodell90pros.tif"
EDM <- stars::read_stars(file, proxy=F)
```

The EDM is in UTM32 when we actually want to have it in UTM33. But transforming it takes too long, so I will transform the indicator map instead.


```r
gran <- st_transform(gran, st_crs(EDM))
```



```r
mire_gran <- st_crop(EDM, gran)
saveRDS(mire_gran, paste0(pData, "cache/mire_gran.rds"))
```





```r
ggplot()+
  geom_stars(data = st_downsample(mire_gran, 10))
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-72-1.png" alt="Wetlands in Gran municipality" width="672" />
<p class="caption">(\#fig:unnamed-chunk-72)Wetlands in Gran municipality</p>
</div>

Then I rasterize the indicator map to match the EDM. This takes a while, even for just one municipality. I'm not sure this would work for the entire country.


```r
gran_rast <- st_rasterize(gran, template = mire_gran)  
saveRDS(gran_rast, paste0(pData, "cache/gran_rast.rds"))
```




```r
gran_outline <- muni %>%
  filter(kommunenummer == "3446")
```


```r
tm_shape(st_downsample(gran_rast, 10))+
  tm_raster(col="w_mean")+
  tm_shape(gran_outline)+
  tm_borders(col="red")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-76-1.png" alt="Indictor values (alien species, extrapolated and area weighted values) in Gran municipality. Note that the pixelation is very small (10 x 10 m), and that the larger squares are remnants from the HIA map which was 1 x 1 km resolution." width="672" />
<p class="caption">(\#fig:unnamed-chunk-76)Indictor values (alien species, extrapolated and area weighted values) in Gran municipality. Note that the pixelation is very small (10 x 10 m), and that the larger squares are remnants from the HIA map which was 1 x 1 km resolution.</p>
</div>

Then i mask to remove areas that are not actually watlands.


```r
gran_rast_masked <- gran_rast
gran_rast_masked[mire_gran == 0] <- NA
```


```r
tm_shape(st_downsample(gran_rast_masked, 10))+
  tm_raster(col="w_mean",
            palette = "red")+
  tm_shape(gran_outline)+
  tm_borders(col="red")
```

<div class="figure">
<img src="alien_species_files/figure-html/unnamed-chunk-78-1.png" alt="Stratified, area weighted indictor values (alien species) in Gran municipality masked by a wetland ecosystem delimination map." width="672" />
<p class="caption">(\#fig:unnamed-chunk-78)Stratified, area weighted indictor values (alien species) in Gran municipality masked by a wetland ecosystem delimination map.</p>
</div>

From here it is easy to get zonal statistics using `exactextratr`. If I have this kind of map for all of Norway I can get the mean value for the regions (defined via a polygon set) and it will of course be area weighted (but no weight given to ecosystem occurences that don't have indicator values). 

