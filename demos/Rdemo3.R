library(classdata)
?fbi
str(fbi)

summary(fbi$Type)
table(fbi$Type)

# Make a factor from scratch
x <- c('cat', 'dog', 'cat', 'cat')
y <- factor(x)

# factor levels
y2 <- factor(x, levels = c('dog', 'cat'))

table(y)
table(y2)

lvl <- levels(fbi$Type)
lvl <- rev(lvl) # ?rev
type1 <- factor(fbi$Type, levels=lvl)
table(type1)
boxplot(fbi$Count ~ type1)

type2 <- type1
levels(type2) <- substr(levels(type1), 1, 5)
boxplot(fbi$Count ~ type2)

lvl2 <- c(lvl[3], lvl[-3])
type3 <- factor(fbi$Type, levels=lvl2)
boxplot(fbi$Count ~ type3)

lvl3 <- c('Larceny.theft', 'Burglary', 'Motor.vehicle.theft', 'Aggravated.assault', 'Robbery', 'Legacy.rape', 'Murder.and.nonnegligent.Manslaughter', 'Rape')
lab <- c('theft', 'burglary', 'v.theft', 'assault', 'robbery', 'l.rape', 'murder', 'rape')
type4 <- factor(fbi$Type, lvl3, labels=lab)
boxplot(fbi$Count ~ type4)

?reorder
type5 <- reorder(fbi$Type, fbi$Count, FUN=mean)
levels(type5)
type5

type5 <- reorder(fbi$Type, fbi$Count, FUN=mean, na.rm=TRUE)

# type conversion
is.factor(type1)
is.integer(type1)
str(type1)
head(type1)
table(type1)

type_c <- as.character(type1)
str(type_c)
head(type_c)
table(type_c)

type_i <- as.numeric(type1)
str(type_i)
head(type_i)
table(type_i)

summary(fbi$Year)
summary(factor(fbi$Year))
