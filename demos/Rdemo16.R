library(tidyverse)
p1 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y=hwy, color=cyl)) + 
  geom_point(position='jitter')
p1
p1 + scale_color_gradient()
?scale_color_gradient
p1 + scale_color_gradient(low='#00FF00', high='#FF0000')
p1 + scale_color_gradient(low='#00FF00', high='#FF0000',
                          trans='log10')

?scale_color_gradient2
p1 + scale_color_gradient2(midpoint=6)
p1 + scale_color_gradient2() # not what we want


p2 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x=cty, y=hwy, color=factor(cyl))) + 
  geom_point(position = 'jitter')
p2 + scale_color_discrete()

cols <- c('4'='blue', '5'='yellow', '6'='darkgreen', '8'='red')
p2 + scale_color_manual(values=cols)

library(RColorBrewer)
display.brewer.all()
p2 + scale_color_brewer(palette='Set1', direction=-1)

states <- map_data('state')
states %>% ggplot(aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group, fill=lat)) + 
  scale_fill_distiller(palette='Blues')
