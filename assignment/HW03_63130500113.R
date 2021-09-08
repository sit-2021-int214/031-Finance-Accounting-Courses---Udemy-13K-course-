

list <- read.csv("INT214-Project1.csv")

listitem <- list(list)

View(listitem)

install.packages("DescTools")

library(DescTools)

install.packages("dplyr")

library(dplyr)

install.packages("MASS")

library(MASS)

cats <- cats

# 5. Who have coefficient of variation be better? between body weight and heart weight

# use dplyr
cats %>% summarise(
  cvBwt = sd(Bwt,na.rm=TRUE)/mean(Bwt,na.rm=TRUE)) # 0.178185 or 17.8185%

cats %>% summarise(
  cvHwt = sd(Hwt,na.rm=TRUE)/mean(Hwt,na.rm=TRUE)) # 0.2290224 or 22.90224%

# conclusion the body weight have variance better than heart weight

survey <- survey
# 1. survey the counting of woman who never smoking

# use dplyr
survey %>%
  select(Sex,Smoke) %>%
  filter(Sex=='Female',Smoke=='Never') %>%
  count(Sex) # 99 row
