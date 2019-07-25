Wildlife Strikes
================

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 3.5.3

    ## -- Attaching packages --------------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.0.0     v purrr   0.2.5
    ## v tibble  2.1.3     v dplyr   0.8.1
    ## v tidyr   0.8.1     v stringr 1.3.1
    ## v readr   1.3.1     v forcats 0.3.0

    ## Warning: package 'tibble' was built under R version 3.5.3

    ## Warning: package 'readr' was built under R version 3.5.3

    ## Warning: package 'dplyr' was built under R version 3.5.3

    ## -- Conflicts ------------------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(magrittr)
```

    ## 
    ## Attaching package: 'magrittr'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     set_names

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     extract

``` r
wildlife_impacts <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-23/wildlife_impacts.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character(),
    ##   incident_date = col_datetime(format = ""),
    ##   num_engs = col_double(),
    ##   incident_month = col_double(),
    ##   incident_year = col_double(),
    ##   time = col_double(),
    ##   height = col_double(),
    ##   speed = col_double(),
    ##   cost_repairs_infl_adj = col_double()
    ## )

    ## See spec(...) for full column specifications.

``` r
summary(wildlife_impacts)
```

    ##  incident_date                    state            airport_id       
    ##  Min.   :1990-01-01 00:00:00   Length:56978       Length:56978      
    ##  1st Qu.:2001-11-15 00:00:00   Class :character   Class :character  
    ##  Median :2009-11-03 00:00:00   Mode  :character   Mode  :character  
    ##  Mean   :2008-05-21 04:57:11                                        
    ##  3rd Qu.:2015-07-26 00:00:00                                        
    ##  Max.   :2018-12-31 00:00:00                                        
    ##                                                                     
    ##    airport            operator            atype          
    ##  Length:56978       Length:56978       Length:56978      
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##    type_eng          species_id          species         
    ##  Length:56978       Length:56978       Length:56978      
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##     damage             num_engs     incident_month   incident_year 
    ##  Length:56978       Min.   :1.000   Min.   : 1.000   Min.   :1990  
    ##  Class :character   1st Qu.:2.000   1st Qu.: 5.000   1st Qu.:2001  
    ##  Mode  :character   Median :2.000   Median : 8.000   Median :2009  
    ##                     Mean   :2.059   Mean   : 7.235   Mean   :2008  
    ##                     3rd Qu.:2.000   3rd Qu.:10.000   3rd Qu.:2015  
    ##                     Max.   :4.000   Max.   :12.000   Max.   :2018  
    ##                     NA's   :233                                    
    ##  time_of_day             time           height            speed      
    ##  Length:56978       Min.   : -84    Min.   :    0.0   Min.   :  0.0  
    ##  Class :character   1st Qu.: 930    1st Qu.:    0.0   1st Qu.:130.0  
    ##  Mode  :character   Median :1426    Median :   50.0   Median :140.0  
    ##                     Mean   :1428    Mean   :  983.8   Mean   :154.6  
    ##                     3rd Qu.:1950    3rd Qu.: 1000.0   3rd Qu.:170.0  
    ##                     Max.   :2359    Max.   :25000.0   Max.   :354.0  
    ##                     NA's   :26124   NA's   :18038     NA's   :30046  
    ##  phase_of_flt           sky               precip         
    ##  Length:56978       Length:56978       Length:56978      
    ##  Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character  
    ##                                                          
    ##                                                          
    ##                                                          
    ##                                                          
    ##  cost_repairs_infl_adj
    ##  Min.   :      11     
    ##  1st Qu.:    5128     
    ##  Median :   26783     
    ##  Mean   :  242388     
    ##  3rd Qu.:   93124     
    ##  Max.   :16380000     
    ##  NA's   :56363

``` r
cols=c("state","airport_id","airport","operator", "atype", "type_eng", "species", "species_id","damage", "phase_of_flt","time_of_day","sky","precip")

wildlife_impacts[cols] <- lapply(wildlife_impacts[cols], factor)
sapply(wildlife_impacts, class) #Check that the classes have been changed to factors
```

    ## $incident_date
    ## [1] "POSIXct" "POSIXt" 
    ## 
    ## $state
    ## [1] "factor"
    ## 
    ## $airport_id
    ## [1] "factor"
    ## 
    ## $airport
    ## [1] "factor"
    ## 
    ## $operator
    ## [1] "factor"
    ## 
    ## $atype
    ## [1] "factor"
    ## 
    ## $type_eng
    ## [1] "factor"
    ## 
    ## $species_id
    ## [1] "factor"
    ## 
    ## $species
    ## [1] "factor"
    ## 
    ## $damage
    ## [1] "factor"
    ## 
    ## $num_engs
    ## [1] "numeric"
    ## 
    ## $incident_month
    ## [1] "numeric"
    ## 
    ## $incident_year
    ## [1] "numeric"
    ## 
    ## $time_of_day
    ## [1] "factor"
    ## 
    ## $time
    ## [1] "numeric"
    ## 
    ## $height
    ## [1] "numeric"
    ## 
    ## $speed
    ## [1] "numeric"
    ## 
    ## $phase_of_flt
    ## [1] "factor"
    ## 
    ## $sky
    ## [1] "factor"
    ## 
    ## $precip
    ## [1] "factor"
    ## 
    ## $cost_repairs_infl_adj
    ## [1] "numeric"

``` r
summary(wildlife_impacts)
```

    ##  incident_date                     state         airport_id   
    ##  Min.   :1990-01-01 00:00:00   N/A    :12671   ZZZZ   :11046  
    ##  1st Qu.:2001-11-15 00:00:00   TX     : 7146   KDFW   : 2455  
    ##  Median :2009-11-03 00:00:00   CA     : 5780   KDEN   : 2249  
    ##  Mean   :2008-05-21 04:57:11   FL     : 3686   KORD   : 1968  
    ##  3rd Qu.:2015-07-26 00:00:00   IL     : 2744   KSMF   : 1651  
    ##  Max.   :2018-12-31 00:00:00   CO     : 2441   KMCO   : 1067  
    ##                                (Other):22510   (Other):36542  
    ##                         airport                    operator    
    ##  UNKNOWN                    :11046   AMERICAN AIRLINES :14887  
    ##  DALLAS/FORT WORTH INTL ARPT: 2455   DELTA AIR LINES   : 9005  
    ##  DENVER INTL AIRPORT        : 2249   SOUTHWEST AIRLINES:17970  
    ##  CHICAGO O'HARE INTL ARPT   : 1968   UNITED AIRLINES   :15116  
    ##  SACRAMENTO INTL            : 1651                             
    ##  ORLANDO INTL               : 1067                             
    ##  (Other)                    :36542                             
    ##        atype       type_eng       species_id   
    ##  B-737-700: 9964   A   :    2   UNKBM  :15394  
    ##  B-737-300: 7641   C   :   34   UNKBS  :14765  
    ##  B-737-800: 5230   D   :56705   UNKB   : 3956  
    ##  B-757-200: 4235   F   :    3   NE1    : 1504  
    ##  A-320    : 3776   NA's:  234   O2205  : 1341  
    ##  A-319    : 3057                YI005  : 1171  
    ##  (Other)  :23075                (Other):18847  
    ##                   species       damage         num_engs    
    ##  Unknown bird - medium:15394   M   : 1892   Min.   :1.000  
    ##  Unknown bird - small :14765   M?  : 1085   1st Qu.:2.000  
    ##  Unknown bird         : 3956   N   :48650   Median :2.000  
    ##  Gulls                : 1504   S   : 1027   Mean   :2.059  
    ##  Mourning dove        : 1341   NA's: 4324   3rd Qu.:2.000  
    ##  Barn swallow         : 1171                Max.   :4.000  
    ##  (Other)              :18847                NA's   :233    
    ##  incident_month   incident_year  time_of_day        time      
    ##  Min.   : 1.000   Min.   :1990   Dawn : 1270   Min.   : -84   
    ##  1st Qu.: 5.000   1st Qu.:2001   Day  :25123   1st Qu.: 930   
    ##  Median : 8.000   Median :2009   Dusk : 1717   Median :1426   
    ##  Mean   : 7.235   Mean   :2008   Night:12735   Mean   :1428   
    ##  3rd Qu.:10.000   3rd Qu.:2015   NA's :16133   3rd Qu.:1950   
    ##  Max.   :12.000   Max.   :2018                 Max.   :2359   
    ##                                                NA's   :26124  
    ##      height            speed             phase_of_flt           sky       
    ##  Min.   :    0.0   Min.   :  0.0   Approach    :20604   No Cloud  :18937  
    ##  1st Qu.:    0.0   1st Qu.:130.0   Take-off run: 8233   Overcast  : 5449  
    ##  Median :   50.0   Median :140.0   Climb       : 7657   Some Cloud:12107  
    ##  Mean   :  983.8   Mean   :154.6   Landing Roll: 7244   NA's      :20485  
    ##  3rd Qu.: 1000.0   3rd Qu.:170.0   Descent     :  661                     
    ##  Max.   :25000.0   Max.   :354.0   (Other)     : 1110                     
    ##  NA's   :18038     NA's   :30046   NA's        :11469                     
    ##        precip      cost_repairs_infl_adj
    ##  None     :32937   Min.   :      11     
    ##  Rain     : 1689   1st Qu.:    5128     
    ##  Fog      :  587   Median :   26783     
    ##  Snow     :   85   Mean   :  242388     
    ##  Fog, Rain:   58   3rd Qu.:   93124     
    ##  (Other)  :    8   Max.   :16380000     
    ##  NA's     :21614   NA's   :56363

``` r
wildlife_impacts$YearMonth<- format(as.Date(wildlife_impacts$incident_date), "%Y-%b") # Formatting date to YYYY-mmm

wildlife_impacts$Phase_of_Flight=str_to_title(wildlife_impacts$phase_of_flt)




#Group by Phase of Flight and Month-Year

data <- wildlife_impacts%>%
  select(Phase_of_Flight,YearMonth,incident_year)%>%
  drop_na()%>% #Remove NAs
  group_by(Phase_of_Flight,YearMonth,incident_year)%>%
  summarise(number_of_incidents=n())%>%
  filter(Phase_of_Flight!="Unknown")

summary(data)
```

    ##  Phase_of_Flight     YearMonth         incident_year  number_of_incidents
    ##  Length:1984        Length:1984        Min.   :1990   Min.   :  1.00     
    ##  Class :character   Class :character   1st Qu.:1998   1st Qu.:  3.00     
    ##  Mode  :character   Mode  :character   Median :2006   Median : 14.00     
    ##                                        Mean   :2005   Mean   : 22.93     
    ##                                        3rd Qu.:2013   3rd Qu.: 30.00     
    ##                                        Max.   :2018   Max.   :297.00

``` r
#Stacked Bar Chart
ggplot(data, aes(fill=Phase_of_Flight, y=number_of_incidents, x=incident_year)) + 
    geom_bar(stat="identity")+
  theme(axis.text.x = element_text(size=10),axis.ticks = element_blank())+
  scale_x_continuous(expand = c(0, 0)) + ylim(0,4000) + 
  scale_fill_brewer(palette = "Spectral")+
  theme(plot.background = element_rect(fill = 'grey'), 
        panel.background = element_rect(fill = 'grey'),
        legend.background = element_rect(fill = 'grey'), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text = element_text( color = "black"),
        legend.key = element_rect(color="grey",linetype='blank'))+
  labs(title = "Phase of Flight when Incident Happened",
              subtitle = "1990-2018",
              x = "Year", y = "Number of Incidents")+
  labs(fill = "Phase of Flight")+
   theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
```

![](Wildlife_Strikes_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
ggsave("Strikes.png")
```

    ## Saving 7 x 5 in image
