# Motivate loops

### purrr 
# p2--4

# A first function
f <- function(x) {
  print(x)
}
f('hello world')
f(1:5)

mymean <- function(x) {
  return(sum(x)/length(x)) # return is optional
}
# The output from the last line is automatically returned
# Same as
mymean <- function(x) {
  sum(x)/length(x)
}

mymean(1:15)
mymean(c(1:15, NA))

mymean <- function(x, na.rm=FALSE) {
  if (na.rm) {
    x <- na.omit(x)
  }
  return(sum(x)/length(x))
}

mymean(1:15)
mymean(c(1:15, NA), na.rm=TRUE)

# 40'

library(tidyverse)
library(rvest)

url <- 'https://www.the-numbers.com/box-office-chart/weekend/2020/03/13'
html <- read_html(url)
tables <- html %>% html_table(fill=TRUE)
tab <- tables[[2]]
names(tab)[1:2] <- c('Rank', 'Rank.Last.Week')
tab <- tab %>% mutate(
  Gross = parse_number(Gross),
  Thr = parse_number(Thr)
)


url <- "https://www.the-numbers.com/box-office-chart/weekend/2020/03/13"

# Define an url first; then write func.
boxoffice_scraper <- function(url) {
  html <- read_html(url)
  tables <- html %>% html_table(fill=TRUE)
  tab <- tables[[2]]
  names(tab)[1:2] <- c('Rank', 'Rank.Last.Week')
  tab <- tab %>% mutate(
    Gross = parse_number(Gross),
    Thr = parse_number(Thr)
  )
  tab
}


box <- boxoffice_scraper("https://www.the-numbers.com/box-office-chart/weekend/2020/03/13")
str(box)

## Your turn to follow up

# Previous week. Use selectorGadget
url <- "https://www.the-numbers.com/box-office-chart/weekend/2020/03/13"
html <- read_html(url)
html %>% html_nodes(".previous a")
html %>% html_nodes(".previous a") %>% html_attr("href")
newurl <- html %>% html_nodes(".previous a") %>% html_attr("href")

# Need to combine with base url
# paste0: connect two character vectors
paste0(c('a', 'b'), c('1', '2'))
paste0('0', c('a', 'b'))

paste0("https://www.the-numbers.com", newurl)
paste0("https://www.the-numbers.com", newurl) %>%
  boxoffice_scraper %>% 
  str

# slides

# Want to create a df from an URL
# Get name of player, name of stat, value of stat
# Write the inside first

url <- "http://www.baseball-reference.com/players/a/aardsda01.shtml"
html <- read_html(url)
names <- html %>% html_nodes("h4") %>% html_text()
values <- html %>% html_nodes(".stats_pullout p") %>% html_text() 
player <- html %>% html_nodes("h1") %>% html_text()


bb_scraper <- function(url) {
  html <- read_html(url)
  
  names <- html %>% html_nodes("h4") %>% html_text()
  values <- html %>% html_nodes(".stats_pullout p") %>% html_text() 
  player <- html %>% html_nodes("h1") %>% html_text()
  data.frame(player=player, 
             statistics=names,  values=parse_number(values))
}

bb_scraper("http://www.baseball-reference.com/players/a/aardsda01.shtml")

url2 <- 'https://www.baseball-reference.com/players/a/aaronha01.shtml'
bb_scraper(url2)

# What about all links? http://www.baseball-reference.com/players/a/

# p15
# Purrr: functional programming
# map:  apply a function to all elements
html <- read_html("http://www.baseball-reference.com/players/a/")
links <- html %>% html_nodes("#div_players_ a") %>% html_attr("href")

fullLinks <- paste0("http://www.baseball-reference.com", links)
data <- map(fullLinks[1:3], bb_scraper)

# Now need to combine. Do it over using tidyverse

bb <- data.frame(links = fullLinks, 
                 stringsAsFactors = FALSE) # factor
# get data for the first few players:
bb <- head(bb) %>% mutate(
  data = purrr::map(links, .f = bb_scraper)
)
str(bb)
dim(bb)

# Nested data frame: draw
bb1 <- bb %>% unnest(data)
summary(bb1)

# Your turn
## ------------------------------------------------------------------------
bb_scraper2 <- function(url) {
  html <- read_html(url)
  
  names <- html %>% html_nodes("h4") %>% html_text()
  values <- html %>% html_nodes(".stats_pullout p") %>% html_text() 
  player <- html %>% html_nodes("h1") %>% html_text()
  position <- html %>% html_nodes("h1+ p") %>% html_text()
  names <- trimws(names)
  player <- trimws(player)
  position <- trimws(position)
  data.frame(player=player, 
             position=position,
             statistics=names,  values=parse_number(values))
}

## ---- warning=FALSE------------------------------------------------------
# Get all urls
html <- read_html("http://www.baseball-reference.com/players/b/")
links <- html %>% html_nodes("#div_players_ a") %>% html_attr("href")

bb2 <- data.frame(links = paste0("http://www.baseball-reference.com", 
                                 links[1:10]), 
                  stringsAsFactors = FALSE)

# get data for the first 10 players:
bb2 <- bb2 %>% mutate(
  data = purrr::map(links, .f = bb_scraper2)
)
bb2 <- bb2 %>% unnest(data)
str(bb2)

## Crawl One World: Extract all verbal description of the artist.
url <- 'https://en.wikipedia.org/wiki/Together_at_Home'
html <- read_html(url)
links <- html %>% html_nodes('.column-width:nth-child(11) a') %>% html_attr(name='href')
fullLinks <- paste0('https://en.wikipedia.org', links)

l1 <- fullLinks[1]
read_html(l1) %>% html_nodes('p') %>% .[2] %>% html_text()
pars <- function(l) {
  read_html(l) %>% 
    html_nodes('p') %>% 
    html_text()
}
df <- data.frame(fl=fullLinks[1:10], stringsAsFactors = FALSE) %>% 
  mutate(data=map(fl, pars)) %>% 
  unnest()

df
# Some weird paragraphs
hist(nchar(df$data), breaks=200) # make wider
abline(v=20)
df1 <- df %>% filter(nchar(data) > 20)
