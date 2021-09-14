library(classdata)
?fbi

str(fbi)
str(cities)

fbi$Type
summary(fbi$Type)
table(fbi$Type)

barplot(table(fbi$Type))
levels(fbi$Type)

# make a factor from scratch
x <- c('cat', 'cat', 'dog', 'cat', 'dog')
y <- factor(x)

y2 <- factor(x, levels=c('dog', 'cat'))

table(y)
table(y2)

# boxplot
boxplot(fbi$Count ~ fbi$Type)
lvl <- levels(fbi$Type)
lvl <- rev(lvl)
type1 <- factor(fbi$Type, levels=lvl)

boxplot(fbi$Count ~ type1)

type2 <- type1
levels(type2) <- substr(levels(type2), 1, 5)
boxplot(fbi$Count ~ type2)

lvl3 <- c('Larceny.theft',
          'Burglary',
          'Motor.vehicle.theft',
          'Aggravated.assault',
          'Robbery',
          'Legacy.rape',
          'Murder.and.nonnegligent.Manslaughter',
          'Rape')
type4 <- factor(fbi$Type, levels=lvl3)
boxplot(fbi$Count ~ type4)

type5 <- factor(fbi$Type, levels=lvl3, 
                labels=c('theft',
                         'burglary',
                         'v.theft',
                         'assault',
                         'robbery',
                         'l.rape',
                         'murder',
                         'rape'))
boxplot(fbi$Count ~ type5)

lvl4 <- c(lvl3[4], lvl3[-4])
type6 <- factor(fbi$Type, levels=lvl4)
boxplot(fbi$Count ~ type6)

# reorder the factor levels according to a criterion
?reorder
type7 <- reorder(fbi$Type, fbi$Count, FUN=mean)
levels(type7)

type8 <- reorder(fbi$Type, fbi$Count, FUN=mean, na.rm=TRUE)
levels(type8)

boxplot(fbi$Count ~ type8)

# type casting
is.factor(type1)
is.character(type1)
is.integer(type1)

type1_i <- as.numeric(type1)
str(type1_i)
str(type1)

head(type1_i)
head(type1)
table(type1_i)
table(type1)

type1_c <- as.character(type1)
str(type1_c)
head(type1_c)
table(type1_c)

fbi$Year
str(fbi$Year)
summary(fbi$Year)

summary(factor(fbi$Year))


fbi$Rate <- fbi$Count / fbi$Population

boxplot(fbi$Rate ~ fbi$Type)

type9 <- factor(fbi$Type, labels=c('assault', 
                                   'burglary',
                                   'theft', 
                                   'l.rape',
                                   'v.theft',
                                   'murder',
                                   'rape',
                                   'robbery'))
boxplot(fbi$Rate ~ type9)

type10 <- reorder(type9, fbi$Rate, FUN=median, na.rm=TRUE)
boxplot(fbi$Rate ~ type10)
