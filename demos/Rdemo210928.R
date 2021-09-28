library(dplyr)
# library(tidyverse)
library(classdata)
library(ggplot2)

# select
dat <- select(fbi, Type, Count, State, Year)

# same as
dat1 <- fbi[, c('Type', 'Count', 'State', 'Year')]
identical(dat, dat1)

?select

dat2 <- select(fbi, c(1, 3, 5, 6))

dat3 <- select(fbi, -Abb, -Population, -Violent.crime)

dat4 <- select(fbi, starts_with('St'), Population)

a <- select(fbi, Type)
b <- fbi$Type

# filter
dat <- filter(fbi, Year == 2014 & Type == 'Burglary')
dat$Type
# same as
dat1 <- fbi[fbi$Year == 2014 & fbi$Type == 'Burglary', ]

dat2 <- filter(fbi, Abb %in% c('IA', 'IL') |
                 Year >= 2015)

iowa2017 <- filter(fbi, State == 'Iowa' & Year == 2017)
iowa2017Sub <- select(iowa2017, State, Year, Type, Count)

# mutate
dat <- mutate(fbi, 
              Rate = Count / Population * 1000,
              Year = Year + 0.1)
dat2 <- mutate(fbi,
               Violent.crime2 = ifelse(Violent.crime == TRUE,
                                       'yes',
                                       'no'))
dat3 <- mutate(fbi,
               Count1 = ifelse(is.na(Count),
                               1,
                               Count))

dat1 <- select(fbi, Abb, Year, Population, Type, Count)
dat2 <- filter(dat1, Year == 2017 & Abb != 'IA')
dat3 <- mutate(dat2, Rate = Count / Population * 1000)
dat4 <- select(dat3, -Count, -Population)

# %>%
x <- 1:3
mean(x)
x %>% mean
x %>% mean()

y <- c(x, NA)
mean(y, na.rm=TRUE)
y %>% mean(na.rm=TRUE)

# 
fbi %>% head %>% str
str(head(fbi))

fbi %>% 
  select(Year) %>% 
  mean

fbi %>%
  .$Year %>%  # same as fbi$Year
  mean

dat <- select(fbi, -Abb)
dat1 <- fbi %>%
  select(-Abb)
identical(dat, dat1)

dat2 <- filter(dat1, State == 'Iowa' & Year == 2017)
dat3 <- dat1 %>%
  filter(State == 'Iowa' & Year == 2017)
identical(dat2, dat3)

dat4 <- fbi %>% 
  select(-Abb) %>% 
  filter(State == 'Iowa' & Year == 2017)
identical(dat4, dat2)

dat4 <- fbi %>% 
  select(-Abb) %>% 
  filter(State == 'Iowa' & 
           Year == 2017)

# Your turn
a <- fbi %>% 
  select(Abb, Year, Population, Type, Count) %>% 
  filter(Year == 2017 & Abb != 'IA') %>% 
  mutate(Rate = Count / Population * 1000) %>% 
  select(-Count, -Population)

# distinct
str(fbi)

fbi %>% 
  distinct(State)
# same as
distinct(fbi, State)

a <- fbi %>%
  distinct(State, Year)
# View(a)

b <- fbi %>% 
  distinct(State, Year, Population)
str(b)

d <- fbi %>% 
  distinct(State, Year, Population, .keep_all=TRUE)
