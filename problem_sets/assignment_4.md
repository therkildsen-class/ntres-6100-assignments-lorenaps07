# assignment_4


## Load packages

To start, load all the required packages with the following code.
Install them if they are not installed yet.

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

<br>

## Exercise 1. Corruption and human development

This exercise explores a dataset containing the human development index
(`HDI`) and corruption perception index (`CPI`) of 173 countries across
6 different regions around the world: Americas, Asia Pacific, Eastern
Europe and Central Asia (`East EU Cemt`), Western Europe
(`EU W. Europe`), Middle East and North Africa and Noth Africa (`MENA`),
and Sub-Saharan Africa (`SSA`). (Note: the larger `CPI` is, the less
corrupted the country is perceived to be.)

<br>

First, we load the data using the following code.

``` r
economist_data <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/EconomistData.csv")
```

    New names:
    Rows: 173 Columns: 6
    ── Column specification
    ──────────────────────────────────────────────────────── Delimiter: "," chr
    (2): Country, Region dbl (4): ...1, HDI.Rank, HDI, CPI
    ℹ Use `spec()` to retrieve the full column specification for this data. ℹ
    Specify the column types or set `show_col_types = FALSE` to quiet this message.
    • `` -> `...1`

<br>

#### 1.1 Show the first few rows of `economist_data`.

``` r
kable(head(economist_data))
```

|  …1 | Country     | HDI.Rank |   HDI | CPI | Region            |
|----:|:------------|---------:|------:|----:|:------------------|
|   1 | Afghanistan |      172 | 0.398 | 1.5 | Asia Pacific      |
|   2 | Albania     |       70 | 0.739 | 3.1 | East EU Cemt Asia |
|   3 | Algeria     |       96 | 0.698 | 2.9 | MENA              |
|   4 | Angola      |      148 | 0.486 | 2.0 | SSA               |
|   5 | Argentina   |       45 | 0.797 | 3.0 | Americas          |
|   6 | Armenia     |       86 | 0.716 | 2.6 | East EU Cemt Asia |

<br>

#### 1.2 Expore the relationship between human development index (`HDI`) and corruption perception index (`CPI`) with a scatter plot as the following.

``` r
plotrelationship <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI)) +
  geom_point()
plotrelationship
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-4-1.png)

<br>

#### 1.3 Make of color of all points in the previous plot red.

``` r
plotredpoints <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI)) +
  geom_point(color = "red")
plotredpoints
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-5-1.png)

<br>

#### 1.4 Color the points in the previous plot according to the `Region` variable, and set the size of points to 2.

``` r
coloredplot <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI, color = Region)) +
  geom_point()
coloredplot
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-6-1.png)

<br>

#### 1.5 Set the size of the points proportional to `HDI.Rank`

``` r
sizedplot <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI, color = Region, size = HDI.Rank)) +
  geom_point()
sizedplot
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-7-1.png)

<br>

#### 1.6 Fit a **smoothing line** to **all** the data points in the scatter plot from Excercise 1.4

``` r
smoothedplot <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI)) +
  geom_point(aes(color = Region)) +
  geom_smooth(aes(group = 1), method = "loess", se = TRUE)
smoothedplot
```

    `geom_smooth()` using formula = 'y ~ x'

![](assignment_4_files/figure-commonmark/unnamed-chunk-8-1.png)

<br>

#### 1.7 Fit a separate **straight line** for **each region** instead, and turn off the confidence interval.

``` r
regionedplot <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI)) +
  geom_point(aes(color = Region)) +
  geom_smooth(aes(color = Region), method = "lm", se = FALSE)
regionedplot
```

    `geom_smooth()` using formula = 'y ~ x'

![](assignment_4_files/figure-commonmark/unnamed-chunk-9-1.png)

<br>

#### 1.8 Building on top of the previous plot, show each `Region` in a different facet.

``` r
facetedplot <- economist_data %>%
  ggplot(aes(x = CPI, y = HDI)) +
  geom_point(aes(color = Region)) +
  geom_smooth(aes(color = Region), method = "lm", se = FALSE) +
  facet_wrap(~Region)
facetedplot
```

    `geom_smooth()` using formula = 'y ~ x'

![](assignment_4_files/figure-commonmark/unnamed-chunk-10-1.png)

<br>

#### 1.9 Show the distribution of `HDI` in each region using density plot. Set the transparency to 0.5

``` r
densityplot <- economist_data %>%
  ggplot(aes(x = HDI, fill = Region)) +
  geom_density(alpha = 0.5)
densityplot
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-11-1.png)

<br>

#### 1.10 Show the distribution of `HDI` in each region using histogram and facetting.

``` r
histplot <- economist_data %>%
  ggplot(aes(x = HDI, fill = Region)) +
  geom_histogram() +
  facet_wrap(~Region)
histplot
```

    `stat_bin()` using `bins = 30`. Pick better value `binwidth`.

![](assignment_4_files/figure-commonmark/unnamed-chunk-12-1.png)

<br>

#### 1.11 Show the distribution of `HDI` in each region using a box plot. Set the transparency of these boxes to 0.5 and do not show outlier points with the box plot. Instead, show all data points for each country in the same plot.

*Hint: `geom_jitter()` or `position_jitter()` might be useful*

``` r
boxplot <- economist_data %>%
  ggplot(aes(x = Region, y = HDI, fill = Region)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.5)
boxplot
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-13-1.png)

<br>

#### 1.12 Show the count of countries in each region using a bar plot.

``` r
barplot <- economist_data %>%
  ggplot(aes(x = Region)) +
  geom_bar()
barplot
```

![](assignment_4_files/figure-commonmark/unnamed-chunk-14-1.png)

<br>

#### 1.13 You have now created a variety of different plots of the same dataset. Which of your plots do you think are the most informative? Describe briefly the major trends that you see in the data.

Answer: *Write your response here*.

<br> <br>

## Exercise 2. Theophylline experiment

This exercise uses the `Theoph` data frame (comes with your R
installation), which has 132 rows and 5 columns of data from an
experiment on the pharmacokinetics of the anti-asthmatic drug
theophylline. Twelve subjects were given oral doses of theophylline then
serum concentrations were measured at 11 time points over the next 25
hours. You can learn more about this dataset by running `?Theoph`

Have a look at the data structure

``` r
str(Theoph)
```

    Classes 'nfnGroupedData', 'nfGroupedData', 'groupedData' and 'data.frame':  132 obs. of  5 variables:
     $ Subject: Ord.factor w/ 12 levels "6"<"7"<"8"<"11"<..: 11 11 11 11 11 11 11 11 11 11 ...
     $ Wt     : num  79.6 79.6 79.6 79.6 79.6 79.6 79.6 79.6 79.6 79.6 ...
     $ Dose   : num  4.02 4.02 4.02 4.02 4.02 4.02 4.02 4.02 4.02 4.02 ...
     $ Time   : num  0 0.25 0.57 1.12 2.02 ...
     $ conc   : num  0.74 2.84 6.57 10.5 9.66 8.58 8.36 7.47 6.89 5.94 ...
     - attr(*, "formula")=Class 'formula'  language conc ~ Time | Subject
      .. ..- attr(*, ".Environment")=<environment: R_EmptyEnv> 
     - attr(*, "labels")=List of 2
      ..$ x: chr "Time since drug administration"
      ..$ y: chr "Theophylline concentration in serum"
     - attr(*, "units")=List of 2
      ..$ x: chr "(hr)"
      ..$ y: chr "(mg/l)"

<br>

For the following exercise, **transform the data as instructed**. Try to
use `tidyverse` functions even if you are more comfortable with base-R
solutions. Show the **first 6 lines** of the transformed data in a table
through RMarkdown **using the kable() function**, as shown above.

#### 2.1 Select columns that contain a lower case “t” in the `Theoph` dataset. Do not manually list all the columns to include.

``` r
kable(head(Theoph %>%
    select(contains("t"))))
```

| Subject |   Wt | Time |
|:--------|-----:|-----:|
| 1       | 79.6 | 0.00 |
| 1       | 79.6 | 0.25 |
| 1       | 79.6 | 0.57 |
| 1       | 79.6 | 1.12 |
| 1       | 79.6 | 2.02 |
| 1       | 79.6 | 3.82 |

<br>

#### 2.2 Rename the `Wt` column to `Weight` and `conc` column to `Concentration` in the `Theoph` dataset.

``` r
kable(head(Theoph %>%
    rename(Weight = Wt,
           Concentration = conc)))
```

| Subject | Weight | Dose | Time | Concentration |
|:--------|-------:|-----:|-----:|--------------:|
| 1       |   79.6 | 4.02 | 0.00 |          0.74 |
| 1       |   79.6 | 4.02 | 0.25 |          2.84 |
| 1       |   79.6 | 4.02 | 0.57 |          6.57 |
| 1       |   79.6 | 4.02 | 1.12 |         10.50 |
| 1       |   79.6 | 4.02 | 2.02 |          9.66 |
| 1       |   79.6 | 4.02 | 3.82 |          8.58 |

<br>

#### 2.3 Extract the `Dose` greater than 4.5 and `Time` greater than the mean `Time`.

``` r
kable(head(Theoph %>%
    filter(Dose > 4.5,
           Time > mean(Time))))
```

| Subject |   Wt | Dose |  Time | conc |
|:--------|-----:|-----:|------:|-----:|
| 3       | 70.5 | 4.53 |  7.07 | 5.30 |
| 3       | 70.5 | 4.53 |  9.00 | 4.90 |
| 3       | 70.5 | 4.53 | 12.15 | 3.70 |
| 3       | 70.5 | 4.53 | 24.17 | 1.05 |
| 5       | 54.6 | 5.86 |  7.02 | 7.09 |
| 5       | 54.6 | 5.86 |  9.10 | 5.90 |

<br>

#### 2.4 Sort the `Theoph` dataset by `Wt` from smallest to largest and secondarily by Time from largest to smallest.

``` r
kable(head(Theoph %>%
    arrange(Wt, desc(Time))))
```

| Subject |   Wt | Dose |  Time | conc |
|:--------|-----:|-----:|------:|-----:|
| 5       | 54.6 | 5.86 | 24.35 | 1.57 |
| 5       | 54.6 | 5.86 | 12.00 | 4.37 |
| 5       | 54.6 | 5.86 |  9.10 | 5.90 |
| 5       | 54.6 | 5.86 |  7.02 | 7.09 |
| 5       | 54.6 | 5.86 |  5.02 | 7.56 |
| 5       | 54.6 | 5.86 |  3.50 | 8.74 |

<br>

#### 2.5 Create a new column called `Quantity` that equals to `Wt` x `Dose` in the `Theoph` dataset. This will tell you the absolute quantity of drug administered to the subject (in mg). Replace the `Dose` variable with `Quantity`.

``` r
kable(head(Theoph %>%
    mutate(Quantity = Wt * Dose) %>%
    select(-Dose)))
```

| Subject |   Wt | Time |  conc | Quantity |
|:--------|-----:|-----:|------:|---------:|
| 1       | 79.6 | 0.00 |  0.74 |  319.992 |
| 1       | 79.6 | 0.25 |  2.84 |  319.992 |
| 1       | 79.6 | 0.57 |  6.57 |  319.992 |
| 1       | 79.6 | 1.12 | 10.50 |  319.992 |
| 1       | 79.6 | 2.02 |  9.66 |  319.992 |
| 1       | 79.6 | 3.82 |  8.58 |  319.992 |

<br>

#### 2.6 Find the mean `conc` and sum of the `Dose` received by each test subject.

``` r
kable(head(Theoph %>%
    group_by(Subject) %>%
    summarise(
      mean_conc = mean(conc),
      sum_dose = sum(Dose)
    )))
```

| Subject | mean_conc | sum_dose |
|:--------|----------:|---------:|
| 6       |  3.525454 |    44.00 |
| 7       |  3.910909 |    54.45 |
| 8       |  4.271818 |    49.83 |
| 11      |  4.510909 |    54.12 |
| 3       |  5.086364 |    49.83 |
| 2       |  4.823636 |    48.40 |

Show data for the 6 subjects with the smallest sum of `Dose` as below.
**Do not define new intermediate objects for this exercise; use pipes to
chain together functions.**

``` r
kable(Theoph %>%
    group_by(Subject) %>%
    summarise(
      mean_conc = mean(conc),
      sum_dose = sum(Dose)
    ) %>%
    arrange(sum_dose) %>%
    head(6))
```

| Subject | mean_conc | sum_dose |
|:--------|----------:|---------:|
| 9       |  4.893636 |    34.10 |
| 6       |  3.525454 |    44.00 |
| 1       |  6.439091 |    44.22 |
| 2       |  4.823636 |    48.40 |
| 4       |  4.940000 |    48.40 |
| 8       |  4.271818 |    49.83 |

<br>
