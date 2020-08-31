library(classdata)
library(tidyverse)
library(lubridate)

d0 <- '2020-03-15'
str(d0)
d0 + 1
ymd(d0) %>% str

ymd('2020/03-15')
ymd('20200315')

mdy('03/15/20')
identical(mdy('03/15/20'), ymd('20200315'))


now()
now() <= mdy('12/31/20') & now() >= mdy('01/01/20')
now() < c(mdy('01/01/20'), mdy('12/31/20'))

str(now())
year(now()) == 2020
wday(now(), label=TRUE)
wday(now(), label=TRUE, week_start = 1)
wday(now(), label=TRUE, abbr = FALSE)
hour(now())
minute(now())

a <- now()
day(a) <- day(a) + 1
a

d1 <- ymd('2020-01-01')
str(d1)
d1 + dyears(1)
d1 + years(1)

d1 + ddays(30)
d1 + months(1)

pre_covid_19 <- interval(ymd('2019/01/01'), ymd('2020/03/15'))
pre_covid_19
now() %within% pre_covid_19
(now() - dyears(1)) %within% pre_covid_19


# stock example
?stock
apple <- stock %>% filter(symbol == 'AAPL')
summary(apple)
str(apple)

summary(as.character(apple$date))

table(month(apple$date))

ggplot(apple, aes(x=month(date, label = TRUE))) + geom_bar()

# What is the 1-month gain since 07/01/2020?
start <- mdy('07/01/2020')
end <- start + months(1)
weekdays(end) # does not work!
weekdays(start)
start %in% apple$date

end <- max(apple$date[apple$date <= start + months(1)])
weekdays(end)

startPrice <- apple$price[apple$date == start]
endPrice <- apple$price[apple$date == end]
(endPrice - startPrice) / startPrice
