install.packages('nycflights13')
library(nycflights13)
library(dplyr)
?flights
?airports
?weather

flight1 <- flights %>%
  select(year, month, day, dep_time, carrier, flight, 
         origin, dest)

flight1 %>%
  inner_join(airports, by=c("origin" = "faa")) %>% 
  inner_join(airports, by=c("dest" = "faa"))

flight1 %>%
  inner_join(airports %>%
               select(faa, lon_origin=lon, lat_origin=lat), 
             by=c("origin" = "faa")) %>% 
  inner_join(airports %>%
               select(faa, lon_dest=lon, lat_dest=lat), 
             by=c("dest" = "faa"))

# Part II, Q1
dim(flights)
flights %>% 
  inner_join(weather)

flights %>% 
  left_join(weather)

flights %>% 
  left_join(weather) %>% 
  filter(is.na(temp))

flights %>% 
  anti_join(weather)

# Q2
old <- flights %>% 
  group_by(tailnum) %>% 
  summarize(nTimes = n()) %>% 
  filter(nTimes >= 100)

flights %>%
  semi_join(old)
flights %>%
  filter(tailnum %in% old$tailnum)
