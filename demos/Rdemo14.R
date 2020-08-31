library(tidyverse)
library(classdata)
str(box)

avengers <- box %>% filter(Movie == 'Avengers: Endgame')
marvel <- box %>% filter(Movie == 'Captain Marvel')
ggplot(avengers, aes(x=Date, y=Total.Gross)) + geom_line()

data <- bind_rows(avengers, marvel)
ggplot(data, aes(x=Date, y=Total.Gross)) + geom_line()
ggplot(data, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line()


ggplot(avengers, aes(x = Date, y = Total.Gross)) + geom_line() +
  scale_x_date(date_labels="%b %d, %y")

dupMovie <- box %>% 
  filter(Week == 1) %>% 
  group_by(Movie) %>% 
  summarize(nDist = n()) %>% 
  filter(nDist > 1)
dup <- box %>%
  filter(Movie %in% dupMovie$Movie) %>%
  arrange(Movie, Distributor, Date)

interaction(
  c('a', 'a', 'b'),
  c('D1', 'D2', 'D2')
)

ggplot(dup, aes(x=Date, y=Total.Gross, 
                group=interaction(Movie, Distributor), color=Movie)) + geom_line()

ggplot(box, aes(x = Date, y=Total.Gross, group=Movie)) + geom_line()
ggplot(box, aes(x = Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line()

box_summary <- box %>% 
  group_by(Movie, Distributor) %>%
  summarize(
    Date = max(Date), 
    Total.Gross = max(Total.Gross)
  )

?geom_text
dat <- data.frame(x = 1:2, y=5:4, text = c('labX', 'labY'))
dat
ggplot(dat, aes(x=x, y=y)) + geom_point()
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text()
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text(hjust=0, vjust=0, angle=45)

box %>% ggplot(aes(x=Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line() + 
  geom_text(data=box_summary, aes(x=Date, y=Total.Gross, label=Movie))

box %>% ggplot(aes(x=Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line() + 
  geom_text(data=box_summary %>% filter(Total.Gross > 2.5), 
            aes(x=Date, y=Total.Gross, label=Movie), 
            vjust=0)

install.packages('ggrepel')
library(ggrepel)
box %>% ggplot(aes(x=Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line() + 
  geom_text_repel(data=box_summary %>% filter(Total.Gross > 2.5), 
                  aes(x=Date, y=Total.Gross, label=Movie))


install.packages('plotly')
library(plotly)
p <- ggplot(box, aes(x=Date, y=Total.Gross, group=interaction(Movie, Distributor))) + geom_line()
p
ggplotly(p)
