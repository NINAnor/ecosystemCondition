# (PART\*) DEPRECATED{-}

# Areal uten død eller skadet røsslyng i kystlynghei

<br />

_Author and date:_
Anders L. Kolstad


```
#> [1] "2023-04-14"
```

<br />

<!-- Load all you dependencies here -->



<!-- Fill in which ecosystem the indicator belongs to, as well as the ecosystem characteristic it should be linked to. It's OK to use some Norwegian here -->



|Ecosystem          |Økologisk.egenskap |ECT.class                      |
|:------------------|:------------------|:------------------------------|
|Semi-naturlig mark |Primærproduksjon   |Structual state characteristic |

<!-- Don't remove these three html lines -->
<br />
<br />
<hr />



<!-- Document you work below. Try not to change  the headers too much. Data can be stored on NINA server. Since the book is rendered on the R Server this works fine, but note that directory paths are different on the server compared to you local machine. If it is not too big you may store under /data/ on this repository -->

## Introduction
Here I quickly go through the ANO data set for the years 2019-2021 to investigate the frequeny of poins that fall within coastal heathlands (kystlynghei). This will decide whether we can use this data to inform an indicator about the proportion of dead _Calluna vulgaris_ (røsslyng).

## Analyses

#### ANO data
Data is downloaded from [here](https://kartkatalog.miljodirektoratet.no/Dataset/Details/2054).

Import and list terms: 

```r
ano <- sf::st_read("/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb",
                   layer = "ANO_SurveyPoint")
#> Reading layer `ANO_SurveyPoint' from data source 
#>   `/data/P-Prosjekter2/41201785_okologisk_tilstand_2022_2023/data/Naturovervaking_eksport.gdb' 
#>   using driver `OpenFileGDB'
#> Simple feature collection with 8974 features and 71 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -51950 ymin: 6467050 xmax: 1094950 ymax: 7923950
#> Projected CRS: ETRS89 / UTM zone 33N
#st_crs(ano)
names(ano)
#>  [1] "GlobalID"                      
#>  [2] "registeringsdato"              
#>  [3] "klokkeslett_start"             
#>  [4] "ano_flate_id"                  
#>  [5] "ano_punkt_id"                  
#>  [6] "ssb_id"                        
#>  [7] "program"                       
#>  [8] "instruks"                      
#>  [9] "aar"                           
#> [10] "dataansvarlig_mdir"            
#> [11] "dataeier"                      
#> [12] "vaer"                          
#> [13] "hovedoekosystem_punkt"         
#> [14] "andel_hovedoekosystem_punkt"   
#> [15] "utilgjengelig_punkt"           
#> [16] "utilgjengelig_begrunnelse"     
#> [17] "gps"                           
#> [18] "noeyaktighet"                  
#> [19] "kommentar_posisjon"            
#> [20] "klokkeslett_karplanter_start"  
#> [21] "art_alle_registrert"           
#> [22] "karplanter_dekning"            
#> [23] "klokkeslett_karplanter_slutt"  
#> [24] "karplanter_feltsjikt"          
#> [25] "moser_dekning"                 
#> [26] "torvmoser_dekning"             
#> [27] "lav_dekning"                   
#> [28] "stroe_dekning"                 
#> [29] "jord_grus_stein_berg_dekning"  
#> [30] "stubber_kvister_dekning"       
#> [31] "alger_fjell_dekning"           
#> [32] "kommentar_ruteanalyse"         
#> [33] "fastmerker"                    
#> [34] "kommentar_fastmerker"          
#> [35] "kartleggingsenhet_1m2"         
#> [36] "hovedtype_1m2"                 
#> [37] "ke_beskrivelse_1m2"            
#> [38] "kartleggingsenhet_250m2"       
#> [39] "hovedtype_250m2"               
#> [40] "ke_beskrivelse_250m2"          
#> [41] "andel_kartleggingsenhet_250m2" 
#> [42] "bv_7gr_gi"                     
#> [43] "bv_7jb_ba"                     
#> [44] "bv_7jb_bt"                     
#> [45] "bv_7jb_si"                     
#> [46] "bv_7tk"                        
#> [47] "bv_7se"                        
#> [48] "forekomst_ntyp"                
#> [49] "ntyp"                          
#> [50] "kommentar_naturtyperegistering"
#> [51] "side_5_note"                   
#> [52] "krypende_vier_dekning"         
#> [53] "ikke_krypende_vier_dekning"    
#> [54] "vedplanter_total_dekning"      
#> [55] "busker_dekning"                
#> [56] "tresjikt_dekning"              
#> [57] "treslag_registrert"            
#> [58] "roesslyng_dekning"             
#> [59] "roesslyngblad"                 
#> [60] "pa_dekning"                    
#> [61] "pa_note"                       
#> [62] "pa_registrert"                 
#> [63] "fa_total_dekning"              
#> [64] "fa_registrert"                 
#> [65] "kommentar_250m2_flate"         
#> [66] "klokkeslett_slutt"             
#> [67] "vedlegg_url"                   
#> [68] "creator"                       
#> [69] "creationdate"                  
#> [70] "editor"                        
#> [71] "editdate"                      
#> [72] "SHAPE"
```

Table of the number of sampling points per year:

```r
table(ano$aar)
#> 
#> 2019 2020 2021 
#> 1111 3411 4452
```


```r
par(mar=c(15,5,0,0))
barplot(table(ano$hovedoekosystem_punkt), las=2)
```

<div class="figure">
<img src="rosslyng_files/figure-html/unnamed-chunk-6-1.png" alt="The distribution of ANO points that fall within different main ecosystems." width="672" />
<p class="caption">(\#fig:unnamed-chunk-6)The distribution of ANO points that fall within different main ecosystems.</p>
</div>

Sub-setting the data to only consider seni natural areas.

```r
snat <- ano[ano$hovedoekosystem_punkt == "semi_naturlig_mark",]
snat2 <- snat[!is.na(snat$GlobalID),]
```
230 points are semi-natural.


```r
table(snat$hovedtype_1m2)
#> 
#>       Åpen jordvannsmyr              Boreal hei 
#>                       4                     107 
#>               Kaldkilde             Kystlynghei 
#>                       1                      49 
#>             Nakent berg              Nedbørsmyr 
#>                       2                       1 
#>       Semi-naturlig eng       Semi-naturlig myr 
#>                      51                       6 
#> Semi-naturlig strandeng    Semi-naturlig våteng 
#>                       1                       1 
#>               Skogsmark 
#>                       4
```
Only 49 1m2 samples are kystlynghei. 


```r
table(ano$hovedtype_250m2)
#> 
#>                                      Åker 
#>                                        62 
#>                         Åpen flomfastmark 
#>                                         1 
#>                      Åpen grunnlendt mark 
#>                                        92 
#>                         Åpen jordvannsmyr 
#>                                       427 
#>                                 Blokkmark 
#>                                       204 
#>                                Boreal hei 
#>                                        94 
#>        Breforland og snøavsmeltingsområde 
#>                                        33 
#>               Eng-liknende oppdyrket mark 
#>                                        19 
#>       Eng-liknende sterkt endret fastmark 
#>                                         2 
#>                Fjellgrashei og grastundra 
#>                                        32 
#>                 Fjellhei leside og tundra 
#>                                       853 
#>                             Flomskogsmark 
#>                                         1 
#>                          Grøftet torvmark 
#>                                         6 
#>                        Grotte og overheng 
#>                                         1 
#>               Hard sterkt endret fastmark 
#>                                         2 
#>                   Helofytt-ferskvannssump 
#>                                         4 
#>                       Historisk skredmark 
#>                                         3 
#>                         Isinnfrysingsmark 
#>                                         2 
#>                                 Kaldkilde 
#>                                         3 
#>                               Kystlynghei 
#>                                        26 
#>                Løs sterkt endret fastmark 
#>                                        43 
#>                     Myr- og sumpskogsmark 
#>                                        53 
#>                               Nakent berg 
#>                                       193 
#>                                Nedbørsmyr 
#>                                        53 
#>                       Oppdyrket varig eng 
#>                                        45 
#>                           Oppfrysingsmark 
#>                                         3 
#>                 Plener parker og liknende 
#>                                        19 
#>                                     Rabbe 
#>                                        83 
#>                                   Rasmark 
#>                                        58 
#>                        Rasmarkhei og -eng 
#>                                         8 
#>                         Semi-naturlig eng 
#>                                        45 
#>                         Semi-naturlig myr 
#>                                        14 
#>                      Semi-naturlig våteng 
#>                                         2 
#>                                 Skogsmark 
#>                                      1288 
#>                   Snø- og isdekt fastmark 
#>                                       105 
#>                                   Snøleie 
#>                                       160 
#>                                Strandberg 
#>                                         5 
#>                                 Strandeng 
#>                                         2 
#>                       Strandsumpskogsmark 
#>                                         2 
#> Tørrlagte våtmarks- og ferskvannssystemer 
#>                                         7 
#>                                   Torvtak 
#>                                         1 
#>                              Treplantasje 
#>                                        13 
#>                Våtsnøleie og snøleiekilde 
#>                                        13
```
Only 26 of the 250m2 circles are kystlynghei. The variable of interest is called _Dekning av død/skadet røsslyng_ and is only recorded on these 26 circles.



## Conclusion
Because of the random allocation of sampling points, not enough points fall in coastal heathlands to allow us to create a trustworthy indicator for this nature type. With a few more years of data we might end up with about 100 points, which is borderline what we need in order to calculate condition values at a regional level with some level of precision. 


