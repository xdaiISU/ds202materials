library(tidyverse)
library(lubridate)

library(ggplot2)

# Show map first, and then show data frame
iowa <- map_data("state") %>% filter(region=="iowa")
iowa %>% ggplot(aes(x = long, y = lat)) + geom_point()
iowa %>% ggplot(aes(x = long, y = lat)) + geom_point() + coord_map()# Some magic here. Map projection. Compare with coord_fixed()

iowa <- map_data("state") %>% filter(region=="iowa")
iowa %>% ggplot(aes(x = long, y = lat)) + geom_point() + geom_path()
# What if we use geom_line?

# Fills the ares
iowa %>% ggplot(aes(x = long, y = lat)) + geom_polygon() 

# Now two states
dat2 <- map_data("state") %>% filter(region %in% c("iowa", "florida"))
str(dat2)
dat2 %>% ggplot(aes(x = long, y = lat)) + geom_path(aes(group=region))
dat2 %>% ggplot(aes(x = long, y = lat)) + geom_polygon(aes(group=region))

## Now all states
states <- map_data("state")
head(states)

states %>% ggplot(aes(x = long, y = lat)) + geom_point()

states %>% ggplot(aes(x = long, y = lat)) + geom_path(aes(group = group))
states %>% ggplot(aes(x = long, y = lat)) + geom_polygon(aes(group = group)) # group=region does not work

# Color by latitude
# Not what we want
states %>% ggplot(aes(x = long, y = lat)) + geom_polygon(aes(group = group, color=lat))
# Use fill= instead
states %>% ggplot(aes(x = long, y = lat)) + geom_polygon(aes(group = group, fill=lat))

state2 <- states %>% filter(region %in% c('washington', 'california'))
ggplot(state2, aes(x=long, y=lat, group=region)) + geom_polygon()
ggplot(state2, aes(x=long, y=lat, group=group)) + geom_polygon()
# The state of Washington has multiple groups, because the land areas are not connected.

# 45' 

# Join map with extra information
covidRaw <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv') 
covid <- covidRaw %>%
  filter(date == mdy('08/31/20')) %>%
  group_by(state) %>%
  summarize(totCases = sum(cases),
            totDeaths = sum(deaths))
str(covid)

# Joining without renaming will fail
covid$region <- tolower(covid$state)

# See what is going on: What states cannot be joined
nomatch1 <- covid %>% anti_join(states, by="region")
# States for which we do not have map data
unique(nomatch1$state)


nomatch2 <- states %>% anti_join(covid, by="region")
# States for which we do not have crime data
unique(nomatch2$state) # NULL

covidMap <- covid %>% left_join(states, by="region")
ggplot(covidMap, aes(x = long, y = lat, fill=totCases)) +
  geom_polygon(aes(group=group))

# 70'
# Your turn
  
# Layers
stateName <- states %>% group_by(region) %>% summarize(long=mean(long), lat=mean(lat))
states %>% ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group)) +
  geom_text(aes(label=region), color='white', data=stateName)


# Introduce FARS: A very large database, containing 
acc <- read.csv("https://raw.githubusercontent.com/xdaiISU/ds202materials/master/hwlabs/fars2017/accident.csv", stringsAsFactors = FALSE)
names(acc)

ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group))
ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group)) + geom_point(aes(x=LONGITUD, y=LATITUDE), data=acc %>% filter(YEAR == 2017), color='white')
ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group)) + geom_point(aes(x=LONGITUD, y=LATITUDE), data=acc %>% filter(YEAR == 2017), color='white', size=0.2) + xlim(-130, -60) + ylim(20, 50)

ggplot(states, aes(x=long, y=lat)) + geom_polygon(aes(group=group)) + geom_point(aes(x=LONGITUD, y=LATITUDE), data=acc %>% filter(YEAR == 2017), color='lightgreen', alpha=0.2, size=0.02) + xlim(-130, -60) + ylim(20, 50) + coord_map()

# No state name
# Useful in lab
# No state name. Have only state code available.
stateDeath <- acc %>% group_by(STATE) %>% summarize(n=n())
str(stateDeath)

maps::state.fips # join with this



