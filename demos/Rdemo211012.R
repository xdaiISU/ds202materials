library(classdata)
data(french_fries, package='reshape2')
# install.packages('reshape2')
library(tidyverse)
library(reshape2)
?french_fries
str(french_fries)
table(french_fries$time)

?pivot_longer
ffm <- pivot_longer(french_fries, 
                    potato:painty,
                    names_to='scale',
                    values_to='score')
ffm2 <- pivot_longer(french_fries,
                     c(-time, -treatment, 
                       -subject, -rep),
                     names_to='scale',
                     values_to='score')
identical(ffm, ffm2)

?pivot_wider
s1 <- pivot_wider(ffm, 
                  names_from='rep', values_from = 'score')
s2 <- pivot_wider(ffm, 
                  names_from='scale', 
                  values_from = 'score')
s3 <- pivot_wider(ffm, 
                  names_from='subject', 
                  values_from = 'score')
s3
View(s3)

# Long format is helpful
ggplot(data=ffm, aes(x=score)) + geom_histogram() + facet_wrap(~scale)

# Wide format is helpful
# compare two repetitions
dat <- pivot_wider(ffm, names_from = 'rep', values_from = 'score')
dat %>%
  filter(time == 1) %>%
  ggplot(aes(x=`1`, y=`2`)) + 
  geom_point() + 
  facet_wrap(~scale) + 
  geom_abline(intercept=0, slope=1)

ffm %>%
  pivot_wider(names_from='time', values_from='score') %>%
  ggplot(aes(x=`1`, y=`10`)) + geom_point() +
  facet_grid(treatment ~ scale)


(dat <- fbiwide %>% pivot_longer(Aggravated.assault:Robbery, names_to='Type', values_to = 'Incidences')  %>% filter(Year==2014, State %in% c("Iowa", "Minnesota"), Type=="Burglary"))

dat$rate <- dat$Incidences / dat$Population * 1000
dat

pivot_wider(dat, names_from = 'State', values_from = 'rate')

dat %>%
  select(-Abb, -Population, -Incidences) %>%
  pivot_wider(names_from='State', values_from='rate')

a <- dat %>%
  select(-Abb) %>%
  pivot_wider(names_from='State', values_from=c('rate', 'Incidences', 'Population'))
