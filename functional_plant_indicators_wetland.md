# Functional plant indicators (Moisture, Light, pH, Nitrogen) {#Functional-plant-indicators-wetland}

<br />

_Author and date:_

Joachim Töpper

May 2023

<br />

<!-- Load all you dependencies here -->







|Ecosystem |Økologisk.egenskap |ECT.class                       |
|:---------|:------------------|:-------------------------------|
|våtmark   |Primærproduksjon   |Functional state characteristic |
|våtmark   |Abiotiske forhold  |Functional state characteristic |



<!-- Don't remove these three html lines -->
<br />
<br />
<hr />

## Introduction
Functional plant indicators can be used to describe the functional signature of plant communities by calculating community-weighted means of plant indicator values for plant communities (Diekmann 2003). The functional signature of plant communities may be indicative of ecosystem identity, depending on which functional plant indicator we look at (cf. Töpper et al. 2018). For instance, using an indicator for moisture one would find a functional signature with higher moisture values for plant communities in mires compared to e.g. grasslands or forests. Deviations in the functional signature of such an indicator beyond a certain range of indicator values (as there of course is natural variation of functional signatures within an ecosystem type) may be related to a reduction in ecological condition. Here, we combine functional indicator data with field sampled plant community data from the Norwegian nature monitoring program ANO (Tingstad et al. 2019) for wetland ecosystems. We calculate the functional signature of plant communities in the monitored sites with respect to light, moisture, pH and nitrogen. These functional signatures are then compared to reference distributions of functional signature, separately for each wetland ecosystem type, calculated from 'generalized species lists' underlying the Norwegian categorization system for eco-diversity (Halvorsen et al. 2020). These plant functional type indicators are developed following the principles and technical protocol of the IBECA framework (Jakobsson et al. 2021, Töpper & Jakobsson 2021).

## About the underlying data
In the 'plant functional indicator' project for wetlands, we use three sets of data for building indicators for ecological condition:

- as test data we use plant community data from the ANO monitoring scheme (cf. Tingstad et al. 2019)
- as reference data we use generalized species lists from the Norwegian categorization system for eco-diversity (NiN) (cf. Halvorsen et al. 2020)
- Swedish plant indicator data for light, moisture, pH, and nitrogen from Tyler et al. (2021)

(1) ANO monitoring data:
ANO stands for 'areal-representativ naturovervåking', i.e. 'area representative nature monitoring'. 1000 sites are randomly distributed across mainland Norway and visitied within a 5-year cycle. Each ANO site spans a 500 x 500 m grid cell, and the data collection at each ANO site includes up to 12 evenly distributed vegetation analyses in 1 x 1 m plots (up to 12, because some of these evenly distributed points may be in water or otherwise inaccessible). For the vegetation analyses, the cover of each vascular plant species in the plot is recorded. Every vegetation analysis is accompanied by an assessment of the ecosystem the plot lies in, including ecosystem type and some additional variables related to ecosystem-specific drivers of state. In the wetland-analysis in this document, we only use the plots which were classified as one of the wetland ecosystem types in the Norwegian categorization system for eco-diversity (NiN).
In the analysis in this document, we use the data available on Miljødirektoratets kartkatalog (https://kartkatalog.miljodirektoratet.no/Dataset/Details/2054), which comprises data from the first three ANO-years, 2019-2021, and a total of 8887 plots in 498 sites.

(2) NiN reference data:
The generalized species lists underlying the ecosystem categorization in NiN represent expert-compiled species lists based on empirical evidence from the literature and expert knowledge of the systems and their species. In these lists, every species is assigned an abundance value on a 6-step scale, with each step representing a range for the 'expected combination of frequency and cover' of occurrence (1: < 1/32, 2: 1/32 - 1/8 , 3: 1/8 - 3/8, 4: 3/8 - 4/5, 5: 3/8 - 4/5 + dominance, 6: > 4/5). For the purpose of this project, these steps are simplified to maximum 'expected combination of frequency and cover', whereby steps 4 & 5 are assigned 0.6 and 0.8, respectively, in order to distinguish between them.

(3) The Swedish plant indicator set published by Tyler et al. (2021) contains a large collection of plant indicators based on the Swedish flora, which is well representative of the Norwegian flora as well. From this set, we decided to include indicator data for light, moisture, pH, and nitrogen for wetlands as these are thought to be subject to potential change due to shrub/tree encroachment, drainage, and pollution.


### Representativity in time and space
For wetlands, the ANO data contain 1351 plots in 330 sites, in principle distributed randomly across the country. As wetlands occur more often in certain regions of Norway than in others, the amount of plots and sites is not equal among Norway's five regions. The 1351 plots are distributed across regions in the following way:

- Northern Norway: 416
- Central Norway:  361
- Eastern Norway:  294
- Western Norway:  150
- Southern Norway: 126

### Temporal coverage
The evaluation data cover the first three years, 2019-2021, of the first 5-year-cycle in the ANO monitoring scheme. Thus there is no actual time series to these data, and the indicator evaluation does therefore not include any temporal analyses.


## Collinearities with other indicators
<!-- Text here -->

## Reference state and values
### Reference state
The reference state is defined via the functional signature of the generalized species lists in NiN (see also Töpper et al. 2018). By bootstrapping the species lists (see details further below) and calculating community-weighted means of functional plant indicators for every re-sampled community, we describe the reference state as a distribution of indicator values for each respective plant functional indicator. These distributions are calculated for minor ecosystem types ("grunntyper" or "kartleggingsenheter" at a 1:5000 mapping scale) within the major ecosystem types (hovedtyper) in NiN. A more extensive discussion on the use of reference communities can be found in Jakobsson et al. (2020).


### Reference values, thresholds for defining _good ecological condition_, minimum and/or maximum values
In this analysis, we derive scaling values from statistical (here, non-parametric) distributions (see Jakobsson et al. 2010). For each ecosystem sub-type and plant functional indicator, the reference value is defined as the median value of the indicator value distribution. As in most cases the distributions naturally are two-sided (but see the Heat-requirement indicator in the mountain assessment for an example of a one-sided plant functional indicator, Fremstad et al. 2022), and deviation from the optimal state thus may occur in both direction (e.g. indicating too low or too high pH), we need to define two threshold values for good ecological condition as well as both a minimum and maximum value. In line with previous assessments of ecological condition for Norwegian forests and mountains, we define a lower and an upper threshold value via the 95% confidence interval of the reference distribution, i.e. its 0.025 and 0.975 quantiles. The minimum and maximum values are given by the minimum and maximum of the possible indicator values for each respective plant functional indicator. For details on the scaling principles in IBECA, please see Töpper & Jakobsson (2021).


## Uncertainties
We can calculate a mean indicator value (after scaling) for every region (or any other delimited area of interest) as well as its corresponding standard error as a measure of spatial uncertainty for a geographical area.


## References
Diekmann, M. 2003. Species indicator values as an important tool in applied plant ecology - a review. Basic and Applied Ecology 4: 493-506, doi:10.1078/1439-1791-00185

Framstad, E., Kolstad, A. L., Nybø, S., Töpper, J. & Vandvik, V. 2022. The condition of forest and mountain ecosystems in Norway. Assessment by the IBECA method. NINA Report 2100. Norwegian Institute for Nature Research.

Halvorsen, R., Skarpaas, O., Bryn, A., Bratli, H., Erikstad, L., Simensen, T., & Lieungh, E. (2020). Towards a systematics of ecodiversity: The EcoSyst framework. Global Ecology and Biogeography, 29(11), 1887-1906. doi:10.1111/geb.13164

Jakobsson, S., Töpper, J.P., Evju, M., Framstad, E., Lyngstad, A., Pedersen, B., Sickel, H., Sverdrup-Thygeson, A., Vandvik. V., Velle, L.G., Aarrestad, P.A. & Nybø, S. 2020. Setting reference levels and limits for good ecological condition in terrestrial ecosystems. Insights from a case study based on the IBECA approach. Ecological Indicators 116: 106492.

Jakobsson, S., Evju, M., Framstad, E., Imbert, A., Lyngstad, A., Sickel, H., Sverdrup-Thygeson, A., Töpper, J., Vandvik, V., Velle, L.G., Aarrestad, P.A. & Nybø, S. 2021. An index-based assessment of ecological condition and its links to international frameworks. Ecological Indicators 124: 107252.

Tingstad, L., Evju, M., Sickel, H., & Töpper, J. 2019. Utvikling av nasjonal arealrepresentativ naturovervåking (ANO). Forslag til gjennomføring, protokoller og kostnadsvurderinger med utgangspunkt i erfaringer fra uttesting i Trøndelag. NINA Rapport 1642.

Töpper, J. & Jakobsson, S. 2021. The Index-Based Ecological Condition Assessment (IBECA) - Technical protocol, version 1.0. NINA Report 1967. Norwegian Institute for Nature Research.

Töpper, J., Velle, L.G. & Vandvik, V. 2018. Developing a method for assessment of ecological state based on indicator values after Ellenberg and Grime (revised edition). NINA Report 1529b. Norwegian Institute for Nature Research.

Tyler, T., Herbertsson, L., Olofsson, J., & Olsson, P. A. 2021. Ecological indicator and traits values for Swedish vascular plants. Ecological In-dicators, 120. doi:10.1016/j.ecolind.2020.106923


## Analyses
### Data sets

ANO data



Plant indicators from Tyler et al. (2021)


Generalized species lists NiN


#### Data handling
- Checking for errors
- Checking species nomenclature in the different species lists to make species and indicator data possible to merge
- Merging indicator data with monitoring data and indicator data with reference data
(not shown here, but documented in the code)


leaving us with the monitoring data including plant indicators (ANO.sp.ind) and the reference data including plant indicators (NiN.wetland.cov)


```r
head(ANO.sp.ind)
#>      Species art_dekning
#> 1 Abies alba           0
#> 2 Abies alba           0
#> 3 Abies alba           0
#> 4 Abies alba           0
#> 5 Abies alba           0
#> 6 Abies alba           0
#>                           ParentGlobalID Light Moisture
#> 1 {CB1796B9-01F5-4109-B44E-4582CA855F93}     2        5
#> 2 {AB9ED5C2-E906-4C73-B543-EC6CB28B39D5}     2        5
#> 3 {32A9B462-5483-4D47-ADAF-78F11AF201AA}     2        5
#> 4 {004C000D-459B-4244-96F4-4FF8B06454D4}     2        5
#> 5 {B7DD61EE-A113-4486-A4B8-D50ACAAC648B}     2        5
#> 6 {0431743B-F268-4819-98F7-FFB7006E55BA}     2        5
#>   Soil_reaction_pH Nitrogen
#> 1                5        5
#> 2                5        5
#> 3                5        5
#> 4                5        5
#> 5                5        5
#> 6                5        5
head(NiN.wetland.cov)
#>                        sp V3-C1a V3-C1b V3-C1c V3-C1d
#> 1    Abietinella abietina      0      0      0      0
#> 2        Acer platanoides      0      0      0      0
#> 3    Achillea millefolium      0      0      0      0
#> 4       Achillea ptarmica      0      0      0      0
#> 5         Acinos arvensis      0      0      0      0
#> 6 Aconitum septentrionale      0      0      0      0
#>   V3-C1e V1-C1a V1-C1b V1-C1c V1-C1d V1-C1e V1-C2a V1-C2b
#> 1      0      0      0      0      0      0      0      0
#> 2      0      0      0      0      0      0      0      0
#> 3      0      0      0      0      0      0      0      0
#> 4      0      0      0      0      0      0      0      0
#> 5      0      0      0      0      0      0      0      0
#> 6      0      0      0      0      0      0      0      0
#>   V1-C2c V1-C2d V1-C3a V1-C3b V1-C3c V1-C3d V1-C4a V1-C4b
#> 1      0      0      0      0      0      0      0      0
#> 2      0      0      0      0      0      0      0      0
#> 3      0      0      0      0      0      0      0      0
#> 4      0      0      0      0      0      0      0      0
#> 5      0      0      0      0      0      0      0      0
#> 6      0      0      0      0      0      0      0      0
#>   V1-C4c V1-C4d V1-C4e V1-C4f V1-C4g V1-C4h V3-C2 V1-C5
#> 1      0      0      0      0      0      0     0     0
#> 2      0      0      0      0      0      0     0     0
#> 3      0      0      0      0      0      0     0     0
#> 4      0      0      0      0      0      0     0     0
#> 5      0      0      0      0      0      0     0     0
#> 6      0      0      0      0      0      0     0     0
#>   V1-C6a V1-C6b V1-C7a V1-C7b V1-C8a V1-C8b V2-C1a V2-C1b
#> 1      0      0      0      0      0      0      0      0
#> 2      0      0      0      0      0      0      0      0
#> 3      0      0      0      0      0      0      0      0
#> 4      0      0      0      0      0      0      0      0
#> 5      0      0      0      0      0      0      0      0
#> 6      0      0      0      0      0      0      0      0
#>   V2-C2a V2-C2b V2-C3a V2-C3b V4-C2 V4-C3 V8-C1 V8-C2 V8-C3
#> 1      0      0      0      0     0     0     0     0     0
#> 2      0      0      0      0     0     0     0     0     0
#> 3      0      0      0      0     0     0     0     0     0
#> 4      0      0      0      0     0     0     0     0     0
#> 5      0      0      0      0     0     0     0     0     0
#> 6      0      0      0      0     0     0     0     0     0
#>   Light Moisture Soil_reaction_pH Nitrogen
#> 1    NA       NA               NA       NA
#> 2     4        4                6        5
#> 3     6        2                5        5
#> 4     5        6                4        4
#> 5     7        1                7        3
#> 6     4        5                7        7
```
For each ecosystem type with a NiN species list, we can calculate a community weighted mean (CWM) for the relevant functional plant indicators.
For wetland ecosystem we are testing "Light", "Moisture", "Soil_reaction_pH", and "Nitrogen". In order to get distributions of CWMs rather than one single value (for comparison with the empirical testing data) the NiN lists can be bootstrapped.

##### bootstrap function for frequency abundance
- function to calculate community weighted means of selected indicator values (ind)
- for species lists (sp) with given abundances in percent (or on a scale from 0 to 1) in one or more 'sites' (abun)
- with a given number of iterations (iter),
- with species given a certain minimum abundance occurring in all bootstraps (obl), and
- with a given re-sampling ratio of the original species list (rat)
- in every bootstrap iteration the abundance of the sampled species can be randomly changed by a limited amount if wished by introducing a re-sampling of abundance values from adjacent abundance steps with a certain probability (var.abun)



Running the bootstraps


```r
colnames(NiN.wetland)
# 1st column is the species
# 2nd-46th column is the abundances of sp in different ecosystem types
# 47th-50th column is the indicator values of the respective species
# we choose 1000 iterations
# species with abundance 1 (i.e. a max of 100%, must be included in each sample)
# each sample re-samples 2/3 of the number of species
# the abundance of the re-sampled species may vary (see bootstrap function for details)
wetland.ref.cov <- indBoot.freq(sp=NiN.wetland.cov[,1],abun=NiN.wetland.cov[,2:46],ind=NiN.wetland.cov[,47:50],
                          iter=1000,obl=1,rat=2/3,var.abun=T)

# fixing NaNs
for (i in 1:length(wetland.ref.cov) ) {
  for (j in 1:ncol(wetland.ref.cov[[i]]) ) {
    v <- wetland.ref.cov[[i]][,j]
    v[is.nan(v)] <- NA
    wetland.ref.cov[[i]][,j] <- v
  }
}
```




```r
head(wetland.ref.cov[[1]])
#>     V3-C1a   V3-C1b   V3-C1c   V3-C1d   V3-C1e   V1-C1a
#> 1 6.336842 5.702703 5.891986 5.407407 5.284661 5.682713
#> 2 6.162896 5.603412 5.233202 5.353870 5.077465 5.908840
#> 3 5.807692 6.099119 5.567627 5.296296 5.269912 6.087065
#> 4 6.775087 5.789572 5.493739 5.475034 5.269912 6.352518
#> 5 5.903114 5.789572 5.641694 5.492308 5.007634 6.364508
#> 6 6.336842 5.726054 5.668407 5.569579 5.178284 5.616307
#>     V1-C1b   V1-C1c   V1-C1d   V1-C1e   V1-C2a   V1-C2b
#> 1 5.723592 5.291436 5.353811 5.171986 5.823009 5.360731
#> 2 5.667160 5.929448 5.263294 5.245902 6.299618 5.416517
#> 3 6.065979 5.575145 5.536041 5.169304 5.894265 5.898420
#> 4 5.483051 5.570014 5.728625 5.022152 5.849462 5.354067
#> 5 5.517544 5.720264 5.458237 5.034188 5.867384 5.418605
#> 6 5.634868 5.710968 5.466031 4.925319 5.891344 5.359712
#>     V1-C2c   V1-C2d   V1-C3a   V1-C3b   V1-C3c   V1-C3d
#> 1 5.617886 5.255973 5.879501 5.451770 5.150421 5.454386
#> 2 5.716802 5.514938 6.344234 5.197347 5.304290 5.319415
#> 3 5.455844 5.415879 5.713128 5.320140 5.617048 5.505593
#> 4 5.591304 5.561783 5.722591 5.573379 5.204703 5.590814
#> 5 5.108579 5.505747 5.830116 5.317019 5.466457 5.370787
#> 6 5.739508 5.353218 5.906937 5.390173 5.092166 5.493927
#>     V1-C4a   V1-C4b   V1-C4c   V1-C4d   V1-C4e   V1-C4f
#> 1 6.036179 5.361275 5.287129 5.246544 5.826291 6.096953
#> 2 5.798913 5.616487 5.851117 5.579498 6.095665 5.593711
#> 3 6.293651 5.648649 5.619327 5.577703 5.855586 5.934783
#> 4 5.889374 5.685484 5.371715 5.093677 5.851802 5.616374
#> 5 5.776280 5.713755 5.469660 5.717724 5.981818 5.697906
#> 6 6.177054 5.651599 5.235872 5.522613 5.779343 5.812823
#>     V1-C4g   V1-C4h    V3-C2    V1-C5   V1-C6a   V1-C6b
#> 1 5.435681 4.918367 4.994775 4.727076 4.996255 4.630435
#> 2 5.651721 5.438084 5.015432 4.652138 5.033333 4.773573
#> 3 5.580581 5.851128 4.773709 4.726855 4.904824 4.773680
#> 4 5.151030 5.386395 4.870244 4.667209 4.994337 4.894553
#> 5 5.566054 5.235374 4.886616 4.814668 4.880233 4.836431
#> 6 5.526852 5.490647 4.876712 4.749831 5.161597 4.823015
#>     V1-C7a   V1-C7b   V1-C8a   V1-C8b   V2-C1a   V2-C1b
#> 1 5.005076 4.927380 4.901750 4.761329 4.395683 4.030844
#> 2 4.801927 4.846557 5.127968 4.896014 4.188559 4.155105
#> 3 4.572449 4.504233 5.070941 4.808081 4.110694 4.091158
#> 4 4.884762 4.812344 4.881336 5.094451 4.260394 4.165308
#> 5 4.783305 4.893412 4.988858 4.848684 4.273535 4.234498
#> 6 4.814433 4.869048 4.859482 4.702290 4.174721 4.005499
#>     V2-C2a   V2-C2b   V2-C3a   V2-C3b    V4-C2    V4-C3
#> 1 4.660793 3.813056 4.138365 3.871470 4.859013 4.983607
#> 2 4.615487 4.059268 4.056991 3.942257 5.042409 5.249798
#> 3 4.479858 3.668596 4.187162 4.057981 5.047048 4.992795
#> 4 4.733990 3.914540 4.233787 4.077534 4.738647 5.027458
#> 5 4.586890 3.797063 4.404070 3.836165 4.844905 4.734485
#> 6 4.520000 4.033181 4.377852 3.859554 4.999081 4.966232
#>      V8-C1    V8-C2    V8-C3
#> 1 4.767647 4.595033 4.620053
#> 2 4.660854 4.547687 4.647333
#> 3 4.679577 4.609576 4.564313
#> 4 4.835616 4.512004 4.539221
#> 5 4.500463 4.502172 4.762053
#> 6 4.805742 4.491489 4.608948
```

This results in an R-list with a slot for every selected indicator, and in every slot there's a data frame with as many columns as there are NiN species lists and as many rows as there were iterations in the bootstrap.
Next, we need to derive scaling values from these bootstrap-lists (the columns) for every mapping unit in NiN. Here, we define things in the following way:

- Median = reference values
- 0.025 and 0.975 quantiles = lower and upper limit values
- min and max of the respective indicator's scale = min/max values


```
#>     V3-C1a   V3-C1b   V3-C1c   V3-C1d   V3-C1e   V1-C1a
#> 1 6.336842 5.702703 5.891986 5.407407 5.284661 5.682713
#> 2 6.162896 5.603412 5.233202 5.353870 5.077465 5.908840
#> 3 5.807692 6.099119 5.567627 5.296296 5.269912 6.087065
#> 4 6.775087 5.789572 5.493739 5.475034 5.269912 6.352518
#> 5 5.903114 5.789572 5.641694 5.492308 5.007634 6.364508
#> 6 6.336842 5.726054 5.668407 5.569579 5.178284 5.616307
#>     V1-C1b   V1-C1c   V1-C1d   V1-C1e   V1-C2a   V1-C2b
#> 1 5.723592 5.291436 5.353811 5.171986 5.823009 5.360731
#> 2 5.667160 5.929448 5.263294 5.245902 6.299618 5.416517
#> 3 6.065979 5.575145 5.536041 5.169304 5.894265 5.898420
#> 4 5.483051 5.570014 5.728625 5.022152 5.849462 5.354067
#> 5 5.517544 5.720264 5.458237 5.034188 5.867384 5.418605
#> 6 5.634868 5.710968 5.466031 4.925319 5.891344 5.359712
#>     V1-C2c   V1-C2d   V1-C3a   V1-C3b   V1-C3c   V1-C3d
#> 1 5.617886 5.255973 5.879501 5.451770 5.150421 5.454386
#> 2 5.716802 5.514938 6.344234 5.197347 5.304290 5.319415
#> 3 5.455844 5.415879 5.713128 5.320140 5.617048 5.505593
#> 4 5.591304 5.561783 5.722591 5.573379 5.204703 5.590814
#> 5 5.108579 5.505747 5.830116 5.317019 5.466457 5.370787
#> 6 5.739508 5.353218 5.906937 5.390173 5.092166 5.493927
#>     V1-C4a   V1-C4b   V1-C4c   V1-C4d   V1-C4e   V1-C4f
#> 1 6.036179 5.361275 5.287129 5.246544 5.826291 6.096953
#> 2 5.798913 5.616487 5.851117 5.579498 6.095665 5.593711
#> 3 6.293651 5.648649 5.619327 5.577703 5.855586 5.934783
#> 4 5.889374 5.685484 5.371715 5.093677 5.851802 5.616374
#> 5 5.776280 5.713755 5.469660 5.717724 5.981818 5.697906
#> 6 6.177054 5.651599 5.235872 5.522613 5.779343 5.812823
#>     V1-C4g   V1-C4h    V3-C2    V1-C5   V1-C6a   V1-C6b
#> 1 5.435681 4.918367 4.994775 4.727076 4.996255 4.630435
#> 2 5.651721 5.438084 5.015432 4.652138 5.033333 4.773573
#> 3 5.580581 5.851128 4.773709 4.726855 4.904824 4.773680
#> 4 5.151030 5.386395 4.870244 4.667209 4.994337 4.894553
#> 5 5.566054 5.235374 4.886616 4.814668 4.880233 4.836431
#> 6 5.526852 5.490647 4.876712 4.749831 5.161597 4.823015
#>     V1-C7a   V1-C7b   V1-C8a   V1-C8b   V2-C1a   V2-C1b
#> 1 5.005076 4.927380 4.901750 4.761329 4.395683 4.030844
#> 2 4.801927 4.846557 5.127968 4.896014 4.188559 4.155105
#> 3 4.572449 4.504233 5.070941 4.808081 4.110694 4.091158
#> 4 4.884762 4.812344 4.881336 5.094451 4.260394 4.165308
#> 5 4.783305 4.893412 4.988858 4.848684 4.273535 4.234498
#> 6 4.814433 4.869048 4.859482 4.702290 4.174721 4.005499
#>     V2-C2a   V2-C2b   V2-C3a   V2-C3b    V4-C2    V4-C3
#> 1 4.660793 3.813056 4.138365 3.871470 4.859013 4.983607
#> 2 4.615487 4.059268 4.056991 3.942257 5.042409 5.249798
#> 3 4.479858 3.668596 4.187162 4.057981 5.047048 4.992795
#> 4 4.733990 3.914540 4.233787 4.077534 4.738647 5.027458
#> 5 4.586890 3.797063 4.404070 3.836165 4.844905 4.734485
#> 6 4.520000 4.033181 4.377852 3.859554 4.999081 4.966232
#>      V8-C1    V8-C2    V8-C3
#> 1 4.767647 4.595033 4.620053
#> 2 4.660854 4.547687 4.647333
#> 3 4.679577 4.609576 4.564313
#> 4 4.835616 4.512004 4.539221
#> 5 4.500463 4.502172 4.762053
#> 6 4.805742 4.491489 4.608948
#>  [1] V3-C1a V3-C1b V3-C1c V3-C1d V3-C1e V1-C1a V1-C1b V1-C1c
#>  [9] V1-C1d V1-C1e V1-C2a V1-C2b V1-C2c V1-C2d V1-C3a V1-C3b
#> [17] V1-C3c V1-C3d V1-C4a V1-C4b V1-C4c V1-C4d V1-C4e V1-C4f
#> [25] V1-C4g V1-C4h V3-C2  V1-C5  V1-C6a V1-C6b V1-C7a V1-C7b
#> [33] V1-C8a V1-C8b V2-C1a V2-C1b V2-C2a V2-C2b V2-C3a V2-C3b
#> [41] V4-C2  V4-C3  V8-C1  V8-C2  V8-C3 
#> <0 rows> (or 0-length row.names)
#>  [1] "V3-C1" "V1-C1" "V1-C2" "V1-C3" "V1-C4" "V3-C2" "V1-C5"
#>  [8] "V1-C6" "V1-C7" "V1-C8" "V2-C1" "V2-C2" "V2-C3" "V4-C2"
#> [15] "V4-C3" "V8-C1" "V8-C2" "V8-C3"
#>  [1] "V3-C1a" "V3-C1b" "V3-C1c" "V3-C1d" "V3-C1e" "V1-C1a"
#>  [7] "V1-C1b" "V1-C1c" "V1-C1d" "V1-C1e" "V1-C2a" "V1-C2b"
#> [13] "V1-C2c" "V1-C2d" "V1-C3a" "V1-C3b" "V1-C3c" "V1-C3d"
#> [19] "V1-C4a" "V1-C4b" "V1-C4c" "V1-C4d" "V1-C4e" "V1-C4f"
#> [25] "V1-C4g" "V1-C4h" "V3-C2"  "V1-C5"  "V1-C6a" "V1-C6b"
#> [31] "V1-C7a" "V1-C7b" "V1-C8a" "V1-C8b" "V2-C1a" "V2-C1b"
#> [37] "V2-C2a" "V2-C2b" "V2-C3a" "V2-C3b" "V4-C2"  "V4-C3" 
#> [43] "V8-C1"  "V8-C2"  "V8-C3"
#>  [1] "V3-C1" "V1-C1" "V1-C2" "V1-C3" "V1-C4" "V1-C6" "V1-C7"
#>  [8] "V1-C8" "V2-C1" "V2-C2" "V2-C3"
#> [1] 1 2 3 4 5
#>          V1       V2       V3       V4       V5       V6
#> 1  4.736150 4.900265 5.120000 5.201878 5.736585 6.151852
#> 2  4.597880 4.760764 4.902329 5.391473 5.821132 6.265910
#> 3  4.610424 4.901870 5.232242 6.708205 7.088321 7.496453
#> 4  4.677531 4.996095 5.309336 6.599488 6.935913 7.284055
#> 5  4.464570 4.709785 4.972819 6.803539 7.217742 7.663696
#> 6  4.425727 4.586035 4.779277 6.925680 7.251258 7.577229
#> 7  4.490343 4.635103 4.790331 7.024416 7.382590 7.755543
#> 8  4.892675 5.594595 6.567474 5.528728 6.907166 8.486166
#> 9  4.958721 5.575057 6.315900 5.735756 7.280132 8.718040
#> 10 5.139566 5.522530 6.264477 6.426842 7.915167 8.924438
#> 11 5.089261 5.450281 6.152334 7.113426 8.216718 9.016390
#> 12 5.126794 5.647878 6.162793 7.065646 8.040734 8.935004
#> 13 4.525242 4.816224 5.124243 6.016056 7.233970 8.688171
#> 14 4.504224 4.804565 5.059866 6.326991 7.271581 8.463120
#> 15 4.558245 4.915094 5.303735 6.258498 7.091729 7.784715
#> 16 3.974819 4.173047 4.598703 5.112448 5.859056 8.126484
#> 17 3.685444 4.256174 4.700616 5.513549 6.488092 7.920221
#> 18 3.631843 4.125515 4.457248 6.004292 6.772113 7.759210
#>          V7       V8       V9      V10      V11      V12
#> 1  1.831766 2.243827 2.533659 1.811728 1.952862 2.142723
#> 2  2.155809 2.516520 2.836431 1.853110 2.167561 2.438285
#> 3  3.437916 3.787654 4.212773 3.008428 3.323729 3.678983
#> 4  3.953983 4.388411 4.813829 3.262604 3.807000 4.234730
#> 5  3.889345 4.163711 4.486426 4.148721 4.462636 4.812027
#> 6  4.381745 4.575937 4.795270 5.142488 5.459677 5.816705
#> 7  4.682191 4.876376 5.070794 5.629958 5.900868 6.152190
#> 8  1.494071 2.013841 2.868778 1.072464 1.494737 1.996790
#> 9  1.697084 2.099490 3.207349 1.389752 1.667114 2.134328
#> 10 2.076494 2.837740 3.691609 1.567785 1.974614 2.519928
#> 11 2.768193 3.604344 4.317389 1.746634 2.396491 3.048414
#> 12 3.410753 4.508963 5.601644 2.053753 2.685903 3.184157
#> 13 2.655389 3.091580 3.699116 2.303992 2.761761 3.191950
#> 14 3.246374 3.547120 3.916825 2.846378 3.186189 3.487493
#> 15 3.808178 4.212409 4.677554 3.058802 3.517028 4.025923
#> 16 2.628539 2.942611 3.685835 2.899263 3.211879 3.767787
#> 17 3.196779 3.618644 4.074977 3.605832 4.032121 4.559970
#> 18 3.783875 4.097649 4.434308 4.489434 4.900636 5.338214
#>      NiN
#> 1  V3-C2
#> 2  V1-C5
#> 3  V4-C2
#> 4  V4-C3
#> 5  V8-C1
#> 6  V8-C2
#> 7  V8-C3
#> 8  V3-C1
#> 9  V1-C1
#> 10 V1-C2
#> 11 V1-C3
#> 12 V1-C4
#> 13 V1-C6
#> 14 V1-C7
#> 15 V1-C8
#> 16 V2-C1
#> 17 V2-C2
#> 18 V2-C3
#>      V1   V2   V3   V4   V5   V6   V7   V8   V9  V10  V11
#> 1  4.74 4.90 5.12 5.20 5.74 6.15 1.83 2.24 2.53 1.81 1.95
#> 2  4.60 4.76 4.90 5.39 5.82 6.27 2.16 2.52 2.84 1.85 2.17
#> 3  4.61 4.90 5.23 6.71 7.09 7.50 3.44 3.79 4.21 3.01 3.32
#> 4  4.68 5.00 5.31 6.60 6.94 7.28 3.95 4.39 4.81 3.26 3.81
#> 5  4.46 4.71 4.97 6.80 7.22 7.66 3.89 4.16 4.49 4.15 4.46
#> 6  4.43 4.59 4.78 6.93 7.25 7.58 4.38 4.58 4.80 5.14 5.46
#> 7  4.49 4.64 4.79 7.02 7.38 7.76 4.68 4.88 5.07 5.63 5.90
#> 8  4.89 5.59 6.57 5.53 6.91 8.49 1.49 2.01 2.87 1.07 1.49
#> 9  4.96 5.58 6.32 5.74 7.28 8.72 1.70 2.10 3.21 1.39 1.67
#> 10 5.14 5.52 6.26 6.43 7.92 8.92 2.08 2.84 3.69 1.57 1.97
#> 11 5.09 5.45 6.15 7.11 8.22 9.02 2.77 3.60 4.32 1.75 2.40
#> 12 5.13 5.65 6.16 7.07 8.04 8.94 3.41 4.51 5.60 2.05 2.69
#> 13 4.53 4.82 5.12 6.02 7.23 8.69 2.66 3.09 3.70 2.30 2.76
#> 14 4.50 4.80 5.06 6.33 7.27 8.46 3.25 3.55 3.92 2.85 3.19
#> 15 4.56 4.92 5.30 6.26 7.09 7.78 3.81 4.21 4.68 3.06 3.52
#> 16 3.97 4.17 4.60 5.11 5.86 8.13 2.63 2.94 3.69 2.90 3.21
#> 17 3.69 4.26 4.70 5.51 6.49 7.92 3.20 3.62 4.07 3.61 4.03
#> 18 3.63 4.13 4.46 6.00 6.77 7.76 3.78 4.10 4.43 4.49 4.90
#>     V12
#> 1  2.14
#> 2  2.44
#> 3  3.68
#> 4  4.23
#> 5  4.81
#> 6  5.82
#> 7  6.15
#> 8  2.00
#> 9  2.13
#> 10 2.52
#> 11 3.05
#> 12 3.18
#> 13 3.19
#> 14 3.49
#> 15 4.03
#> 16 3.77
#> 17 4.56
#> 18 5.34
#>    Light_q2.5      Light_q50      Light_q97.5   
#>  Min.   :3.632   Min.   :4.126   Min.   :4.457  
#>  1st Qu.:4.471   1st Qu.:4.654   1st Qu.:4.818  
#>  Median :4.578   Median :4.858   Median :5.122  
#>  Mean   :4.561   Mean   :4.909   Mean   :5.323  
#>  3rd Qu.:4.854   3rd Qu.:5.337   3rd Qu.:5.942  
#>  Max.   :5.140   Max.   :5.648   Max.   :6.567  
#>    Moist_q2.5      Moist_q50      Moist_q97.5   
#>  Min.   :5.112   Min.   :5.737   Min.   :6.152  
#>  1st Qu.:5.580   1st Qu.:6.806   1st Qu.:7.599  
#>  Median :6.293   Median :7.155   Median :7.852  
#>  Mean   :6.209   Mean   :7.028   Mean   :7.945  
#>  3rd Qu.:6.780   3rd Qu.:7.278   3rd Qu.:8.638  
#>  Max.   :7.113   Max.   :8.217   Max.   :9.016  
#>     pH_q2.5          pH_q50         pH_q97.5    
#>  Min.   :1.494   Min.   :2.014   Min.   :2.534  
#>  1st Qu.:2.274   1st Qu.:2.864   1st Qu.:3.687  
#>  Median :3.222   Median :3.611   Median :4.144  
#>  Mean   :3.061   Mean   :3.507   Mean   :4.051  
#>  3rd Qu.:3.802   3rd Qu.:4.200   3rd Qu.:4.630  
#>  Max.   :4.682   Max.   :4.876   Max.   :5.602  
#>  Nitrogen_q2.5    Nitrogen_q50   Nitrogen_q97.5 
#>  Min.   :1.072   Min.   :1.495   Min.   :1.997  
#>  1st Qu.:1.822   1st Qu.:2.225   1st Qu.:2.652  
#>  Median :2.873   Median :3.199   Median :3.583  
#>  Mean   :2.883   Mean   :3.272   Mean   :3.696  
#>  3rd Qu.:3.520   3rd Qu.:3.976   3rd Qu.:4.479  
#>  Max.   :5.630   Max.   :5.901   Max.   :6.152  
#>      NiN           
#>  Length:18         
#>  Class :character  
#>  Mode  :character  
#>                    
#>                    
#> 
#>    Light_q2.5 Light_q50 Light_q97.5 Moist_q2.5 Moist_q50
#> 1    4.736150  4.900265    5.120000   5.201878  5.736585
#> 2    4.597880  4.760764    4.902329   5.391473  5.821132
#> 3    4.610424  4.901870    5.232242   6.708205  7.088321
#> 4    4.677531  4.996095    5.309336   6.599488  6.935913
#> 5    4.464570  4.709785    4.972819   6.803539  7.217742
#> 6    4.425727  4.586035    4.779277   6.925680  7.251258
#> 7    4.490343  4.635103    4.790331   7.024416  7.382590
#> 8    4.892675  5.594595    6.567474   5.528728  6.907166
#> 9    4.958721  5.575057    6.315900   5.735756  7.280132
#> 10   5.139566  5.522530    6.264477   6.426842  7.915167
#> 11   5.089261  5.450281    6.152334   7.113426  8.216718
#> 12   5.126794  5.647878    6.162793   7.065646  8.040734
#> 13   4.525242  4.816224    5.124243   6.016056  7.233970
#> 14   4.504224  4.804565    5.059866   6.326991  7.271581
#> 15   4.558245  4.915094    5.303735   6.258498  7.091729
#> 16   3.974819  4.173047    4.598703   5.112448  5.859056
#> 17   3.685444  4.256174    4.700616   5.513549  6.488092
#> 18   3.631843  4.125515    4.457248   6.004292  6.772113
#>    Moist_q97.5  pH_q2.5   pH_q50 pH_q97.5 Nitrogen_q2.5
#> 1     6.151852 1.831766 2.243827 2.533659      1.811728
#> 2     6.265910 2.155809 2.516520 2.836431      1.853110
#> 3     7.496453 3.437916 3.787654 4.212773      3.008428
#> 4     7.284055 3.953983 4.388411 4.813829      3.262604
#> 5     7.663696 3.889345 4.163711 4.486426      4.148721
#> 6     7.577229 4.381745 4.575937 4.795270      5.142488
#> 7     7.755543 4.682191 4.876376 5.070794      5.629958
#> 8     8.486166 1.494071 2.013841 2.868778      1.072464
#> 9     8.718040 1.697084 2.099490 3.207349      1.389752
#> 10    8.924438 2.076494 2.837740 3.691609      1.567785
#> 11    9.016390 2.768193 3.604344 4.317389      1.746634
#> 12    8.935004 3.410753 4.508963 5.601644      2.053753
#> 13    8.688171 2.655389 3.091580 3.699116      2.303992
#> 14    8.463120 3.246374 3.547120 3.916825      2.846378
#> 15    7.784715 3.808178 4.212409 4.677554      3.058802
#> 16    8.126484 2.628539 2.942611 3.685835      2.899263
#> 17    7.920221 3.196779 3.618644 4.074977      3.605832
#> 18    7.759210 3.783875 4.097649 4.434308      4.489434
#>    Nitrogen_q50 Nitrogen_q97.5    NiN
#> 1      1.952862       2.142723 V3-C-2
#> 2      2.167561       2.438285 V1-C-5
#> 3      3.323729       3.678983 V4-C-2
#> 4      3.807000       4.234730 V4-C-3
#> 5      4.462636       4.812027 V8-C-1
#> 6      5.459677       5.816705 V8-C-2
#> 7      5.900868       6.152190 V8-C-3
#> 8      1.494737       1.996790 V3-C-1
#> 9      1.667114       2.134328 V1-C-1
#> 10     1.974614       2.519928 V1-C-2
#> 11     2.396491       3.048414 V1-C-3
#> 12     2.685903       3.184157 V1-C-4
#> 13     2.761761       3.191950 V1-C-6
#> 14     3.186189       3.487493 V1-C-7
#> 15     3.517028       4.025923 V1-C-8
#> 16     3.211879       3.767787 V2-C-1
#> 17     4.032121       4.559970 V2-C-2
#> 18     4.900636       5.338214 V2-C-3
#>          N1 hoved  grunn county region       Ind       Rv
#> 1   wetland    NA V3-C-2    all    all    Light1 4.900265
#> 2   wetland    NA V3-C-2    all    all    Light2 4.900265
#> 3   wetland    NA V1-C-5    all    all    Light1 4.760764
#> 4   wetland    NA V1-C-5    all    all    Light2 4.760764
#> 5   wetland    NA V4-C-2    all    all    Light1 4.901870
#> 6   wetland    NA V4-C-2    all    all    Light2 4.901870
#> 7   wetland    NA V4-C-3    all    all    Light1 4.996095
#> 8   wetland    NA V4-C-3    all    all    Light2 4.996095
#> 9   wetland    NA V8-C-1    all    all    Light1 4.709785
#> 10  wetland    NA V8-C-1    all    all    Light2 4.709785
#> 11  wetland    NA V8-C-2    all    all    Light1 4.586035
#> 12  wetland    NA V8-C-2    all    all    Light2 4.586035
#> 13  wetland    NA V8-C-3    all    all    Light1 4.635103
#> 14  wetland    NA V8-C-3    all    all    Light2 4.635103
#> 15  wetland    NA V3-C-1    all    all    Light1 5.594595
#> 16  wetland    NA V3-C-1    all    all    Light2 5.594595
#> 17  wetland    NA V1-C-1    all    all    Light1 5.575057
#> 18  wetland    NA V1-C-1    all    all    Light2 5.575057
#> 19  wetland    NA V1-C-2    all    all    Light1 5.522530
#> 20  wetland    NA V1-C-2    all    all    Light2 5.522530
#> 21  wetland    NA V1-C-3    all    all    Light1 5.450281
#> 22  wetland    NA V1-C-3    all    all    Light2 5.450281
#> 23  wetland    NA V1-C-4    all    all    Light1 5.647878
#> 24  wetland    NA V1-C-4    all    all    Light2 5.647878
#> 25  wetland    NA V1-C-6    all    all    Light1 4.816224
#> 26  wetland    NA V1-C-6    all    all    Light2 4.816224
#> 27  wetland    NA V1-C-7    all    all    Light1 4.804565
#> 28  wetland    NA V1-C-7    all    all    Light2 4.804565
#> 29  wetland    NA V1-C-8    all    all    Light1 4.915094
#> 30  wetland    NA V1-C-8    all    all    Light2 4.915094
#> 31  wetland    NA V2-C-1    all    all    Light1 4.173047
#> 32  wetland    NA V2-C-1    all    all    Light2 4.173047
#> 33  wetland    NA V2-C-2    all    all    Light1 4.256174
#> 34  wetland    NA V2-C-2    all    all    Light2 4.256174
#> 35  wetland    NA V2-C-3    all    all    Light1 4.125515
#> 36  wetland    NA V2-C-3    all    all    Light2 4.125515
#> 37  wetland    NA V3-C-2    all    all    Moist1 5.736585
#> 38  wetland    NA V3-C-2    all    all    Moist2 5.736585
#> 39  wetland    NA V1-C-5    all    all    Moist1 5.821132
#> 40  wetland    NA V1-C-5    all    all    Moist2 5.821132
#> 41  wetland    NA V4-C-2    all    all    Moist1 7.088321
#> 42  wetland    NA V4-C-2    all    all    Moist2 7.088321
#> 43  wetland    NA V4-C-3    all    all    Moist1 6.935913
#> 44  wetland    NA V4-C-3    all    all    Moist2 6.935913
#> 45  wetland    NA V8-C-1    all    all    Moist1 7.217742
#> 46  wetland    NA V8-C-1    all    all    Moist2 7.217742
#> 47  wetland    NA V8-C-2    all    all    Moist1 7.251258
#> 48  wetland    NA V8-C-2    all    all    Moist2 7.251258
#> 49  wetland    NA V8-C-3    all    all    Moist1 7.382590
#> 50  wetland    NA V8-C-3    all    all    Moist2 7.382590
#> 51  wetland    NA V3-C-1    all    all    Moist1 6.907166
#> 52  wetland    NA V3-C-1    all    all    Moist2 6.907166
#> 53  wetland    NA V1-C-1    all    all    Moist1 7.280132
#> 54  wetland    NA V1-C-1    all    all    Moist2 7.280132
#> 55  wetland    NA V1-C-2    all    all    Moist1 7.915167
#> 56  wetland    NA V1-C-2    all    all    Moist2 7.915167
#> 57  wetland    NA V1-C-3    all    all    Moist1 8.216718
#> 58  wetland    NA V1-C-3    all    all    Moist2 8.216718
#> 59  wetland    NA V1-C-4    all    all    Moist1 8.040734
#> 60  wetland    NA V1-C-4    all    all    Moist2 8.040734
#> 61  wetland    NA V1-C-6    all    all    Moist1 7.233970
#> 62  wetland    NA V1-C-6    all    all    Moist2 7.233970
#> 63  wetland    NA V1-C-7    all    all    Moist1 7.271581
#> 64  wetland    NA V1-C-7    all    all    Moist2 7.271581
#> 65  wetland    NA V1-C-8    all    all    Moist1 7.091729
#> 66  wetland    NA V1-C-8    all    all    Moist2 7.091729
#> 67  wetland    NA V2-C-1    all    all    Moist1 5.859056
#> 68  wetland    NA V2-C-1    all    all    Moist2 5.859056
#> 69  wetland    NA V2-C-2    all    all    Moist1 6.488092
#> 70  wetland    NA V2-C-2    all    all    Moist2 6.488092
#> 71  wetland    NA V2-C-3    all    all    Moist1 6.772113
#> 72  wetland    NA V2-C-3    all    all    Moist2 6.772113
#> 73  wetland    NA V3-C-2    all    all       pH1 2.243827
#> 74  wetland    NA V3-C-2    all    all       pH2 2.243827
#> 75  wetland    NA V1-C-5    all    all       pH1 2.516520
#> 76  wetland    NA V1-C-5    all    all       pH2 2.516520
#> 77  wetland    NA V4-C-2    all    all       pH1 3.787654
#> 78  wetland    NA V4-C-2    all    all       pH2 3.787654
#> 79  wetland    NA V4-C-3    all    all       pH1 4.388411
#> 80  wetland    NA V4-C-3    all    all       pH2 4.388411
#> 81  wetland    NA V8-C-1    all    all       pH1 4.163711
#> 82  wetland    NA V8-C-1    all    all       pH2 4.163711
#> 83  wetland    NA V8-C-2    all    all       pH1 4.575937
#> 84  wetland    NA V8-C-2    all    all       pH2 4.575937
#> 85  wetland    NA V8-C-3    all    all       pH1 4.876376
#> 86  wetland    NA V8-C-3    all    all       pH2 4.876376
#> 87  wetland    NA V3-C-1    all    all       pH1 2.013841
#> 88  wetland    NA V3-C-1    all    all       pH2 2.013841
#> 89  wetland    NA V1-C-1    all    all       pH1 2.099490
#> 90  wetland    NA V1-C-1    all    all       pH2 2.099490
#> 91  wetland    NA V1-C-2    all    all       pH1 2.837740
#> 92  wetland    NA V1-C-2    all    all       pH2 2.837740
#> 93  wetland    NA V1-C-3    all    all       pH1 3.604344
#> 94  wetland    NA V1-C-3    all    all       pH2 3.604344
#> 95  wetland    NA V1-C-4    all    all       pH1 4.508963
#> 96  wetland    NA V1-C-4    all    all       pH2 4.508963
#> 97  wetland    NA V1-C-6    all    all       pH1 3.091580
#> 98  wetland    NA V1-C-6    all    all       pH2 3.091580
#> 99  wetland    NA V1-C-7    all    all       pH1 3.547120
#> 100 wetland    NA V1-C-7    all    all       pH2 3.547120
#> 101 wetland    NA V1-C-8    all    all       pH1 4.212409
#> 102 wetland    NA V1-C-8    all    all       pH2 4.212409
#> 103 wetland    NA V2-C-1    all    all       pH1 2.942611
#> 104 wetland    NA V2-C-1    all    all       pH2 2.942611
#> 105 wetland    NA V2-C-2    all    all       pH1 3.618644
#> 106 wetland    NA V2-C-2    all    all       pH2 3.618644
#> 107 wetland    NA V2-C-3    all    all       pH1 4.097649
#> 108 wetland    NA V2-C-3    all    all       pH2 4.097649
#> 109 wetland    NA V3-C-2    all    all Nitrogen1 1.952862
#> 110 wetland    NA V3-C-2    all    all Nitrogen2 1.952862
#> 111 wetland    NA V1-C-5    all    all Nitrogen1 2.167561
#> 112 wetland    NA V1-C-5    all    all Nitrogen2 2.167561
#> 113 wetland    NA V4-C-2    all    all Nitrogen1 3.323729
#> 114 wetland    NA V4-C-2    all    all Nitrogen2 3.323729
#> 115 wetland    NA V4-C-3    all    all Nitrogen1 3.807000
#> 116 wetland    NA V4-C-3    all    all Nitrogen2 3.807000
#> 117 wetland    NA V8-C-1    all    all Nitrogen1 4.462636
#> 118 wetland    NA V8-C-1    all    all Nitrogen2 4.462636
#> 119 wetland    NA V8-C-2    all    all Nitrogen1 5.459677
#> 120 wetland    NA V8-C-2    all    all Nitrogen2 5.459677
#> 121 wetland    NA V8-C-3    all    all Nitrogen1 5.900868
#> 122 wetland    NA V8-C-3    all    all Nitrogen2 5.900868
#> 123 wetland    NA V3-C-1    all    all Nitrogen1 1.494737
#> 124 wetland    NA V3-C-1    all    all Nitrogen2 1.494737
#> 125 wetland    NA V1-C-1    all    all Nitrogen1 1.667114
#> 126 wetland    NA V1-C-1    all    all Nitrogen2 1.667114
#> 127 wetland    NA V1-C-2    all    all Nitrogen1 1.974614
#> 128 wetland    NA V1-C-2    all    all Nitrogen2 1.974614
#> 129 wetland    NA V1-C-3    all    all Nitrogen1 2.396491
#> 130 wetland    NA V1-C-3    all    all Nitrogen2 2.396491
#> 131 wetland    NA V1-C-4    all    all Nitrogen1 2.685903
#> 132 wetland    NA V1-C-4    all    all Nitrogen2 2.685903
#> 133 wetland    NA V1-C-6    all    all Nitrogen1 2.761761
#> 134 wetland    NA V1-C-6    all    all Nitrogen2 2.761761
#> 135 wetland    NA V1-C-7    all    all Nitrogen1 3.186189
#> 136 wetland    NA V1-C-7    all    all Nitrogen2 3.186189
#> 137 wetland    NA V1-C-8    all    all Nitrogen1 3.517028
#> 138 wetland    NA V1-C-8    all    all Nitrogen2 3.517028
#> 139 wetland    NA V2-C-1    all    all Nitrogen1 3.211879
#> 140 wetland    NA V2-C-1    all    all Nitrogen2 3.211879
#> 141 wetland    NA V2-C-2    all    all Nitrogen1 4.032121
#> 142 wetland    NA V2-C-2    all    all Nitrogen2 4.032121
#> 143 wetland    NA V2-C-3    all    all Nitrogen1 4.900636
#> 144 wetland    NA V2-C-3    all    all Nitrogen2 4.900636
#>           Gv maxmin
#> 1   4.736150      1
#> 2   5.120000      7
#> 3   4.597880      1
#> 4   4.902329      7
#> 5   4.610424      1
#> 6   5.232242      7
#> 7   4.677531      1
#> 8   5.309336      7
#> 9   4.464570      1
#> 10  4.972819      7
#> 11  4.425727      1
#> 12  4.779277      7
#> 13  4.490343      1
#> 14  4.790331      7
#> 15  4.892675      1
#> 16  6.567474      7
#> 17  4.958721      1
#> 18  6.315900      7
#> 19  5.139566      1
#> 20  6.264477      7
#> 21  5.089261      1
#> 22  6.152334      7
#> 23  5.126794      1
#> 24  6.162793      7
#> 25  4.525242      1
#> 26  5.124243      7
#> 27  4.504224      1
#> 28  5.059866      7
#> 29  4.558245      1
#> 30  5.303735      7
#> 31  3.974819      1
#> 32  4.598703      7
#> 33  3.685444      1
#> 34  4.700616      7
#> 35  3.631843      1
#> 36  4.457248      7
#> 37  5.201878      1
#> 38  6.151852     12
#> 39  5.391473      1
#> 40  6.265910     12
#> 41  6.708205      1
#> 42  7.496453     12
#> 43  6.599488      1
#> 44  7.284055     12
#> 45  6.803539      1
#> 46  7.663696     12
#> 47  6.925680      1
#> 48  7.577229     12
#> 49  7.024416      1
#> 50  7.755543     12
#> 51  5.528728      1
#> 52  8.486166     12
#> 53  5.735756      1
#> 54  8.718040     12
#> 55  6.426842      1
#> 56  8.924438     12
#> 57  7.113426      1
#> 58  9.016390     12
#> 59  7.065646      1
#> 60  8.935004     12
#> 61  6.016056      1
#> 62  8.688171     12
#> 63  6.326991      1
#> 64  8.463120     12
#> 65  6.258498      1
#> 66  7.784715     12
#> 67  5.112448      1
#> 68  8.126484     12
#> 69  5.513549      1
#> 70  7.920221     12
#> 71  6.004292      1
#> 72  7.759210     12
#> 73  1.831766      1
#> 74  2.533659      8
#> 75  2.155809      1
#> 76  2.836431      8
#> 77  3.437916      1
#> 78  4.212773      8
#> 79  3.953983      1
#> 80  4.813829      8
#> 81  3.889345      1
#> 82  4.486426      8
#> 83  4.381745      1
#> 84  4.795270      8
#> 85  4.682191      1
#> 86  5.070794      8
#> 87  1.494071      1
#> 88  2.868778      8
#> 89  1.697084      1
#> 90  3.207349      8
#> 91  2.076494      1
#> 92  3.691609      8
#> 93  2.768193      1
#> 94  4.317389      8
#> 95  3.410753      1
#> 96  5.601644      8
#> 97  2.655389      1
#> 98  3.699116      8
#> 99  3.246374      1
#> 100 3.916825      8
#> 101 3.808178      1
#> 102 4.677554      8
#> 103 2.628539      1
#> 104 3.685835      8
#> 105 3.196779      1
#> 106 4.074977      8
#> 107 3.783875      1
#> 108 4.434308      8
#> 109 1.811728      1
#> 110 2.142723      9
#> 111 1.853110      1
#> 112 2.438285      9
#> 113 3.008428      1
#> 114 3.678983      9
#> 115 3.262604      1
#> 116 4.234730      9
#> 117 4.148721      1
#> 118 4.812027      9
#> 119 5.142488      1
#> 120 5.816705      9
#> 121 5.629958      1
#> 122 6.152190      9
#> 123 1.072464      1
#> 124 1.996790      9
#> 125 1.389752      1
#> 126 2.134328      9
#> 127 1.567785      1
#> 128 2.519928      9
#> 129 1.746634      1
#> 130 3.048414      9
#> 131 2.053753      1
#> 132 3.184157      9
#> 133 2.303992      1
#> 134 3.191950      9
#> 135 2.846378      1
#> 136 3.487493      9
#> 137 3.058802      1
#> 138 4.025923      9
#> 139 2.899263      1
#> 140 3.767787      9
#> 141 3.605832      1
#> 142 4.559970      9
#> 143 4.489434      1
#> 144 5.338214      9
#>       N1               hoved               grunn   
#>  Length:144         Length:144         V1-C-1 : 8  
#>  Class :character   Class :character   V1-C-2 : 8  
#>  Mode  :character   Mode  :character   V1-C-3 : 8  
#>                                        V1-C-4 : 8  
#>                                        V1-C-5 : 8  
#>                                        V1-C-6 : 8  
#>                                        (Other):96  
#>     county             region                 Ind    
#>  Length:144         Length:144         Light1   :18  
#>  Class :character   Class :character   Light2   :18  
#>  Mode  :character   Mode  :character   Moist1   :18  
#>                                        Moist2   :18  
#>                                        Nitrogen1:18  
#>                                        Nitrogen2:18  
#>                                        (Other)  :36  
#>        Rv              Gv            maxmin     
#>  Min.   :1.495   Min.   :1.072   Min.   : 1.00  
#>  1st Qu.:3.469   1st Qu.:3.431   1st Qu.: 1.00  
#>  Median :4.611   Median :4.605   Median : 4.00  
#>  Mean   :4.679   Mean   :4.716   Mean   : 5.00  
#>  3rd Qu.:5.758   3rd Qu.:5.864   3rd Qu.: 8.25  
#>  Max.   :8.217   Max.   :9.016   Max.   :12.00  
#> 
```


```r
head(wetland.ref.cov.val)
#>        N1 hoved  grunn county region    Ind       Rv
#> 1 wetland    NA V3-C-2    all    all Light1 4.900265
#> 2 wetland    NA V3-C-2    all    all Light2 4.900265
#> 3 wetland    NA V1-C-5    all    all Light1 4.760764
#> 4 wetland    NA V1-C-5    all    all Light2 4.760764
#> 5 wetland    NA V4-C-2    all    all Light1 4.901870
#> 6 wetland    NA V4-C-2    all    all Light2 4.901870
#>         Gv maxmin
#> 1 4.736150      1
#> 2 5.120000      7
#> 3 4.597880      1
#> 4 4.902329      7
#> 5 4.610424      1
#> 6 5.232242      7
```

Once test data (ANO) and the scaling values from the reference data (NiN) are in place, we can calculate CWMs of the selected indicators for the ANO community data and scale them against the scaling values from the reference distribution. Note that we scale each ANO plot's CWM against either the lower threshold value and the min value OR the upper threshold value and the max value based on whether the CWM is smaller or higher than the reference value. Since the scaled values for both sides range between 0 and 1, we generate separate lower and upper indicators for each plant functional indicator type. An ANO plot can only have a scaled value in either the lower or the upper indicator (the other one will be 'NA'), except for the unlikely event that the CWM exactly matches the reference value, in which case both lower and upper indicator will receive a scaled indicator value of 1.

Here is the scaling function

```r

#### scaled values ####
r.s <- 1    # reference value
l.s <- 0.6  # limit value
a.s <- 0    # abscence of indicator, or indicator at maximum

#### function for calculating scaled values for measured value ####

## scaling function including truncation
scal <- function() {
  # place to hold the result
   x <- numeric()
  if (maxmin < ref) {
    # values >= the reference value equal 1
    if (val >= ref) {x <- 1}
    # values < the reference value and >= the limit value can be deducted from the linear relationship between these two
    if (val < ref & val >= lim) {x <- (l.s + (val-lim) * ( (r.s-l.s) / (ref-lim) ) )}
    # values < the limit value and > maxmin can be deducted from the linear relationship between these two
    if (val < lim & val > maxmin) {x <- (a.s + (val-maxmin) * ( (l.s-a.s) / (lim-maxmin) ) )}
    # value equals or lower than maxmin
    if (val <= maxmin) {x <-0}
  } else {
    # values <= the reference value equal 1
    if (val <= ref) {x <- 1}
    # values > the reference value and <= the limit value can be deducted from the linear relationship between these two
    if (val > ref & val <= lim) {x <- ( r.s - ( (r.s - l.s) * (val - ref) / (lim - ref) ) )}
    # values > the limit value and < maxmin can be deducted from the linear relationship between these two
    if (val > lim) {x <- ( l.s - (l.s * (val - lim) / (maxmin - lim) ) )}
    # value equals or larger than maxmin
    if (val >= maxmin) {x <-0}
  }
  return(x)
  
}
```

We then can prepare a list of data frames to hold the results and perform the scaling according to the principles described in NINA report 1967 (Töpper and Jakobsson 2021)



```r

#### calculating scaled and non-truncated values for the indicators based on the dataset ####
for (i in 1:nrow(ANO.wetland) ) {  #
  tryCatch({
    print(i)
    print(paste(ANO.wetland$ano_flate_id[i]))
    print(paste(ANO.wetland$ano_punkt_id[i]))
#    ANO.wetland$Hovedoekosystem_sirkel[i]
#    ANO.wetland$Hovedoekosystem_rute[i]

    # if the ANO.hovedtype exists in the reference
    if (ANO.wetland$hovedtype_rute[i] %in% unique(substr(wetland.ref.cov.val$grunn,1,2)) ) {
      
      # if there is any species present in current ANO point  
      if ( length(ANO.sp.ind[ANO.sp.ind$ParentGlobalID==as.character(ANO.wetland$GlobalID[i]),'Species']) > 0 ) {
        

          
          # Light
          dat <- ANO.sp.ind[ANO.sp.ind$ParentGlobalID==as.character(ANO.wetland$GlobalID[i]),c('art_dekning','Light')]
          results.wetland[['original']][i,'richness'] <- nrow(dat)
          dat <- dat[!is.na(dat$Light),]
          
          if ( nrow(dat)>0 ) {
            
            val <- sum(dat[,'art_dekning'] * dat[,'Light'],na.rm=T) / sum(dat[,'art_dekning'],na.rm=T)
            # lower part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Light1'] <- scal() 
            results.wetland[['non-truncated']][i,'Light1'] <- scal.2() 
            results.wetland[['original']][i,'Light1'] <- val 
            
            # upper part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Light2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Light2'] <- scal() 
            results.wetland[['non-truncated']][i,'Light2'] <- scal.2() 
            results.wetland[['original']][i,'Light2'] <- val
          }
          
          
          # Moisture
          dat <- ANO.sp.ind[ANO.sp.ind$ParentGlobalID==as.character(ANO.wetland$GlobalID[i]),c('art_dekning','Moisture')]
          results.wetland[['original']][i,'richness'] <- nrow(dat)
          dat <- dat[!is.na(dat$Moisture),]
          
          if ( nrow(dat)>0 ) {
            
            val <- sum(dat[,'art_dekning'] * dat[,'Moisture'],na.rm=T) / sum(dat[,'art_dekning'],na.rm=T)
            # lower part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Moist1'] <- scal() 
            results.wetland[['non-truncated']][i,'Moist1'] <- scal.2() 
            results.wetland[['original']][i,'Moist1'] <- val 
            
            # upper part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Moist2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Moist2'] <- scal() 
            results.wetland[['non-truncated']][i,'Moist2'] <- scal.2() 
            results.wetland[['original']][i,'Moist2'] <- val
          }
          
          
          # Soil_reaction_pH
          dat <- ANO.sp.ind[ANO.sp.ind$ParentGlobalID==as.character(ANO.wetland$GlobalID[i]),c('art_dekning','Soil_reaction_pH')]
          results.wetland[['original']][i,'richness'] <- nrow(dat)
          dat <- dat[!is.na(dat$Soil_reaction_pH),]
          
          if ( nrow(dat)>0 ) {
            
            val <- sum(dat[,'art_dekning'] * dat[,'Soil_reaction_pH'],na.rm=T) / sum(dat[,'art_dekning'],na.rm=T)
            # lower part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'pH1'] <- scal() 
            results.wetland[['non-truncated']][i,'pH1'] <- scal.2() 
            results.wetland[['original']][i,'pH1'] <- val 
            
            # upper part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='pH2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'pH2'] <- scal() 
            results.wetland[['non-truncated']][i,'pH2'] <- scal.2() 
            results.wetland[['original']][i,'pH2'] <- val
          }
          
          
          # Nitrogen
          dat <- ANO.sp.ind[ANO.sp.ind$ParentGlobalID==as.character(ANO.wetland$GlobalID[i]),c('art_dekning','Nitrogen')]
          results.wetland[['original']][i,'richness'] <- nrow(dat)
          dat <- dat[!is.na(dat$Nitrogen),]
          
          if ( nrow(dat)>0 ) {
            
            val <- sum(dat[,'art_dekning'] * dat[,'Nitrogen'],na.rm=T) / sum(dat[,'art_dekning'],na.rm=T)
            # lower part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen1' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Nitrogen1'] <- scal() 
            results.wetland[['non-truncated']][i,'Nitrogen1'] <- scal.2() 
            results.wetland[['original']][i,'Nitrogen1'] <- val 
            
            # upper part of distribution
            ref <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Rv']
            lim <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'Gv']
            maxmin <- wetland.ref.cov.val[wetland.ref.cov.val$Ind=='Nitrogen2' & wetland.ref.cov.val$grunn==as.character(results.wetland[['original']][i,"kartleggingsenhet_1m2"]),'maxmin']
            # coercing x into results.wetland dataframe
            results.wetland[['scaled']][i,'Nitrogen2'] <- scal() 
            results.wetland[['non-truncated']][i,'Nitrogen2'] <- scal.2() 
            results.wetland[['original']][i,'Nitrogen2'] <- val
          }
          
        }
      }
      

    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

# for using both sides of the plant indicators
results.wetland[['2-sided']] <- results.wetland[['non-truncated']]

# remove values >1 for 2-sided indicators
results.wetland[['2-sided']]$Light1[results.wetland[['2-sided']]$Light1>1] <- NA
results.wetland[['2-sided']]$Light2[results.wetland[['2-sided']]$Light2>1] <- NA

results.wetland[['2-sided']]$Moist1[results.wetland[['2-sided']]$Moist1>1] <- NA
results.wetland[['2-sided']]$Moist2[results.wetland[['2-sided']]$Moist2>1] <- NA

results.wetland[['2-sided']]$pH1[results.wetland[['2-sided']]$pH1>1] <- NA
results.wetland[['2-sided']]$pH2[results.wetland[['2-sided']]$pH2>1] <- NA

results.wetland[['2-sided']]$Nitrogen1[results.wetland[['2-sided']]$Nitrogen1>1] <- NA
results.wetland[['2-sided']]$Nitrogen2[results.wetland[['2-sided']]$Nitrogen2>1] <- NA

```




```r
head(results.wetland[['2-sided']])
#>                                 GlobalID
#> 1 {36BAE83E-F412-4C90-8B56-DE6B4225BB17}
#> 2 {662B047A-411B-42F1-8F2F-E24602CBF350}
#> 3 {F003E630-94CD-4FFF-839B-772299BF697A}
#> 4 {F8239C33-99BD-4EEE-85A9-04A10772858D}
#> 5 {95E184F4-9560-4ADC-A7A9-75AD9A97D654}
#> 6 {6C11D423-9559-4C61-9036-C1309E0C6328}
#>      registeringsdato klokkeslett_start ano_flate_id
#> 1 2019-08-16 11:59:59             13:19      ANO0003
#> 2 2019-08-16 11:59:59             15:38      ANO0003
#> 3 2019-08-16 11:59:59             15:07      ANO0003
#> 4 2019-08-16 11:59:59             13:58      ANO0003
#> 5 2019-08-16 11:59:59             12:06      ANO0003
#> 6 2019-08-15 11:59:59             15:43      ANO0003
#>   ano_punkt_id         ssb_id program
#> 1   ANO0003_35 20940006559500     ANO
#> 2   ANO0003_44 20940006559500     ANO
#> 3   ANO0003_64 20940006559500     ANO
#> 4   ANO0003_55 20940006559500     ANO
#> 5   ANO0003_15 20940006559500     ANO
#> 6   ANO0003_51 20940006559500     ANO
#>                                                                   instruks
#> 1 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#> 2 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#> 3 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#> 4 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#> 5 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#> 6 https://nedlasting.miljodirektoratet.no/naturovervaking/ano_instruks.pdf
#>    aar      dataansvarlig_mdir                   dataeier
#> 1 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#> 2 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#> 3 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#> 4 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#> 5 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#> 6 2019 Ole Einar Butli Hårstad Miljødirektoratet, VAL/VMK
#>        vaer hovedoekosystem_punkt
#> 1 overskyet              vaatmark
#> 2       sol              vaatmark
#> 3       sol              vaatmark
#> 4       sol              vaatmark
#> 5       sol              vaatmark
#> 6    nedbør              vaatmark
#>   andel_hovedoekosystem_punkt utilgjengelig_punkt
#> 1                          NA                <NA>
#> 2                          NA                <NA>
#> 3                          NA                <NA>
#> 4                          NA                <NA>
#> 5                          NA                <NA>
#> 6                          NA                <NA>
#>   utilgjengelig_begrunnelse  gps noeyaktighet
#> 1                      <NA> <NA>         <NA>
#> 2                      <NA> <NA>         <NA>
#> 3                      <NA> <NA>         <NA>
#> 4                      <NA> <NA>         <NA>
#> 5                      <NA> <NA>         <NA>
#> 6                      <NA> <NA>         <NA>
#>   kommentar_posisjon klokkeslett_karplanter_start
#> 1               <NA>                         <NA>
#> 2               <NA>                         <NA>
#> 3               <NA>                         <NA>
#> 4               <NA>                         <NA>
#> 5               <NA>                         <NA>
#> 6               <NA>                         <NA>
#>   art_alle_registrert karplanter_dekning
#> 1                <NA>               85.1
#> 2                <NA>               81.0
#> 3                <NA>               79.0
#> 4                <NA>               51.1
#> 5                <NA>               71.0
#> 6                <NA>               11.3
#>   klokkeslett_karplanter_slutt karplanter_feltsjikt
#> 1                         <NA>                   NA
#> 2                         <NA>                   NA
#> 3                         <NA>                   NA
#> 4                         <NA>                   NA
#> 5                         <NA>                   NA
#> 6                         <NA>                   NA
#>   moser_dekning torvmoser_dekning lav_dekning stroe_dekning
#> 1            20                20           0            60
#> 2             5                 0           0            45
#> 3            85                75           0            15
#> 4            80                60           0            75
#> 5            80                80           0            23
#> 6            85                85           0             1
#>   jord_grus_stein_berg_dekning stubber_kvister_dekning
#> 1                           NA                      NA
#> 2                           NA                      NA
#> 3                           NA                      NA
#> 4                           NA                      NA
#> 5                           NA                      NA
#> 6                           NA                      NA
#>   alger_fjell_dekning
#> 1                  NA
#> 2                  NA
#> 3                  NA
#> 4                  NA
#> 5                  NA
#> 6                  NA
#>                                 kommentar_ruteanalyse
#> 1                                                <NA>
#> 2                                                <NA>
#> 3                                                <NA>
#> 4 har noen arter som er i V1C2 men bare veldig lokalt
#> 5                                                <NA>
#> 6                                                <NA>
#>   fastmerker kommentar_fastmerker kartleggingsenhet_1m2
#> 1       <NA>                 <NA>                V1-C-5
#> 2       <NA>                 <NA>                V1-C-1
#> 3       <NA>                 <NA>                V1-C-1
#> 4       <NA>                 <NA>                V1-C-1
#> 5       <NA>                 <NA>                V1-C-1
#> 6       <NA>                 <NA>                V1-C-1
#>       hovedtype_1m2                      ke_beskrivelse_1m2
#> 1 Åpen jordvannsmyr svært og temmelig kalkfattige myrkanter
#> 2 Åpen jordvannsmyr svært og temmelig kalkfattige myrflater
#> 3 Åpen jordvannsmyr svært og temmelig kalkfattige myrflater
#> 4 Åpen jordvannsmyr svært og temmelig kalkfattige myrflater
#> 5 Åpen jordvannsmyr svært og temmelig kalkfattige myrflater
#> 6 Åpen jordvannsmyr svært og temmelig kalkfattige myrflater
#>   kartleggingsenhet_250m2 hovedtype_250m2
#> 1                    <NA>            <NA>
#> 2                    <NA>            <NA>
#> 3                    <NA>            <NA>
#> 4                    <NA>            <NA>
#> 5                    <NA>            <NA>
#> 6                    <NA>            <NA>
#>   ke_beskrivelse_250m2 andel_kartleggingsenhet_250m2
#> 1                 <NA>                            NA
#> 2                 <NA>                            NA
#> 3                 <NA>                            NA
#> 4                 <NA>                            NA
#> 5                 <NA>                            NA
#> 6                 <NA>                            NA
#>   groeftingsintensitet bruksintensitet beitetrykk
#> 1                    1               1         NA
#> 2                    1               1         NA
#> 3                    1               1         NA
#> 4                    1               1         NA
#> 5                    1               1         NA
#> 6                    1               1         NA
#>   slatteintensitet tungekjoretoy slitasje forekomst_ntyp
#> 1                1             0        0            nei
#> 2                1             0        0            nei
#> 3                1             0        0            nei
#> 4                1             0        0            nei
#> 5                1             0        0            nei
#> 6                1             0        0            nei
#>   ntyp
#> 1 <NA>
#> 2 <NA>
#> 3 <NA>
#> 4 <NA>
#> 5 <NA>
#> 6 <NA>
#>                                                    kommentar_naturtyperegistering
#> 1                         en del gjengroing med bjørk og einer, noen store furuer
#> 2                                                                            <NA>
#> 3                        40% bærlyngskog T4C5, rute i overgang mellom myr og skog
#> 4                                                   noen store furuer, litt bjørk
#> 5 delvis myr, ganske mye lyng, virker som det gror igjen med bjørk, einer og furu
#> 6                                             rute ligger i en streng i fattigmyr
#>   side_5_note krypende_vier_dekning
#> 1        <NA>                     0
#> 2        <NA>                     0
#> 3        <NA>                     0
#> 4        <NA>                     0
#> 5        <NA>                     0
#> 6        <NA>                     0
#>   ikke_krypende_vier_dekning vedplanter_total_dekning
#> 1                          1                       30
#> 2                          0                        7
#> 3                          0                       45
#> 4                          3                       17
#> 5                          0                       53
#> 6                          0                        5
#>   busker_dekning tresjikt_dekning treslag_registrert
#> 1             12               15               <NA>
#> 2              1                3               <NA>
#> 3             12                8               <NA>
#> 4              8               12               <NA>
#> 5             13                8               <NA>
#> 6              2                0               <NA>
#>   roesslyng_dekning roesslyngblad pa_dekning pa_note
#> 1                NA          <NA>         NA    <NA>
#> 2                NA          <NA>         NA    <NA>
#> 3                NA          <NA>         NA    <NA>
#> 4                NA          <NA>         NA    <NA>
#> 5                NA          <NA>         NA    <NA>
#> 6                NA          <NA>         NA    <NA>
#>   pa_registrert fa_total_dekning fa_registrert
#> 1          <NA>                0          <NA>
#> 2          <NA>                0          <NA>
#> 3          <NA>                0          <NA>
#> 4          <NA>                0          <NA>
#> 5          <NA>                0          <NA>
#> 6          <NA>                0          <NA>
#>        kommentar_250m2_flate klokkeslett_slutt
#> 1          litt nakent berg              13:33
#> 2                       <NA>             15:45
#> 3                       <NA>             15:17
#> 4                       <NA>             14:12
#> 5 en bekk går gjennom flaten             12:19
#> 6                       <NA>             15:50
#>                                                                                             vedlegg_url
#> 1 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/36bae83e-f412-4c90-8b56-de6b4225bb17
#> 2 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/662b047a-411b-42f1-8f2f-e24602cbf350
#> 3 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/f003e630-94cd-4fff-839b-772299bf697a
#> 4 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/f8239c33-99bd-4eee-85a9-04a10772858d
#> 5 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/95e184f4-9560-4adc-a7a9-75ad9a97d654
#> 6 https://nin-felles-test.miljodirektoratet.no/api/Overvaking/list/6c11d423-9559-4c61-9036-c1309e0c6328
#>                    creator        creationdate
#> 1 chrpot_miljodirektoratet 2019-09-09 10:54:17
#> 2 chrpot_miljodirektoratet 2019-09-09 10:56:19
#> 3 chrpot_miljodirektoratet 2019-09-09 10:57:21
#> 4 chrpot_miljodirektoratet 2019-09-09 10:58:29
#> 5 chrpot_miljodirektoratet 2019-09-09 10:59:26
#> 6 chrpot_miljodirektoratet 2019-09-09 10:59:58
#>                     editor            editdate
#> 1 chrpot_miljodirektoratet 2019-09-09 10:54:17
#> 2 chrpot_miljodirektoratet 2019-09-09 10:56:19
#> 3 chrpot_miljodirektoratet 2019-09-09 10:57:21
#> 4 chrpot_miljodirektoratet 2019-09-09 10:58:29
#> 5 chrpot_miljodirektoratet 2019-09-09 10:59:26
#> 6 chrpot_miljodirektoratet 2019-09-09 10:59:58
#>   hovedtype_rute    Light1    Light2    Moist1    Moist2
#> 1             V1        NA 0.9880821        NA 0.5073251
#> 2             V1 0.5557351        NA        NA 0.9783315
#> 3             V1 0.5506190        NA 0.5484802        NA
#> 4             V1        NA 0.9702611        NA 0.7785145
#> 5             V1 0.5998524        NA 0.5246274        NA
#> 6             V1 0.9771330        NA        NA 0.9056025
#>         pH1       pH2 Nitrogen1 Nitrogen2
#> 1 0.5130170        NA        NA 0.6919856
#> 2 0.9992800        NA        NA 0.5718196
#> 3        NA 0.8622486        NA 0.5796588
#> 4        NA 0.4743074        NA 0.5484617
#> 5 0.8311036        NA        NA 0.7270619
#> 6        NA 0.7803061        NA 0.9422970
```
#### Scaled value analyses

In order to visualize the results we need to rearrange the results-objects from wide to long format (note that there is both a lower and an upper condition indicator for each of the functional plant indicators).


```r
#### plotting scaled values by main ecosystem type ####
## continuing with 2-sided
res.wetland <- results.wetland[['2-sided']]

# make long version of the scaled value part
res.wetland <-
res.wetland %>%
pivot_longer(
cols = c("Light1","Light2","Moist1","Moist2","pH1","pH2","Nitrogen1","Nitrogen2"),
names_to = "fp_ind",
values_to = "scaled_value",
values_drop_na = FALSE
)

# add original values as well
res.wetland <-
res.wetland %>% add_column(original = results.wetland[['original']] %>%
pivot_longer(
cols = c("Light1","Light2","Moist1","Moist2","pH1","pH2","Nitrogen1","Nitrogen2"),
names_to = NULL,
values_to = "original",
values_drop_na = FALSE
) %>%
pull(original)
)
```

### Ecosystem sub-types
And we can show the resulting scaled values as Violin plots for each indicator and main ecosystem type 
<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-20-1.png" width="672" />

### Indicator index maps
We can also show the results as a map, for instance for pH1 (the lower pH indicator), either by directly plotting the data onto the map...

```
#> Reading layer `outlineOfNorway_EPSG25833' from data source 
#>   `/data/scratch/Matt_temp/ecosystemCondition/data/outlineOfNorway_EPSG25833.shp' 
#>   using driver `ESRI Shapefile'
#> Simple feature collection with 1 feature and 2 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -113472.7 ymin: 6448359 xmax: 1114618 ymax: 7939917
#> Projected CRS: ETRS89 / UTM zone 33N
#> Reading layer `regions' from data source 
#>   `/data/scratch/Matt_temp/ecosystemCondition/data/regions.shp' 
#>   using driver `ESRI Shapefile'
#> Simple feature collection with 5 features and 2 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -99551.21 ymin: 6426048 xmax: 1121941 ymax: 7962744
#> Projected CRS: ETRS89 / UTM zone 33N
#> [1] "Nord-Norge"      "Midt-Norge"      "Ã\u0098stlandet"
#> [4] "Vestlandet"      "SÃ¸rlandet"
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-21-1.png" width="672" />
...but here the colors and values of the data points on the map are hard to make out.

### Regions - maps and statistics
Alternatively we can calculate and show the region-wise means and their related standard errors. But note that calculating a simple mean would be inappropriate for these data. This is because:
(i) the scaled data are bound between 0 and 1, and thus follow a beta-distribution rather than a Gaussian one
(ii) the ANO dataset has a nested structure

Therefore, we need to (i) use a beta-model, that (ii) can account for the nested structure of the data.
Here, we apply the following function using either a glmmTMB null-model with a beta-distribution, logit link, and the nesting as a random intercept, or a simple betareg null-model with logit link if the nesting is not extensive enough for a mixed model.

```r
library(betareg)
library(glmmTMB)
#> Warning in checkMatrixPackageVersion(): Package version inconsistency detected.
#> TMB was built with Matrix version 1.5.3
#> Current Matrix version is 1.5.1
#> Please re-install 'TMB' from source using install.packages('TMB', type = 'source') or ask CRAN for a binary version of 'TMB' matching CRAN's 'Matrix' package
#> Warning in checkDepPackageVersion(dep_pkg = "TMB"): Package version inconsistency detected.
#> glmmTMB was built with TMB version 1.9.2
#> Current TMB version is 1.9.4
#> Please re-install glmmTMB from source or restore original 'TMB' package (see '?reinstalling' for more information)

expit <- function(L) exp(L) / (1+exp(L)) # since the beta-models use a logit link, we need to calculate the estimates back to the identity scale

# the function performs a glmmTMB if there's >= 5 random levels in the nesting structure
# if that is not the case, then the function performs a betareg if theres >= 2 observations
# if that is not the case either, then the function returns the value of the single observation with NA standard error

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
```


```r

res.wetland2 = st_join(res.wetland2, regnor, left = TRUE)

regnor <- regnor %>%
  mutate(
    pH1.reg.mean = c(indmean.beta(df=res.wetland2[res.wetland2$region=="Northern Norway",c("pH1","ano_flate_id")])[1],
                                 indmean.beta(df=res.wetland2[res.wetland2$region=="Central Norway",c("pH1","ano_flate_id")])[1],
                                 indmean.beta(df=res.wetland2[res.wetland2$region=="Eastern Norway",c("pH1","ano_flate_id")])[1],
                                 indmean.beta(df=res.wetland2[res.wetland2$region=="Western Norway",c("pH1","ano_flate_id")])[1],
                                 indmean.beta(df=res.wetland2[res.wetland2$region=="Southern Norway",c("pH1","ano_flate_id")])[1]
    ),
    pH1.reg.se = c(indmean.beta(df=res.wetland2[res.wetland2$region=="Northern Norway",c("pH1","ano_flate_id")])[2],
                               indmean.beta(df=res.wetland2[res.wetland2$region=="Central Norway",c("pH1","ano_flate_id")])[2],
                               indmean.beta(df=res.wetland2[res.wetland2$region=="Eastern Norway",c("pH1","ano_flate_id")])[2],
                               indmean.beta(df=res.wetland2[res.wetland2$region=="Western Norway",c("pH1","ano_flate_id")])[2],
                               indmean.beta(df=res.wetland2[res.wetland2$region=="Southern Norway",c("pH1","ano_flate_id")])[2]
    ),
    pH1.reg.n = c(nrow(res.wetland2[res.wetland2$region=="Northern Norway" & !is.na(res.wetland2$pH1),]),
                              nrow(res.wetland2[res.wetland2$region=="Central Norway" & !is.na(res.wetland2$pH1),]),
                              nrow(res.wetland2[res.wetland2$region=="Eastern Norway" & !is.na(res.wetland2$pH1),]),
                              nrow(res.wetland2[res.wetland2$region=="Western Norway" & !is.na(res.wetland2$pH1),]),
                              nrow(res.wetland2[res.wetland2$region=="Southern Norway" & !is.na(res.wetland2$pH1),])
    )
  )


## scaled value maps for pH1 (lower indicator)
# mean
tm_shape(regnor) +
  tm_polygons(col="pH1.reg.mean", title="pH (lower), mean", style="quantile", palette=rev(get_brewer_pal(palette="OrRd", n=5, plot=FALSE))) +
  tm_text("pH1.reg.n",col="black",bg.color="grey")
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-23-1.png" width="672" />
Mean index value by region for the lower pH indicator (i.e. index shows deviations towards a more acidic environment). Numbers in grey fields show the number of observations in the respective region.


```r
# se
tm_shape(regnor) +
  tm_polygons(col="pH1.reg.se", title="pH (lower), sd", style="quantile", palette=get_brewer_pal(palette="OrRd", n=5, plot=FALSE)) +
  tm_text("pH1.reg.n",col="black",bg.color="grey")
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-24-1.png" width="672" />
Standard error to the mean index value by region for the lower pH indicator. Numbers in grey fields show the number of observations in the respective region.


### unscaled values vs. reference
We can also compare the unscaled values to the reference distribution in order to identify ecosystem types and functional plant indicators showing a deviation from the expectation. Since pH and nitrogen show some deviation in the lower indicator we exemplify this with these two indicators for unscaled values.


```r
summary(res.wetland$kartleggingsenhet_1m2)
#>      V1  V1-C-1  V1-C-2  V1-C-3  V1-C-4  V1-C-5  V1-C-6 
#>       8    2144    1224     448     160    2424    1248 
#>  V1-C-7  V1-C-8 V10-C-1 V10-C-3 V11-C-1     V12 V12-C-1 
#>     320      48      40       8      16      16     152 
#> V12-C-2      V2  V2-C-1  V2-C-2  V2-C-3      V3  V3-C-1 
#>       8       8     832     224      32      40     440 
#>  V3-C-2      V4  V4-C-1  V4-C-2  V4-C-4  V6-C-1  V6-C-2 
#>     472       8      32      72       8      64       8 
#>  V6-C-3  V6-C-4  V6-C-5  V6-C-7  V6-C-9  V8-C-1  V8-C-2 
#>      72      40       8       8       8      16       8 
#>  V9-C-1  V9-C-2  V9-C-3 
#>      80      16      16
length(unique(res.wetland$kartleggingsenhet_1m2))
#> [1] 38
# 16 NiN-types to plot
colnames(wetland.ref.cov[['Soil_reaction_pH']])
#>  [1] "V3-C1a" "V3-C1b" "V3-C1c" "V3-C1d" "V3-C1e" "V1-C1a"
#>  [7] "V1-C1b" "V1-C1c" "V1-C1d" "V1-C1e" "V1-C2a" "V1-C2b"
#> [13] "V1-C2c" "V1-C2d" "V1-C3a" "V1-C3b" "V1-C3c" "V1-C3d"
#> [19] "V1-C4a" "V1-C4b" "V1-C4c" "V1-C4d" "V1-C4e" "V1-C4f"
#> [25] "V1-C4g" "V1-C4h" "V3-C2"  "V1-C5"  "V1-C6a" "V1-C6b"
#> [31] "V1-C7a" "V1-C7b" "V1-C8a" "V1-C8b" "V2-C1a" "V2-C1b"
#> [37] "V2-C2a" "V2-C2b" "V2-C3a" "V2-C3b" "V4-C2"  "V4-C3" 
#> [43] "V8-C1"  "V8-C2"  "V8-C3"

### pH
par(mfrow=c(2,4))
## V1s
# V1-C-1
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C1a","V1-C1b","V1-C1c","V1-C1d","V1-C1e")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C1',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original)),
       col="red")

# V1-C-2
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C2a","V1-C2b","V1-C2c","V1-C2d")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C2',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original)),
       col="red")

# V1-C-3
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C3a","V1-C3b","V1-C3c","V1-C3d")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C3',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original)),
       col="red")

# V1-C-4
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C4a","V1-C4b","V1-C4c","V1-C4d","V1-C4e","V1-C4f","V1-C4g","V1-C4h")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C4',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original)),
       col="red")

# V1-C-5
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C5")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C5',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original)),
       col="red")

# V1-C-6
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C6a","V1-C6b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C6',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original)),
       col="red")

# V1-C-7
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C7a","V1-C7b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C7',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original)),
       col="red")

# V1-C-8
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V1-C8a","V1-C8b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C8',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original)),
       col="red")
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-25-1.png" width="672" />

```r

par(mfrow=c(2,4))
## V2s
# V2-C-1
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V2-C1a","V2-C1b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C1',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original)),
       col="red")

# V2-C-2
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V2-C2a","V2-C2b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C2',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original)),
       col="red")

# V2-C-3
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V2-C3a","V2-C3b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C3',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original)),
       col="red")

## V3s
# V3-C-1
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V3-C1a","V3-C1b","V3-C1c","V3-C1d","V3-C1e")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V3-C1',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original)),
       col="red")

# V3-C-2
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V3-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V3-C2',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original)),
       col="red")

## V4s
# V4-C-2
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V4-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V4-C2',xlab='pH value')
points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original)),
       col="red")


## V8s
# V8-C-1
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V8-C1")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V8-C1',xlab='pH value')
#points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original,na.rm=T),
#       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original)),
       col="red")

# V8-C-2
plot(density( as.matrix(wetland.ref.cov[['Soil_reaction_pH']][,c("V8-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V8-C2',xlab='pH value')
#points(density(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original,na.rm=T),
#       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="pH1" & res.wetland$fp_ind=="pH1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original)),
       col="red")
legend("topleft", legend=c("reference","field data"), pch=c(NA,1), lty=1, col=c("black","red"))
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-25-2.png" width="672" />

```r




### Nitrogen
par(mfrow=c(2,4))
## V1s
# V1-C-1
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C1a","V1-C1b","V1-C1c","V1-C1d","V1-C1e")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C1',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-1",]$original)),
       col="red")

# V1-C-2
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C2a","V1-C2b","V1-C2c","V1-C2d")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C2',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-2",]$original)),
       col="red")

# V1-C-3
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C3a","V1-C3b","V1-C3c","V1-C3d")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C3',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-3",]$original)),
       col="red")

# V1-C-4
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C4a","V1-C4b","V1-C4c","V1-C4d","V1-C4e","V1-C4f","V1-C4g","V1-C4h")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C4',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-4",]$original)),
       col="red")

# V1-C-5
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C5")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C5',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-5",]$original)),
       col="red")

# V1-C-6
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C6a","V1-C6b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C6',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-6",]$original)),
       col="red")

# V1-C-7
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C7a","V1-C7b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C7',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-7",]$original)),
       col="red")

# V1-C-8
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V1-C8a","V1-C8b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V1-C8',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V1-C-8",]$original)),
       col="red")
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-25-3.png" width="672" />

```r

par(mfrow=c(2,4))
## V2s
# V2-C-1
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V2-C1a","V2-C1b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C1',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-1",]$original)),
       col="red")

# V2-C-2
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V2-C2a","V2-C2b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C2',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-2",]$original)),
       col="red")

# V2-C-3
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V2-C3a","V2-C3b")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V2-C3',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V2-C-3",]$original)),
       col="red")

## V3s
# V3-C-1
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V3-C1a","V3-C1b","V3-C1c","V3-C1d","V3-C1e")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V3-C1',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-1",]$original)),
       col="red")

# V3-C-2
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V3-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V3-C2',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V3-C-2",]$original)),
       col="red")

## V4s
# V4-C-2
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V4-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V4-C2',xlab='Nitrogen value')
points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original,na.rm=T),
       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V4-C-2",]$original)),
       col="red")

## V8s
# V8-C-1
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V8-C1")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V8-C1',xlab='Nitrogen value')
#points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original,na.rm=T),
#       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-1",]$original)),
       col="red")

# V8-C-2
plot(density( as.matrix(wetland.ref.cov[['Nitrogen']][,c("V8-C2")]) ,na.rm=T),
     xlim=c(1,7), type="l", main='V8-C2',xlab='Nitrogen value')
#points(density(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original,na.rm=T),
#       type="l", col="red")
points(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original,
       rep(0,length(res.wetland[res.wetland$fp_ind=="Nitrogen1" & res.wetland$fp_ind=="Nitrogen1" & res.wetland$kartleggingsenhet_1m2=="V8-C-2",]$original)),
       col="red")

legend("topleft", legend=c("reference","field data"), pch=c(NA,1), lty=1, col=c("black","red"))
```

<img src="functional_plant_indicators_wetland_files/figure-html/unnamed-chunk-25-4.png" width="672" />
Deviations from the reference occur mainly in V2-C1, which represents limestone-poor swamp forests. According to the functional signature from the plant community composition many of the occurrences of this ecosystem type are too acidic and may have too low availability of nitrogen. 

### Eksport file (final product)
<!-- Export final file. Ideally a georeferenced shape or raster wit indicators values (raw and normalised), reference values and errors. -->
