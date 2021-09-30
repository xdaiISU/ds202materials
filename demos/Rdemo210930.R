library(dplyr)
library(tidyverse)
# install.packages('tidyverse')
library(classdata)

fbi2017 <- fbi %>% 
  filter(Year == 2017)

fbi2017 %>% 
  arrange(Count) %>% 
  head

fbi2017 %>% 
  arrange(desc(Count)) %>% 
  head

fbi2017 %>% 
  arrange(Type, desc(Count)) %>% 
  head

fbiNew <- fbi %>%
  mutate(Rate = Count / Population * 1000)

summarize(fbiNew, 
          mean_rate = mean(Rate, na.rm=TRUE),
          sd_rate = sd(Rate, na.rm=TRUE),
          nrows = n())

# group_by
fbi2017 <- fbiNew %>% filter(Year == 2017)
fbi2017 %>% 
  group_by(Type)

fbi2017 %>%
  group_by(Type) %>% 
  summarize(mean_rate = mean(Rate, na.rm=TRUE),
            sd_rate = sd(Rate, na.rm=TRUE))

fbiNew %>%
  group_by(Type, Year) %>% 
  summarize(mean_rate = mean(Rate, na.rm=TRUE),
            sd_rate = sd(Rate, na.rm=TRUE))

fbi2017 %>% 
  group_by(Type) %>% 
  mutate(max_rate = max(Rate, na.rm = TRUE),
         rel_rate = Rate / max_rate) %>% 
  ungroup() %>% 
  summarize(mean_rel_rate = mean(rel_rate, na.rm = TRUE))

fbi %>% 
  str
fbi %>% 
  distinct(State, Year, Population) %>% 
  filter(Year == 2017) %>%
  nrow()

fbi %>%
  mutate(Rate = Count / Population * 1000) %>% 
  arrange(desc(Rate)) %>%
  head

fbi %>% 
  mutate(Rate = Count / Population * 1000) %>% 
  filter(Type == 'Burglary') %>%
  group_by(State) %>% 
  mutate(max_rate = max(Rate, na.rm = TRUE), 
         rel_to_the_max = Rate / max_rate) 


library(readxl)
defense <- read_excel('cyclonesFootball2020.xlsx', sheet='Defensive')
str(defense)

# clean up
defenseClean <- defense %>% 
  mutate(Tackles_Solo = as.numeric(Tackles_Solo),
         Tackles_ASST = as.numeric(Tackles_ASST)) %>% 
  rename(Opponent = Opponent_Opponent) %>% 
  mutate(Opponent = factor(Opponent, 
                           as.character(unique(Opponent))))
str(defenseClean)

lvls <- as.character(unique(defenseClean$Opponent))
lvls

# analyze solo tackles
defenseClean %>% 
  ggplot(aes(x = Tackles_Solo)) + 
  geom_histogram(binwidth = 1)

defenseClean %>%
  summarize(n = n(),
            solo = sum(Tackles_Solo))

soloPerGame <- defenseClean %>%
  group_by(Opponent) %>%
  summarize(n = n(),
            solo = sum(Tackles_Solo)) %>%
  arrange(desc(solo)) 

ggplot(soloPerGame, aes(x=Opponent, weight=solo)) + geom_bar() + coord_flip()


# 

dat <- readxl::read_xls('GSS 2.xls')
a <- dat %>%
  rename(marital = `Marital status`)
str(a)

table(dat$`Highest year of school completed`)
table(dat$Highest year of school completed) # doesn't work


  mutate(defense, 
         Tackles_Solo = as.numeric(Tackles_Solo),
         Tackles_ASST = as.numeric(Tackles_ASST))
  
library(dplyr)
dat %>%
  mutate(`Highest year of school completed` = as.numeric(`Highest year of school completed`)) %>%
  group_by(`Marital status`) %>%
  summarize(meanEdu = mean(`Highest year of school completed`, na.rm=TRUE))
  
dat %>%
  mutate(`Highest year of school completed` = as.numeric(`Highest year of school completed`)) %>%
  group_by(`Marital status`) %>%
  mutate(meanEdu = mean(`Highest year of school completed`, na.rm=TRUE))
