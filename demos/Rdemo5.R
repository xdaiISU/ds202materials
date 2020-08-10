library(ggplot2)
library(classdata)

ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point()
ggplot(fbiwide, aes(x=`Burglary`, y=`Murder`)) + geom_point()

ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point() + geom_line()

fbi2018 <- fbiwide[fbiwide$Year == 2018 & 
                     fbiwide$State %in% 
                     c('Iowa', 'Illinois', 'Nebraska'), ]
fbi2018

ggplot(fbi2018, aes(x=State, y=Population)) + geom_bar() # WRONG
ggplot(fbi2018, aes(x=State, weight=Population)) + geom_bar()

ggplot(fbiwide[fbiwide$State %in% c('Iowa', 'Illinois', 'Nebraska'), ], aes(x=State, weight=Population)) + geom_bar()

ggplot(fbi2018, aes(x=State)) + geom_bar()

ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(mpg, aes(cty, hwy)) + geom_point(position='jitter')

ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder, size=Population)) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder, color=Population)) + geom_point()

dat <- fbiwide[fbiwide$Year %in% 2016:2018 & 
                 fbiwide$State %in% c('Iowa', 'Illinois', 'Nebraska'), ]
dat
dat$Year <- factor(dat$Year)
ggplot(dat, aes(x=State, weight=Population, fill=Year)) + geom_bar()
ggplot(dat, aes(x=State, weight=Population, color=Year)) + geom_bar() # WRONG
ggplot(dat, aes(x=State, weight=Population, fill=Year)) + geom_bar(position='dodge')

# scales
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point()
ggplot(fbiwide, aes(x=log(Burglary), y=log(Murder))) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point() + scale_x_log10() + scale_y_log10()

# coord
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point() + coord_cartesian(xlim=c(2e5, 6e5), ylim=c(2000, 4500))

ggplot(fbiwide, aes(x=State, weight=Population)) + geom_bar()
ggplot(fbiwide, aes(x=State, weight=Population)) + geom_bar() + coord_flip()

# facet
ggplot(aes(x=Year, y=Murder), data=fbiwide) + geom_point() + facet_wrap(~ State)

?facet_wrap
ggplot(aes(x=Year, y=Murder), data=fbiwide) + geom_point() + facet_wrap(~ State, nrow=10)
ggplot(aes(x=Year, y=Murder), data=fbiwide) + geom_point() + facet_wrap(~ State, ncol=10)
ggplot(aes(x=Year, y=Murder), data=fbiwide) + geom_point() + facet_wrap(~ State, scales='free_y')

dat1 <- fbi[fbi$Year %in% 2016:2018 & 
              fbi$State %in% c('Iowa', 'Illinois', 'Nebraska'), 
            ]
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + facet_grid(Year ~ State)
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + facet_grid(State ~ Year)
ggplot(dat1, aes(x=Type, weight=Count)) + geom_bar() + facet_grid(State ~ Year, scales = 'free_y')

ggplot(aes(x=Year, y=Murder), data=fbiwide) + geom_line() + facet_wrap(~ State)
ggplot(aes(x=Year, y=Murder, color=State), data=fbiwide) + geom_line() # BAD!

ggplot(aes(x=Year, y=Murder, color = State == 'California', group=State), data=fbiwide) + geom_line()

# themes
p <- ggplot(fbiwide, aes(x=Murder, y=Motor.vehicle.theft)) + geom_point()
p
p + xlab('Number of murders') + ylab('Number of motor vehicle theft') + ggtitle('Data all states in all years')
