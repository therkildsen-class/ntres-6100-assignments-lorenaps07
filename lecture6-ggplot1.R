library(tidyverse)
mpg
?mpg

cars
?cars

View(mpg)

head(cars, 4)
tail(cars)

#create a ggplot
ggplot(data =mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) #layer aesthetics

#good practices: keep all new layers in new lines

#exercise 2
ggplot(data =mpg) # does not make a plot because does not have layers

ggplot(data =mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy)) #other way of displaying data

ggplot(data =mpg) +
  geom_point(mapping = aes(x = class, y = drv)) #not good way to display data because points overlap

#add color, size and shape
ggplot(data =mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)

?geom_point #gives help and explanation

#exercise 3, color points by the yr of manufacture for each car model
ggplot(data =mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))

#put the main data default inside ggplot to use that for all next plots
ggplot(data =mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year, nrow = 2)

#facet_wrap to divide by some variable, create subplots
ggplot(data =mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class, size = cyl)) +
  facet_wrap(~ class)

ggsave(filename = "plots/hmy_vs_displ.pdf", plot1)
?ggsave
create.dir = TRUE
ggsave(filename = "plots/hmy_vs_displ.pdf")
