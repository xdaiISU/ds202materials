a <- rep(1, 4)
a[c(2, 4)] <- 0
a

seq(1, 4) %% 2 == 0
a[seq(1, 4) %% 2 == 0] <- 0
a

## last your turn

library(classdata)

cities[1:10, ]
head(cities, 10)

cities$Burglary
cities[, 'Burglary']
mean(cities$Burglary)
sd(cities$Burglary)

mean(cities$Burglary, na.rm=TRUE)
sd(cities$Burglary, na.rm=TRUE)

mean(cities$Burglary, NA.rm=TRUE) # doesn't work. R is case-sensitive

library(classdata)

## Data exploration
str(cities)
unique(cities$City)
length(unique(cities$City))

# sort, rank, order
# Which is the most dangerous city in 2016?
# Could use just the number of violent crimes
# Could also use the sum of the numbers of violent and property crimes.
# Take the first approach
dat2016 <- cities[cities$Year == 2016, ]
violent <- dat2016$Violent.crime
names(violent) <- dat2016$City
sort(violent)
sort(violent, decreasing = TRUE)[1:5]
worst5 <- head(sort(violent, decreasing = TRUE), 5)
names(worst5)
str(worst5)

rank(violent)
rank(violent)['Ames']

order(violent)
violent[9]
violent[37] 
violent[order(violent)] # same as sort(violent)
dat2016Sorted <- dat2016[order(violent), ]

# plotting functions
# univaritate
hist(dat2016$Violent.crime)
boxplot(dat2016$Violent.crime)

hist(dat2016$Violent.crime / dat2016$Population)
boxplot(dat2016$Violent.crime / dat2016$Population)

amesPop <- dat2016[dat2016$City == 'Ames', 'Population']
ankenyPop <- dat2016$Population[dat2016$City == 'Ankeny']
pop <- c(amesPop, ankenyPop)
names(pop) <- c('Ames', 'Ankeny')
barplot(pop)

# bivariate
plot(dat2016$Population, dat2016$Violent.crime)
plot(log(dat2016$Population), log(dat2016$Violent.crime))
plot(log10(dat2016$Population), log10(dat2016$Violent.crime))

x <- log(dat2016$Population)
y <- log(dat2016$Violent.crime)
city <- dat2016$City
plot(x, y)
points(x[city == 'Ames'], y[city == 'Ames'], col='red')
points(x[city == 'Ames'], y[city == 'Ames'], col='red', cex=2)
points(x[city == 'Ames'], y[city == 'Ames'], col='red', cex=2,
       pch=3)

cities$Violent1000 <- cities$Violent.crime / cities$Population * 1000

ames <- cities[cities$City == 'Ames', ]
plot(ames$Year, ames$Violent1000)
plot(ames$Year, ames$Violent1000, type='b')
plot(ames$Year, ames$Violent1000, type='l')
plot(ames$Year, ames$Violent1000, type='l', 
     ylim=c(0, max(ames$Violent1000)))

ankeny <- cities[cities$City == 'Ankeny', ]
lines(ankeny$Year, ankeny$Violent1000)
points(ankeny$Year, ankeny$Violent1000)
abline(h=2)

plot(ames$Year, ames$Violent1000, 
     ylim=c(0, max(ames$Violent1000)),
     type='b', 
     main = 'Crime rate over the years', 
     xlab = 'Year', ylab='Crime per thousand')
points(ankeny$Year, ankeny$Violent1000,
       pch=2, col='blue')
lines(ankeny$Year, ankeny$Violent1000,
      pch=2, col='blue', lty=2)
legend('topright', 
       c('Ames', 'Ankeny'),
       col=c('black', 'blue'),
       lty=c(1, 2),
       pch=c(1, 2))
