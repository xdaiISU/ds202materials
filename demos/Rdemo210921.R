library(classdata)
a <- fbi[fbi$Year %in% c(2010, 2011) &
      fbi$State == 'Iowa', ]
dim(a)

library(ggplot2)

str(fbiwide)
# Add a layer of points
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + 
  geom_point()

# Add one more layer of lines. Not too meaningful, just to demonstrate the functionality
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + 
  geom_point() + 
  geom_line()

p <- ggplot(fbiwide, aes(x=Burglary, y=Murder)) + 
  geom_point()
p
p + geom_line()

# more geoms
fbi2018 <- fbiwide[fbiwide$Year == 2018 &
                     fbiwide$State %in% c('Iowa', 'Illinois', 'Nebraska'), ]
fbi2018
ggplot(fbi2018, aes(x=State, y=Population)) + geom_bar() # Doesn't work
ggplot(fbi2018, aes(x=State, weight=Population)) + geom_bar() # special thing about geom_bar(). If there are multiple rows for each state, the bars are stacked. I.e., the height of the final bar is the sum of the population in all years.

ggplot(fbiwide[fbiwide$State %in% 
                 c('Iowa', 'Illinois', 'Nebraska'), ], 
       aes(x=State, weight=Population)) + geom_bar()

ggplot(fbi2018, aes(x=State)) + geom_bar()
ggplot(fbiwide, aes(x=State)) + geom_bar()

# more ways to call ggplot
ggplot(data=fbi2018, aes(x=State)) + geom_bar()
ggplot(aes(x=State), data=fbi2018) + geom_bar()

# More ggplot aesthetics
ggplot(fbiwide, aes(x=Burglary, y=Murder, size=Population)) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder, color=Population)) + geom_point()

# ggplot options
ggplot(mpg, aes(x=cty, y=hwy)) + geom_point()
dim(mpg)
ggplot(mpg, aes(x=cty, y=hwy)) + geom_point(position='jitter')

dat <- fbiwide[fbiwide$Year %in% 2016:2018 &
                 fbiwide$State %in% c('Iowa', 'Illinois', 'Nebraska'), ]
dat$Year <- factor(dat$Year)
ggplot(dat, aes(x=State, weight=Population, fill=Year)) + 
  geom_bar()
ggplot(dat, aes(x=State, weight=Population, color=Year)) + 
  geom_bar() # not what we want

ggplot(dat, aes(x=State, weight=Population, fill=Year)) + 
  geom_bar(position='dodge')

# scales
ggplot(fbiwide, aes(x=log(Burglary), y=log(Murder))) + geom_point()
ggplot(fbiwide, aes(x=Burglary, y=Murder)) + geom_point() + 
  scale_x_log10() + scale_y_log10()


fbi2018_1 <- fbiwide[fbiwide$Year == 2018, ]
ggplot(fbi2018_1, aes(x=State, weight=Population)) + geom_bar()

ggplot(fbiwide, aes(Burglary, Murder)) + geom_point()
ggplot(fbiwide, aes(Burglary, Murder)) + geom_point() + scale_x_log10() + scale_y_log10()
ggplot(fbiwide, aes(Burglary, Motor.vehicle.theft, color=State)) + geom_point() + scale_x_log10() + scale_y_log10()

ggplot(fbiwide, aes(Burglary, Motor.vehicle.theft, size=Population)) + geom_point() + scale_x_log10() + scale_y_log10()

# coordinate systems
fbi2018_1 <- fbiwide[fbiwide$Year == 2018, ]
p <- ggplot(fbi2018_1, aes(x=State, weight=Population)) + geom_bar()
p + coord_flip()

ggplot(fbiwide, aes(Burglary, Murder)) + geom_point() + 
  coord_cartesian(xlim=c(10000, 100000), ylim=c(100, 500))
