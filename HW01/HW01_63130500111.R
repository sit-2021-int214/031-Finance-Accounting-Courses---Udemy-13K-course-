#Exercise 1
#Finding the average, sum, median, s.d., variance of 10.4, 5.6, 3.1, 6.4, 21.7
x <- c(10.4,5.6,3.1,6.4,21.7)
#Sum
sum(x) #47.2
#average
sum(x)/length(x) #9.44
#median
median(x) #6.4
#s.d.
sd(x) #7.33846
#variance
sd(x)*sd(x) #53.853

#Exercise 2
#2.1. Create data structure in variable named marvel_movies and explain why you using this data structure ?

# List of Marvel movies (Order by Marvel Phase released)
names <- c("Iron Man","The Incredible Hulk","Iron Man 2","Thor","Captain America: The First Avenger",
           "The Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier",
           "Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War",
           "Doctor Strange","Guardians of the Galaxy 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther",
           "Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame",
           "Spider-Man: Far From Home","WandaVision","Falcon and the Winter Soldier","Loki","Black Widow")

# List of released year of Marvel movies
years <- c(2008,2008,2010,2011,2011,2012,rep(2013:2016,each=2),
           rep(2017,4),rep(2018,2),rep(2019,3),rep(2021,4))
#this function took less time to code

marvel_movies <- data.frame(MovieNaeme = names,Releaseyear = years)
View(marvel_movies)
#using data.frame make the result easier to understand

#2.2 Finding the information:
#-The numbers of movies
length(names) #27
#Finding the 19th movies name
names[19] #"Avengers: Infinity War"
#Which year is most released movies (In this question can using observation data, not necessary to used command to find answer)
#2021