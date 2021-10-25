

list <- read.csv("INT214-Project1.csv")

listitem <- list(list)

View(listitem)

install.packages("DescTools")

library(DescTools)

install.packages("MASS")

library(MASS)

cats <- cats

# 1. find mean of body weighted in kg and heart weighted in g
mean(cats$Bwt) # 2.723611
mean(cats$Hwt) # 10.63056

# 2. find median of body weighted in kg and heart weighted in g
median(cats$Bwt) # 2.7 kg
median(cats$Hwt) # 10.1 g

# 3. the most of gender cat is 
table(cats$Sex) # ans male cat have 97 cats
factCatSex <- factor(cats$Sex) # or
summary(factCatSex) # ans male cat have 97 cats

# 4. standard deviation of body weighted in kg and heart weighted in g
sd(cats$Bwt) # 0.4853066
sd(cats$Hwt) # 2.434636

# 5. Who have coefficient of variation be better? between body weight and heart weight
cvBwt <- sd(cats$Bwt)/mean(cats$Bwt)
print(cvBwt) # 0.178185 or 17.8185%
cvHwt <- sd(cats$Hwt)/mean(cats$Hwt) 
print(cvHwt) # 0.2290224 or 22.90224%
# conclusion the body weight have variance better than heart weight

survey <- survey
# 1. survey the counting of woman who never smoking

# use condition operation
sum(survey$Sex[survey$Smoke == 'Never'] == 'Female', na.rm = TRUE) # 99 row

# 2. find height mean of male and female
mean(survey$Height[survey$Sex == 'Male'],na.rm = TRUE) # 178.826 cm
mean(survey$Height[survey$Sex == 'Female'],na.rm = TRUE) # 165.6867 cm

# 3. find height median of male and female
median(survey$Height[survey$Sex == 'Male'],na.rm = TRUE) # 180 cm
median(survey$Height[survey$Sex == 'Female'],na.rm = TRUE) # 166.75 cm

# 4. find height mode of male and female
Mode(survey$Height[survey$Sex == 'Male'],na.rm = TRUE) # 180.00 cm and 180.34 cm
Mode(survey$Height[survey$Sex == 'Female'],na.rm = TRUE) # 165.00 cm and 170.00 cm

# 5. find name of clap and exercise of the most count and show the count of them
factClap <- factor(survey$Clap)
summary(factClap) # right 147

factExer <- factor(survey$Exer)
summary(factExer) # frequency 115
