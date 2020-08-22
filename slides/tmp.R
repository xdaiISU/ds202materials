# Load data and clean 5'
library(readxl)
library(ggplot2)
library(dplyr)
defense <- read_excel('cyclonesFootball2019.xlsx', sheet='Defensive')
str(defense)
defense <- defense %>% 
  mutate(Tackles_Solo = as.numeric(Tackles_Solo)) %>% 
  select(Name, Opponent_Opponent, Tackles_Solo)
str(defense)

offense <- read_excel('cyclonesFootball2019.xlsx', sheet='Offensive')
str(offense) # glossaries in the excel. Focus on # of receivings
offense <- offense %>% 
  mutate(Receiving_REC = as.numeric(Receiving_REC)) %>% 
  select(Name, Opponent_Opponent, Receiving_REC) # number of receiving
str(offense)

# Goal: defensive & offensive skills. To get started with joins; not terribly common to compare def & off
dSumm <- defense %>% 
  group_by(Name) %>% 
  summarize(tackles = sum(Tackles_Solo))
oSumm <- offense %>% 
  group_by(Name) %>% 
  summarize(receiving = sum(Receiving_REC))
dSumm %>% filter(Name %in% oSumm$Name)

# Inner join: which players contributed to both defense and offense
dSumm %>% inner_join(oSumm)
dSumm %>% inner_join(oSumm, by='Name')
# same as inner_join(dSumm, oSumm)

# Left join: What are the # of receiving for the defensive players
dSumm %>% left_join(oSumm)

# Right join: What are the # of solo tackles for the offensive players
dSumm %>% right_join(oSumm)

# Full join: What are the # of solo tackles & # of receiving for both the defensive and offensive players
a <- dSumm %>% full_join(oSumm)
View(a)
# Pay attention to the number of rows

# Semi join: Which defensive player contributed to offense?
dSumm %>% semi_join(oSumm)

# Anti join: Which defensive player did not contribute to offense?
dSumm %>% anti_join(oSumm)

# Anti join: Which offensive player did not contribute to defense? This is different from above
oSumm %>% anti_join(dSumm)

# Next round: join by two columns
dat <- defense %>% inner_join(offense)
head(dat) %>% print(width=Inf)
# same as
dat1 <- defense %>% inner_join(offense, by=c('Name', 'Opponent_Opponent'))

# What is this?
dat2 <- defense %>% inner_join(offense, by='Name')
dim(dat2)
head(dat2) %>% print(width=Inf) # Records are crossed -- more rows are produced. Does not make sense

# # Your turn 65'
# dat <- defense %>% 
#   full_join(offense, by=c('Name', 'Opponent_Opponent'))
# dim(dat)
# str(dat)
# head(dat) %>% print(width=Inf)
# 
# dat1 <- defense %>%
#   inner_join(offense, by=c('Name', 'Opponent_Opponent'))
# 
# dat2 <- offense %>% left_join(defense)
# dat2 %>% 
#   group_by(Name) %>% 
#   summarize(tackle=sum(Tackles_Solo, na.rm=TRUE),
#             receiving = sum(Receiving_REC, na.rm=TRUE)) %>% 
#   filter(tackle == max(tackle))
