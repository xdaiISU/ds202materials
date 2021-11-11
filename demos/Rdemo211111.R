library(tidyverse)
library(lubridate)
states <- map_data('state')

ggplot(states, aes(x=long, y=lat, fill=lat, group=group)) + geom_polygon()

covidRaw <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv') 
covid <- covidRaw %>%
  filter(date == mdy('08/31/21')) %>%
  group_by(state) %>%
  summarize(totCases = sum(cases),
            totDeaths = sum(deaths))

inner_join(covid, states, by=c(state='region')) # doesn't work
head(covid)
head(states)

covid$region <- tolower(covid$state)
head(covid)

joinedDat <- inner_join(covid, states, by='region')

anti_join(covid, states)
anti_join(states, covid)

ggplot(joinedDat, aes(x=long, y=lat, group=group, fill=totCases)) + geom_polygon()

ggplot(joinedDat, aes(x=long, y=lat, group=group, fill=totDeaths)) + geom_polygon()


ggplot(joinedDat, aes(x=long, y=lat, group=group, fill=totDeaths)) + geom_polygon() + scale_fill_gradient(low='lightblue', high='black')

# Map type 2
stateName <- states %>% 
  group_by(region) %>%
  summarize(long = mean(long), lat = mean(lat))

ggplot(states, aes(x=long, y=lat)) +
  geom_polygon(aes(group=group)) + 
  geom_text(aes(label=region), data=stateName, 
            color='white')

# FARS
acc <- read.csv("https://raw.githubusercontent.com/xdaiISU/ds202materials/master/hwlabs/fars2017/accident.csv", stringsAsFactors = FALSE)
names(acc)
dim(acc)

ggplot(states, aes(x=long, y=lat)) + 
  geom_polygon(aes(group=group)) + 
  geom_point(aes(x=LONGITUD, y=LATITUDE), data=acc,
             color='lightgreen',
             alpha=0.2, size=0.02) + 
  xlim(-130, -60) + ylim(20, 50) +
  coord_map()
