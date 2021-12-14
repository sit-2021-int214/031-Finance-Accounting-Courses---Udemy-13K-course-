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

# Explore data 
glimpse(UdemyCSV) #data of Udemy have 13608 rows and 20 columns by each columns have

# id : The course ID of that particular course.
# title : Shows the unique names of the courses available under the development category on Udemy.
# url: Gives the URL of the course.
# is_paid : Returns a boolean value displaying true if the course is paid and false if otherwise.

# num_subscribers : Shows the number of people who have subscribed that course.
# avg_rating : Shows the average rating of the course.
# avg rating recent : Reflects the recent changes in the average rating.
# rating : Reflects the recent changes in the average rating.
# num_reviews : Gives us an idea related to the number of ratings that a course has received.
# is_wishlisted : Show course who are favorite by marked wishlist.

# num_ published_lectures : Shows the number of lectures the course offers.
# num_ published_ practice_tests : Gives an idea of the number of practice tests that a course offers.

# created : The time of creation of the course.
# published_time : Time of publishing the course.

# discounted_ price_amount : The discounted price which a certain course is being offered at.
# discounted_ price_currency : The currency corresponding to the discounted price which a certain course is being offered at.
# discounted_ price_price_string :

# price_ detail_amount : The original price of a particular course.
# price_ detail_currency : The currency corresponding to the price detail amount for a course.
# price_ detail_price_string : 

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

# and replace by string with current+amount with mutate
# discount price
Udemy <- Udemy %>% mutate(discount_price__price_string=paste(discount_price__currency,discount_price__amount))
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional])
# price detail
Udemy <- Udemy %>% mutate(price_detail__price_string=paste(price_detail__currency,price_detail__amount))

# find title name, rating, number of subscribers and number of reviews who are top of 10 courses have the most reviews in each course
Udemy %>%
  select(title,rating,num_subscribers,num_reviews) %>%
  arrange(desc(num_reviews)) %>%
  summarise(title,rating,subscribe=num_subscribers,reviews=num_reviews) %>%
  head(10)
# result from output:
# show the The Complete SQL Bootcamp 2020: Go from Zero to Hero have the most reviews
#                                                           title  rating subscribe reviews
# 1          The Complete SQL Bootcamp 2020: Go from Zero to Hero 4.67874    295509   78006
# 2  Tableau 2020 A-Z: Hands-On Tableau Training for Data Science 4.60015    209070   54581
# 3                        PMP Exam Prep Seminar -  PMBOK Guide 6 4.59326    155282   52653
# 4                    The Complete Financial Analyst Course 2020 4.53772    245860   46447
# 5  An Entire MBA in 1 Course:Award Winning Business School Prof 4.47173    374836   41630
# 6   Microsoft Power BI - A Complete Introduction [2020 EDITION] 4.57676    124180   38093
# 7  Agile Crash Course: Agile Project Management; Agile Delivery 4.29118     96207   30470
# 8    Beginner to Pro in Excel: Financial Modeling and Valuation 4.53346    127680   28665
# 9     Become a Product Manager | Learn the Skills & Get the Job 4.50080    112572   27408
# 10                The Business Intelligence Analyst Course 2020 4.49575    115269   23906

# find number of courses and price detail of amount who are top of 15 courses have the most price detail of amount course
Udemy %>%
  count(amount=price_detail__amount) %>%
  arrange(desc(amount)) %>%
  head(15)

# result from output:
# show 123 courses have amount of detail price is 12800 rupee
# 8 course have amount of detail price is 12480 rupee
# and 4 course have amount of detail price is 12160 rupee
#    amount    n
# 1   12800  123
# 2   12480    8
# 3   12160    4
# 4   11840    6
# 5   11520    4
# 6   11200    3
# 7   10880    2
# 8   10560    2
# 9   10240    8
# 10   9920    3
# 11   9600   52
# 12   9280   34
# 13   8960   52
# 14   8640 3213
# 15   8320   71

# show your summarise of course who are paid and not paid with
# count of course, average of rating, average of subscribes,
# max of subscribe and average of review and max of review

Udemy %>% count(is_paid) %>% summarise(is_paid,count_course=n)
# show result counting of paid and not paid course
#   is_paid count_course
# 1   False          496
# 2    True        13112

Udemy %>% group_by(is_paid) %>% 
  select(rating,num_subscribers,num_reviews) %>%
  summarise(average_rating = mean(rating, na.rm = TRUE),
            average_subscribes = mean(num_subscribers,na.rm=TRUE),
            max_subscribes = max(num_subscribers,na.rm=TRUE),
            average_reviews = mean(num_reviews, na.rm=TRUE),
            max_reviews = max(num_reviews, na.rm=TRUE)
            )
# show result average rating,average and max subscribes and average and max reviews of paid and non paid course
#   is_paid average_rating average_subscribes max_subscribes average_reviews max_reviews
#   <chr>            <dbl>              <dbl>          <int>           <dbl>       <int>
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


# Data visualization can code here!!





# Analytically Inferential Statistics
# Topic (โจทย์): ถ้าเราอยากจะรู้ว่าข้อมูลการซื้อขายของ course ที่ซื้อกับไม่ซื้อมี rating ที่แตกต่างกันมากไหมและมี จำนวนผู้ติดตามมากน้อยแค่ไหน โดยให้ค่าความสำคัญที่ 5% ที่สามารถแตกต่างกันได้

# Hypothesis rating โดยใช้การสุ่มกลุ่มตัวอย่าง จากข้อมูล 2 ชุดที่มีจำนวนเท่ากัน 100 ชุด
# H0: mean_pop_rating_paid = mean_pop_rating_free
# Ha: mean_pop_rating_paid != mean_pop_rating_free
# test type: two tail: upper tail
sample_rating_is_paid <- sample(Udemy$rating[Udemy$is_paid == "True"], 100, replace = F)
sample_rating_is_paid
sample_rating_is_free <- sample(Udemy$rating[Udemy$is_paid == "False"], 100, replace = F)
sample_rating_is_free

# ช่วงเตรียมอุปกรณ์
n_rating_paid <- 100
n_rating_free <- 100
mean_pop_rating_paid <- mean(Udemy$rating[Udemy$is_paid == "True"])
mean_pop_rating_free <- mean(Udemy$rating[Udemy$is_paid == "False"])
mean_rating_paid <- mean(sample_rating_is_paid)
mean_rating_free <- mean(sample_rating_is_free)
sd_known_rating_paid <- sd(Udemy$rating[Udemy$is_paid == "True"])
sd_known_rating_free <- sd(Udemy$rating[Udemy$is_paid == "False"])

# หาค่า z value ในการทดสอบ
sd_error_rating <- sqrt(sd_known_rating_paid^2/n_paid+sd_known_rating_free^2/n_free)
z_rating <- ((mean_rating_paid-mean_rating_free)-(mean_pop_rating_paid-mean_pop_rating_free))/sd_error_rating
z_rating

# หาค่า p value ในการทดสอบ
if(z_rating < 0){
  p_rating <- pnorm(z_rating)
} else {
  p_rating <- 1-pnorm(z_rating)
}
p_rating

# สรุปผล
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

# ถ้าหากเราจะไปทำนายหาช่วงผลต่างของ rating ที่จ่ายด้วยเงินและไม่จ่ายด้วยเงิน
margin_rating <- qnorm(1-0.05/2)*sd_error_rating
margin_rating

# upper value
upper_rating <- abs(mean_rating_paid-mean_rating_free) + margin_rating
upper_rating

# lower value
lower_rating <- abs(mean_rating_paid-mean_rating_free) - margin_rating
lower_rating

# ตัวอย่างการทดสอบ

# sample is paid rating by n = 100
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

# sample is free rating by n = 100
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

# mean population rating paid is 3.909139
# mean population rating free is 3.994254
# mean sample rating paid is 4.078325
# mean sample rating free is 3.960068

# standard deviation known of rating paid is 1.045568
# standard deviation known of rating free is 0.8518249

# standard error of rating is 0.1348636

# z-test of sample rating is 1.507981

# p-value of sample rating is 0.06577976

# conclusion by significant value 5%, p-value is "Accept H0" and critical-value is "Accept Ho"

# สรุปข้อมูลทั้ง 2 ชุดคือ course ที่จ่ายและไม่จ่ายด้วยเงินต่างมีข้อมูล rating ที่ไม่แตกต่างกันมาก

# เมื่อนำข้อมูลไปคาดการณ์ ถึงความแตกต่างกันระหว่าง ค่าเฉลี่ย rating ของ course ที่จ่ายเงินกับไม่จ่ายเงิน

# margin error of rating is 0.2643277

# upper value is 0.3825848

# lower value is -0.1460706

# สรุปข้อมูลทั้งสองชุด คาดการณ์ว่ามีผลต่างของ rating ในช่วงของ 0 ถึง 0.3826

# Hypothesis subscribes โดยใช้การสุ่มกลุ่มตัวอย่าง จากข้อมูล 2 ชุดที่มีจำนวนเท่ากัน 100 ชุด
# H0: mean_pop_sub_paid = mean_pop_sub_free
# Ha: mean_pop_sub_paid != mean_pop_sub_free
# curve type: two tail: upper tail
sample_sub_is_paid <- sample(Udemy$num_subscriber[Udemy$is_paid == "True"], 100, replace = F)
sample_sub_is_paid
sample_sub_is_free <- sample(Udemy$num_subscriber[Udemy$is_paid == "False"], 100, replace = F)
sample_sub_is_free

# ช่วงเตรียมอุปกรณ์
n_paid <- 100
n_free <- 100
mean_pop_sub_paid <- mean(Udemy$num_subscriber[Udemy$is_paid == "True"])
mean_pop_sub_free <- mean(Udemy$num_subscriber[Udemy$is_paid == "False"])
mean_sub_paid <- mean(sample_sub_is_paid)
mean_sub_free <- mean(sample_sub_is_free)
sd_known_sub_paid <- sd(Udemy$num_subscriber[Udemy$is_paid == "True"])
sd_known_sub_free <- sd(Udemy$num_subscriber[Udemy$is_paid == "False"])

# หาค่า z value ในการทดสอบ
sd_error_sub <- sqrt(sd_known_sub_paid^2/n_paid+sd_known_sub_free^2/n_free)
z_sub <- ((mean_sub_paid-mean_sub_free)-(mean_pop_sub_paid-mean_pop_sub_free))/sd_error_sub
z_sub

# หาค่า p value ในการทดสอบ
if(z_sub < 0){
  p_sub <- pnorm(z_sub)
} else {
  p_sub <- 1-pnorm(z_sub)
}
p_sub

# สรุปผล
# p-value
if(p_sub < 0.05/2){
  print("Reject H0")
} else {
  print("Accept H0")
}
# critical value
if(z_sub > qnorm(1-0.05/2)){
  print("Reject H0")
} else {
  print("Accept H0")
}

# ถ้าหากเราจะไปทำนายหาช่วงผลต่างของ rating ที่จ่ายด้วยเงินและไม่จ่ายด้วยเงิน
margin_sub <- qnorm(1-0.05/2)*sd_error_sub
margin_sub

# upper value
upper_sub <- abs(mean_sub_paid-mean_sub_free) + margin_sub
upper_sub

# lower value
lower_sub <- abs(mean_sub_paid-mean_sub_free) - margin_sub
lower_sub

# ตัวอย่างการทดสอบ

# sample is paid number subscribe by n = 100
# [1]  1299   111  1370    21    57    19   423 15118  1616    18    93   175   143 13388
# [15]  2000     5   505   112     0   358   781    79 13388   239  1555  7916    50   513
# [29]    22  2226  1432    18  6376  1583  2245    10   209    56    27  1503   583  2108
# [43] 11707  1081    67    68  5539  1001    37    11    20  2428     7  9464   861    43
# [57]  6476   126  7779    15   371   188   318   105  2630   233  1032    27  5287   102
# [71]  1814     9    41  5479    89     6   654 24842  1437  1239  7107    12   277  1108
# [85] 83126   676  1547   133  3986  1048    90   116   203   135     0  1022   960  1569
# [99]    27   440

# sample is free number subscribe by n = 100
# [1]   751   108  2591   284  8304   122  5908  1913   428  1250  4801    25   485  5375
# [15]  4362    39  2305  1511  4751  1322  3017  2151 12540   831  4651  2118  5774   401
# [29]  7557  1372  9996  1106   314 10920 17254   188   738  7621   324  6187  4472  2648
# [43] 43137    54  1195  8706 11223   798   486   204   409  3147  2927  8479  1072 39295
# [57] 21619   938  5303  2745 21177  1521 10030 14827  2262  9750   460 20233  3934  5168
# [71]  7702   787   214  5592  4103  1146  5691 16532   457  2180   527 14694    47  5340
# [85]  1189   105    19  4175  4844    81  2497 10785  3681  3742    83  3859  1270  6022
# [99]    81  1317

# mean population number subscribe paid is 2732.987
# mean population number subscribe free is 5861.286
# mean sample number subscribe paid is 2759.65
# mean sample number subscribe free is 4986.76

# standard deviation known of number subscribe paid is 9179.169
# standard deviation known of number subscribe free is 14400.34

# standard error of number subscribe is 1707.709

# z-test of sample number subscribe is 0.5277185

# p-value of sample number subscribe is 0.2988474

# conclusion by significant value 5%, p-value is "Accept H0" and critical-value is "Accept Ho"

# สรุปข้อมูลทั้ง 2 ชุดคือ course ที่จ่ายและไม่จ่ายด้วยเงินต่างมีข้อมูล number subscribe ที่ไม่แตกต่างกันมาก

# เมื่อนำข้อมูลไปคาดการณ์ ถึงความแตกต่างกันระหว่าง ค่าเฉลี่ยของ number subscribe ของ course ที่จ่ายเงินกับไม่จ่ายเงิน

# margin error of number subscribe is 3347.048

# upper value is 5574.158

# lower value is -1119.938

# สรุปข้อมูลทั้งสองชุด คาดการณ์ว่ามีผลต่างของผู้ติดตามในช่วงของ 0 ถึง 5574.158 คน

