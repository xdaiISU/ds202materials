TRUE & FALSE
TRUE | FALSE
!TRUE

# Logical operators are vectorized
isChick <- c(TRUE, FALSE)
isCy <- c(FALSE, TRUE)
hasFist <- c(FALSE, TRUE)
isChick & isCy
isChick | isCy
!isChick
isChick | isCy & hasFist # & is calculated before |
isChick | (isCy & hasFist)
(isChick | isCy) & hasFist
!isChick | isCy
!(isChick | isCy)
?Syntax

# Comparison operators
a <- c(1, 10)
b <- c(2, 3)
a < b
a >= b
a == b
a != b
a = b # NOT a comparison

x <- 1:5
isOdd <- (x %% 2) == 1
isSmall <- x <= 3
x[isOdd & isSmall]
x[isOdd | isSmall]

# %in%
col <- 'cardinal'
redCols <- c('red', 'wine', 'cherry', 'cardinal')
col %in% redCols
c('cherry', 'pear') %in% redCols
redCols %in% c('cherry', 'pear')

ifelse(1:10 %% 2 == 0, 'even', 'odd')
?ifelse

dat <- data.frame(x = 1:3, 
                  y = c('a', 'b', 'c'),
                  stringsAsFactors = FALSE)
dat
dat[1, 2]
dat[c(TRUE, FALSE, FALSE), c(FALSE, TRUE)]

library(classdata)
str(fbi)
takeout <- fbi$State == 'Iowa' & fbi$Year == 2009
summary(takeout)
Iowa2009 <- fbi[takeout, ]
str(Iowa2009)

someStates <- fbi[fbi$State %in% c('Nebraska', 'Minnesota', 'Illinois'), ]
table(someStates$State)

fbi$State[fbi$State == 'Iowa'] <- 'Our State'