library(tidyverse)
library(lubridate)

states <- map_data('state')
iowa <- states %>% filter(region == 'iowa')
ggplot(iowa, aes(x=long, y=lat)) + geom_path()
ggplot(iowa, aes(x=long, y=lat)) + geom_line() #wrong
ggplot(iowa, aes(x=long, y=lat)) + geom_polygon()

dat2 <- states %>% filter(region %in% c('iowa', 'florida'))
ggplot(dat2, aes(x=long, y=lat)) + geom_path()
ggplot(dat2, aes(x=long, y=lat)) + geom_path(aes(group=group))
ggplot(dat2, aes(x=long, y=lat)) + geom_polygon(aes(group=group))

ggplot(states, aes(x=long, y=lat)) + geom_path(aes(group=group))
ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group))
ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=region)) # wrong


ggplot(states, aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group, fill=lat))
ggplot(states, aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group, color=lat))

covidRaw <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv') 
str(covidRaw)
covid <- covidRaw %>%
  filter(date == mdy('08/31/20')) %>%
  group_by(state) %>%
  summarize(totCases=sum(cases),
            totDeaths = sum(deaths))
str(covid)

covid %>% left_join(states, by=c('state' = 'region'))

covid$region <- tolower(covid$state)
head(covid)
covidMap <- covid %>% left_join(states, by='region')

covid %>% anti_join(states, by='region')
states %>% anti_join(covid, by='region')

ggplot(covidMap, aes(x=long, y=lat, fill=totCases)) + 
  geom_polygon(aes(group=group)) + coord_map()


acc <- read.csv("https://raw.githubusercontent.com/xdaiISU/ds202materials/master/hwlabs/fars2017/accident.csv", stringsAsFactors = FALSE)
str(acc)

ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group))
ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group)) + 
  geom_point(data=acc, aes(x=LONGITUD, y=LATITUDE), color='lightgreen', size=0.02, alpha=0.2) +
  coord_map(xlim=c(-130, -60), ylim=c(20, 50))
