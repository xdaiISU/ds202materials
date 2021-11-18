library(tidyverse)
p1 <- mpg %>%
  filter(year == 2008) %>%
  ggplot(aes(x=cty, y=hwy, color=cyl)) + 
  geom_point(position='jitter')
p1
p1 + scale_color_gradient()
p1 + scale_color_gradient(low='yellow', high='red')

p1 + scale_color_gradient2()
p1 + scale_color_gradient2(midpoint=6)
p1 + scale_color_gradient2(midpoint=6, 
                           low=scales::muted('blue'),
                           high='red')
p1 + scale_color_gradient2(midpoint=6, 
                           low = '#FF5500',
                           high='#0055FF')


?diamonds
p <- ggplot(diamonds, aes(x=carat, y=price, color=price)) + 
  geom_point()
p + scale_color_gradient()
p + scale_color_gradient(high='gray')
p + scale_color_gradient2(low='black', mid='green', high='red', midpoint =10000)

p2 <- mpg %>%
  filter(year == 2008) %>%
  ggplot(aes(x=cty, y=hwy, color=factor(cyl))) + 
  geom_point(position='jitter')
p2
p2 + scale_color_discrete()
p2 + scale_color_discrete(direction=-1)

mapping <- c('4' = 'blue', '5' = 'yellow', '6'='darkgreen', '8' = 'red')
p2 + scale_color_manual(values=mapping)

library(RColorBrewer)
display.brewer.all()

p2 + scale_color_brewer(palette='Set1')
p2 + scale_color_brewer(palette='Set3')

states <- map_data('state')
p3 <- states %>%
  ggplot(aes(x=long, y=lat, group=group, 
             fill=lat)) + 
  geom_polygon()

p3 + scale_fill_distiller(palette='GnBu', direction=1)

ggplot(diamonds, aes(x=carat, y=price, color=clarity )) + geom_point() +
  scale_color_brewer(palette='Blues', direction = -1)

ggplot(diamonds, aes(x=carat, y=price, color=depth )) + geom_point() + 
  scale_color_distiller(palette='Blues', direction=-1)



library(tidyverse)
tlong <- read_csv('topics.csv')  %>% mutate(
  rating = factor(rating, 
                  levels= c("Favorite", "Like it very much",
                            "Like it", "Don't like it that much")))
p0 <- tlong %>% 
  mutate(rating = factor(rating, rev(levels(rating)))) %>%
  ggplot(aes(x = topic)) + geom_bar(aes(fill=rating))

col <- rev(c('blue', 'dodgerblue', 'skyblue', 'red'))
p0 + 
  coord_flip() + 
  scale_fill_manual(values=col) + 
  theme(axis.text.y=element_blank(),
        legend.position='bottom') + 
  geom_text(aes(x=topic, label=topic), y=0, hjust=0, color='white')
