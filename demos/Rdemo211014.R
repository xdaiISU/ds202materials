library(tidyverse)
df <- data.frame(term = c('Fall.2020', 'Spring.2021'))
df

?separate
df %>% 
  separate(term, c('semester', 'year'))
df %>% 
  separate(term, c(semester, year))

df1 <- df %>% 
  separate(term, c('semester', 'year'), sep='\\.')
df

df1 %>%
  unite('term', semester, year, sep=' ')
df1 %>%
  unite(term, semester, year, sep=' ')

NA + 1
TRUE | NA
FALSE | NA
FALSE & NA

x <- c(1, NA, 3)
x
x[x == NA] <- 0 # doesn't work
x[is.na(x)] <- 0
x

# campaign
campaign <- read_csv('Iowa_Campaign_Expenditures.csv')
str(campaign)
campaign <- campaign[1:10000, ]
str(campaign)

dat <- campaign %>%
  separate(Date, c('Month', 'Day', 'Year'), sep='/', remove = FALSE) %>%
  separate(Zip, c('Zip5', 'ZipExt'), sep='-') %>%
  replace_na(list(ZipExt = ''))
View(dat)

dat2 <- dat %>%
  replace_na(list(`First Name` = '', `Last Name` = '')) %>%
  unite('Full Name', `First Name`, `Last Name`, sep=' ')

dat2_1 <- dat %>%
  replace_na(list(`First Name` = '', `Last Name` = '')) %>%
  unite('Full Name', `Last Name`, `First Name`, sep=', ')


dat3 <- dat %>%
  drop_na(`First Name`)

dat4 <- dat %>%
  mutate(`First Name` = ifelse(is.na(`First Name`),
                               '',
                               `First Name`))

dat5 <- dat %>%
  filter(is.na(`Receiving Organization Name`))
