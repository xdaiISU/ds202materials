# Basic data types: numeric, charater, logical
3
pi # math constant
'hello world'
"hello world"
TRUE
FALSE
T #not recommended
F

# Classes
class(13)
class("hello")
class(TRUE)

# Making vectors
1:3
3:1
c(30, 10)
c("a", "b")
c(TRUE, FALSE)

# Calling an R function
seq(1, 5)
1:5
seq(5, 1)
?seq
seq(1, 5, by=2)
seq(1, 5, length.out=3)
seq(1, 5, length.out=4)

rep(1, 5)
rep(c(1, 2), 2)
rep(c(1, 2), times=2)
rep(c(1, 2), each = 2)
?rep

c(rep(c(1, 2), 2), 3)

# Assignment operator
numGender <- c(30, 20)
numGender
names(numGender) <- c("male", "female")
numGender

str(numGender)
str(1:2)
b <- c("hello", "world")
b
str(b)
str(c)
c <- 1
str(c)
rm(c) # remove
str(c)

# Numeric operators and functions.
1 + 1
1 + 2 * 3 - 4
2 ^ 3
5 / 2
5 %/% 2
5 %% 2

# vectorizied operation
a <- rep(1, 4)
b <- 1:4
a + b

a + 1
a + c(1, 2)
a + c(1, 2, 3) # avoid this.

a ^ 2

# Some math/stat functions
b
sqrt(b)
sum(b)
mean(b)
sd(b)
range(b)
quantile(b, 0.5) # median
median(b)
quantile(b, c(0.25, 0.75))

cov(1:4, 4:1)
cor(1:4, 4:1)

# extract elements
b <- c('sunny', 'windy', 'rainy', 'snowy')
b
b[1]
b[c(1, 4)]
b[5]
b[-1]
b[3] <- 'sleet'
b

b == 'sleet'
b != 'sleet'
b[b != 'sleet']

## cities data
devtools::install_github('xdaiISU/classdata')
library(classdata)

cities
str(cities)
class(cities)
names(cities)
head(cities)
tail(cities)
dim(cities)
summary(cities)

# Extracting columns
cities$Population
summary(cities$Population)
names(cities)
violent <- cities[, 1:3]
str(violent)
violent <- cities[, c('City', 'Population', 'Violent.crime')]
str(violent)

# Extracting rows
cities[c(1, 4, 5), ]
cities[cities$City == 'Ames', ]

# Combining them:
cities[c(1, 1000), c('City', 'Population')]

cities$Violent.crime[1:10]
cor(cities$Violent.crime[1:10], cities$Property.crime[1:10])
