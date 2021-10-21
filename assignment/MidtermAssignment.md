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

# and replace by string with â¹+amount with mutate
# discount price
Udemy <- Udemy %>% mutate(discount_price__price_string=paste("â¹",discount_price__amount))
# note your can't use character plus character by character + character but can use paste(x1,x2,...,(collapse="-")[optional])
# price detail
Udemy <- Udemy %>% mutate(price_detail__price_string=paste("â¹",price_detail__amount))
```
