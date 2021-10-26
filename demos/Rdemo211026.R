l <- list(1, c('ha', 'ma', 'da'), factor(c('cat', 'dog')))
l
str(l)
l[[2]]
l[2]
l[[2]][3]

class(l)
class(1)
class(l[1])
class(l[[1]])

library(classdata)
str(fbi)
is.list(fbi)

fbi[[1]]
fbi$State
names(fbi)
fbi[['State']]

# scraping box office data
library(rvest)
url <- 'https://www.the-numbers.com/box-office-chart/weekend/2021/10/15'
html <- read_html(url)
tables <- html %>%
  html_table()
tables
str(tables)
tab <- tables[[2]]
str(tab)

library(tidyverse)
names(tab)[1:2] <- c('rank', 'rankLastWeek')
tab1 <- tab %>%
  mutate(Gross = parse_number(Gross),
         Thr = parse_number(Thr))
str(tab1)

tab1 <- tab1[-seq(nrow(tab1) - 1, nrow(tab1)), ]
tab1

#div_players_ a

url <- 'https://www.baseball-reference.com/players/a/'
html <- read_html(url)
nodes <- html %>% 
  html_nodes('#div_players_ a')
nodes %>%
  html_text()
relURL <- nodes %>%
  html_attr(name='href')
absURL <- paste0('www.baseball-reference.com', relURL)
