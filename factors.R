library(tidyverse)
library(gapminder)  #install.packages("gapminder")
library(gridExtra)  #install.packages("gridExtra")

gapminder

str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")

gapminder |>
  count(continent)

h_gap <- gapminder |>
  filter(country %in% h_countries)

nlevels(h_gap$country)

h_gap_dropped <-