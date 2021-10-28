library(rvest)
library(tidyverse)

url <- 'https://www.baseball-reference.com/players/a/aardsda01.shtml'
url1 <- 'https://www.baseball-reference.com/players/a/aaronha01.shtml'

html <- read_html(url1)
names <- html %>%
  html_nodes('span strong') %>% 
  html_text()

values <- html %>%
  html_nodes('.stats_pullout p') %>% 
  html_text()

f <- function(x) {
  print(x)
}
f('hello world')
f(1:5)

mymean <- function(x, na.rm=FALSE) {
  
  if (na.rm == TRUE) {
    x <- x[!is.na(x)]
  }
  
  m <- sum(x) / length(x)
  # return(m)
  m
}
mymean(1:5)
mymean(c(1:5, NA), na.rm=TRUE)

# scrape box office data
url <- 'https://www.the-numbers.com/box-office-chart/weekend/2021/10/22'

boxoffice_scraper <- function(url) {
  html <- read_html(url)
  tables <- html %>%
    html_table()
  # str(tables)
  tab <- tables[[2]]
  # str(tab)
  
  names(tab)[1:2] <- c('rank', 'rankLastWeek')
  tab1 <- tab %>%
    mutate(Gross = parse_number(Gross),
           Thr = parse_number(Thr))
  tab1 <- tab1[-seq(nrow(tab1) - 1, nrow(tab1)), ]
  tab1
}

boxoffice_scraper('https://www.the-numbers.com/box-office-chart/weekend/2021/10/22')
boxoffice_scraper('https://www.the-numbers.com/box-office-chart/weekend/2021/10/15')
boxoffice_scraper('https://www.the-numbers.com/box-office-chart/weekend/2021/10/08')

GetPreviousURL <- function(url) {
  html <- read_html(url)
  previousURL <- html_nodes(html, '.previous a') %>%
    html_attr('href')
  previousURL1 <- paste0('https://www.the-numbers.com', previousURL)
  
  previousURL1
}

url0 <- 'https://www.the-numbers.com/box-office-chart/weekend/2021/10/22'
GetPreviousURL(url0) %>%
  boxoffice_scraper()

# purrr
library(purrr)
map(1:3, function(x) 1:x)



html <- read_html('https://www.baseball-reference.com/players/a/')
relUrl <- html %>%
  html_nodes('#div_players_ a') %>%
  html_attr('href')
fullUrl <- paste0('https://www.baseball-reference.com', relUrl)
head(fullUrl)

url1 <- 'https://www.baseball-reference.com/players/a/aaronha01.shtml'

bb_scraper <- function(url) {
  html <- read_html(url)
  names <- html %>%
    html_nodes('#info span strong') %>% 
    html_text()
  values <- html %>%
    html_nodes('.stats_pullout p') %>% 
    html_text()
  playerName <- html %>%
    html_nodes('h1 span') %>%
    html_text()
  res <- data.frame(playerName = playerName,
                    statistics = names,
                    values = values) %>%
    mutate(values = parse_number(values))
  return(res)
}

bb_scraper('https://www.baseball-reference.com/players/a/aardsda01.shtml')
bb_scraper('https://www.baseball-reference.com/players/a/aaronha01.shtml')

data <- map(fullUrl[1:5], bb_scraper) %>% 
  bind_rows()
