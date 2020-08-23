data(french_fries, package='reshape2')
library(tidyverse)

str(french_fries)

?pivot_longer
ffm <- french_fries %>%
  pivot_longer(potato:painty, names_to='scale', values_to='score')
ffm2 <- french_fries %>%
  pivot_longer(c(-time, -treatment, -subject, -rep), names_to='scale', values_to='score')
identical(ffm, ffm2)

# pivot_wider
?pivot_wider
s1 <- ffm %>% pivot_wider(names_from='rep', values_from='score')
s1$`1` %>% str
s2 <- ffm %>% pivot_wider(names_from='scale', values_from='score')

ggplot(ffm, aes(x=score)) + geom_histogram() + facet_wrap(~scale, scales='free_y')

s1 %>%
  filter(time == 1) %>%
  ggplot(aes(x=`1`, y=`2`)) + 
  geom_point() + 
  facet_wrap(~scale) +
  geom_abline(color='grey', intercept=0, slope=1)



library(classdata)
str(fbiwide)
fbilong <- fbiwide %>%
  pivot_longer(Aggravated.assault:Robbery, names_to='Type', values_to='Incidences')
str(fbilong)
dat <- fbilong %>%
  filter(Year >= 2014 & State %in% c('Iowa', 'Minnesota') & Type == 'Burglary')
dat

dat %>% 
  select(-Abb, -Population) %>%
  pivot_wider(names_from='State', values_from='Incidences')

# incorrect!
dat %>% 
  # select(-Abb, -Population) %>%
  pivot_wider(names_from='State', values_from='Incidences')

