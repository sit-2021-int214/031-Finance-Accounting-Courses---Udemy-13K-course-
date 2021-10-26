install.packages("readr")
install.packages("assertive")
install.packages("stringr")
install.packages("dplyr")
install.packages("ggplot2")

library("readr")
library("assertive")
library("stringr")
library("dplyr")
library("ggplot2")

data <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/superstore_sales.csv")

glimpse(data)

# explore data by issues
# 1) show order.id,order.date, customer.id and customer.name of customer who lives in city Los Angeles
data %>% filter(City=="Los Angeles")%>% select(Order.ID,Order.Date,Customer.ID,Customer.Name) 

# 2) show postal code,id,and name of customer who use segment term consumer and lives central in central region
data %>% filter(Region=="Central",Segment=="Consumer") %>% select(Postal.Code,Customer.ID,Customer.Name)

# 3) How many item each customer order on each categories 
data %>% group_by(Category) %>% count(Category,Customer.Name) 

data %>% distinct(Ship.Mode)
# 4) How many Bookcase were shipped in first class to Kentucky
data %>% filter(Sub.Category=="Bookcases",Ship.Mode=="First Class",State=="Kentucky") %>% count(Order.ID)

# 5) How many order came from California by a Corporate in each day 
data %>% filter(Segment=="Corporate",State=="California") %>% group_by(Order.Date) %>% count(Order.Date)

# 6) what are the name of customer who
# - lives in Florida
# - Order a standard class chairs as Home office
 data %>% filter(Segment=="Home Office",State=="Florida",Sub.Category=="Chairs",Ship.Mode=="Standard Class") %>% distinct(Customer.Name)
 
 #using ggplot2
 
#1. show the amount Sales of items in each categories order by home office. that less than 1000
 
 data %>% filter(Segment=="Home Office",Sales<1000)  %>% ggplot(aes(x=Sales,y=Category))+geom_point()
 
#2. show how many order came from each state
 
 state_each <- ggplot(data,aes(y=State))+geom_bar()
 state_each + ggtitle("Order that came from each state") +
                        xlab("Orders") + ylab("States")
 
 
 