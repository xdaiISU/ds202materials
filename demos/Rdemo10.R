library(tidyverse)

url <- "https://data.iowa.gov/api/views/3adi-mht4/rows.csv"
campaign <- readr::read_csv(url)

str(campaign)

dat <- campaign %>%
  separate(Zip, c('zip5', 'zipAddon')) %>%
  separate(Date, c('Month', 'Day', 'Year'), sep='/') %>% 
  mutate(Month = as.integer(Month),
         Day = as.integer(Day),
         Year = as.integer(Year))
str(dat)

dat2 <- dat %>%
  unite(`Receiver Full Name`, `First Name`, `Last Name`, sep=' ')

dat3 <- dat2 %>%
  mutate(`Receiving Name` = ifelse(
    is.na(`Receiving Organization Name`),
    `Receiver Full Name`, 
    `Receiving Organization Name`
  ))
dat3$`Receiving Name`
