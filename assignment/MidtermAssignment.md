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
