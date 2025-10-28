library(tidyverse)

# Basic syntax of functions
# function_name <- function(inputs) {output_value <- do_something(inputs)return(output_value)}

# remember to use return() to return the output value you want, in this case volume
calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}
# now you need to give values to the arguments in the function
calc_shrub_vol(0.8, 1.6, 2.0)
# [1] 2.56

# Now try to get the area instead

calc_shrub_area <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(area)
}
calc_shrub_area(0.8, 1.6, 2.0)
# [1] 1.28

# you can also define what the values are more specifically

calc_shrub_area(length = 0.8, width = 1.6, height = 2.0)
# the default is in this order, but if you want to change the default you specify
# like having the second term as height instead of width

# Exercise: create a function that converts pounds to grams
convert_pounds_to_grams <- function(pounds) {
  grams <- 453.6 * pounds
  return(grams)
}
convert_pounds_to_grams(3.75)
# [1] 1701.0

# It is important to note that even after we’ve defined and run a function, 
# we can’t access variables created inside the function. For example:
#volume > object 'volume' not found
#width > object 'width' not found

# Each function should be single conceptual chunk of code.
# Functions can be combined to do larger tasks in two ways. The first is in a row 
est_shrub_mass <- function(volume){
  mass <- 2.65 * volume^0.9
  return(mass)
}
shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0)
shrub_mass <- est_shrub_mass(shrub_volume)
shrub_mass
# [1] 5.233

#the second is using pipes, which is cleaner but also does not explicitly show the intermediate steps
library(dplyr)

shrub_mass <- calc_shrub_vol(0.8, 1.6, 2.0) |>
  est_shrub_mass()
shrub_mass
# [1] 5.233

# You can use functions to clean a for loop code
library(gapminder)
gapminder

# For loop code

dir.create("figures") 
dir.create("figures/Europe") 

gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdpTot = gdpPercap * pop)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) { # (cntry = country_list[1])
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpTot)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpTot.png", sep = ""), plot = my_plot)
} 


# Function code

dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry) {
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = gdpTot)) + 
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, "GDP per capita", sep = " "))
  
  ggsave(filename = paste("figures/Europe/", cntry, "_gdpTot.png", sep = ""), plot = my_plot)
} 

save_plot("Germany")
save_plot("France")

# We can even write a for loop to run the function on each country in a list of countries (doing exactly the same as our for loop did before, but now we have pulled the code specifying the operation out of the for loop itself)

country_list <- unique(gap_europe$country) # ?unique() returns the unique values

for (cntry in country_list) {
  
  save_plot(cntry)
  
}

# now using the function to get some outputs we define
dir.create("figures") 
dir.create("figures/Europe") 

## We still keep our calculation outside the function because we can do this as a single step for all countries outside the function. But we could also build this step into our function if we prefer.
gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdpTot = gdpPercap * pop)

#define our function
save_plot <- function(cntry, stat = "gdpPercap", filetype = "pdf") {   # Here I'm adding additional arguments to the function, which we'll use to specify what statistic we want plotted and what filetype we want
  
  ## filter the country to plot
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  ## add a print message to see what's plotting
  print(paste("Plotting", cntry))
  
  ## plot
  my_plot <- ggplot(data = gap_to_plot, aes(x = year, y = get(stat))) +    # We need to use get() here to access the value we store as stat when we call the function
    geom_point() +
    ## add title and save
    labs(title = paste(cntry, stat, sep = " "), y = stat)
  
  ggsave(filename = paste("figures/Europe/", cntry, "_", stat, ".", filetype, sep = ""), plot = my_plot)
} 


# Testing our function
save_plot("Germany")
save_plot("Germany", "lifeExp", "jpg")


