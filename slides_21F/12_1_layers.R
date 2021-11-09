## ----setup, include=FALSE------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache=TRUE, message=FALSE, warning=FALSE)
library(tidyverse)
library(lubridate)


## ------------------------------------------------------------------------------------------
library(tidyverse)
covid <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')
str(covid)


## ---- fig.width=9.5, fig.height = 3--------------------------------------------------------
story <- covid %>% filter(state == 'Iowa' & 
                            county == 'Story' & 
                            date >= mdy('08/01/21'))
ggplot(story, aes(x = date, y = cases)) + geom_point() +
  geom_smooth(method='lm')


## ---- fig.width=9.5, fig.height = 2.5------------------------------------------------------
ggplot(story, aes(x = date, y = cases)) + geom_point() +
  geom_smooth(method="loess")


## ---- fig.width=9.5, fig.height = 2.5------------------------------------------------------
ggplot(story, aes(x = date, y = cases)) + geom_point() +
  geom_smooth(method="loess", span=1/3)


## ---- fig.width=9.5, fig.height = 3, message = FALSE---------------------------------------
johnson <- covid %>% filter(state == 'Iowa' & 
                              county == 'Johnson' & 
                              date >= mdy('08/01/21'))
ggplot(story, aes(x = date, y = cases)) + 
  geom_line(color='red') +
  geom_line(data=johnson, color='yellow')


## ---- fig.width=9.5, fig.height = 3, message = FALSE---------------------------------------
ggplot(story, aes(x = date, y = cases)) + geom_line() +
  geom_point(aes(y=deaths))


## ---- fig.width=9.5, fig.height = 3, message = FALSE---------------------------------------
ggplot(story, aes(x = date, y = cases)) + 
  geom_line(color='blue')


## ---- fig.width=9.5, fig.height = 3, message = FALSE---------------------------------------
ggplot(story, aes(x = date, y = cases, color='blue')) + 
  geom_line()

