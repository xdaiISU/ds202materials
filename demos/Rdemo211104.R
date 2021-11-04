library(tidyverse)
library(classdata)
?box

avengers <- box %>%
  filter(Movie == 'Avengers: Endgame')
marvel <- box %>%
  filter(Movie == 'Captain Marvel')
ggplot(avengers, aes(x=Date, y=Total.Gross)) + geom_line()
ggplot(avengers, aes(x=Date, y=Gross)) + geom_line()

data <- bind_rows(avengers, marvel)

ggplot(data, aes(x=Date, y=Total.Gross)) + geom_line() # incorrect

ggplot(data, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line() # correct

# Your turn
spiderman <- box %>% 
  filter(Movie == 'Spider-Man: Far From …')
ggplot(spiderman, aes(x=Date, y=Total.Gross)) + geom_line()

data1 <- bind_rows(data, spiderman)
ggplot(data1, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line()
ggplot(data1, aes(x=Date, y=Total.Gross, group=Movie, color=Movie)) + geom_line()

ggplot(data1, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line()
ggplot(data1, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line() + scale_x_date(date_labels = '%a %b, %Y')
?scale_x_date

dupMovie <- box %>%
  filter(Week == 1) %>% 
  group_by(Movie) %>%
  summarize(n = n()) %>% 
  filter(n > 1)
dupMovie

dupMovieData <- box %>%
  semi_join(dupMovie)
ggplot(dupMovieData, aes(x=Date, y=Total.Gross, Group=Movie, color=Movie)) + geom_line()

interaction(c('a', 'a', 'b'), c(3, 4, 4))

ggplot(dupMovieData, 
       aes(x=Date, y=Total.Gross, 
           group=interaction(Movie, Distributor), 
           color=interaction(Movie, Distributor))) + 
  geom_line()

p <- ggplot(box, aes(x=Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line()

box_summary <- box %>%
  group_by(Movie, Distributor) %>%
  summarize(Date = max(Date),
            Total.Gross = max(Total.Gross))

p + geom_text(aes(x=Date, y=Total.Gross, label=Movie), data=box_summary %>% filter(Total.Gross > 2.5))

p + geom_text(aes(x=Date, y=Total.Gross, label=Movie), data=box_summary %>% filter(Total.Gross > 2.5), hjust=0, vjust=0)

p + geom_text(aes(x=Date, y=Total.Gross, label=Movie), data=box_summary %>% filter(Total.Gross > 2.5), hjust=0, vjust=0, angle=45)

library(ggrepel)
p + geom_text_repel(aes(x=Date, y=Total.Gross, label=Movie), data=box_summary %>% filter(Total.Gross > 2.5))

p1 <- p + geom_text(aes(x=Date, y=Total.Gross, label=Movie), data=box_summary %>% filter(Total.Gross > 2.5), hjust=0, vjust=0)

library(plotly)
ggplotly(p1)
