f <- function(x) {
  print(x)
}
f('hello world')
f(1:5)

mymean <- function(x) {
  sum(x) / length(x)
}

mymean <- function(x, na.rm=FALSE) {
  if (na.rm) {
    x <- na.omit(x)
  }
  sum(x) / length(x)
}
mymean(c(1:15, NA))
mymean(c(1:15, NA), na.rm=TRUE)


library(tidyverse)
library(rvest)

url <- 'https://www.the-numbers.com/box-office-chart/weekend/2020/03/13'

boxoffice_scraper <- function(url) {
  html <- read_html(url)
  tables <- html %>% html_table(fill=TRUE)
  tab <- tables[[2]]
  # cleaning
  names(tab)[1:2] <- c('Rank', 'Rank.Last.Week')
  tab <- tab %>% mutate(
    Gross = parse_number(Gross),
    Thr = parse_number(Thr)
  )
  tab
}

boxoffice_scraper(url) %>% str
boxoffice_scraper('https://www.the-numbers.com/box-office-chart/weekend/2020/03/06') %>% str



url

html <- read_html(url)
newurl <- html %>% html_nodes('.previous a') %>% html_attr('href')
newurl
base <- 'https://www.the-numbers.com'

paste0('hello', 'World')
paste0('hello', c(' cat', ' dog'))

newurl <- paste0(base, newurl)
newurl
boxoffice_scraper(newurl)

previous_url <- function(url, base='https://www.the-numbers.com') {
  html <- read_html(url)
  newurl <- html %>% html_nodes('.previous a') %>% html_attr('href')
  newurl <- paste0(base, newurl)
  newurl
}
previous_url(url)


## baseball

url <- 'https://www.baseball-reference.com/players/a/aardsda01.shtml'
bb_scraper <- function(url) {
  html <- read_html(url)
  names <- html %>% html_nodes('h4') %>% html_text
  values <- html %>% html_nodes('.stats_pullout p') %>% html_text
  player <- html %>% html_nodes('h1 span') %>% html_text
  data.frame(
    player=player,
    statistics = names,
    values = parse_number(values)
  )
}
bb_scraper(url)
bb_scraper('https://www.baseball-reference.com/players/a/aaronha01.shtml')

html <- read_html('https://www.baseball-reference.com/players/a/')
links <- html %>% html_nodes('#div_players_ a') %>% html_attr('href')
fullLinks <- paste0('https://www.baseball-reference.com', links)
head(fullLinks)
?map
data <- map(fullLinks[1:3], bb_scraper)
str(data)
dataAll <- bind_rows(data)
str(dataAll)
