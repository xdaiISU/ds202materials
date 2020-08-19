# dplyr
library(dplyr)
# library(tidyverse)
library(classdata)

## select
str(fbi)
dat <- select(fbi, Type, Count, State, Year)
head(dat)

dat1 <- fbi[, c('Type', 'Count', 'State', 'Year')]
identical(dat, dat1)

dat2 <- select(fbi, c(1, 3, 5:6))
head(dat2)

# dropping columns
dat3 <- select(fbi, -Abb, -Population, -Violent.crime)

names(fbi)
dat4 <- select(fbi, Abb:Type)
head(dat4)

dat5 <- select(fbi, starts_with('St'))

a <- select(fbi, Type)
b <- fbi$Type
str(a)
str(b)

## filter
dat <- filter(fbi, Type == 'Burglary' & Year == 2014)
dat1 <- fbi[fbi$Type == 'Burglary' & fbi$Year == 2014, ]

iowa2017 <- filter(fbi, State == 'Iowa' & Year == 2017)
iowa2017sub <- select(iowa2017, State, Year, Type, Count)
str(iowa2017sub)


## mutate
dat <- mutate(fbi, Rate = Count / Population * 1000)
str(dat)

dat1 <- mutate(fbi, 
               Rate = Count / Population * 1000,
               Year = Year + 0.1)

dat2 <- mutate(dat, 
               Violent.crime2 = ifelse(Violent.crime == TRUE,
                                       'Yes',
                                       'No'))
dat3 <- mutate(dat, Count = ifelse(is.na(Count), 1, Count))

## The pipe operator
x <- 1:3
mean(x)
x %>% mean
x %>% mean()

y <- c(x, NA)
mean(y, na.rm=TRUE)
y %>% mean(na.rm=TRUE)

dim(head(fbi))
fbi %>% head %>% dim

fbi %>% select(Year) %>% str
fbi %>% .$Year %>% str

dat2 <- fbi %>%
  select(-Abb) %>% 
  filter(State == 'Iowa' & Year == 2017)

dat <- select(fbi, -Abb)
dat1 <- filter(dat, State == 'Iowa' & Year == 2017)
identical(dat1, dat2)

dat2 <- fbi 
%>% select(-Abb) 
%>% filter(State == 'Iowa' & Year == 2017)

fbi %>% filter(
  State == 
             'Iowa' & 
    Year == 2017
)

## arrange
fbi2017 <- fbi %>% filter(Year == 2017)
fbi2017 %>% arrange(Count) %>% head
fbi2017 %>% arrange(desc(Count)) %>% head

fbi2017 %>% 
  arrange(Type, desc(Count)) %>% 
  select(State, Type, Count) %>% 
  head
a <- fbi2017 %>% 
  arrange(Type, desc(Count)) %>% 
  select(State, Type, Count)
View(a)

## summarize (summarise)
fbiNew <- fbi %>% mutate(rate = Count / Population * 1000)
summarize(fbiNew, 
          mean_rate = mean(rate, na.rm=TRUE),
          sd_rate = sd(rate, na.rm=TRUE),
          nrows = n())

fbi2017 <- fbiNew %>% filter(Year == 2017)

## group_by
fbi2017 %>% 
  group_by(Type)

fbi2017 %>% 
  group_by(Type) %>% 
  summarize(
    mean_rate = mean(rate, na.rm=TRUE),
    sd_rate = sd(rate, na.rm=TRUE),
    nrows = n()
  )

fbiNew %>%
  group_by(Year, Type) %>% 
  summarize(
    mean_rate = mean(rate, na.rm=TRUE),
    sd_rate = sd(rate, na.rm=TRUE),
    nrows = n()
  )

b <- fbi2017 %>% 
  group_by(Type) %>% 
  mutate(max_rate = max(rate, na.rm = TRUE),
         rel_rate = rate / max_rate)
View(b)

b %>% summarize(worst = max(max_rate))
b %>% ungroup %>% summarize(worst = max(max_rate))
