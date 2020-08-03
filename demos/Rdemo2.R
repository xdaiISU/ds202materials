library(classdata)
?cities

unique(cities$City)
length(unique(cities$City))

range(cities$Year)
dat2016 <- cities[cities$Year == 2016, ]

# Which is the most dangerous city in 2016?
violent <- dat2016$Violent.crime
names(violent) <- dat2016$City
sort(violent)
sort(violent, decreasing = TRUE)
head(sort(violent, decreasing = TRUE))
worst5 <- head(sort(violent, decreasing = TRUE), n = 5)
names(worst5)

rank(violent)
rank(violent)['Ames']

order(violent)
violent[9]
violent[37]
violent[order(violent)]
a <- dat2016[order(violent), ]

## Plotting functions
# Plotting one single variable
hist(dat2016$Violent.crime)
hist(dat2016$Violent.crime / dat2016$Population)

boxplot(dat2016$Violent.crime / dat2016$Population)

amesPop <- dat2016$Population[dat2016$City == 'Ames']
ankenyPop <- dat2016$Population[dat2016$City == 'Ankeny']
pop <- c(amesPop, ankenyPop)
names(pop) <- c('Ames', 'Ankeny')
barplot(pop)

# Plot a pair of variables using plot()
plot(dat2016$Population, dat2016$Violent.crime)
plot(log(dat2016$Population), log(dat2016$Violent.crime))

x <- log(dat2016$Population)
y <- log(dat2016$Violent.crime)
city <- dat2016$City
plot(x, y)
points(x[city == 'Ames'], y[city == 'Ames'], col='red')
points(x[city == 'Ames'], y[city == 'Ames'], col='red', cex=2)
points(x[city == 'Ames'], y[city == 'Ames'], col='red', cex=2, pch=3)

# Compare the crimes in Ames and Ankeny
cities$Violent1000 <- cities$Violent.crime / cities$Population * 1000
ames <- cities[cities$City == 'Ames', ]
ankeny <- cities[cities$City == 'Ankeny', ]

plot(ames$Year, ames$Violent1000)
plot(ames$Year, ames$Violent1000, ylim=c(0, 4))
plot(ames$Year, ames$Violent1000, ylim=c(0, max(ames$Violent1000)))
plot(ankeny$Year, ankeny$Violent1000, ylim=c(0, max(ames$Violent1000)))

plot(ames$Year, ames$Violent1000, ylim=c(0, max(ames$Violent1000)),
     type='l')

plot(ames$Year, ames$Violent1000, ylim=c(0, max(ames$Violent1000)),
     type='b')
points(ankeny$Year, ankeny$Violent1000, col='blue', pch=2)
lines(ankeny$Year, ankeny$Violent1000, col='blue', lty=2)
abline(h = 2)

# Make plots nicer
plot(ames$Year, ames$Violent1000, ylim=c(0, max(ames$Violent1000)),
     type='b', xlab='Year', ylab='Violent crimes per 1000', main='Violent crimes over the years')
