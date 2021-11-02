library(classdata)
library(lubridate)
library(tidyverse)

d0 <- '2021-03-01' # March 01, 2021
str(d0)
d0 + 1
ymd(d0) %>% str

a <- ymd('2021-03-01')
b <- mdy('03/01/2021')
identical(a, b)

x <- c('01/01/2021', '12/31/2021')
mdy(x) %>% str

# Your turn
mdy('11/03/2021')
mdy('11/03/21')
ymd('21-11-03')
mdy('Nov 3, 2021')
ymd_hms("2021-11-11 11:00:00")


now()
now() > mdy('11/01/2021')
now() < c(mdy('11/01/2021'), mdy('12/31/2021'))
now() == mdy('11/02/2021')

a <- now()
year(a)
month(a, label=TRUE, abbr = FALSE)
day(a)
wday(a, label=TRUE)
wday(a, label=TRUE, week_start = 1)
hour(a)
minute(a)

a
yday(a) <- 2
a

d1 <- ymd('2020-01-01')
d1 + dyears(1)
d1 + dseconds(365.25 * 24 * 3600)
d1 + years(1)

b <- now()
b
b + dweeks(1)
b + weeks(1)

semester <- interval(mdy('08/22/21'), mdy('12/16/21'))
semester
now() %within% semester # use %within% to tell whether a time point falls in an interval

?stock
str(stock)
apple <- stock %>%
  filter(symbol == 'AAPL')
apple %>%
  summary

apple$date %>% as.character() %>% summary

head(apple)
week(apple$date)
table(week(apple$date))

ggplot(apple, aes(x=month(date, label=TRUE))) + geom_bar()

# What would be my gain if I bought on May 01, 2020 and sell in two month
start <- mdy('05/01/2020')
end <- start + months(2)
startingPrice <- apple %>%
  filter(date == start) %>%
  .$price
endingPrice <- apple %>%
  filter(date == end) %>%
  .$price

end <- max(apple$date[apple$date <= start + months(3)])

startingPrice <- apple %>%
  filter(date == start) %>%
  .$price
endingPrice <- apple %>%
  filter(date == end) %>%
  .$price

(endingPrice - startingPrice) / startingPrice

ggplot(stock, aes(x=wday(date, label=TRUE))) + geom_bar()

stock %>%
  filter(date %within% interval(mdy('01/01/20'), mdy('06/30/20'))) %>%
  .$date %>%
  month() %>%
  table

stock %>%
  group_by(week(date)) %>%
  filter(date == max(date)) %>% 
  ungroup %>%
  mutate(latePrice = lag(price)) %>%
  mutate(gain = (latePrice / price) - 1)
