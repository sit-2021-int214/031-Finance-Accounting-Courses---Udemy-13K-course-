## 1. install Package readr assertive stringr dplyr.
install.packages("readr")
install.packages("assertive")
install.packages("stringr")
install.packages("dplyr")
install.packages("ggplot")
install.packages("tidyverse")
install.packages("lubridate")


## 2. import package readr assertive stringr dplyr.
library(dplyr)
library(readr)
library(assertive)
library(stringr)
library(lubridate)
library(tidyverse)



## 3. Import data csv check data type with glimpse
superData <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/superstore_sales.csv")
View(superData)
glimpse(superData)



## 4. Cleaning Data Change  and Ship.Date from chr to Date , Ship.Date to date type by dmy from lubridate
superData$Order.Date <- dmy(superData$Order.Date)
superData$Ship.Date <- dmy(superData$Ship.Date)
glimpse(superData)

## 5. Exploring data

### 5.1 Which city has sales more than sales average
result1 <- superData %>% group_by(City) %>% summarise(mean = mean(Sales,na.rm = TRUE)) %>% select(City,mean) %>% filter(mean >= mean(superData$Sales, na.rm = TRUE))
view(result)
write.csv(result,"D:\\sit\\int214\\project\\HW04\\HW04_62130500133\\result\\result1.csv", row.names = FALSE)

### 5.2 list orderId and order.date has order.date after 30/12/2018
result2 <- superData %>% select(Order.ID,Order.Date) %>% filter(Order.Date >= dmy("30/12/2018"))
print(result2)

### 5.3 find mean of Home office segment sales
result3 <- superData %>% filter(Segment == "Home Office") %>% summarise(mean = mean(Sales,na.rm = TRUE))
print(result3)

### 5.4 Which Ship mode use the most by Home office segment
result4 <- superData %>% filter(Segment == "Home Office") %>% count(couting = Ship.Mode) %>% filter(couting == max(couting))
print(result4)

### 5.5 find min sales of each city sort by sales min
result5 <- superData %>% group_by(City) %>% summarise(min_Sales = min(Sales)) %>% arrange(min_Sales)
print(result5)

### 5.6 find city has max sales
result6 <- superData %>% select(City,Sales) %>% filter(Sales == min(Sales))
print(result6)




## Part 2 Graph
# 1. Creating a Bar Graph for list average Sales of each state

#Find mean of each state Sales table to use port graph
meanToplot <- superData %>% group_by(State) %>% summarise(avg = mean(Sales))
view(meanToplot)

meanToplotGraph <- meanToplot %>% ggplot(aes(x = State, y = avg)) + geom_bar(stat="identity", fill="orange") +
  geom_text(aes(label=format(round(avg, 0), nsmall = 0)), vjust=1, color = "black", size = 3.5) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

meanToplotGraph + ggtitle("Average Sales of each state") + xlab("State") + ylab("Number of average Sales")

# 2. Box plot Sub category Sales
predictGraph <- superData %>% ggplot(aes(x = Sub.Category , y = Sales)) + geom_boxplot(aes(color = Sub.Category)) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
predictGraph + ggtitle("Scatter plot from Sales and Sub category") + xlab("Sub.Category") + ylab("Sales")

## Part 3 Example of StringR
DataProducts <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/products_original.csv")
glimpse(DataProducts)
# 1. in colunm price is not number and has "THB"
# use remove string "THB"
DataProducts$price <- str_remove(DataProducts$price,"THB")
# use remove string ","
DataProducts$price <- str_remove(DataProducts$price,",")
# Change data TYPE chr to dbl
DataProducts$price <- as.double(DataProducts$price)
glimpse(DataProducts)
View(DataProducts)




