# import csv

UdemyCSV <- read.csv("https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/data/udemy_output_All_Finance__Accounting_p1_p626.csv")
View(UdemyCSV)

install.packages("readr")
install.packages("assertive")
install.packages("stringr")
install.packages("dplyr")
library("readr")
library("assertive")
library("stringr")
library("dplyr")

# Data cleaning

# check data type of Udemy
glimpse(Udemy)

# by id is duplicate
Udemy$id %>% duplicated() %>% sum()
# 0
# Umedy have some data are not duplicate

# When amount price of course aren't show in table should replace by o
Udemy$discount_price__amount <- replace(Udemy$discount_price__amount,is.na(Udemy$discount_price__amount), 0)

# When currency price of course aren't show in table should replace by INR
Udemy$discount_price__currency <- replace(Udemy$discount_price__currency,Udemy$discount_price__currency=="", "INR")

# and replace by string with ₹+amount with mutate
Udemy <- Udemy %>% mutate(discount_price__price_string=paste("₹",discount_price__amount)) # convert to character
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional]) 