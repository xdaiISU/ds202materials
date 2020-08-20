library(readxl) # install.packages('readxl')
library(tidyverse)
defense <- read_excel('../_slides/cyclonesFootball2019.xlsx', sheet='Defensive')
str(defense)

# Cleaning
defense <- defense %>%
  mutate(Tackles_Solo = as.numeric(Tackles_Solo), 
         Tackles_ASST = as.numeric(Tackles_ASST))
str(defense)

defense <- defense %>% 
  rename(Opponent = Opponent_Opponent) %>% 
  mutate(Opponent = factor(Opponent))

defense <- defense %>% 
  select(Name, Opponent, Tackles_Solo)

table(defense$Opponent)

defense <- defense %>% 
  filter(!Opponent %in% c('Iowa', 'Notre Dame', 'UNI'))

# 
defense %>% ggplot(aes(x = Tackles_Solo)) + geom_histogram()
defense %>% ggplot(aes(x = Tackles_Solo)) + geom_histogram(binwidth=1)

defense %>% 
  summarize(solo = sum(Tackles_Solo))

soloPerGame <- defense %>% 
  group_by(Opponent) %>% 
  summarize(solo = sum(Tackles_Solo)) %>% 
  arrange(solo)

ggplot(soloPerGame, aes(x=Opponent, weight=solo)) + geom_bar() + coord_flip()

defense %>% 
  group_by(Opponent) %>% 
  summarize(nPlayers=n(), solo = sum(Tackles_Solo))
