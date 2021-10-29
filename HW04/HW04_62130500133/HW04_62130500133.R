install.packages("readr")
install.packages("assertive")
install.packages("stringr")
install.packages("dplyr")

library(dplyr)
library(readr)
library(assertive)
library(stringr)

DataProducts <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/products_original.csv")


View(DataProducts)

glimpse(DataProducts)


DataProducts$price <- str_remove(DataProducts$price,"	
THB")