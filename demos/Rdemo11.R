l <- list(1, c('ha', 'ma', 'da'), factor(c('cat', 'dog')))
l
length(l)
l[[2]]
length(l[[2]])
class(l[[2]])

l[2]
length(l[2])
l[2:3]
class(l[2:3])

library(classdata)
is.list(fbi)
str(fbi)
str(fbi[[1]])
str(fbi[['State']])
str(fbi$State)

str(fbi$St)
fbi[['St']]


library(tidyverse)
library(rvest)
url <- 'https://www.the-numbers.com/box-office-chart/weekend/2020/03/13'
html <- read_html(url)
html

tables <- html %>% html_table(fill=TRUE)
str(tables)
class(tables)
tab <- tables[[2]]
head(tab)
names(tab)

# cleaning
names(tab)[1:2] <- c('Rank', 'Rank.Last.Week')
tab <- tab %>% mutate(
  Gross = parse_number(Gross),
  Thr = parse_number(Thr)
)
str(tab)


url <- 'https://www.baseball-reference.com/players/a/'
html <- read_html(url)
html
nodeSet <- html %>% html_nodes('#div_players_ a')
playerName <- nodeSet %>%
  html_text()
playerName
nodeSet
nodeSet %>% html_attr('href')




url <- 'https://www.baseball-reference.com/players/a/aardsda01.shtml'
html <- read_html(url)
html %>% html_nodes('h4') %>% html_text
html %>% html_nodes('.stats_pullout p') %>% html_text

url <- 'https://www.baseball-reference.com/players/a/aaronha01.shtml'
html <- read_html(url)
html %>% html_nodes('h4') %>% html_text
html %>% html_nodes('.stats_pullout p') %>% html_text
