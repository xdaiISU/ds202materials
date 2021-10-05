library(readxl)
library(tidyverse)
defense <- read_excel('cyclonesFootball2020.xlsx', sheet='Defensive')
str(defense)

defense <- defense %>%
  mutate(Tackles_Solo = as.numeric(Tackles_Solo)) %>%
  select(Name, Opponent_Opponent, Tackles_Solo)

offense <- read_excel('cyclonesFootball2020.xlsx', sheet='Offensive')
str(offense)
offense <- offense %>%
  mutate(Receiving_REC = as.numeric(Receiving_REC)) %>%
  select(Name, Opponent_Opponent, Receiving_REC)
str(offense)

# Goal: compare defensive & offensive skills
dSumm <- defense %>%
  group_by(Name) %>%
  summarize(tackles = sum(Tackles_Solo, na.rm=TRUE))
dSumm

oSumm <- offense %>%
  group_by(Name) %>%
  summarize(receiving = sum(Receiving_REC, na.rm=TRUE))

# Which player contributed to both defense and offense?
# inner_join
inner_join(dSumm, oSumm)
inner_join(dSumm, oSumm, by='Name')

# What are the # of receivings for the defensive players
# (Which of the defensive players contributed to offense)
left_join(dSumm, oSumm, by='Name')

# Which of the offensive players contributed to defense
right_join(dSumm, oSumm, by='Name')
left_join(oSumm, dSumm, by='Name')

# Inner join: Which players contributed to either defense or offense
a <- full_join(dSumm, oSumm, by='Name')
View(a)

# semi_join: Which defensive players contributed to offense?  Retain information for the defensive stat
dSumm %>%
  semi_join(oSumm)
dSumm %>% 
  filter(Name %in% oSumm$Name)

# anti_join: Which defensive players did not contribute to offense?
dSumm %>%
  anti_join(oSumm)
dSumm %>%
  filter(!Name %in% oSumm$Name)

# Next round: Join by two columns

# Look at the game-player level statistics 
dat <- defense %>% 
  inner_join(offense, by=c('Name', 'Opponent_Opponent'))
View(dat)

# Does not make too much sense
dat2 <- defense %>% 
  inner_join(offense, by=c('Name'))
View(dat2)
