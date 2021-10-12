
# https://docs.google.com/forms/u/0/d/e/1FAIpQLSeXjJDtFAXQETIuk0b0vBxQIVhlki1tAGhRhvSVLEFOIFoklg/formResponse?edit2=2_ABaOnucn0LBiiR2SwrE5crXpBQnZ0HN4GLYEGjTRUuEfYA_a_iww9qYM0lBDQayZ8Q

## Step 0: install package and Loading library and explore datasets

# install all package
install.packages("DescTools")
install.packages("MASS")
install.packages("dplyr")
install.packages("readr")
install.packages("assertive")
install.packages("stringr")

# library all package
library(DescTools)
library(Mass)
library(dplyr)
library(readr)
library(assertive)
library(stringr)

# import datasets
SAT <- read_csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")

SAT
View(SAT)

## Define a question

# 1. How many observation of this dataset (before cleaning) ?

glimpse(SAT)
# Rows 485
# Columns 5

# 2. Are there duplicate data sets ? (If have duplicate data, list the data that duplicate)

SAT %>% duplicated() %>% sum()
SAT %>% duplicated() %>% table()
# yes 

SAT %>% filter(duplicated(SAT))
# list duplicate data

# 3. How many distinct school in this dataset ? (Know after drop duplicate data)
SAT <- SAT %>% distinct()

SAT %>% select(school_name) %>% distinct(school_name) %>% count()
# 478 distinct schools

# data cleaning in case of s score
# Handling String with stringr by remove s score
SAT$math_score <- SAT$math_score %>% str_remove("s")
SAT$reading_score <- SAT$reading_score %>% str_remove("s")
SAT$writing_score <- SAT$writing_score %>% str_remove("s")

# Changing the types of values
SAT$math_score <- as.numeric(SAT$math_score)
SAT$reading_score <- as.numeric(SAT$reading_score)
SAT$writing_score <- as.numeric(SAT$writing_score)

# Replace score with 200
SAT$math_score <- replace(SAT$math_score,is.na(SAT$math_score),200)
SAT$reading_score <- replace(SAT$reading_score,is.na(SAT$reading_score),200)
SAT$writing_score <- replace(SAT$writing_score,is.na(SAT$writing_score),200)

# Clearing of outliner data
# case of STUYVESANT HIGH SCHOOL
SAT$math_score <- replace(SAT$math_score,SAT$math_score == 7735,735)

# case of BRONX COMMUNITY HIGH SCHOOL
SAT$math_score <- replace(SAT$math_score,SAT$math_score == 969,369)

# case of RICHARD R. GREEN HIGH SCHOOL OF TEACHING
SAT$writing_score <- replace(SAT$writing_score,SAT$writing_score == 4030,403)

# case of score lower than 200
SAT$math_score <- replace(SAT$math_score,SAT$math_score<200,200)
SAT$reading_score <- replace(SAT$reading_score,SAT$reading_score<200,200)
SAT$writing_score <- replace(SAT$writing_score,SAT$writing_score<200,200)

# 4. What is min, max, average, quantile of each part in SAT ?
SAT %>%
  select(math_score) %>%
  summarise(min=min(math_score),max=max(math_score),mean=mean(math_score),q1=quantile(math_score,0.25),median=quantile(math_score,0.5),q3=quantile(math_score,0.75))

SAT %>%
  select(reading_score) %>%
  summarise(min=min(reading_score),max=max(reading_score),mean=mean(reading_score),q1=quantile(reading_score,0.25),median=quantile(reading_score,0.5),q3=quantile(reading_score,0.75))

SAT %>%
  select(writing_score) %>%
  summarise(min=min(writing_score),max=max(writing_score),mean=mean(writing_score),q1=quantile(writing_score,0.25),median=quantile(writing_score,0.5),q3=quantile(writing_score,0.75))

# 5. What is min, max, average, quantile of total score in SAT ?

#create column sum_score
SAT <- SAT %>% mutate(sum_score = math_score+reading_score+writing_score)

SAT %>%
  summarise(min=min(sum_score),max=max(sum_score),mean=mean(sum_score),q1=quantile(sum_score,0.25),median=quantile(sum_score,0.5),q3=quantile(sum_score,0.75))


# 6. Which school is get highest SAT score ?
SAT %>%
  select(school_name,sum_score) %>%
  filter(sum_score == max(sum_score))
# STUYVESANT HIGH SCHOOL