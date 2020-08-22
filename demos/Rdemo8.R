# load data
library(readxl)
library(ggplot2)
library(dplyr)
defense <- read_excel('cyclonesFootball2019.xlsx', sheet='Defensive')
str(defense)
defense <- defense %>%
  mutate(Tackles_Solo = as.numeric(Tackles_Solo)) %>% 
  select(Name, Opponent_Opponent, Tackles_Solo)
str(defense)

offense <- read_excel('cyclonesFootball2019.xlsx', sheet='Offensive') %>%
  mutate(Receiving_REC = as.numeric(Receiving_REC)) %>%
  select(Name, Opponent_Opponent, Receiving_REC)
str(offense)

dSumm <- defense %>% 
  group_by(Name) %>% 
  summarize(tackles = sum(Tackles_Solo))
oSumm <- offense %>% 
  group_by(Name) %>% 
  summarize(receiving = sum(Receiving_REC))

dSumm %>% inner_join(oSumm)
inner_join(dSumm, oSumm)
inner_join(dSumm, oSumm, by='Name')

dSumm %>% left_join(oSumm)
dSumm %>% right_join(oSumm)

a <- dSumm %>% full_join(oSumm)
View(a)

dSumm %>% semi_join(oSumm)
dSumm %>% filter(Name %in% oSumm$Name)

dSumm %>% anti_join(oSumm)

defense %>% inner_join(offense)
defense %>% inner_join(offense, by=c('Name', 'Opponent_Opponent'))

b <- defense %>% inner_join(offense, by=c('Name'))
str(b)
str(defense)
View(b) # nonsense
