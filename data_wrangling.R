library(tidyverse) 
library(skimr) # install.packages("skimr")

coronavirus <- read_csv('https://github.com/RamiKrispin/coronavirus.git')
summary(coronavirus)

skim(coronavirus)
view(coronavirus)
