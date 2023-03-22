# Project Term Assignment

Exploring data from udemy dataset ( [Here](https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/data/udemy_output_All_Finance__Accounting_p1_p626.csv) )

and R file is in here ( [Here](https://raw.githubusercontent.com/sit-2021-int214/031-Finance-Accounting-Courses---Udemy-13K-course-/main/assignment/MidtermAssignment.R) )

## Prepare

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
View(Udemy)
```

## Explore a Data
```{R}
# Testing with glimpse
glimpse(Udemy)
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

## Data Cleaning

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

# When amount price of course aren't show in table should replace by global average
# discount price
Udemy$discount_price__amount <- replace(Udemy$discount_price__amount,is.na(Udemy$discount_price__amount), round(mean(Udemy$discount_price__amount,na.rm=T)))
# price detail
Udemy$price_detail__amount <- replace(Udemy$price_detail__amount,is.na(Udemy$price_detail__amount), round(mean(Udemy$discount_price__amount,na.rm=T)))

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

3.) Explore Data

3.1) find title name, rating, number of subscribers and number of reviews who are top of 10 courses have the most reviews in each course

```{R}
Udemy %>%
  select(title,rating,num_subscribers,num_reviews) %>%
  arrange(desc(num_reviews)) %>%
  summarise(title,rating,subscribe=num_subscribers,reviews=num_reviews) %>%
  head(10)
```

result from output:

```{R}
# show the The Complete SQL Bootcamp 2020: Go from Zero to Hero have the most reviews
                                                          title  rating subscribe reviews
1          The Complete SQL Bootcamp 2020: Go from Zero to Hero 4.67874    295509   78006
2  Tableau 2020 A-Z: Hands-On Tableau Training for Data Science 4.60015    209070   54581
3                        PMP Exam Prep Seminar -  PMBOK Guide 6 4.59326    155282   52653
4                    The Complete Financial Analyst Course 2020 4.53772    245860   46447
5  An Entire MBA in 1 Course:Award Winning Business School Prof 4.47173    374836   41630
6   Microsoft Power BI - A Complete Introduction [2020 EDITION] 4.57676    124180   38093
7  Agile Crash Course: Agile Project Management; Agile Delivery 4.29118     96207   30470
8    Beginner to Pro in Excel: Financial Modeling and Valuation 4.53346    127680   28665
9     Become a Product Manager | Learn the Skills & Get the Job 4.50080    112572   27408
10                The Business Intelligence Analyst Course 2020 4.49575    115269   23906
```

3.2) find number of courses and price detail of amount who are top of 15 courses have the most price detail of amount course

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
3.3) show your summarise of course who are paid and not paid with count of course, average of rating, average of subscribes, max of subscribe and average of review and max of review

```{R}
Udemy %>% count(is_paid) %>% summarise(is_paid,count_course=n) # count of course

Udemy %>% group_by(is_paid) %>% 
  select(rating,num_subscribers,num_reviews) %>%
  summarise(average_rating = mean(rating, na.rm = TRUE),
            average_subscribes = mean(num_subscribers,na.rm=TRUE),
            max_subscribes = max(num_subscribers,na.rm=TRUE),
            average_reviews = mean(num_reviews, na.rm=TRUE),
            max_reviews = max(num_reviews, na.rm=TRUE)
            ) # summarise of rating, subscribe and reviews
```

result from output:

```{R}
# show result counting of paid and not paid course
#   is_paid count_course
# 1   False          496
# 2    True        13112

# show result average rating,average and max subscribes and average and max reviews of paid and non paid course
# is_paid average_rating average_subscribes max_subscribes average_reviews max_reviews
# <chr>            <dbl>              <dbl>          <int>           <dbl>       <int>
# 1 False             3.99              5861.         259888            309.       23635
# 2 True              3.91              2733.         374836            241.       78006

# in conclusion
# paid courses have count more than non paid courses by 12616 courses

# rating
# rating of paid courses have average is 3.99 point
# rating of non paid courses have average is 3.91 point

# subscribes
# subscribes of paid courses have average is 5861 subscribes and have max subscribe is 259888 subscribes
# subscribes of non paid courses have average is 2733 subscribes and have max subscribe is 374836 subscribes

# rating
# rating of paid courses have average is 309 reviews and have max review is 23635 reviews
# rating of paid courses have average is 241 reviews and have max review is 78006 reviews
```

## Analytically Inferential Statistics

### **Topic(โจทย์):** ถ้าเราอยากจะรู้ว่าข้อมูลการซื้อขายของ course ที่ซื้อกับไม่ซื้อมี rating ที่แตกต่างกันมากไหม โดยให้ค่าความสำคัญที่ 5% ที่สามารถแตกต่างกันได้

**วิธีทำ**

1.) Hypothesis rating โดยใช้การสุ่มกลุ่มตัวอย่าง จากข้อมูล 2 ชุดที่มีจำนวนเท่ากัน 100 ชุด โดยตั้งสมมุติฐานว่า

- H0: mean_pop_rating_paid = mean_pop_rating_free
- Ha: mean_pop_rating_paid != mean_pop_rating_free

**test type (ทดสอบในลักษณะ):** two tail แบบ upper tail

----

2.) ตั้งกลุ่มตัวอย่าง 100 ตัวในข้อมูลในแต่ละชุดคือชุดที่จ่ายเงินกับชุดที่ไม่จ่ายเงินของ แต่ละ course

```{R}
sample_rating_is_paid <- sample(Udemy$rating[Udemy$is_paid == "True"], 100, replace = F)
sample_rating_is_paid
sample_rating_is_free <- sample(Udemy$rating[Udemy$is_paid == "False"], 100, replace = F)
sample_rating_is_free
```

----

3.) เตรียมเครื่องมือเอาไว้ใช้ในการคำนวณเครื่องมือทางสถิติ โดยหา จำนวนข้อมูลในแต่ละชุดโดยแยกข้อมูลออกจากกัน, ค่าเฉลี่ยของประชากรแต่ละชุด, ค่าเฉลี่ยของกลุ่มตัวอย่างแต่ละชุด, ส่วนเบี่ยงเบนมาตราฐานที่รู้แต่ละชุด

```{R}
n_rating_paid <- 100
n_rating_free <- 100
mean_pop_rating_paid <- mean(Udemy$rating[Udemy$is_paid == "True"])
mean_pop_rating_free <- mean(Udemy$rating[Udemy$is_paid == "False"])
mean_rating_paid <- mean(sample_rating_is_paid)
mean_rating_free <- mean(sample_rating_is_free)
sd_known_rating_paid <- sd(Udemy$rating[Udemy$is_paid == "True"])
sd_known_rating_free <- sd(Udemy$rating[Udemy$is_paid == "False"])
```

----

4.) หา standard error และ ค่ามาตราฐาน (z-test)

```{R}
sd_error_rating <- sqrt(sd_known_rating_paid^2/n_rating_paid+sd_known_rating_free^2/n_rating_free)
z_rating <- ((mean_rating_paid-mean_rating_free)-(mean_pop_rating_paid-mean_pop_rating_free))/sd_error_rating
z_rating
```

----

5.) หาค่า p-value โดยที่ p-value ไม่ควรเกิน 0.5 จึงทำเงื่อนไขตาม R syntax

```{R}
if(z_rating < 0){
  p_rating <- pnorm(z_rating)
} else {
  p_rating <- 1-pnorm(z_rating)
}
```

----

6.) สรุปผล 

```{R}
# p-value
if(p_rating < 0.05/2){
  print("Reject H0")
} else {
  print("Accept H0")
}
# critical value
if(z_rating > qnorm(1-0.05/2)){
  print("Reject H0")
} else {
  print("Accept H0")
}
```

### ถ้าเราอยากรู้ว่าข้อมูลที่เราใช้ในการทดสอบคาดการณ์ว่ามีผลต่างของข้อมูลอยู่ในช่วงไหน

เราต้องหา margin error

```{R}
# ถ้าหากเราจะไปทำนายหาช่วงผลต่างของ rating ที่จ่ายด้วยเงินและไม่จ่ายด้วยเงิน
margin_rating <- qnorm(1-0.05/2)*sd_error_rating
margin_rating
```

หาค่าสูงสุดและต่ำสุดที่เป็นไปได้

```{R}
# upper value
upper_rating <- abs(mean_rating_paid-mean_rating_free) + margin_rating
upper_rating

# lower value
lower_rating <- abs(mean_rating_paid-mean_rating_free) - margin_rating
lower_rating
```

### ตัวอย่างข้อมูลที่สุ่มออกมาใช้ในการทดสอบ

sample is paid rating by n = 100

```{R}
# [1] 3.94945 4.14795 4.66057 4.35504 4.55401 4.56240 2.00000 4.57799 4.33636 2.93186
# [11] 3.60035 3.91849 4.36840 4.61793 4.38520 2.47247 3.81780 3.63925 4.58543 4.38030
# [21] 4.21049 4.19113 5.00000 2.80897 4.89543 4.79492 3.92075 4.73606 4.20583 4.78134
# [31] 4.10000 4.63867 4.05345 4.56246 4.34425 4.22471 4.88821 4.67703 4.16000 4.43382
# [41] 4.11458 4.49054 3.91908 4.31248 4.52021 3.75936 4.28778 4.33648 3.86469 4.51779
# [51] 3.97261 3.40142 3.96048 0.00000 2.85834 4.56611 4.62871 4.05963 4.33540 4.22954
# [61] 4.55241 3.85204 3.84667 3.89128 4.10302 4.24844 4.02976 4.28173 4.30664 4.42281
# [71] 4.73625 2.70729 4.47386 4.00153 3.58243 4.27064 3.92559 4.28619 2.90401 4.35076
# [81] 4.40367 4.23163 4.18657 4.07095 3.55283 4.17347 3.31548 3.34162 4.53329 4.49135
# [91] 4.90196 4.06397 3.72520 3.99918 3.83553 3.97387 4.74109 4.24397 3.58698 4.06257
```

sample is free rating by n = 100

```{R}
# [1] 3.75213 4.14571 4.13750 3.89460 4.17271 3.50000 4.06563 4.58665 4.10678 4.40525
# [11] 4.00000 0.00000 3.84598 5.00000 4.38160 4.38556 4.25875 0.00000 4.20942 3.53047
# [21] 3.84792 4.02083 4.58019 4.24133 4.34252 4.19693 3.33148 3.83048 4.24015 3.73411
# [31] 4.44648 4.29982 3.81307 4.40483 3.08827 4.35902 4.41875 3.85280 3.70693 4.27452
# [41] 4.11127 4.59946 4.44332 3.00000 4.87276 4.42527 4.37402 4.11986 3.72713 4.61725
# [51] 0.00000 4.31090 4.20072 4.25665 4.59504 4.05951 4.12339 4.23459 0.00000 0.00000
# [61] 4.18113 3.92760 4.29007 4.51729 4.59369 4.06067 3.96070 4.04902 4.05323 4.32281
# [71] 4.22472 4.74157 4.03237 3.94719 4.83056 4.30133 4.12517 4.12463 4.52387 4.00000
# [81] 4.20644 3.65905 4.00888 4.46141 3.74929 3.99102 3.77589 3.89936 4.71842 4.13518
# [91] 4.28257 4.21348 4.53623 4.32703 4.21097 4.52087 3.95332 4.26935 4.42219 4.37794
```

----

เตรียมเครื่องมือเอาไว้ใช้ในการคำนวณเครื่องมือทางสถิติ

หาค่าเฉลี่ยของข้อมูลในแต่ละชุด

> mean population rating paid is 3.909139

> mean population rating free is 3.994254

> mean sample rating paid is 4.078325

> mean sample rating free is 3.960068

หาค่าส่วนเบี่ยงเบนมาตราฐาน

> standard deviation known of rating paid is 1.045568

> standard deviation known of rating free is 0.8518249

หาค่า standard error

> standard error of rating is 0.1348636

หาค่า z-test

> z-test of sample rating is 1.507981

หาค่า p-value

> p-value of sample rating is 0.06577976

ทดสอบว่าต่ำกว่าค่าความสำคัญเท่ากับ 5% ไหม

> conclusion by significant value 5%, p-value is "Accept H0" and critical-value is "Accept Ho"

**สรุป** ข้อมูลทั้ง 2 ชุดคือ course ที่จ่ายและไม่จ่ายด้วยเงินต่างมีข้อมูล rating ที่ไม่แตกต่างกันมาก

----

### เมื่อนำข้อมูลไปคาดการณ์ ถึงความแตกต่างกันระหว่าง ค่าเฉลี่ย rating ของ course ที่จ่ายเงินกับไม่จ่ายเงิน

> margin error of rating is 0.2643277

> upper value is 0.3825848

> lower value is -0.1460706

**สรุป** ข้อมูลทั้งสองชุด คาดการณ์ว่ามีผลต่างของ rating ในช่วงของ 0 ถึง 0.3826
