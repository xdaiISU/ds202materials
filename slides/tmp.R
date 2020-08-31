# Box office example

library(tidyverse)
library(classdata)
str(box) 

avengers <- box %>% filter(Movie == 'Avengers: Endgame')
marvel <- box %>% filter(Movie == 'Captain Marvel')
ggplot(avengers, aes(x = Date, y = Total.Gross)) + geom_point()
ggplot(avengers, aes(x = Date, y = Total.Gross)) + geom_line()
data <- bind_rows(avengers, marvel)
ggplot(data, aes(x = Date, y = Total.Gross)) + geom_line()
ggplot(data, aes(x = Date, y = Total.Gross, group=Movie)) + geom_line()

# Back to slides 

# Format the x-axis. ?strptime
ggplot(avengers, aes(x = Date, y = Total.Gross)) + geom_line() +
  scale_x_date(date_labels = ("%b %Y"))

dupMovie <- box %>%
  filter(Week == 1) %>%
  group_by(Movie) %>%
  summarize(nDist = n()) %>%
  filter(nDist > 1)
# dup <- box %>%
#   filter(Movie %in% dupMovie$Movie) %>%
#   select(Movie, Distributor, Date) %>%
#   arrange(Movie, Distributor, Date)

interaction(c('a', 'a', 'b'), c(3, 4, 4))

dup <- box %>% 
  filter(Movie %in% dupMovie$Movie) %>%
  arrange(Movie, Distributor, Date)
ggplot(dup, 
       aes(x=Date, y=Total.Gross, 
           group=interaction(Movie, Distributor),
           color=Movie)) +
  geom_line()
# interaction: Create a new factor
# df <- data.frame(week = c(1:5, 6:10, 11:15), 
#                  gross=c(1:5, 2:11), 
#                  Movie=c(rep('Movie1', 10), rep('Movie2', 5)), 
#                  Distributor=c(rep('Distributor1', 5), 
#                                rep('Distributor2', 10)))

# Movie2 has two different distributors
# ggplot(df, aes(x=week, y=gross, group=Movie)) + geom_line()
# # Group by both variables
# ggplot(df, aes(x=week, y=gross, group=interaction(Movie, Distributor))) + geom_line()


ggplot(box, aes(x=Date, y=Total.Gross, group=Movie)) + geom_line()
ggplot(box, 
       aes(x=Date, y=Total.Gross, 
           group=interaction(Movie, Distributor))) +
  geom_line()

# 20'

# Your turn 25'


box_summary <- box %>% group_by(Movie, Distributor) %>%
  summarize(
    Date = max(Date),
    Total.Gross = max(Total.Gross),
  )
box_summary %>% arrange(desc(Total.Gross)) %>% head

# 30'

# Label the top grossing movies
?geom_text # needs a label Aethetics
dat <- data.frame(x=1:2, y=5:4, text=c('LabX', 'LabY'))
ggplot(dat, aes(x=x, y=y)) + geom_point()
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text()
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text() + geom_point()
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text(hjust=0, vjust=0) + geom_point() # hjust=0, vjust=0: Put the lower-left corner at (x,y)
ggplot(dat, aes(x=x, y=y, label=text)) + geom_text(hjust=0, vjust=0, angle=45) + geom_point() 

# Top grosser
box %>% ggplot(aes(x=Date, y=Total.Gross, group=Movie)) + geom_line()
box %>% ggplot(aes(x=Date, y=Total.Gross, group=Movie, label=Movie)) + geom_line() + geom_text() # not nice

box %>% ggplot(aes(x=Date, y=Total.Gross, group=Movie, label=Movie)) + geom_line() + 
  geom_text(data=box_summary, aes(x=Date, y=Total.Gross,
                                  label=Movie)) # nicer, still ineligible

# Show movies with gross > 2.5M
box %>% ggplot(aes(x=Date, y=Total.Gross, group=Movie, label=Movie)) + geom_line() + 
  geom_text(data=box_summary %>% filter(Total.Gross>2.5), aes(x=Date, y=Total.Gross,                                   label=Movie)) # much better

box %>% ggplot(aes(x=Date, y=Total.Gross, group=Movie, label=Movie)) + geom_line() + 
  geom_text(data=box_summary %>% filter(Total.Gross>2.5), aes(x=Date, y=Total.Gross, label=Movie), vjust=0, hjust=0.3) # vjust=0: bottom of the text aligns with (x,y), to avoid overlap

# Automatically avoid overlap: ggrepel
install.packages('ggrepel')
library(ggrepel)
ggplot(box, aes(x=Date, y=Total.Gross, group=Movie)) + 
  geom_line() + 
  ggrepel::geom_text_repel(
    data=box_summary %>% filter(Total.Gross>2.5), 
    aes(x=Date, y=Total.Gross, label=Movie))

# Back to slides 

## slide 13, plotly
install.packages('plotly')
library(plotly)
p <- ggplot(box, 
            aes(x=Date, 
                y=Total.Gross, 
                group=interaction(Movie, Distributor))) + geom_line()
p
ggplotly(p)

# p1 <- ggplot(box, 
#              aes(x=Date, 
#                  y=Total.Gross, 
#                  group=interaction(Movie, Distributor),
#                  distributor=Distributor)) + geom_line()
# ggplotly(p1)

# top <- box_summary$Movie[box_summary$Total.Gross  > 2.5]
# p2 <- ggplot(box, 
#              aes(x=Date, 
#                  y=Total.Gross, 
#                  group=Movie,
#                  distributor=Distributor)) + geom_line() + 
#   geom_line(data=box %>% filter(Movie %in% top), color='red', size=1)
# p2  
# ggplotly(p2)

# 55'

# Your turn 
mov20 <- box %>% 
  group_by(Movie, Distributor) %>% 
  summarize(releaseYear = min(year(Date))) %>% 
  filter(releaseYear == 2020)

dat <- box %>% inner_join(mov20)
p <- ggplot(dat, 
            aes(x=Date, 
                y=Total.Gross, 
                group=Movie,
                distributor=Distributor)) + 
  geom_line()
datSumm <- box_summary %>% 
  inner_join(mov20)
p1 <- p + 
  geom_text(
    data=datSumm, 
    aes(x=Date, y=Total.Gross, label=Movie)) +
  scale_y_log10()
p1
ggplotly(p1)

# 70'
