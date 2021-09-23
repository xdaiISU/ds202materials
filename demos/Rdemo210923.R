library(ggplot2)
library(classdata)

ggplot(fbiwide, aes(x=Year, y=Murder)) + geom_line()
ggplot(fbiwide, aes(x=Year, y=Murder, group=State)) + geom_line()

ggplot(fbiwide, aes(x=Year, y=Murder)) + geom_line() + 
  facet_wrap(~ State)
?facet_wrap

ggplot(fbiwide, aes(x=Year, y=Murder)) + geom_line() + 
  facet_wrap(~ State, scales='free_y')


ggplot(fbiwide, aes(x=Year, y=Murder)) + geom_line() + 
  facet_wrap(~ State, nrow=5)

dat1 <- fbi[fbi$Year %in% c(2016, 2017, 2018) &
              fbi$State %in% c('Iowa', 'Illinois', 'Nebraska'), ]
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar()
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + 
  facet_grid(Year ~ State)

ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + 
  facet_grid(State ~ Year)
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + 
  facet_grid(State ~ Year, scales='free_y')

ggplot(aes(x=Year, y=Murder, color=State, group=State), 
       data=fbiwide) + geom_line()
ggplot(aes(x=Year, y=Murder, group=State), 
       data=fbiwide) + geom_line() + facet_wrap(~State)

ggplot(aes(x=Year, y=Murder, color=(State == 'Iowa'), group=State), data=fbiwide) + geom_line()

dat2 <- fbiwide
dat2$State <- factor(dat2$State, 
                     c('Iowa', unique(dat2$State[dat2$State != 'Iowa'])))
ggplot(aes(x=Year, y=Murder, group=State), 
       data=dat2) + geom_line() + facet_wrap(~State)

p <- ggplot(fbiwide, aes(x= Murder, y=Motor.vehicle.theft)) +
  geom_point()
p
p + ylab('Motor vehicle crime') + ggtitle('Data for all states in all years')

ggplot(fbiwide, aes(x=Year, y=Motor.vehicle.theft)) + geom_line() + facet_wrap(~State)
ggplot(fbiwide, aes(x=Year, y=log10(Motor.vehicle.theft))) + geom_line() + facet_wrap(~State)
ggplot(fbiwide, aes(x=Year, y=Motor.vehicle.theft)) + geom_line() + facet_wrap(~State, scales='free_y')

ggplot(fbiwide, aes(x=Murder)) + geom_histogram()

