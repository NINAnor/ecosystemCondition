# (PART\*) INDICATORS{-}

# Slitasje og kjørespor

*Author and date:* 

Anders L. Kolstad

March 2023






|Ecosystem                                                           |Økologisk.egenskap                       |ECT.class                      |
|:-------------------------------------------------------------------|:----------------------------------------|:------------------------------|
|Våtmark, Naturlig åpne områder under skoggrensa, Semi-naturlig mark |Primærproduksjon (evt. Abiotiske fohold) |Physical state characteristics |

<hr/>

## Introduction
This indicator represent human caused damage or **disturbance to soils and vegetation**, typically from things like recreational activities and off-road vehicle traffic. The data come from a combination non-random field surveys and area-representative surveys. Disturbance to soils and vegetation is recorded in the various data sets are NiN variables 7SE and 7TK, or as the similar, but more fine-scaled variable, PRSL and PRTK. Effects from domestic animal is not included in the definition of these variables, and the upper reference value is therefore set to 0% disturbance. 

Since the data is not sampled in a systematic or random way, we must take extra care not to over-extrapolate in space. We delineate _homogeneous impact areas_ (HIA) based on four classes of increasing infrastructure, and we say that the field data is representative inside the HIA and region (_five regions in Norway_) where it was recorded. We then calculate an area weighted mean (and error) indicator value for each HIA and region combination, as long as there is more than 150 data points for a give combination of HIA and region.     

Here is a general workflow for the calculation of the indicator.

1.  Import [Nature type data](#NTM) data set (incl. GRUK) and [ANO data
    set](#ANO-import)

2.  Identify the [relevant](#naturtype) nature types and [subset](#NTM)
    the data

3.  Convert [ANO points to polygons](#ANO-points-to-poly)

4.  For each polygon, extract the NiN-variable that has the lowest value
    (one-out all-out principle), e.g. Fig. \@ref(fig:slitasje-naturetype).

5.  [Combine](#combine-nt-ano) data sets

6.  [Scale](#scale-slitasje-ind) the `slitasje` variable based on
    reference values.

7.  Define [homogeneous impact areas](#HIA) (HIA)

8.  [Aggregate and spread](#spread-slitasje) indicator value across HIAs
    and assessment regions

9.  Confirm relationship between infrastructure index and indicator
    values to justify the extrapolation

10. TO DO: Prepare ecosystem delineation maps and us ethese to mask the extrapolated indicator maps

11. Spatial aggregation of indicator values and uncertainties to accounting areas

12. Export indicator maps and regional extrapolated maps

## About the underlying data

The indicator uses a data set from a standardised field survey of nature
types. You can read more about the preliminary analyses
[here](#naturtype). See also the [official
site](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/naturkartlegging/naturtyper/)
of the Environment Agency. I also import a data set called
[ANO](#ANO-import), which you can read about
[here](https://www.miljodirektoratet.no/ansvarsomrader/overvaking-arealplanlegging/miljoovervaking/overvakingsprogrammer/natur-pa-land/arealrepresentativ-naturovervakning-ano/)

### Representativity in time and space

The nature type mapping is not random and cannot be said to be area
representative. The ANO data set however, is area representative. The
data is from 2018 to present. The data from one field season usually
becomes available early the following year.

### Original units

The variables are recorded on a coarse four-step ordinal scale (Fig.
\@ref(fig:four-step)) or eigth-step scale.

### Temporal coverage

The data goes back to 2018. I therefore bulk all the data from 2018 to 2022 into one time step. I then use the mean date for the raw data,
and define the variable as belonging to the year 2020 (read more
[here](#scaled-slitasje-variable)).

### Aditional comments about the dataset

For a run through of the nature type data set, see [here](#naturtype).

## Ecosystem characteristic

### Norwegain standard

The indicator is tagged to the *Økologisk egenskap* called
**Primærproduksjon** (Primary productivity). This is tentative, and
perhaps *abiotiske forhold* is more suited. But the thought behind the
choice is that *slitasje* affect the potential for primary productivity.

### UN standard

The indicator is tagged as a **Physical state characteristics**
indicator. This is quite clear. It's a type of abiotic characteristic that
has to do with the physical structure rather than the chemical
composition.

## Collinearities with other indicators

_Slitasje_ is not thought to exhibit collinearity with any other indicator at
the present.

## Reference condition and values

### Reference condition

The reference condition is one with minimal negative human impact. This
is also true for semi-natural ecosystems. For example, in the reference
condition, *slitasje* in semi-natural ecosystems is defined to be zero,
even though at no point in time would this condition be realized.

### Reference values, thresholds for defining *good ecological condition*, minimum and/or maximum values

* Upper = 0%

* Threshold = 10%

* Lower = 100%

The upper reference value is 0 (no *slitasje*), and the lower reference
value is 100%. Note that 100% _slitasje_ does not mean that all the area
must be scarred or damaged, but that all hypothetical quadrats around a
point is affected (the variable is frequency-driven, and not
amount-driven). The threshold for good ecosystem condition is 10%
damage. Perhaps is should be set somewhat higher, like 20 or 30%.
The indicator value could be interpretted differently at the polygon
vs at the landscape scale. At the polygon scale, 10% damage may seem 
like not that much, whilst at the landscape scale, 10% seems more serious.
This final threshold value should be debated and illustrated with examples.

Read about the normalisation [here](##scaled-slitasje-variable).

## Uncertainties

Uncertainties/errors are estimated for aggregated indicator values by
bootstrapping individual indicator values 1000 times and calculating a
distribution of area weighted means. See the documentation for `eaTools::ea_spread` [here](https://ninanor.github.io/eaTools/reference/ea_spread.html). 
This uncertainty is different from 
the spatial variation which we could get more straight forward without 
bootstrapping. When aggregating a second time,
from homogeneous impact areas to accounting areas, we assume a normal
distribution around the indicator values, with the already mentioned
errors, and sample _n_ times from these and combine the resamples into an
a new, area weighted, distribution. The errors for the accounting areas
thus represents both the spatial variation, and the precision, of the
indicator values within the accounting areas.

## References

No additional references.

## Analyses

### Data sets

#### Nature type mapping {#NTM}

This indicator uses the data set
`Naturtyper etter Miljødirektoratets Instruks`, which can be found
[here](https://kartkatalog.geonorge.no/metadata/naturtyper-miljoedirektoratets-instruks/eb48dd19-03da-41e1-afd9-7ebc3079265c).
See also [here](#naturtype) for a detailed description of the data set.

We also have a separate [summary file](##exp-natureType-summary) where
the nature types are manually mapped the NiN variables and to the correct NiN-main types. We can use this to find the nature types associated with the NiN main types
that we are interested in.


```r
naturetypes_summary_import <- readRDS("data/naturetypes/natureType_summary.rds")
```

We are only interested in a mapping units that include our target variables.


```r
myVars <- c('7TK', '7SE', 'PRTK', 'PRSL')
```



```r
naturetypes_summary <- naturetypes_summary_import %>%
  rowwise() %>%
  mutate(keepers = sum(c_across(
    all_of(myVars))>0, na.rm=T)) %>%
  filter(keepers > 0) %>%
  select(Nature_type, NiN_mainType, Year)
```

This deleted 17 nature types and left us with these:


```r
DT::datatable(naturetypes_summary)
```

```{=html}
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-47e098de8202a6aff8df" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-47e098de8202a6aff8df">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37"],["Slåttemyr","Eng-aktig sterkt endret fastmark","Sørlig kaldkilde","Åpen flomfastmark","Høgereligende og nordlig nedbørsmyr","Øyblandingsmyr","Strandeng","Nakent tørkeutsatt kalkberg","Kystlynghei","Sørlig slåttemyr","Konsentrisk høymyr","Boreal hei","Sanddynemark","Semi-naturlig strandeng","Rik åpen jordvannsmyr i mellomboreal sone","Sørlig nedbørsmyr","Atlantisk høymyr","Terrengdekkende myr","Åpen grunnlendt kalkrik mark i boreonemoral sone","Rik åpen sørlig jordvannsmyr","Aktiv skredmark","Semi-naturlig myr","Silt og leirskred","Eksentrisk høymyr","Øvre sandstrand uten pionervegetasjon","Kalkrik helofyttsump","Fuglefjell-eng og fugletopp","Isinnfrysingsmark","Åpen grunnlendt kalkrik mark i sørboreal sone","Sørlig etablert sanddynemark","Rik åpen jordvannsmyr i nordboreal og lavalpin sone","Fossepåvirket berg","Fosse-eng","Svært tørkeutsatt sørlig kalkberg","Kanthøymyr","Platåhøymyr","Palsmyr"],["V9","T41","V4","T18","V3","V1","T12","T1","T34","V9","V3","T31","T21","T33","V1","V3","V3","V3","T2","V1","T17","V9","T17","V3","T29","L4","T8","T20","T2","T21","V1","T1","T15","T1","V3","V3","V3"],["2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021","2018, 2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2019, 2020, 2021, 2022","2021, 2022"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Nature_type<\/th>\n      <th>NiN_mainType<\/th>\n      <th>Year<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

Importing and sub-setting the main data file, fix duplicate _hovedøkosystem_, calculate area, split one column in two, make numeric, and select target variables:

```r
naturetypes <- sf::st_read(dsn = path) %>%
  filter(naturtype %in% naturetypes_summary$Nature_type) %>%
  mutate(hovedøkosystem = recode(hovedøkosystem,
                                 "naturligÅpneOmråderUnderSkoggrensa" = "naturligÅpneOmråderILavlandet"),
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
#> Warning: There was 1 warning in `stopifnot()`.
#> ℹ In argument: `NiN_variable_value =
#>   as.numeric(NiN_variable_value)`.
#> Caused by warning:
#> ! NAs introduced by coercion
```


```r
ggplot(data = naturetypes, aes(x = naturtype, fill = hovedøkosystem))+
  geom_bar()+
  coord_flip()+
  theme_bw(base_size = 12)+
  theme(legend.position = "top",
        legend.title = element_blank(),
        legend.direction = "vertical")+
  #guides(fill = "none")+
  xlab("")+
  ylab("Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-8-1.png" alt="An overview of the naturetypes for which we will calculate the indicator. Colours refer to the main ecosystem affiliation." width="672" />
<p class="caption">(\#fig:unnamed-chunk-8)An overview of the naturetypes for which we will calculate the indicator. Colours refer to the main ecosystem affiliation.</p>
</div>

Column names starting with a number is problematic, so adding a prefix


```r
naturetypes$NiN_variable_code <- paste0("var_", naturetypes$NiN_variable_code)
```


```r
barplot(table(naturetypes$kartleggingsår))
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-10-1.png" alt="Distribution of data points over time." width="672" />
<p class="caption">(\#fig:unnamed-chunk-10)Distribution of data points over time.</p>
</div>


Now I need to create a single row per locality with a new variable which
is a product/function of the four variables "7SE", "7TK", "PRTK" and
"PRSL". I want to base this indicator on whichever of the variables have the highest value (worst condition). Therefore I first convert the ordinal scale to a continuous scale, using the median value of each ordinal step.

The variables use slightly different scales. PRSL and PRTK use this 8
step scale:


```r
knitr::include_graphics("images/mdirPRscale.PNG")
```

<div class="figure">
<img src="images/mdirPRscale.PNG" alt="Eight step condition scale" width="314" />
<p class="caption">(\#fig:eight-step)Eight step condition scale</p>
</div>

7TK and 7SE use a 4 step scale


```r
knitr::include_graphics("images/ninAR4b.PNG")
```

<div class="figure">
<img src="images/ninAR4b.PNG" alt="Four step condition scale" width="554" />
<p class="caption">(\#fig:four-step)Four step condition scale</p>
</div>

I here transfer these ordinal variables over to a continuous scale.


```r
naturetypes <- naturetypes %>%
  mutate(NiN_variable_value = case_when(
    NiN_variable_code %in% c("var_7TK", "var_7SE") ~ 
      case_match(NiN_variable_value,
             0 ~ 0,
             1 ~ mean(c(0, 1/16))*100,
             2 ~ mean(c(1/16, 1/2))*100,
             3 ~ 75),
    NiN_variable_code %in% c('var_PRTK', 'var_PRSL') ~ 
      case_match(NiN_variable_value,
             0 ~ 0,
             1 ~ 1.5,
             2 ~ mean(c(3, 6.25)),
             3 ~ mean(c(6.25, 12.5)),
             4 ~ mean(c(12.5, 25)),
             5 ~ mean(c(25, 50)),
             6 ~ mean(c(50, 75)),
             7 ~ mean(c(75, 100)))
    )
  )
```


I will create a new data table where I calculate the new
variable which I then paste back into the sf object.


```r
naturetypes_wide <- pivot_wider(naturetypes,
                                names_from = "NiN_variable_code",
                                values_from = "NiN_variable_value",
                                id_cols = "identifikasjon_lokalId")
naturetypes_wide <- as.data.frame(naturetypes_wide)
head(naturetypes_wide, 10)
#>    identifikasjon_lokalId var_PRSL var_7TK var_7SE var_PRTK
#> 1         NINFP2210087853      0.0       0      NA       NA
#> 2         NINFP2210087857      0.0       0      NA       NA
#> 3         NINFP1910012022       NA      NA   0.000       NA
#> 4         NINFP1910005432      1.5      NA      NA       NA
#> 5         NINFP2210089748       NA       0   0.000       NA
#> 6         NINFP2210096062       NA      NA   0.000      0.0
#> 7         NINFP1910029434       NA      NA   3.125      1.5
#> 8         NINFP2010029112       NA       0   0.000       NA
#> 9         NINFP2010029325       NA       0   0.000       NA
#> 10        NINFP1910057556       NA      NA   0.000       NA
```

First I will combine 7TK and PRTK, and also 7SE and PRSL


```r
naturetypes_wide <- naturetypes_wide %>%
  mutate(TK = if_else(
    is.na(var_PRTK), var_7TK, var_PRTK),
    SE = if_else(
      is.na(var_PRSL), var_7SE, var_PRSL)
    )
```


SE has 10064
NA's, and TK has
7007.


```r
temp <- naturetypes_wide %>%
  group_by(SE) %>%
  summarise(sum = n())

ggplot(temp, aes(x = factor(SE),
                 y = sum))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "7SE or PRSL score",
       y = "Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-14-1.png" alt="7SE scores in the naturetype dataset" width="480" />
<p class="caption">(\#fig:unnamed-chunk-14)7SE scores in the naturetype dataset</p>
</div>

The NA fraction is quite big. These are localities with 7TK or PRTK recorded,
but not 7SE or PRSL.


```r
temp <- naturetypes_wide %>%
  group_by(TK) %>%
  summarise(sum = n())

ggplot(temp, aes(x = factor(TK),
                 y = sum))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "7TK og PRTK score",
       y = "Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-15-1.png" alt="7TK scores in the nature type dataset" width="480" />
<p class="caption">(\#fig:unnamed-chunk-15)7TK scores in the nature type dataset</p>
</div>

Then I can combine these two variables into a composite variable called
`slitasje`


```r
naturetypes_wide$slitasje <- apply(naturetypes_wide[,c("TK", "SE")], 1, max, na.rm=T)
```

When both variables are NA, we get -Inf. There were 13 cases of this. Removing these now.


```r
naturetypes_wide <- naturetypes_wide[naturetypes_wide$slitasje>=0,]
```


```r
temp <- naturetypes_wide %>%
  group_by(slitasje) %>%
  summarise(sum = n())

ggplot(temp, aes(x = factor(slitasje),
                 y = sum))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "Slitasje score converted to percentage",
       y = "Number of localities") + 
  theme(axis.text.x = element_text(angle=90, vjust=0.5))
```

<div class="figure">
<img src="slitasje_files/figure-html/slitasje-naturetype-1.png" alt="Slitasje scores." width="288" />
<p class="caption">(\#fig:slitasje-naturetype)Slitasje scores.</p>
</div>

It appears most localities are in good condition.

I would also like to know, when both tk and SE was recordedm
how often TK was defining of the slitasje-indicator, and how 
often it was SE. I can do this by taking the difference.


```r


diff <- naturetypes_wide$SE - naturetypes_wide$TK

diff <- ifelse(diff == 0, "TK and SE",
               ifelse(diff <0, "TK", "SE"))

diff_tbl <- as.data.frame(table(diff))

ggplot(diff_tbl, aes(x = diff, y = Freq))+
  geom_bar(stat = "identity",
           colour = "black",
           fill = "grey")+
  theme_bw(base_size = 12)+
  labs(x = "Defining variable",
       y = "Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-18-1.png" alt="Counting the number of cases where TK or SE was defining of the slitasje indicator score." width="288" />
<p class="caption">(\#fig:unnamed-chunk-18)Counting the number of cases where TK or SE was defining of the slitasje indicator score.</p>
</div>

Looks like SE (= 7SE or PRSL) is more likely to be in a detrimental state.

Now I will copy these slitasje-values into the sf object.


```r
naturetypes$slitasje <- naturetypes_wide$slitasje[match(naturetypes$identifikasjon_lokalId, naturetypes_wide$identifikasjon_lokalId)]
#nrow(naturetypes[is.na(naturetypes$slitasje),])  # 13 cases
naturetypes <- naturetypes[!is.na(naturetypes$slitasje),]
```

#### GRUK

This variable is also recorded in
[GRUK](https://www.nina.no/Naturmangfold/Trua-natur/%C3%85pen-grunnlendt-kalkmark).
The nature type data set I'm working on here includes this data already
(presently only 2021 included). GRUK also records a related variable:
`% cover in 5m radii circles`, which is much more detailed. This data is
not published. In any case it is better to use the harmonized data set
in our case.

#### ANO {#ANO-import}

Arealrepresentativ Naturovervåking (ANO) consist of 1000 systematically
placed locations each with 18 sample points. In each sample point a
circle of 250 m2 is visualised, and the main ecosystem is recorded.
Depending on the main ecosystem, certain NiN variables are also
recorded. 7SE is recorded for våtmark, but not semi-natural areas or
naturally open areas. 7TK is recorded in våtmark and naturally open
areas only.

| Variable | Våtmark | Naturlig åpne områder | Semi-naturlige områder |
|----------|---------|-----------------------|------------------------|
| 7SE      | X       | \-                    | \-                     |
| 7TK      | X       | X                     | \-                     |

: Table showing which main ecosystems the two NiN variables 7SE and 7TK
is recorded in withing the ANO data set.

It would be very nice to have 7SE recorded for naturally open areas.
This variable is very relevant here.

I think I will only use våtmark here since my approach will be to the
'worst value' of the variable 7SE and 7TK (see below). I think not
having 7SE for naturally open areas will underestimate the degree of
degredation in these areas.


> *ANO could harmonise better with the Naturetype data set if it included
> 7SE and 7TK for Naturally open and Semi natural ecosystem.*



```r
ano <- sf::st_read(paste0(pData, "Naturovervaking_eksport.gdb"),
                   layer = "ANO_SurveyPoint") %>%
  dplyr::filter(hovedoekosystem_punkt == "vaatmark")
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
#>  130  558
```

This data set only contains data from year 2019 and 2021. We need to
update this data set later. It is not clear why there is no data from
2020.

Each point/row here is 250 square meters. The data also contains
information about how big a proportion of this area is made up of the
dominant main ecosystem. However, there are
130
NA's here, which is 19% of the data.

It appears the proportion of each circle that is made up of the dominant
ecosystem was only recorded after year 2019. In fact, the main ecosystem
was not recorded at all in 2019:

```r
# Hard coding name change
#unique(ano$hovedtype_250m2)[3]
#ano$hovedtype_250m2[ano$hovedtype_250m2==unique(ano$hovedtype_250m2)[3]] <- "Aapen jordvassmyr"
```



```r
table(ano$hovedtype_250m2, ano$aar)
#>                             
#>                              2019 2021
#>   Åpen jordvannsmyr             0  416
#>   Boreal hei                    0    1
#>   Fjellhei leside og tundra     0    3
#>   Grøftet torvmark              0    5
#>   Helofytt-ferskvannssump       0    3
#>   Kaldkilde                     0    2
#>   Myr- og sumpskogsmark         0   51
#>   Nedbørsmyr                    0   53
#>   Rasmark                       0    1
#>   Semi-naturlig myr             0    7
#>   Semi-naturlig våteng          0    2
#>   Skogsmark                     0    2
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
<img src="slitasje_files/figure-html/unnamed-chunk-25-1.png" alt="Distribution of the ANO variable andel_hovedoekosystem_punkt for wetland localities." width="672" />
<p class="caption">(\#fig:unnamed-chunk-25)Distribution of the ANO variable andel_hovedoekosystem_punkt for wetland localities.</p>
</div>

The zero in there is an obvious mistake.


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
  xlab("Percentage cover of the Våtmark main ecosystem\n in the 250m2 circle")+
  scale_x_continuous(limits = c(0,101),
                     breaks = seq(0,100,10))
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-27-1.png" alt="Percentage cover of the Våtmark main ecosystem in the 250m2 circle" width="672" />
<p class="caption">(\#fig:unnamed-chunk-27)Percentage cover of the Våtmark main ecosystem in the 250m2 circle</p>
</div>

We can see that people tend to record the variable in steps of 5%, and
that most sample points are 100% belonging to the same main ecosystem.

We want to use area weighting in this indicator, so we can use this
percentage cover data to calculate the area. Note that both data sets
use m^2^ as area units.


```r
ano$area <- (ano$andel_hovedoekosystem_punkt/100)*250
```

Let's now look at the distribution of the variables. First I need to
separate the variable name from the values themselves. Now the data
looks like this:


```r
ano$bv_7se[1:6]
#> [1] "7SE_0" "7SE_0" "7SE_0" "7SE_0" "7SE_0" "7SE_0"
```

So I create a new variable prefixed var\_:


```r
ano$var_7SE <- as.numeric(sub(pattern = "7SE_",
                 replacement = "",
                 x = ano$bv_7se))
#> Warning: NAs introduced by coercion
```

The NA's is the case of blank cells. The field app should not allow
users leaving this field blank. I will need to remove these rows. There
are fourteen cases:


```r
nrow(ano[is.na(ano$var_7SE),])
#> [1] 14
```


```r
ano <- ano[!is.na(ano$var_7SE),]
```

Same with the other variable 7TK


```r
ano$var_7TK <- as.numeric(sub(pattern = "7TK_",
                 replacement = "",
                 x = ano$bv_7tk))
```

No NA's this time.


> *The ANO field app should not allow user to leave blank cells. This
> resulted in the exclusion of data.*



```r
par(mfrow=c(1,2))
barplot(table(ano$var_7TK), xlab="7TK scores")
barplot(table(ano$var_7SE), xlab="7SE scores")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-34-1.png" alt="Distribution of 7TK and 7SE scores in the ANO data" width="672" />
<p class="caption">(\#fig:unnamed-chunk-34)Distribution of 7TK and 7SE scores in the ANO data</p>
</div>

The ANO sites seem to be in an even better condition than the localities in the naturtype data set.

Combining these two variables 7TJ and 7SE into one, same as for the nature
type data.


```r
temp <- as.data.frame(ano)
temp$slitasje <- apply(temp[,c("var_7TK", "var_7SE")], 1, max, na.rm=T)
ano$slitasje <- temp$slitasje
```

Then I extract the mid values for each ordinal range step, like I did previously for the nature type data set.


```r
ano <- ano %>%
  mutate(slitasje = case_match(slitasje,
             0 ~ 0,
             1 ~ mean(c(0, 1/16))*100,
             2 ~ mean(c(1/16, 1/2))*100,
             3 ~ 75))
```



```r
barplot(table(ano$slitasje), xlab="% Slitasje", ylab = "Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-37-1.png" alt="Distribution of slitasje scores in the ANO data" width="576" />
<p class="caption">(\#fig:unnamed-chunk-37)Distribution of slitasje scores in the ANO data</p>
</div>

##### Combine Naturtype data and ANO {#combine-nt-ano}

We need to combine the nature type data set with the ANO data set. I
will add a column `origin` to show where the data comes from. I will
also add a column with the main ecosystem.


```r
ano$origin <- "ANO"
naturetypes$origin <- "Nature type mapping"
ano$hovedøkosystem <- "Våtmark"
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
slitasje_data <- dplyr::bind_rows(select(ano,
                                  GlobalID,
                                  origin,
                                  kartleggingsår,
                                  hovedøkosystem,
                                  area,
                                  slitasje,
                                  SHAPE), 
                           select(naturetypes,
                                  identifikasjon_lokalId,
                                  origin,
                                  hovedøkosystem,
                                  kartleggingsår,
                                  area,
                                  slitasje,
                                  SHAPE))

unique(st_geometry_type(slitasje_data))
#> [1] POINT        MULTIPOLYGON
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON ... TRIANGLE
```

###### Points to polygons {#ANO-points-to-poly}

The ANO data is point data, and the nature type data is *multipolygon*.
Because later we might want to save this as a shape file, we cannot have
a mixed class type. I will therefore convert the points to polygons. I
use the area column to calculate a radii that gives that area.


```r
slitasje_data_points <- slitasje_data %>%
  mutate(g_type = st_geometry_type(.)) %>%
  filter(g_type =="POINT") %>%
  st_buffer(sqrt(slitasje_data$area/pi))
```

Checking now that the new polygons have the area corresponding to the
proportion of the point that was part of the same main ecosystem:


```r
slitasje_data_points$area2 <- st_area(slitasje_data_points)
plot(slitasje_data_points$area, slitasje_data_points$area2,
     xlab = "Target area",
     ylab = "Area of the new polygons")
abline(0,1)
```

<div class="figure">
<img src="slitasje_files/figure-html/new-area-1.png" alt="Checking that the area of the new polygons fall in line with the proportion of each point which is part of the main ecosystem." width="672" />
<p class="caption">(\#fig:new-area)Checking that the area of the new polygons fall in line with the proportion of each point which is part of the main ecosystem.</p>
</div>

The area calculation seems to have worked fine. Checking that the new
data set contains **only polygons**.


```r
slitasje_data_polygons <- slitasje_data %>%
  mutate(g_type = st_geometry_type(.)) %>%
  filter(g_type !="POINT")

slitasje_data <- bind_rows(slitasje_data_points, slitasje_data_polygons)

unique(st_geometry_type(slitasje_data))
#> [1] POLYGON      MULTIPOLYGON
#> 18 Levels: GEOMETRY POINT LINESTRING POLYGON ... TRIANGLE
```

Ok.

#### Distribution of Slitasje scores


```r
temp <- as.data.frame(table(slitasje_data$slitasje))
ggplot(temp, aes(x = Var1,
                 y = Freq))+
  geom_bar(stat="identity",
           fill="grey",
           colour = "black")+
  theme_bw(base_size = 12)+
  labs(x = "slitasje score",
       y = "Number of localities")
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-43-1.png" alt="Slitasje scores (ANO Naturetype (and GRUK) data combined). The score for a locality equals the highest (worst) score of the related variables 7TK, 7SE, PRSL and PRTK." width="672" />
<p class="caption">(\#fig:unnamed-chunk-43)Slitasje scores (ANO Naturetype (and GRUK) data combined). The score for a locality equals the highest (worst) score of the related variables 7TK, 7SE, PRSL and PRTK.</p>
</div>

Let's see the proportion of data points (not area) origination from each
data set


```r
temp <- as.data.frame(table(slitasje_data$origin))

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
<img src="slitasje_files/figure-html/unnamed-chunk-44-1.png" alt="Barplot show the contribution (number of localities) of different data sets to the slitasje indicator." width="384" />
<p class="caption">(\#fig:unnamed-chunk-44)Barplot show the contribution (number of localities) of different data sets to the slitasje indicator.</p>
</div>

So the ANO data is not very important here, but it can become more
important in the future so good to have them included in the workflow.

#### Outline of Norway and regions

The GIS layers are used to crop out marine areas, and to define
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

### Scaled indicator values {#scale-slitasje-ind}

I can scale the indicator for each polygon, or I can chose to aggregate
them first. If the scaled value is representative and precise at the
polygon level, then I could scale at that level. I think they are.

However, the combined surveyed area is a very small fraction of the
total area of Norway, so that only producing indicator values for the
mapped areas leaves the indicator without much value for regional
assessments. When we do regional assessments and calculate regional
indicator values, we cannot simply do an area weighting of the polygons
in each region. This is because we don't want to assume that the
polygons are representative far outside of the mapped area. But perhaps
we can assume them to be representative inside *homogeneous ecological
areas,* or *Homoegeneous Impact Areas* (HIAs). That's where the
infrastructure index comes in. Here's the plan:

1.  normalise the indicators at the polygon level.

2.  take a simplified infrastructure index (vector data set with HIAs)
    and extract the corresponding indicator values that intersect with a
    given HIA, and extrapolate the area weighted mean of those values to
    the entire HIA withing a given geographical region. Errors are
    calculated from bootstrapping.

3.  Take the new area weighted indicator values for the HIAs and match
    them with ecosystem occurrences of the same HIA (possibly using
    randomly sampled points from the available ecosystem occurrences).
    The errors are the same as for the HIAs.

4.  calculate an indicator value for a region (accounting area) by doing
    a weighted average based of the relative area of ecosystem
    occurrences. Errors should be carried somehow, perhaps via weighted
    resampling.

#### Scaled variable {#scaled-slitasje-variable}

I will use the same reference levels/values for all of Norway:


```r
upper <- 0
lower <- 100
threshold <- 5
```

This implies that it is impossible to detect or measure a state when it
is in its most degraded form (100% disturbed). This is a problem with
the original data resolution. But I will compensate somewhat for this by
using a non-linear transformation.

Also, the threshold value is set quite conservatively (I think), and should be
discussed.

I need to do a little trick and reverse the upper and lower reference
values for the normalisation to work. This is a bug which can be fixed
inside eaTools.

<!-- THE BREAKPOINT IS AT 0.5 RATHER THAN 0.6. TEST CODE FROM HERE: https://ninanor.github.io/eaTools/articles/normalise-condition-variable.html -->


```r
eaTools::ea_normalise(data = slitasje_data,
                      vector = "slitasje",
                      upper_reference_level = lower,
                      lower_reference_level = upper,
                      break_point = threshold,
                      plot=T,
                      reverse = T
                      )
```

<div class="figure">
<img src="slitasje_files/figure-html/slitasje-normalise-1.png" alt="Performing a linear break-point type normalisation of the slitasje variable." width="480" />
<p class="caption">(\#fig:slitasje-normalise)Performing a linear break-point type normalisation of the slitasje variable.</p>
</div>

This normalisation seems reasonable to me. I can save it as indicator
values. There is no point yet making this a time series, and I will
assign all the indicator value to the average year of the data.


```r
mean(slitasje_data$kartleggingsår)
#> [1] 2020.254
```

Assigning the indicator to year 2020.


```r
slitasje_data$i_2020 <- eaTools::ea_normalise(data = slitasje_data,
                      vector = "slitasje",
                      upper_reference_level = lower,
                      lower_reference_level = upper,
                      break_point = threshold,
                      reverse = T
                      )
```

### Homogeneous impact areas {#HIA}

I want to use the [Homogeneous Impact Areas](#HIA) (HIA) to define
smaller regions into which I can extrapolate the indicator values. This
data is generated by discretizing the Norwegian Infrastructure Index. I
refer to the ordinal values of the four HIA classes as their *Human
Impact Factor* (HIF). This is just to keep the approach separate from
the Norwegian Infrastructure Index.


```r
HIA <- readRDS(paste0(pData, "infrastrukturindeks/homogeneous_impact_areas.rds"))
```

I want to check that HIF is in fact a good predictor for *slitasje*.

I also want to split these four HIA classes based on their region. To do
this I need the two layers to have the same CRS.


```r
st_crs(HIA) == st_crs(regions)
#> [1] TRUE
```

Since the HIA map and the _region_ map are completely overlapping (HIA was masked using the region map), we can get the
intersections


```r
HIA_regions <- eaTools::ea_homogeneous_area(HIA,
                             regions,
                             keep1 = "infrastructureIndex",
                             keep2 = "region")
saveRDS(HIA_regions, "P:/41201785_okologisk_tilstand_2022_2023/data/cache/HIA_regions.rds")
```



Create a new column by crossing region and HIF


```r
HIA_regions <- HIA_regions %>%
  mutate(region_HIF = paste(region, infrastructureIndex))
```

#### Validate

I now have 20 unique areas (for each main ecosystem) that I will, given
there is data, extrapolate indicator values over.

###### Subset ETs

I will subset the `slitasje_data` into the three ecosystems. Note that
only for open wetland do we have good ecosystem delineation maps to base
a spatial averaging on.


```r
#Check spelling
#unique(slitasje_data$hovedøkosystem)

# Rename one level
slitasje_data <- slitasje_data %>%
  mutate(hovedøkosystem = recode(hovedøkosystem, "Våtmark" = "våtmark"))

#make valid
slitasje_data <- st_make_valid(slitasje_data)

#subset
wetlands <- slitasje_data[slitasje_data$hovedøkosystem == "våtmark",]
seminat <- slitasje_data[slitasje_data$hovedøkosystem == "semi-naturligMark",]
natOpen <- slitasje_data[slitasje_data$hovedøkosystem == "naturligÅpneOmråderILavlandet",]
```

Creating some summary statistics.


```r
wetland_stats <- ea_spread(indicator_data = wetlands,
          indicator = i_2020,
          regions = HIA_regions,
          groups = region_HIF,
          summarise = TRUE)

seminat_stats <- ea_spread(indicator_data = seminat,
          indicator = i_2020,
          regions = HIA_regions,
          groups = region_HIF,
          summarise = TRUE)

natOpen_stats <- ea_spread(indicator_data = natOpen,
          indicator = i_2020,
          regions = HIA_regions,
          groups = region_HIF,
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
  separate(region_HIF,
           into = c("region", "HIF"),
           sep = " ")

saveRDS(all_stats, "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/all_stats.rds")
```




```r
temp_plot <- all_stats %>%
  mutate(HIF_NA = case_when(
    n > 150 ~ HIF
  ))

myColour_list <- unique(temp_plot$myColour)
names(myColour_list) <-   myColour_list

ggarrange(
ggplot(temp_plot, aes(x = region, y = n, group = HIF, fill = HIF_NA))+
  geom_bar(position = "dodge", stat = "identity", col="black")+
  theme_bw(base_size = 10)+
  scale_fill_brewer(palette="Oranges")+
  theme(axis.text.x = element_text(angle = 90, vjust=0.5))+
  coord_flip()+
  facet_wrap(.~eco),
ggplot(temp_plot, aes(x = region, y = w_mean, group = HIF, fill = HIF_NA))+
  geom_bar(position = "dodge", stat = "identity", col="black")+
  theme_bw(base_size = 10)+
  scale_fill_brewer(palette="Oranges")+
  theme(axis.text.x = element_text(angle = 90, vjust=0.5))+
  coord_flip()+
  facet_wrap(.~eco),
ggplot(temp_plot, aes(x = region, y = sd, group = HIF, fill = HIF_NA))+
  geom_bar(position = "dodge", stat = "identity", col="black")+
  theme_bw(base_size = 10)+
  scale_fill_brewer(palette="Oranges")+
  theme(axis.text.x = element_text(angle = 90, vjust=0.5))+
  coord_flip()+
  facet_wrap(.~eco),
ncol = 1)
```

<div class="figure">
<img src="slitasje_files/figure-html/dense-stats-1.png" alt="Barplot showing the number of data points, the area weighted indicator values and the sd for the slitasje indicator. Transparrent bars represents categories with less than 150 data points." width="672" />
<p class="caption">(\#fig:dense-stats)Barplot showing the number of data points, the area weighted indicator values and the sd for the slitasje indicator. Transparrent bars represents categories with less than 150 data points.</p>
</div>

In the figure above, colors refer to Human Impact Factor (amount or frequency of infrastructure) 
and NA means that there are less than 150 data points which we set as a threshold for evaluating the indicator values.

In the top row
we see that the sample size (number of polygons) varies between
ecosystems. For naturally open ecosystems many polygons are from high
infrastructure areas, not surprisingly, and there are few points for the
lowest impact class (zero such polygons in *Sørlandet* for example). We
may therefore not be able to extrapolate indicator values for Naturally
open areas in in *Sørlandet* with low levels of infrastructure. 

In semi-natural areas and wetlands, we have very little data from HIF
class 3.

We can also from the middle row see the association between the indicator
values (area weighted means) and the modified infrastructure index
(HIF). We should then not put any weight on the bars were there is
little data (transparent bars). Then we se the general pattern that the indicator 
value decreases with increasing HIF. But there are exceptions, like for Semi-natural areas
in Vestlandet.

Let us look at the indicator to pressure relationship across all ecosystems.


```r
temp_plot %>%
  filter(!is.na(HIF_NA)) %>%
  ggplot(aes(x = HIF_NA, y = w_mean))+
  geom_point(size=2, position = position_dodge2(.1))+
  geom_violin(alpha=0)+
  theme_bw()
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-58-1.png" alt="Indicator to pressure relationship across all ecosystems." width="672" />
<p class="caption">(\#fig:unnamed-chunk-58)Indicator to pressure relationship across all ecosystems.</p>
</div>

The pattern is not perfect, and there is quite some noise. But this is perhaps also expected.

Let us look at the effect of sample size on the indicator uncertainty.


```r
temp_plot %>%
  ggplot(aes(x = n, y = sd))+
  geom_point(size=2, position = position_dodge2(.1))+
  theme_bw()+
    facet_wrap(.~eco)
```

<div class="figure">
<img src="slitasje_files/figure-html/unnamed-chunk-59-1.png" alt="Smaple size against indicator uncertainty." width="672" />
<p class="caption">(\#fig:unnamed-chunk-59)Smaple size against indicator uncertainty.</p>
</div>

This shows that the uncertainty is inflated with sample sizes less than about 300-500.


```r
DT::datatable(all_stats)
```

<div class="figure">

```{=html}
<div class="datatables html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-56d7b49041b4f1f1ef9d" style="width:100%;height:auto;"></div>
<script type="application/json" data-for="htmlwidget-56d7b49041b4f1f1ef9d">{"x":{"filter":"none","vertical":false,"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"],["Midt-Norge","Midt-Norge","Midt-Norge","Midt-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Sørlandet","Sørlandet","Sørlandet","Sørlandet","Vestlandet","Vestlandet","Vestlandet","Vestlandet","Østlandet","Østlandet","Østlandet","Østlandet","Midt-Norge","Midt-Norge","Midt-Norge","Midt-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Sørlandet","Sørlandet","Sørlandet","Sørlandet","Vestlandet","Vestlandet","Vestlandet","Vestlandet","Østlandet","Østlandet","Østlandet","Østlandet","Midt-Norge","Midt-Norge","Midt-Norge","Midt-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Nord-Norge","Sørlandet","Sørlandet","Sørlandet","Vestlandet","Vestlandet","Vestlandet","Vestlandet","Østlandet","Østlandet","Østlandet","Østlandet"],["0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","0","1","2","3","1","2","3","0","1","2","3","0","1","2","3"],[20425516.793161,55942079.0852367,25271797.033968,402403.654717704,4177429.11487822,39799602.0218486,21289663.1377251,119342.520216003,1199953.10537375,2555863.89072861,1316446.89966768,28747.3798501565,2429070.74019894,7091916.84858253,1976037.38284999,83419.9734570635,1338836.52571996,10667431.8327424,12151597.8760085,777759.443905594,45082128.9721422,105282331.371692,65698434.9289448,1458536.77645433,12119453.8140127,39689431.8549581,23764139.6700521,560734.383622149,12833361.1414629,55230811.320468,21059796.7186225,281368.955707136,62771221.3693583,171913529.764963,89577387.4688441,2762081.96649456,22722135.5559064,72301565.3418464,46433821.8958926,531602.555394967,38617.3295027119,1088104.72301855,4085898.43293656,551146.817578847,1145883.34854498,6747952.7632901,6810143.31086301,90891.4412507273,109835.996095306,882962.104436279,674506.417532786,13843.1727794531,198525.028855817,436639.782215109,47244.6292264749,17970.0303946844,671054.025118375,5315089.41465925,1026810.93562918],[1001,2507,1463,43,548,2503,1513,16,129,457,132,10,272,723,329,24,151,768,912,119,764,2361,2314,101,399,1323,1279,69,153,737,713,56,484,2239,2218,181,251,1104,1650,143,55,298,1098,189,223,1419,1422,52,39,385,254,18,111,246,34,11,216,1419,416],[0.771750910678313,0.7875186612059,0.793527794730975,0.865720748692812,0.831477335386509,0.801232017375005,0.745740593748365,0.791099692645648,0.906027687414072,0.911013644607549,0.798963551938973,1,0.957236019313803,0.880727771695884,0.825256022857242,0.791359885839299,0.788313328500717,0.791395245167583,0.750731099672693,0.923119549784727,0.902593418006151,0.83593202285124,0.80467219237372,0.807328459520766,0.873503412863498,0.83350830318046,0.831318829695963,0.951610294891564,0.94985520619026,0.888240984238651,0.853134247523411,0.729140255239416,0.9098194463842,0.869385864286768,0.885433805699666,0.916486246113373,0.737934602429538,0.722254276853415,0.706036226775658,0.630459416309339,0.951417060773914,0.95003102838554,0.84863012352793,0.810123844078759,0.844666568065667,0.814820273682474,0.803164434951812,0.753302327707886,0.838687587547142,0.645133805861738,0.642709425559455,0.933046230074286,0.969736857282128,0.834162035025874,0.545331235282478,0.893416505831439,0.872053422790955,0.826622204638684,0.810474925985478],[0.920985067564015,0.867491969852833,0.825670935712487,0.792117503059976,0.898993469074145,0.855201757890531,0.826648693776742,0.743125,0.95453488372093,0.933700909823794,0.861945773524721,1,0.946281927244582,0.933323505860086,0.90592225243961,0.835635964912281,0.896889159986058,0.858679070723684,0.816871537396122,0.871275984077842,0.948676632681179,0.90910575358345,0.862583814765955,0.849241792600313,0.955019126764279,0.91984425349087,0.921706514135221,0.946414950419527,0.984117647058824,0.955265300292794,0.900607145493467,0.773397556390977,0.953312309699869,0.930312286970217,0.924071353993641,0.907515266065717,0.877254141329419,0.820020022883295,0.779115789473684,0.738916083916084,0.972727272727273,0.917387848816673,0.891231665228645,0.857699805068226,0.95627802690583,0.904449946218612,0.883170478939966,0.845394736842105,0.857962213225371,0.683749145591251,0.664680895151264,0.916666666666667,0.935277382645804,0.854032948224219,0.826625386996904,0.931818181818182,0.864918372319688,0.815831200623122,0.732730263157895],[0.00521180430068777,0.00434945752819324,0.00602063114291312,0.0357420655181531,0.00788601096109206,0.0043498025604811,0.0057907664431112,0.0530979110767958,0.00965832014067245,0.0072080861750764,0.0181116104747688,0,0.00837811441658417,0.0056414016696469,0.00896478394465009,0.0450854963918842,0.0140911117320106,0.00740041633236665,0.00744264089345736,0.0171829338414869,0.00503700280784231,0.00364269206680451,0.00430006747608547,0.0217928162646461,0.00637942868020546,0.00453240639310002,0.00462555044884439,0.0172207735139846,0.00604208609205063,0.00471198160238452,0.00680508640195998,0.0365666211196643,0.00605252356670952,0.00328820222512962,0.00347028570681106,0.0126362557588608,0.0120587689199437,0.00661779589544552,0.00566362941182635,0.0225870247899212,0.0139374336521784,0.0107014488006716,0.00607389080650256,0.0135282003589769,0.00776844313926837,0.00526458585632371,0.00529260013803737,0.0321211661039465,0.0374330986359293,0.0147547583391982,0.0175217575275686,0.0362045873291141,0.0172631766042164,0.013918519872522,0.0378085287908935,0.0438071664018427,0.0159270768134006,0.00686810399276487,0.0135103015633108],["wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","wetland","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","semi-natural","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open","Naturally-open"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>region<\/th>\n      <th>HIF<\/th>\n      <th>total_area<\/th>\n      <th>n<\/th>\n      <th>w_mean<\/th>\n      <th>mean<\/th>\n      <th>sd<\/th>\n      <th>eco<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[3,4,5,6,7]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
```

<p class="caption">(\#fig:unnamed-chunk-60)Summary statistics for the slitasje indicator.</p>
</div>

In addition to looking at the area weighted means and its relationship
with the pressure indicator (HIF), we can do the same at the polygon
level. Because the indicator is pseudo-continuous, boxplots for example
become useless, so I will present a relative frequency plot.


```r
corrCheck <- st_intersection(slitasje_data, HIA_regions)
saveRDS(corrCheck, "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/corrCheck.rds")
```




```r
ggplot(corrCheck, aes(x = factor(infrastructureIndex), fill = factor(round(i_2020,2))))+
  geom_bar(position="fill")+
  theme_bw(base_size = 12)+
  guides(fill = guide_legend("Sliatsje indicator"))+
  ylab("Fraction of data points")+
  xlab("HIF")+
  scale_fill_brewer(palette = "RdYlGn")+
  facet_grid(hovedøkosystem~region)
```

<div class="figure">
<img src="slitasje_files/figure-html/slitasje-precentageplot-1.png" alt="Relative frequency plot (conditioned on region and main ecosystem) showing the distribution of polygons with different indicator values." width="672" />
<p class="caption">(\#fig:slitasje-precentageplot)Relative frequency plot (conditioned on region and main ecosystem) showing the distribution of polygons with different indicator values.</p>
</div>

The figure above I think supports the indicator-pressure relationship
and justifies using the HIA+region intersections as local reference
areas. Especially when down-weighting the importance of those
groups/categories that have very little data.


#### Looking at the HIA

Here is a view of the data zooming in on Trondheim


```r
myBB <- st_bbox(c(xmin=260520.12, xmax = 278587.56,
                ymin = 7032142.5, ymax = 7045245.27),
                crs = st_crs(HIA_regions))
```

Cropping the raster to the bbox


```r
HIA_trd <- sf::st_crop(HIA_regions, myBB)
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
<img src="slitasje_files/figure-html/unnamed-chunk-66-1.png" alt="A closer look at the HIA designation over Trondheim" width="672" />
<p class="caption">(\#fig:unnamed-chunk-66)A closer look at the HIA designation over Trondheim</p>
</div>

Let's calculate the areas of these polygons and compare the HIF in the
five regions.


```r
HIA_regions$area <- sf::st_area(HIA_regions)
```


```r
temp <- as.data.frame(HIA_regions) %>%
  group_by(region, infrastructureIndex) %>%
  summarise(area = mean(area))
#> `summarise()` has grouped output by 'region'. You can
#> override using the `.groups` argument.

ggplot(temp, aes(x = region, y = area, fill = factor(infrastructureIndex)))+
  geom_bar(position = "stack", stat = "identity")+
  guides(fill = guide_legend("HIF"))
```

<div class="figure">
<img src="slitasje_files/figure-html/HIF-region-1.png" alt="Stacked barplot showing the distribution of human impact factor across five regions in Norway." width="672" />
<p class="caption">(\#fig:HIF-region)Stacked barplot showing the distribution of human impact factor across five regions in Norway.</p>
</div>

The figure above shows that _Nord-Norge_ for example, has a lot of
relatively untouched areas, and that _Østlandet_ has the highest
proportion of impacted areas. This is expected.

### Aggregate and spread (extrapolate) {#spread-slitasje}

I now want to find the mean indicator value for each HIA (i.e. to
aggregate) and to spread these out spatially to the entire HIA within
each region (i.e. to extrapolate).

I want to add a threshold so that we don't end up over extrapolating
based on too few data points. I have previousl used 150 data pionts, and I think that was about right.


```r
wetlands_slitasje_extr <- ea_spread(indicator_data = wetlands,
                         indicator = i_2020,
                         regions = HIA_regions,
                         groups = region_HIF,
                         threshold = 150)

seminat_slitasje_extr <- ea_spread(indicator_data = seminat,
                         indicator = i_2020,
                         regions = HIA_regions,
                         groups = region_HIF,
                         threshold = 150)

natOpen_slitasje_extr <- ea_spread(indicator_data = natOpen,
                         indicator = i_2020,
                         regions = HIA_regions,
                         groups = region_HIF,
                         threshold = 150)
#saveRDS(wetlands_slitasje_extr, "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/wetlands_slitasje_extr.rds")
#saveRDS(seminat_slitasje_extr,  "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/seminat_slitasje_extr.rds")
#saveRDS(natOpen_slitasje_extr,  "/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/cache/natOpen_slitasje_extr.rds")
```



It's easier to see what's happening if we zoom in a bit. Lets get a
boundary box around Trondheim.


```r
myBB <- st_bbox(c(xmin=260520.12, xmax = 278587.56,
                ymin = 7032142.5, ymax = 7045245.27),
                crs = st_crs(wetlands_slitasje_extr))
```

Cropping the data to the bbox


```r
wetlands_slitasje_extr_trd <- sf::st_crop(wetlands_slitasje_extr, myBB)
seminat_slitasje_extr_trd <- sf::st_crop(seminat_slitasje_extr, myBB)
natOpen_slitasje_extr_trd <- sf::st_crop(natOpen_slitasje_extr, myBB)
```


```r
myCol <- "RdYlGn"
tmap_arrange(
tm_shape(wetlands_slitasje_extr_trd)+
  tm_polygons(col = "w_mean",
    title="Slitasje indicator",
    palette = myCol,
    style="cont",
    breaks = c(0,1))+
  tm_layout(legend.outside = T)+
  tm_shape(hw_utm)+
  tm_lines(col="blue")+
  tm_layout(title = "Wetland"),

tm_shape(seminat_slitasje_extr_trd)+
  tm_polygons(col = "w_mean",
    title="Slitasje indicator",
    palette = myCol,
    style="cont",
    breaks = c(0,1))+
  tm_layout(legend.outside = T)+
  tm_shape(hw_utm)+
  tm_lines(col="blue")+
  tm_layout(title = "Semi-natural areas"),

tm_shape(natOpen_slitasje_extr_trd)+
  tm_polygons(col = "w_mean",
    title="Slitasje indicator",
    palette = myCol,
    style="cont",
    breaks = c(0,1))+
  tm_layout(legend.outside = T)+
  tm_shape(hw_utm)+
  tm_lines(col="blue")+
  tm_layout(title = "Naturally open areas"),
HIA_trd)
```

<div class="figure">
<img src="slitasje_files/figure-html/extrapolated-slitasje-1.png" alt="Slitasje indicator extrapolated over Trondheim" width="672" />
<p class="caption">(\#fig:extrapolated-slitasje)Slitasje indicator extrapolated over Trondheim</p>
</div>

Note that for wetland and semi-natural areas we did not
extrapolate values for the most urban areas, and that for naturally open
areas we did not extrapolate to the least affected areas.
For the other regions we generally excluded more HIFs. 

> *The maps above are easy to misunderstand, and they should therefor be
> communicated with caution. They should be considered as temporary
> files or as by-products.*


The next step now is to

1. Prepare ecosystem delineation maps in EPSG25833 and perfectly aligned to a master grid

2. Rasterize the extrapolated indicator map, using the ET map as a template (see Fig. \@ref(fig:#masking-example))

3. and mask it using the perfectly aligned ET map.


A faster way could be to:

1.  Draw *n* random point samples from the ET map, and

2.  extract indicator values at those points (from the extrapolated
    indicator map (a stars object)).

... but his will not provide spatially explicit indicator values for the
entire ecosystem delineation.

### Ecosystem map

See [here](https://github.com/NINAnor/ecosystemCondition/issues/34).

### Aggregate to region

We need to aggreate the ET occurence and their indicator values, to a
regional delineation. This functionality can be developed in `eaTools`,
but will in any case build around `exactextratr::exact_extract()`.

To carry the errors, we can for example
produce distributions for the indicator values for each ET
occurrence (or groups of them) and resample the distributions with an
area weighting.

### Uncertainty

The calculations of indicator uncertainty is done with bootstrapping, as
is described in eaTools.

## Eksport files (final product)

According to the workflow specifications, I will export the indicator
map at its highest resolution, for use in various web interfaces etc.
For the finest resolution indicator map I will not include columns for
uncertainty (because this will only be estimated at the aggregated
level), or reference levels (because there is no spatial variation).

I can also export a map of the indicator where we extrapolate the
indicator values to the homogeneous areas (e.g. Fig. \@ref(fig:extrapolated-slitasje) . This map should be
interpreted with caution, since they appear as providing explicit indicator
values for areas where there is no data. This map is mainly for
aggregation purposes. I will mark this map with the prefix
*homogeneous-areas*. I will also export this same map after masking it
with the ET map, and this output must come with the same disclaimers.

Finally I will export a map of the five accounting areas with
wall-to-wall indicator value and errors (e.g. Fig \@ref(fig:wall-to-wall-summer-temp-indicator)). This map can also contain data
covering other ETs. Otherwise the maps would not we visually
interpretative.

### Slitasje in wetlands

This is how I plan to export the final product.


```r
# keep col names short and standardized
exp_wetland <- ...
```


```r
exp_wetland_HIAextrapolated <- …
```


```r
exp_wetland_AAextrapolated <- …
```

Write to file


```r
st_write(exp_wetland, "indicators/indicatorMaps/slitasje/wetland_slitasje.shp",
         append = F)

st_write(exp_wetlandHIAextrapolated, 
         "indicators/indicatorMaps/extrapolated_to_homogeneous_areas/slitasje/homogeneous_areas_wetland_slitasje.shp",
         append = F)

st_write(exp_wetland, "indicators/indicatorMaps/extrapolated_to_accounting_areas/slitasje/accounting_areas_wetland_slitasje.shp",
         append = F)
```
