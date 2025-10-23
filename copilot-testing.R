library(tidyverse)

library(palmerpenguins)
#install.packages("palmerpenguins")

#explore penguin dataset
glimpse(penguins)
summary(penguins)


#what is the relationship between body mass and flipper length in penguins?
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relationship between Body Mass and Flipper Length in Penguins",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()
