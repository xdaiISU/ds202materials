library(tidyverse)
library(lubridate)
covid <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')
str(covid)
summary(covid)

story <- covid %>%
  filter(state == 'Iowa' & county == 'Story' &
           date >= mdy('08/01/21'))
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth()
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth(method='lm')
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth(method='loess')
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth(method='loess', span=1/10) # Not smooth enough with a small span
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth(method='loess', span=2) # Too smooth, so the fit to data is not good
ggplot(story, aes(x=date, y=cases)) + geom_point() + geom_smooth(method='loess', span=1/3)

johnson <- covid %>%
  filter(state == 'Iowa' & county == 'Johnson' &
           date >= mdy('08/01/21'))

ggplot(story, aes(x=date, y=cases)) + geom_line(color='red') + geom_line(data=johnson, color='yellow')

ggplot(story, aes(x=date, y=cases)) + geom_line() + geom_line(mapping=aes(y=deaths))

ggplot(story, aes(x=date, y=cases)) + geom_line(color='blue')

ggplot(story, aes(x=date, y=cases, color='black')) + geom_line() # WRONG



## Making maps
state <- map_data('state')
?map_data
iowa <- state %>%
  filter(region == 'iowa')
ggplot(iowa, aes(x=long, y=lat)) + geom_point()
ggplot(iowa, aes(x=long, y=lat)) + geom_path()
ggplot(iowa, aes(x=long, y=lat)) + geom_line() # WRONG

dat2 <- state %>%
  filter(region %in% c('iowa', 'florida'))
ggplot(dat2, aes(x=long, y=lat, group=group)) + geom_path()

ggplot(state, aes(x=long, y = lat, group=group)) + geom_path()

ggplot(state, aes(x=long, y = lat, group=region)) + geom_path()


ggplot(state, aes(x=long, y = lat, group=group)) + geom_polygon()

dat3 <- state %>%
  filter(region %in% c('california', 'washington'))
ggplot(dat3, aes(x=long, y=lat, group=group)) + geom_path()
ggplot(dat3, aes(x=long, y=lat, group=group)) + geom_polygon()
ggplot(dat3, aes(x=long, y=lat, group=region)) + geom_path()

county <- map_data('county')
ggplot(county, aes(x=long, y=lat, group=group)) + geom_polygon()
dallas <- county %>%
  filter(subregion == 'dallas')
ggplot(county, aes(x=long, y=lat, group=group)) + geom_polygon() + geom_polygon(data=dallas, color='blue')
