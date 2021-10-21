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
Udemy <- read.csv("https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/data/udemy_output_All_Finance__Accounting_p1_p626.csv")
```

### Explore a Data
```{R}
# Testing with glimpse
glimpse(Udemy)

# View table
View(Udemy)
```
data of Udemy have 13608 rows and 20 columns by each columns have
- id : The course ID of that particular course.
- title : Shows the unique names of the courses available under the development category on Udemy.
- url: Gives the URL of the course.
- is_paid : Returns a boolean value displaying true if the course is paid and false if otherwise.

- num_subscribers : Shows the number of people who have subscribed that course.
- avg_rating : Shows the average rating of the course.
- avg rating recent : Reflects the recent changes in the average rating.
- rating : Reflects the recent changes in the average rating.
- num_reviews : Gives us an idea related to the number of ratings that a course has received.
- is_wishlisted : Show course who are favorite by marked wishlist by return a boolean value.

- num_ published_lectures : Shows the number of lectures the course offers.
- num_ published_ practice_tests : Gives an idea of the number of practice tests that a course offers.

- created : The time of creation of the course.
- published_time : Time of publishing the course.

- discounted_ price_amount : The discounted price which a certain course is being offered at.
- discounted_ price_currency : The currency corresponding to the discounted price which a certain course is being offered at.
- discounted_ price_price_string :

- price_ detail_amount : The original price of a particular course.
- price_ detail_currency : The currency corresponding to the price detail amount for a course.
- price_ detail_price_string :

### Data Cleaning

1.) check data type of UdemyCSV and declare Udemy

```{R}
# check data type of Udemy
glimpse(Udemy)
```

result of output:
```{R}
# Rows: 13,608
# Columns: 20
# $ id                           <int> 762616, 937678, 1361790, 648826, 637930, 1208634, 864146, 321~
# $ title                        <chr> "The Complete SQL Bootcamp 2020: Go from Zero to Hero", "Tabl~
# $ url                          <chr> "/course/the-complete-sql-bootcamp/", "/course/tableau10/", "~
# $ is_paid                      <chr> "True", "True", "True", "True", "True", "True", "True", "True~
# $ num_subscribers              <int> 295509, 209070, 155282, 245860, 374836, 124180, 96207, 127680~
# $ avg_rating                   <dbl> 4.66019, 4.58956, 4.59491, 4.54407, 4.47080, 4.56228, 4.32383~
# $ avg_rating_recent            <dbl> 4.67874, 4.60015, 4.59326, 4.53772, 4.47173, 4.57676, 4.29118~
# $ rating                       <dbl> 4.67874, 4.60015, 4.59326, 4.53772, 4.47173, 4.57676, 4.29118~
# $ num_reviews                  <int> 78006, 54581, 52653, 46447, 41630, 38093, 30470, 28665, 27408~
# $ is_wishlisted                <chr> "False", "False", "False", "False", "False", "False", "False"~
# $ num_published_lectures       <int> 84, 78, 292, 338, 83, 275, 23, 275, 144, 413, 117, 67, 43, 41~
# $ num_published_practice_tests <int> 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0~
# $ created                      <chr> "2016-02-14T22:57:48Z", "2016-08-22T12:10:18Z", "2017-09-26T1~
# $ published_time               <chr> "2016-04-06T05:16:11Z", "2016-08-23T16:59:49Z", "2017-11-14T2~
# $ discount_price__amount       <dbl> 455, 455, 455, 455, 455, 455, 455, 455, 455, 455, 455, 455, 4~
# $ discount_price__currency     <chr> "INR", "INR", "INR", "INR", "INR", "INR", "INR", "INR", "INR"~
# $ discount_price__price_string <chr> "โ\202น455", "โ\202น455", "โ\202น455", "โ\202น455", "โ\202น45~
# $ price_detail__amount         <dbl> 8640, 8640, 8640, 8640, 8640, 8640, 8640, 8640, 8640, 8640, 8~
# $ price_detail__currency       <chr> "INR", "INR", "INR", "INR", "INR", "INR", "INR", "INR", "INR"~
# $ price_detail__price_string   <chr> "โ\202น8,640", "โ\202น8,640", "โ\202น8,640", "โ\202น8,640", "~
```

2.) change type of value form character of amount to numberic

```{R}
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

# and replace by string with current+amount with mutate
# discount price
Udemy <- Udemy %>% mutate(discount_price__price_string=paste(discount_price__currency,discount_price__amount))
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional])
# price detail
Udemy <- Udemy %>% mutate(price_detail__price_string=paste(price_detail__currency,price_detail__amount))
```

2.) Explore Data

2.1) find title name,rating and number of reviews who are top of 10 courses have the most reviews in each course

```{R}
Udemy %>%
  select(title,rating,num_reviews) %>%
  arrange(desc(num_reviews)) %>%
  summarise(title,rating,reviews=num_reviews) %>%
  head(10)
```

result from output:

```{R}
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
```

2.2) find number of courses and price detail of amount who are top of 15 courses have the most price detail of amount course

```{R}
Udemy %>%
  count(amount=price_detail__amount) %>%
  arrange(desc(amount)) %>%
  head(15)
```

result from output:

```{R}
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
```
