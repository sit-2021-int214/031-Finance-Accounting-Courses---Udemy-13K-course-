install.packages("dplyr")
install.packages("readr")
install.packages("stringr")
install.packages("ggplot2")
lnstall.packages("assertive")

library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(assertive)

ProgBook <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/prog_book.csv")

View(ProgBook)

# Explore data
glimpse(ProgBook)
# Rows: 271
# Columns: 7
# $ Rating          <dbl> 4.17, 4.01, 3.33, 3.97, 4.06, 3.84, 4.09, 4.15, 3.87, 4.62, 4.03, 3.78, 3.~
# $ Reviews         <chr> "3,829", "1,406", "0", "1,658", "1,325", "117", "5,938", "1,817", "2,093",~
# $ Book_title      <chr> "The Elements of Style", "The Information: A History, a Theory, a Flood", ~
# $ Description     <chr> "This style manual offers practical advice on improving writing skills. Th~
# $ Number_Of_Pages <int> 105, 527, 50, 393, 305, 288, 256, 368, 259, 128, 352, 352, 200, 328, 240, ~
# $ Type            <chr> "Hardcover", "Hardcover", "Kindle Edition", "Hardcover", "Kindle Edition",~
# $ Price           <dbl> 9.323529, 11.000000, 11.267647, 12.873529, 13.164706, 14.188235, 14.232353~

# Column name
# Rating: The user rating for the book. the rating score ranges between 0 and 5.
# Reviews: The number of reviews found on this book.
# Book_title: The name of the book.
# Description: a short description of the book.
# Number of page: Number of pages in the book
# Type: The type of the book meaning is it a hardcover book or an ebook or a kindle book etc.
# Price: The average price of the book in USD where the average is calculated according the 5 web sources.


# Data cleaning
# check duplicate data
ProgBook %>% duplicated() %>% table() # 0 row are duplicated

# remove , from review because if change type of value then some values are NA.
ProgBook$Reviews <- ProgBook$Reviews %>% str_remove(",")

# change type of value of review from character to integer
ProgBook$Reviews <- as.integer(ProgBook$Reviews)

# replace value of type book from "Boxed Set - Hardcover" to "Hardcover"
ProgBook$Type <- replace(ProgBook$Type,ProgBook$Type == "Boxed Set - Hardcover", "Hardcover")

# Data analysis

# find top 10 books title have most rating
TopRating <- ProgBook %>% select(Book_title,Rating) %>% arrange(desc(Rating)) %>% head(10)
TopRating
#                                                                                                  Book_title  Rating
# 1                                                                                   Your First App: Node.js   5.00
# 2                                                   The Art of Computer Programming, Volumes 1-4a Boxed Set   4.77
# 3  Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems   4.72
# 4               Build Web Applications with Java: Learn every aspect to build web applications from scratch   4.67
# 5                                                  Fluent Python: Clear, Concise, and Effective Programming   4.67
# 6                                           ZX Spectrum Games Code Club: Twenty fun games to code and learn   4.62
# 7                             The Linux Programming Interface: A Linux and Unix System Programming Handbook   4.62
# 8                                                                          CLR via C# (Developer Reference)   4.58
# 9                       The Elements of Computing Systems: Building a Modern Computer from First Principles   4.54
# 10                                                                 Practical Object Oriented Design in Ruby   4.54

# find top 10 books title have most number of page
TopPage <- ProgBook %>% select(Book_title,Number_Of_Pages) %>% arrange(desc(Number_Of_Pages)) %>% head(10)
TopPage
#                                                                       Book_title Number_Of_Pages
# 1                        The Art of Computer Programming, Volumes 1-4a Boxed Set            3168
# 2  The Linux Programming Interface: A Linux and Unix System Programming Handbook            1506
# 3                             Numerical Recipes: The Art of Scientific Computing            1235
# 4                                                                Learning Python            1214
# 5                                                               Beginning Java 2            1200
# 6                                                     Introduction to Algorithms            1180
# 7                                                       Database System Concepts            1142
# 8                                          Modern Operating Systems, 4th Edition            1136
# 9                             The C++ Standard Library: A Tutorial and Reference            1136
# 10                                    Artificial Intelligence: A Modern Approach            1132


# find count in each type book
TypeBook <- ProgBook %>% count(Type) %>% summarise(TypeBook=Type,count=n) 
TypeBook
#          TypeBook count
# 1           ebook     7
# 2       Hardcover    96
# 3  Kindle Edition    10
# 4       Paperback   156
# 5 Unknown Binding     2

# find average of rating, review, number of page and price in each Type of book
AverageTypeBook <- ProgBook %>%
  group_by(Type) %>%
  select(Rating,Reviews,Number_Of_Pages,Price) %>%
  summarise(avg_rating=mean(Rating),
            avg_review=mean(Reviews),
            avg_number_page=mean(Number_Of_Pages),
            avg_price=mean(Price)
            )
AverageTypeBook
# # A tibble: 5 x 5
#   Type            avg_rating avg_review avg_number_page avg_price
#   <chr>                <dbl>      <dbl>           <dbl>     <dbl>
# 1 ebook                 4.29       51.4            386       51.4
# 2 Hardcover             4.06      312.             617.      71.7
# 3 Kindle Edition        4.01      156.             283.      32.4
# 4 Paperback             4.06      116.             407.      45.8
# 5 Unknown Binding       3.99      124.             249       37.2

# Data Visualization

# Histogram
# show histogram of rating book by bandwidth = 0.5.
HistRating <- ProgBook %>% ggplot(aes(x=Rating)) + geom_histogram(fill="gold",col="white",binwidth=0.5)
HistRating + ggtitle("Number show rating book") +
  xlab("Rating") + ylab("Count")

# show histogram of number of page book by bandwidth = 100.
HistPage <- ProgBook %>% ggplot(aes(x=Number_Of_Pages)) + geom_histogram(fill="maroon",col="gold",binwidth=100)
HistPage + ggtitle("Number show number of page book") +
  xlab("Number of page") + ylab("Count")

# Bar chart
# show top 5 type book have the most reviews in each type book.
BarTypeTopAvgReview <- AverageTypeBook %>% ggplot(aes(x=reorder(Type, -avg_review),y=avg_review)) + geom_bar(stat = "identity",fill="purple",col="violet")
BarTypeTopAvgReview + ggtitle("Top 5 type books have the most average reviews") +
  xlab("") + ylab("average of Review")

# show top 5 type book have the most average price in each type book.
BarTypeTopAvgPrice <- AverageTypeBook %>% ggplot(aes(x=reorder(Type, -avg_price),y=avg_price)) + geom_bar(stat = "identity",fill="lightgreen",col="green")
BarTypeTopAvgPrice + ggtitle("Top 5 type books have the most average price") +
  xlab("") + ylab("average of price")

# Pie chart
# show count of book in type of book to pie chart.
PieTypeBook <- ggplot(TypeBook,aes(x="",y=count,fill = TypeBook)) +
  geom_col() + coord_polar(theta = "y")
PieTypeBook + ggtitle("Number show each type of book") + xlab("") + ylab("All book have 271 books")

# Scatter plot 
# compare rating and reviews by show each type of book are different.
ScatterRatingReview <- ProgBook %>% ggplot(aes(x=Rating,y=Reviews)) + geom_point(aes(color=Type))
ScatterRatingReview <- ProgBook %>% filter(Reviews<=100) %>% ggplot(aes(x=Rating,y=Reviews)) + geom_point(aes(color=Type))
ScatterRatingReview + ggtitle("Compare rating and review by type of book by Review") + xlab("Rating") + ylab("Reviews")

# Uncertainly scatter plot
# compare number of page and price by show each type of book are different and predict it is possible? if book have more page, price of book is increase.
UncertainlyRatingReview <- ProgBook %>% ggplot(aes(x=Price,y=Number_Of_Pages)) + geom_point(aes(color=Type)) + geom_smooth()
UncertainlyRatingReview + ggtitle("Compare and predict page of book with price by type of book") + xlab("Price") + ylab("")
# Yes, if book have more page, price of book is increase.

# Box plot
# show rating in each type book.
BoxRating <- ProgBook %>% ggplot(aes(x=Type,y=Rating)) + geom_boxplot(aes(color=Type)) + geom_dotplot(aes(color=Type),binaxis='y', stackdir='center', dotsize=0.3)
BoxRating