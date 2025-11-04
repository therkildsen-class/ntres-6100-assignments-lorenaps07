# assignment_6


``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.1     ✔ stringr   1.5.2
    ✔ ggplot2   4.0.0     ✔ tibble    3.3.0
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ✔ purrr     1.1.0     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(knitr)
```

## Exercise 1. Tibble and Data Import

<br>

#### 1.1 Create the following tibble manually, first using `tribble()` and then using `tibble()`. Print both results.

``` r
library(tibble)

data_with_tribble <- tribble(~a, ~b,   ~c, 1,  2.1, "apple", 2,  3.2, "orange")

data_with_tribble
```

    # A tibble: 2 × 3
          a     b c     
      <dbl> <dbl> <chr> 
    1     1   2.1 apple 
    2     2   3.2 orange

``` r
data_with_tibble <- tibble(
  a = c(1, 2),
  b = c(2.1, 3.2),
  c = c("apple", "orange")
)
data_with_tibble
```

    # A tibble: 2 × 3
          a     b c     
      <dbl> <dbl> <chr> 
    1     1   2.1 apple 
    2     2   3.2 orange

<br>

#### 1.2 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt` into R. Change the column names into “Name”, “Weight”, “Price”.

``` r
exercise1.2 <- read_table(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt",
  col_names = c("Name", "Weight", "Price")
)
```


    ── Column specification ────────────────────────────────────────────────────────
    cols(
      Name = col_character(),
      Weight = col_character(),
      Price = col_character()
    )

    Warning: 3 parsing failures.
    row col  expected    actual                                                                                           file
      1  -- 3 columns 1 columns 'https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt'
      2  -- 3 columns 1 columns 'https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt'
      3  -- 3 columns 1 columns 'https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt'

``` r
exercise1.2
```

    # A tibble: 3 × 3
      Name           Weight Price
      <chr>          <chr>  <chr>
    1 apple,1,2.9    <NA>   <NA> 
    2 orange,2,4.9   <NA>   <NA> 
    3 durian,10,19.9 <NA>   <NA> 

<br>

#### 1.3 Import `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt` into R. Watch out for the first few lines, missing values, separators, quotation marks, and deliminaters.

``` r
exercise1.3 <- read_delim(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt",
  delim = ";",
  skip = 2,
  na = c("NA", "N/A", "")
)
```

    Rows: 3 Columns: 3
    ── Column specification ────────────────────────────────────────────────────────
    Delimiter: ";"
    chr (3): /Name/, /Weight/, /Price/

    ℹ Use `spec()` to retrieve the full column specification for this data.
    ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
exercise1.3
```

    # A tibble: 3 × 3
      `/Name/` `/Weight/` `/Price/`    
      <chr>    <chr>      <chr>        
    1 /apple/  1          2.9          
    2 /orange/ 2          Not Available
    3 /durian/ ?          19.9         

<br>

## Exercise 2. Weather station

This dataset contains the weather and air quality data collected by a
weather station in Taiwan. It was obtained from the Environmental
Protection Administration, Executive Yuan, R.O.C. (Taiwan).

#### 2.1 Variable descriptions

- The text file
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt`
  contains descriptions of different variables collected by the station.

- Import it into R and print it in a table as shown below with
  `kable()`.

``` r
weather_variable_descriptions <- read_lines(
  "https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station_notes.txt"
)
weather_variable_descriptions_df <- tibble(
  Variable = weather_variable_descriptions
)
kable(weather_variable_descriptions_df)
```

| Variable |
|:---|
| Item-Unit-Description |
| AMB_TEMP-Celsius-Ambient air temperature |
| CO-ppm-Carbon monoxide |
| NO-ppb-Nitric oxide |
| NO2-ppb-Nitrogen dioxide |
| NOx-ppb-Nitrogen oxides |
| O3-ppb-Ozone |
| PM10-μg/m3-Particulate matter with a diameter between 2.5 and 10 μm |
| PM2.5-μg/m3-Particulate matter with a diameter of 2.5 μm or less |
| RAINFALL-mm-Rainfall |
| RH-%-Relative humidity |
| SO2-ppb-Sulfur dioxide |
| WD_HR-degress-Wind direction (The average of hour) |
| WIND_DIREC-degress-Wind direction (The average of last ten minutes per hour) |
| WIND_SPEED-m/sec-Wind speed (The average of last ten minutes per hour) |
| WS_HR-m/sec-Wind speed (The average of hour) |

<br>

#### 2.2 Data tidying

- Import
  `https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/2015y_Weather_Station.csv`
  into R. As you can see, this dataset is a classic example of untidy
  data: values of a variable (i.e. hour of the day) are stored as column
  names; variable names are stored in the `item` column.

- Clean this dataset up and restructure it into a tidy format.

- Parse the `date` variable into date format and parse `hour` into time.

- Turn all invalid values into `NA` and turn `NR` in rainfall into `0`.

- Parse all values into numbers.

- Show the first 6 rows and 10 columns of this cleaned dataset, as shown
  below, *without* using `kable()`.

*Hints: you don’t have to perform these tasks in the given order; also,
warning messages are not necessarily signs of trouble.*

<br>

Before cleaning:

    ## # A tibble: 6 × 10
    ##   date       station item     `00`  `01`  `02`  `03`  `04`  `05`  `06` 
    ##   <chr>      <chr>   <chr>    <chr> <chr> <chr> <chr> <chr> <chr> <chr>
    ## 1 2015/01/01 Cailiao AMB_TEMP 16    16    15    15    15    14    14   
    ## 2 2015/01/01 Cailiao CO       0.74  0.7   0.66  0.61  0.51  0.51  0.51 
    ## 3 2015/01/01 Cailiao NO       1     0.8   1.1   1.7   2     1.7   1.9  
    ## 4 2015/01/01 Cailiao NO2      15    13    13    12    11    13    13   
    ## 5 2015/01/01 Cailiao NOx      16    14    14    13    13    15    15   
    ## 6 2015/01/01 Cailiao O3       35    36    35    34    34    32    30

<br>

After cleaning:

    ## # A tibble: 6 × 10
    ##   date       station hour   AMB_TEMP    CO    NO   NO2   NOx    O3  PM10
    ##   <date>     <chr>   <time>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ## 1 2015-01-01 Cailiao 00:00        16  0.74   1      15    16    35   171
    ## 2 2015-01-01 Cailiao 01:00        16  0.7    0.8    13    14    36   174
    ## 3 2015-01-01 Cailiao 02:00        15  0.66   1.1    13    14    35   160
    ## 4 2015-01-01 Cailiao 03:00        15  0.61   1.7    12    13    34   142
    ## 5 2015-01-01 Cailiao 04:00        15  0.51   2      11    13    34   123
    ## 6 2015-01-01 Cailiao 05:00        14  0.51   1.7    13    15    32   110

<br>

#### 2.3 Using this cleaned dataset, plot the daily variation in ambient temperature on September 25, 2015, as shown below.

<br>

#### 2.4 Plot the daily average ambient temperature throughout the year with a **continuous line**, as shown below.

![](assignment_6_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

<br>

#### 2.5 Plot the total rainfall per month in a bar chart, as shown below.

*Hint: separating date into three columns might be helpful.*

![](assignment_6_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

<br>

#### 2.6 Plot the per hour variation in PM2.5 in the first week of September with a **continuous line**, as shown below.

*Hint: uniting the date and hour and parsing the new variable might be
helpful.*

![](assignment_6_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

<br>
