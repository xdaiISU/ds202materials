library(dplyr)
library(ggplot2)
# could as well library(tidyverse)
library(classdata)


## select
dat <- select(fbi, Type, Count, State, Year)
head(dat)

# same as 
dat1 <- fbi[, c('Type', 'Count', 'State', 'Year')]
identical(dat, dat1)

# args(select)
args(select)

# Different ways to (positively) select
dat2 <- select(fbi, c(1, 3, 5:6))

# dropping columns (negative select)
dat3 <- select(fbi, -Abb, -Population, -Violent.crime)
dat4 <- select(fbi, c(-2, -4, -7))

# More selection methods; see ?select
dat5 <- select(fbi, starts_with('St')) # needs strings

a <- select(fbi, Type)
b <- fbi$Type
identical(a, b) # same?

## filter
dat <- filter(fbi, Type=="Burglary" & Year==2014)
# same as (except for row names)
dat1 <- fbi[fbi$Type == 'Burglary' & fbi$Year == 2014, ]

# Recall logical operators & | !
# Comparisons ==, >=, <
# %in% 
dat2 <- filter(fbi, Abb %in% c('IA', 'IL') & Year >= 2015)
# Either violent or burlary
dat3 <- filter(fbi, Violent.crime | Type == 'Burglary')

# Selecting both rows and columns
iowa2017 <- filter(fbi, State == 'Iowa' & Year == 2017)
iowa2017sub <- select(iowa2017, State, Year, Type, Count)

## mutate
dat <- mutate(fbi, Rate = Count/Population* 1000)
dat <- mutate(dat, Year = Year + 0.1) # changing the same column

# same as
dat1 <- mutate(fbi, Rate = Count/Population* 1000,
               Year = Year + 0.1)
identical(dat, dat1)

# recall ifelse
dat2 <- mutate(dat, Violent.crime2 = ifelse(Violent.crime == TRUE, 'Yes', 'No'))

# changing a subset of values
# If Count is NA, replace it by 1
dat3 <- dat
dat3$Count[is.na(dat3$Count)] <- 1

dat4 <- mutate(dat, Count=ifelse(is.na(Count), 1, Count))
identical(dat3, dat4)

# ## mutate_at: transform a few columns in the same way
# # Transform population and count into a log scale
# # ?mutate_at
# dat5 <- mutate_at(fbi, vars(Population, Count), log10)
# dat6 <- mutate(fbi, Population = log10(Population),
#                Count = log10(Count))
# identical(dat5, dat6)
# ?mutate_at

## Your turn 

## `%>%`: The prev output is used as the first argument to the next function
?magrittr::`%>%`

x <- 1:3
mean(x)
x %>% mean
x %>% mean()

y <- c(x, NA)
mean(y, na.rm=TRUE) # same as
y %>% mean(na.rm=TRUE)

# Combining pipes
head(fbi)
fbi %>% head %>% dim

# take out a column as a df
fbi %>% select(Year) %>% str

# take out a column as a vector
fbi %>% .$Year %>% str

# Crime data for iowa in 2017
dat <- select(fbi, -Abb)
dat1 <- fbi %>% select(-Abb)
identical(dat, dat1)

dat2 <- filter(fbi, State == 'Iowa' & Year == 2017)
dat3 <- fbi %>% filter(State == 'Iowa' & Year == 2017)
identical(dat2, dat3)

dat4 <- fbi %>% 
  select(-Abb) %>% 
  filter(State == 'Iowa' & Year == 2017)

# comment on line breaking. R needs to know the input does not end.
dat5 <- fbi 
%>% filter(State == 'Iowa' & Year == 2017) 
%>% select(-Abb)

# Syntax like `%>%`, `,`, `&`, `(` at the end of each line let R knows the line 
# should continue.
# Space does not matter for R.
dat6 <- fbi %>% filter(
  State == 
    'Iowa' &
    Year == 2017)

# Your turn

library(dplyr)
library(classdata)
fbi2017 <- fbi %>% filter(Year == 2017)
# Arrange
fbi2017 %>% arrange(Count) %>% head
fbi2017 %>% arrange(desc(Count)) %>% head

# Arrange by type, and then decreasing count
fbi2017 %>% arrange(Type, desc(Count)) %>% select(State, Type, Count) %>% head
a <- fbi2017 %>% arrange(Type, desc(Count)) %>% select(State, Type, Count)
View(a) # Remove before submitting HW. Irreproducible

# Take the overall mean crime rates
## summarize # spelling
fbiNew <- fbi %>% mutate(rate = Count / Population * 1000)
summarize(fbiNew, 
          mean_rate = mean(rate, na.rm=TRUE), 
          sd_rate = sd(rate, na.rm = TRUE))

summarize(fbiNew, 
          mean_rate = mean(rate, na.rm=TRUE), 
          sd_rate = sd(rate, na.rm = TRUE),
          nrows = n())

# A meaningless collapse of info 

fbi2017 <- fbiNew %>% filter(Year == 2017)

# group_by %>% summarize
# This is more right. Summarize for each type of crime
fbi2017 %>% 
  group_by(Type) # Doesn't do anything, except for telling ggplot that the data has a group variable. Behavior of downstream dplyr actions will change.

fbi2017 %>%
  group_by(Type) %>%
  summarize(
    mean_rate = mean(rate, na.rm=TRUE), 
    sd_rate = sd(rate, na.rm = TRUE))

# all data, by year and type
fbiNew %>%
  group_by(Year, Type) %>%
  summarize(
    mean_rate = mean(rate, na.rm=TRUE), 
    sd_rate = sd(rate, na.rm = TRUE))

# group_by %>% mutate
# How does each state compare with the worst state?

# a <- fbi2017 %>%
#   group_by(Type) %>%
#   mutate(max_rate=max(rate, na.rm=TRUE))
# View(a %>% select(State, Type, rate, max_rate))

b <- fbi2017 %>%
  group_by(Type) %>%
  mutate(max_rate=max(rate, na.rm=TRUE), 
         rel_rate = rate / max_rate)
# Why is there a warning?

# Don't forget to ungroup
b
b %>% summarize(worst=max(max_rate))
b %>% ungroup %>% summarize(worst=max(max_rate))

# Your turn


########################################

# 40'

### Football
# First 4 Slides
# 50'
# Load data
library(readxl) # install.packages('readxl')
defense <- read_excel('../_slides/cyclonesFootball2019.xlsx', sheet='Defensive') # Change path for yourself
str(defense)

# Clean
library(ggplot2)
library(dplyr)
defense <- defense %>% 
  mutate(Tackles_Solo = as.numeric(Tackles_Solo),
         Tackles_ASST = as.numeric(Tackles_ASST)) 
str(defense)

# More cleaning
defense <- defense %>% 
  rename(Opponent=Opponent_Opponent) %>% 
  mutate(Opponent = factor(Opponent))

defense <- defense %>% 
  select(Name, Opponent, Tackles_Solo) %>% 
  filter(!Opponent %in% c('Iowa', 'UNI', 'Notre Dame'))


# tackle solo
defense %>% ggplot(aes(x = Tackles_Solo)) + geom_histogram()
defense %>% ggplot(aes(x = Tackles_Solo)) + geom_histogram(binwidth = 1)

#  Total number of tackles
defense %>% 
  summarize(n = n(), solo = sum(Tackles_Solo))

# tackles by Opponent
defense %>% 
  group_by(Opponent) %>% 
  summarize(solo = sum(Tackles_Solo)) %>% 
  arrange(solo)

soloPerGame <- defense %>% 
  group_by(Opponent) %>% 
  summarize(solo = sum(Tackles_Solo))

ggplot(soloPerGame, aes(x=Opponent, weight=solo)) + geom_bar() + coord_flip()

# n(): gives the total number of rows
# Counting players appeared in each game
defense %>% 
  group_by(Opponent) %>% 
  summarize(nPlayers = n(), solo = sum(Tackles_Solo))

# Your turn
