# Walk over slides until French fries. 10'

# Load data
library(classdata)
data(french_fries, package="reshape2")
library(tidyverse)
# ?french_fries. First understand experimental setup 15'
# # # of subjects, # of replications, etc
# str(french_fries)
# table(french_fries$time)
# table(french_fries$treatment)
# table(french_fries$subject)
# table(french_fries$rep)
# 
# # Number of records for each subjects
# french_fries %>% group_by(subject) %>% summarize(n=n())
# 
# # Number of  subjects each time
# french_fries %>% group_by(time) %>% summarize(n=n())
# a <- french_fries %>% group_by(subject, time) %>% summarize(n=n())

# pivot_longer: previously called `gather`
# ?pivot_longer
# cols: The columns to pivot
# names_to: key col name; value: val col name
ffm <- french_fries %>% pivot_longer(potato:painty, names_to='scale', values_to='score')
# The cols argument 
# ffm1 <- french_fries %>% pivot_longer(5:9, names_to='scale', values_to='score')
ffm2 <- french_fries %>% pivot_longer(c(-time, -treatment, -subject, -rep), names_to='scale', values_to='score')
# identical(ffm, ffm1)
identical(ffm, ffm2)

# pivot_wider: previously called `spread`. Pivots a key column and makes it measurement columns
s1 <- ffm %>% pivot_wider(names_from = 'rep', values_from = 'score')
s2 <- ffm %>% pivot_wider(names_from = 'scale', values_from = 'score') # similar to french_fries
s3 <- ffm %>% pivot_wider(names_from = 'subject', values_from = 'score') # now the last few columns corresponds to subject ID goes

# When is each format useful?
ffm %>%
  ggplot(aes(x=score)) + geom_histogram() + facet_wrap(~scale, scales='free_y')

# Compare two reps for each subject: Are subjects consistent?
dat <- ffm %>% 
  pivot_wider(names_from = 'rep', values_from = 'score') %>% 
  filter(time == 1) # Take only time 1

dat %>%
  # ggplot(aes(x = 1, y = 2)) + geom_point() +
  ggplot(aes(x = `1`, y = `2`)) + 
  geom_point() + # Use backflip `` to quote columns
  facet_wrap(~scale) + 
  geom_abline(colour = "grey50") # intercept=0, slope=1

# # Your turn 1
# ffm <- french_fries %>% pivot_longer(potato:painty, names_to='scale', values_to='score')
# s4 <- ffm %>% pivot_wider(names_from='time', values_from='score')
# ggplot(s4, aes(x=`1`, y=`10`)) + geom_point() + facet_wrap( ~ treatment + scale)
# ggplot(s4, aes(x=`1`, y=`10`)) + geom_point() + facet_grid(treatment ~ scale)
# ggplot(s4, aes(x=`1`, y=`10`, color=subject, shape=factor(rep))) + geom_point() + facet_grid(treatment ~ scale)
# # Not very consistent over time.
# # Pattern: there is a subject effect. See some outliers in the first column
# # Treatment effect

library(classdata)
fbilong <- fbiwide %>% 
  pivot_longer(Aggravated.assault:Robbery, names_to='Type', values_to = 'Incidences')
dat <- fbilong %>% 
  filter(Year >= 2014, State %in% c("Iowa", "Minnesota"), Type=="Burglary")

pivot_wider(dat, names_from='State', values_from='Incidences')
dat %>%
  select(-Abb, -Population) %>%
  pivot_wider(names_from='State', values_from='Incidences')

pivot_wider(dat %>% select(-Abb), 
            names_from='State', values_from=c('Incidences', 'Population'))

pivot_wider(dat %>% select(-Abb), 
            names_from='State', values_from=c('Incidences', 'Population')) %>%
  pivot_longer(3:6, names_pattern="(.*)_(.*)", names_to=c('.value', 'State'))


# #  Your turn 2
# data("fbiwide", package="classdata")
# fbiwide
# fbilong <- fbiwide %>% 
#   pivot_longer(Aggravated.assault:Robbery, names_to='Type', values_to='Incidences') %>% mutate(rate = Incidences / Population * 1000)
# IAMN <- fbilong %>% 
#   filter(State %in% c('Iowa', 'Minnesota')) %>% 
#   pivot_wider(names_from='State', values_from='rate') # does not work!
# # Need to retain only keys and one value column
# # The new key varialbes are only Year and Type
# IAMN2 <- fbilong %>% 
#   filter(State %in% c('Iowa', 'Minnesota')) %>% 
#   select(-Abb, -Incidences, -Population) %>% 
#   pivot_wider(names_from='State', values_from='rate')


# Not only answer whether or not two things are correlated, but how much (large, small; direction)?
# absolute path & relative paths


## Pick up here
# Messy 2
# library(tidyverse)
# df <- data.frame(x = c("a.b", "a.d", "b.c", NA), b=1)
# df
# df %>% separate(col=x, into = c("A", "B")) # By default, the separator is anything that is not alphanumeric (letters and numbers). https://rstudio.com/resources/cheatsheets/
# df %>% separate(col=x, into = c("A", "B"), sep = '\\.') # More rigorous. 
# 
# address <- c('1301 8th St. SE, Orange City, Iowa 51041',
#              '2102 Durant, Harlan, Iowa 51537')
# df1 <- data.frame(address = address)
# 
# # Change delimiter
# df1 %>% separate(address, into=c('Street', 'City', 'StateZip'))
# df1 %>% separate(address, into=c('Street', 'City', 'StateZip'), sep=',')
# 
# df2 <- data.frame(zip=c('95616', '50010-1234'))
# df2 %>% separate(zip, into=c('zip', 'addon'))

# 15'

# Your turn 20'


url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)

# Explore date and zip columns
# Next slide, and then demo

library(readr)
dat <- campaign %>% 
  separate(Date, c('Month', 'Day', 'Year')) %>% 
  separate(Zip, c('zip5', 'zipAddon'))
dat %>% head %>% print(width=Inf)

# Replace NA values in zipAddon by an empty string
# dat1 <- dat %>% 
#   replace_na(list(zipAddon='')) %>% 
#   head %>% print(width=Inf)

# Drop rows with NA values in certain columns
# Which money goes to a person (rather than an organization)?
# dat2 <- dat %>% 
#   drop_na(`First Name`, `Last Name`)
# select(dat2, `Committee Name`, `First Name`, `Last Name`)

# Put back columns: unite
dat2 <- dat1 %>% 
  unite('Full Name', `First Name`, `Last Name`, sep=' ') # remove=FALSE

is.na(dat2$`Receiving Organization Name`) %>% table
is.na(dat2$`Full Name`) %>% table
# Last your turn 35'


## Final Project
team formed on March 22 after turning in Lab 4, 
pick coordinator, 
write proposal together
obtain new dataset (download, crawl, the more difficult the better)
Finding new data: 1. think what 2. google 3. Post on Piazza and see if there is source
think about how to analyze it and write a report

https://systems.jhu.edu/research/public-health/ncov/
  Talks about the background of the topic of concern. What is it and why does it matter?
  1st paragraph
2nd section

https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6
https://coronavirus.1point3acres.com/
  
  1. What is corona virus
2. Map:
  a. Over view: big numbers and trend
b. Details: Numbers in each region. Interactive; plot on a map 
c. Dots are dawn in the log scale. Hubei, Korea, Japan, US
d. 

3. What should be improved: 
  a. rate
b. size in the original scale

Features we will learn: interactive plot, map, 
What we want: informative visualization. Good story telling. 
