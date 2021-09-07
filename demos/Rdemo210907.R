# Basic data types
3
pi
1:5

'hello world'
"hello world"
c('cat', 'dog', 'lizard')

TRUE
FALSE
c(TRUE, FALSE)

# variable classes
class(pi)
class('hello')
class(c(TRUE, TRUE))

# Making vectors
1:5
5:10
c(30, 10)

seq(1, 5)
seq(5, 1)
?seq

seq(1, 5) # matching argument by position
seq(to=1, from=5) # matching argument by name

seq(1, 5, by=1)
seq(1, 5, by=2)
seq(1, 5, length.out=3)
seq(1, 5, length.out=2)
seq(length.out=3, 1, 5) # R matches the argument by name first, and the rest of the arguments are matched by position

rep(1, 3)
rep(c(1, 2), 2)
rep(c(1, 2), times=2)
rep(c(1, 2), length.out=3)
rep(c(1, 2), each=2)

c(rep(c(1, 2), 2), 3)

# Assignment operator
numGender <- c(15, 5)
names(numGender) <- c('male', 'female')
numGender

str(numGender) # show strucutre of an R object
str(c(15, 5))
b <- c('hello', 'world')
str(b)
str(c)
c <- 1
rm(c) # remoce an R object

# Numeric operators and functions
1 + 2 * 3 - 4 # note the operator precedence
2 ^ 3 
5 / 2
5 %/% 2 # integer division
5 %% 2  # take the remainder (modulo)
?Syntax

# vectorized operation
a <- rep(1, 4)
b <- 1:4
a + b
a + 1
b ^ 2

a + c(1, 2) # recycling rule
a + 1:3

# some math/stat functions
b
sqrt(b)
sum(b)
sqrt(sum(b^2))
mean(b)
sd(b)
range(b)
quantile(b, c(0.25, 0.75))

cov(1:4, 4:1)
cor(1:4, 4:1)

# Extract elements
highT <- c(83, 89, 81, 69, 81, 87, 87)
highT
highT[1]
highT[c(1, 4)]
highT[4] <- 79
highT

highT == 87
highT != 87

?mean
?+ # does not work
?`+`  

# Your turn
x <- c(4, 1, 3, 9)
y <- 1:4
z <- c('c', 'b', 'a')

sqrt(sum((x - y)^2))
x[-1]
x[c(-1, -4)]

x[c(1,1,1,2,2,2,3,3,3)]

install.packages('devtools')
devtools::install_github("xdaiISU/classdata")
library(classdata)

cities
View(cities)

str(cities)
class(cities)
names(cities)
head(cities)
head(cities, 10)
tail(cities)
dim(cities)
length(cities)
summary(cities)

# Extract columns
cities$Population
summary(cities$Population)
names(cities)
violent <- cities[, 1:3]
str(violent)

violent <- cities[, c('City', 'Population', 'Violent.crime')]  # preferred
str(violent) 

# extracting rows
cities[c(1, 4, 5), ]
cities[cities$City == 'Ames', ]
str(cities$City == 'Ames')

# Combine rows and column
cities[c(1, 1000), c('City', 'Population')]
cities$Violent.crime[1:10]
