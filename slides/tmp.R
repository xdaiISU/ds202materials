
# Continuous 
library(tidyverse)
p1 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y = hwy, color = cyl)) +
  geom_point(position='jitter')
p1 + scale_color_gradient() # same
?scale_color_gradient
p1 + scale_color_gradient(low='#56B1F7', high='#132B43')
p1 + scale_color_gradient(trans='log10') # color scale in log


# gradient2: midpoint = 0 by default
?scale_color_gradient2
p1 + scale_color_gradient2()
p1 + scale_color_gradient2(midpoint=6) 
p1 + scale_color_gradient2(midpoint=6, low=scales::muted('blue'), high=scales::muted('red')) 

# Hexidecimal code: '#RRGGBB'. Each range from 0 to F (F=15). FF = 15 * 16 + 15
rgb(0, 255, 0, maxColorValue = 255) # green
p1 + scale_color_gradient2(midpoint=6, low='#00FF00', high='#0000FF') 

# ## Your turn 1
# data(diamonds)
# ggplot(diamonds, aes(x=carat, y=price, color=price)) + geom_point() + scale_color_gradient(low='black', high='lightblue')
# ggplot(diamonds, aes(x=carat, y=price, color=price)) + geom_point() + scale_color_gradient2(low='black', mid='green', high='red', midpoint = 10000)

# Discrete
p2 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_point(position='jitter')
p2 + scale_color_discrete()
cols <- c("4" = "blue", "5"="yellow", "6" = "darkgreen", "8" = "red")
p2 + scale_colour_manual(values = cols)

library(RColorBrewer)
display.brewer.all()

p2 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_point()
p2 + scale_color_brewer(palette='Set1') # better, since the colors can be named, and darker

# ## Your turn 2
# ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + geom_point() + scale_color_brewer(palette='Blues')

## Brewer color schemes - Continuous
#For continuous variables, use `*_color_distiller`:
states <- map_data('state')
states %>% ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill=lat)) + 
  scale_fill_distiller(palette='OrRd', direction=1) # Note direction

# # Your turn
# ggplot(diamonds, aes(x=carat, y=price, color=depth)) + geom_point() + scale_color_distiller(palette='Blues')

mpg %>% ggplot(aes(x = manufacturer)) + geom_bar() +
  theme(axis.text.x = element_text(angle=45))
mpg %>% ggplot(aes(x = manufacturer)) + geom_bar() +
  theme(axis.text.x = element_text(angle=45, vjust=1, hjust=1))
