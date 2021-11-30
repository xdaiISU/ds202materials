library(plotly)
library(classdata)
library(tidyverse)

fbi1 <- fbi %>%
  mutate(rate = Count / Population * 1000) %>%
  select(Year, State, Type, rate) %>%
  pivot_wider(names_from='Type', values_from='rate')
head(fbi1)

ggplot(fbi1, aes(x=Year, Aggravated.assault, group=State)) + geom_line()

plot_ly(fbi1, 
        x=~Year, y=~Burglary, z=~Aggravated.assault,
        text=~State,
        group=~State,
        type='scatter3d', mode='lines')


fbi1 <- fbi %>%
  mutate(rate = Count / Population * 1000) %>%
  select(Year, State, Type, rate) %>%
  pivot_wider(names_from='Type', values_from='rate')

fbi1 %>% 
  filter(State %in% c('Iowa', 'Illinois', 'Nebraska', 'Minnesota')) %>% 
  group_by(State) %>% 
  plot_ly(x=~Year, y=~Burglary, z=~Aggravated.assault,
        text=~State,
        color=~(State == 'Iowa'), 
        type='scatter3d', mode='lines')

fbi1 %>% 
  filter(State %in% c('Iowa', 'Illinois', 'Nebraska', 'Minnesota')) %>% 
  group_by(State) %>% 
  plot_ly(x=~Year, y=~Larceny.theft, z=~Motor.vehicle.theft,
          text=~State,
          color=~(State == 'Iowa'), 
          type='scatter3d', mode='lines')


fbi2015 <- fbi1 %>%
  filter(Year == 2015)

plot_ly(fbi2015, 
        x=~Burglary, y=~Larceny.theft, z=~Aggravated.assault,
        text = ~State,
        type = 'scatter3d',
        mode = 'markers+text',
        color=~(State == 'Iowa'), 
        colors=c('FALSE' = 'black', 'TRUE' = 'red'))

m <- lm(Aggravated.assault ~ Burglary + Larceny.theft, data=fbi2015)

xx <- unique(fbi2015$Burglary)
yy <- unique(fbi2015$Larceny.theft)
dat <- expand_grid(Burglary = xx, Larceny.theft = yy)
dat
zz <- predict(m, dat)
zz <- matrix(zz, length(xx), length(yy))

plot_ly() %>%
  add_trace(x=~Burglary, y=~Larceny.theft, z=~Aggravated.assault, data=fbi2015, 
            text=~State,
            color=~(State == 'Iowa'),
            colors=c(`FALSE`= 'black', `TRUE` = 'red'),
            type='scatter3d', mode='markers+text') %>%
  add_trace(x=~xx, y=~yy, z=~zz,
            type='surface',
            colorscale=list(c(0, 1), c('gray', 'gray')),
            opacity=0.5)
