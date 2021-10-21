# Project Midterm

Exploring data from udemy dataset ( [Here](https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/data/udemy_output_All_Finance__Accounting_p1_p626.csv) )

and R file is in here ( [Here](https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/MidtermAssignment.R) )

### Prepare

1.) install Package readr assertive stringr dplyr.

```{R}
install.packages("readr")
install.packages("assertive")
install.packages("stringr")
install.packages("dplyr")
```

2.) import package readr assertive stringr dplyr.

```{R}
library("readr")
library("assertive")
library("stringr")
library("dplyr")
```

3.) import and read data from udemy csv and view it.

```{R}
UdemyCSV <- read.csv("https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/data/udemy_output_All_Finance__Accounting_p1_p626.csv")
View(UdemyCSV)
```

### Data Cleaning

1.) check data type of UdemyCSV and declare Udemy

```{R}
Udemy <- glimpse(UdemyCSV)
#data of Udemy have 13608 rows and 20 columns by each columns have
```

result

```{R}
id : The course ID of that particular course.
title : Shows the unique names of the courses available under the development category on Udemy.
url: Gives the URL of the course.
is_paid : Returns a boolean value displaying true if the course is paid and false if otherwise.

num_subscribers : Shows the number of people who have subscribed that course.
avg_rating : Shows the average rating of the course.
avg rating recent : Reflects the recent changes in the average rating.
rating : Reflects the recent changes in the average rating.
num_reviews : Gives us an idea related to the number of ratings that a course has received.
is_wishlisted : Show course who are favorite by marked wishlist.

num_ published_lectures : Shows the number of lectures the course offers.
num_ published_ practice_tests : Gives an idea of the number of practice tests that a course offers.

created : The time of creation of the course.
published_time : Time of publishing the course.

discounted_ price_amount : The discounted price which a certain course is being offered at.
discounted_ price_currency : The currency corresponding to the discounted price which a certain course is being offered at.
discounted_ price_price_string :

price_ detail_amount : The original price of a particular course.
price_ detail_currency : The currency corresponding to the price detail amount for a course.
price_ detail_price_string :
```

2.) change type of value form character of amount to numberic

```{R}
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

# and replace by string with +amount with mutate
# discount price
Udemy <- Udemy %>% mutate(discount_price__price_string=paste("",discount_price__amount))
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional])
# price detail
Udemy <- Udemy %>% mutate(price_detail__price_string=paste("",price_detail__amount))
```
