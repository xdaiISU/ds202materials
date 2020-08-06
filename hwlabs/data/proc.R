library(readr)
library(tidyr)
library(tidyverse)

dat <- read_csv('chocoRaw.csv')

sep <- c(',', 'and', ',and', ', and')
sep %>% 
  map(function(x) {
        dat$Characteristics %>%
          str_count(x) %>%
          table
  }) %>% 
  setNames(sep)

clean <- separate(dat, 
                  Characteristics, 
                  into=paste0('Characteristics', 1:4), 
                  sep='[[:space:]]*(,|and )[[:space:]]*') %>% 
  mutate(Cocoa_Percent = parse_number(Cocoa_Percent))

## Worst characteristics
clean %>% 
  mutate(Characteristics1 = reorder(Characteristics1, Rating, mean)) %>% 
  filter(Characteristics1 %in% levels(Characteristics1)[1:20]) %>% 
  ggplot(aes(x=Characteristics1, y=Rating)) + geom_boxplot()

## Best characteristics
clean %>% 
  mutate(Characteristics1 = reorder(Characteristics1, -Rating, mean)) %>% 
  filter(Characteristics1 %in% levels(Characteristics1)[1:20]) %>% 
  ggplot(aes(x=Characteristics1, y=Rating)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90)) 

clean %>% 
  mutate(Characteristics2 = reorder(Characteristics2, -Rating, mean)) %>% 
  filter(Characteristics2 %in% levels(Characteristics2)[1:20]) %>% 
  ggplot(aes(x=Characteristics2, y=Rating)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90)) 

write.csv(clean, file='choco.csv', row.names=FALSE)

## The csv created is OK when read in
a <- read.csv('choco.csv')

a %>%
  mutate(Characteristics1 = reorder(Characteristics1, -Rating, mean)) %>% 
  filter(Characteristics1 %in% levels(Characteristics1)[1:20]) %>% 
  ggplot(aes(x=Characteristics1, y=Rating)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90)) 
