# lab5


# Load required packages

library(tidyverse) library(knitr)

# Read in the data

titanic \<-
read_csv(“https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/Titanic.csv”)

# Let’s look at the top 5 lines of the dataset

head(titanic, n = 5) \|\> kable()
