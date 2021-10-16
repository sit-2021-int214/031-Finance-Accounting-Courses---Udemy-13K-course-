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

# change type of value form character of amount to numberic
# discount price
Udemy$discount_price__amount <- as.numeric(Udemy$discount_price__amount)
# price detail
Udemy$price_detail__amount <- as.numeric(Udemy$price_detail__amount)

# by id is duplicate
Udemy$id %>% duplicated() %>% sum()
# 0
# Umedy have some data are not duplicate

# When amount price of course aren't show in table should replace by o
# discount price
Udemy$discount_price__amount <- replace(Udemy$discount_price__amount,is.na(Udemy$discount_price__amount), 0)
# price detail
Udemy$price_detail__amount <- replace(Udemy$price_detail__amount,is.na(Udemy$price_detail__amount), 0)

# When currency price of course aren't show in table should replace by INR
# discount price
Udemy$discount_price__currency <- replace(Udemy$discount_price__currency,Udemy$discount_price__currency=="", "INR")
# detail of price
Udemy$price_detail__amount <- replace(Udemy$price_detail__amount,Udemy$price_detail__amount=="", "INR")

# and replace by string with ₹+amount with mutate
# discount price
Udemy <- Udemy %>% mutate(discount_price__price_string=paste("₹",discount_price__amount))
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional])
# price detail
Udemy <- Udemy %>% mutate(price_detail__price_string=paste("₹",price_detail__amount))

# find title name,rating and number of reviews who are top of 10 courses have the most reviews in each course
Udemy %>%
  select(title,rating,num_reviews) %>%
  arrange(desc(num_reviews)) %>%
  summarise(title,rating,reviews=num_reviews) %>%
  head(10)
# result from output:
# show the The Complete SQL Bootcamp 2020: Go from Zero to Hero have the most reviews
                                                          title  rating reviews
1          The Complete SQL Bootcamp 2020: Go from Zero to Hero 4.67874   78006
2  Tableau 2020 A-Z: Hands-On Tableau Training for Data Science 4.60015   54581
3                        PMP Exam Prep Seminar -  PMBOK Guide 6 4.59326   52653
4                    The Complete Financial Analyst Course 2020 4.53772   46447
5  An Entire MBA in 1 Course:Award Winning Business School Prof 4.47173   41630
6   Microsoft Power BI - A Complete Introduction [2020 EDITION] 4.57676   38093
7  Agile Crash Course: Agile Project Management; Agile Delivery 4.29118   30470
8    Beginner to Pro in Excel: Financial Modeling and Valuation 4.53346   28665
9     Become a Product Manager | Learn the Skills & Get the Job 4.50080   27408
10                The Business Intelligence Analyst Course 2020 4.49575   23906

# find number of courses and price detail of amount who are top of 15 courses have the most price detail of amount course
Udemy %>%
  count(amount=price_detail__amount) %>%
  arrange(desc(amount)) %>%
  head(15)

# result from output:
# show 123 courses have amount of detail price is 12800 rupee
# 8 course have amount of detail price is 12480 rupee
# and 4 course have amount of detail price is 12160 rupee
   amount    n
1   12800  123
2   12480    8
3   12160    4
4   11840    6
5   11520    4
6   11200    3
7   10880    2
8   10560    2
9   10240    8
10   9920    3
11   9600   52
12   9280   34
13   8960   52
14   8640 3213
15   8320   71