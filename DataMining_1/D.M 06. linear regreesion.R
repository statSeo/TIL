
# http://www-bcf.usc.edu/~gareth/ISL/data.html

# Chapter 3 Lab: Linear Regression
install.packages(c("MASS","ISLR"))
install.packages("car")
library(MASS)
library(ISLR)
library(car)
??SPM
  
# Simple Linear Regression
#Advertising data
adv <- read.csv("C:/Users/CAU/Downloads/Advertising.csv", header = T)
adv <- adv[,-1]
dim(adv)
names(adv)
head(adv)
str(adv)
plot(adv)
SPM(adv)
attach(adv)
gtv=lm(Sales~TV)
summary(gtv)

names(summary(gtv))
summary(gtv)[[4]]
summary(gtv)[[4]][2,4]
summary(gtv)[[4]][2,3]
summary(gtv)[[4]][2,3]^2

summary(gtv)[[4]][2,1]/summary(gtv)[[4]][2,2]

summary(gtv)[[4]][1,2]^2

vcov(gtv) # variance-covariance matrix 
?vcov

plot(TV,Sales)
abline(gtv,col="red")
par(mfrow=c(2,2))
plot(gtv) #Diagnostics plots
plot(gtv,1) # ~ plot(gtv,6)
#cook's distance > 1

rstudent(gtv) -> a
shapiro.test(a)
# random error constant variance
ncvTest(gtv)
#


##
gradio=lm(Sales~Radio)
summary(gradio)
gnewspaper=lm(Sales~Newspaper)
summary(gnewspaper)
#Multiple linear regression
g=lm(Sales~TV+Radio+Newspaper)
summary(g)
library(car)

# VIF > 10 : Rule of Thumb
vif(g)

par(mfrow=c(2,2))
plot(g)
step(g,k=log(nobs(g)))->gstep
summary(gstep)
par(mfrow=c(2,2))
plot(gstep)
# x1:100 x2:20 일때 신뢰/예측 구간  
predict(gstep,data.frame(TV=100,Radio=20),interval="confidence") #Confidence interval 좁
predict(gstep,data.frame(TV=100,Radio=20),interval="prediction") #Prediction interval 넓

#상호 작용 텀 추가 / t value가 높음 significant + R^2 도 늘어남
gint=update(gstep,.~.+TV:Radio)
summary(gint)
par(mfrow=c(2,2))
plot(gint)
anova(gstep,gint)



#Credit data
credit <- read.csv(file.choose(),header=T)
credit=credit0[,-1]
attach(credit)
SPM(credit)
boxplot(Balance~Gender)
f_gender=lm(Balance~Gender)
summary(f_gender)
## p-value가 크다.

boxplot(Balance~Ethnicity)
f_ethnicity=lm(Balance~Ethnicity)
summary(f_ethnicity)
# 마찬가지로 p-value가 큼. 어떤 factor도 중요x / box plot에서 본 그대로

boxplot(Balance~Student)
summary(lm(Balance~Student))

f_IS=lm(Balance~Income+Student)
summary(f_IS)
# 변수는 중요하다고 판단되나 설명력이 낮음

f_ISI=update(f_IS,.~.+Income:Student)
summary(f_ISI)
plot(Income,Balance)
plot(Income[Student=="Yes"],Balance[Student=="Yes"],col="blue")
points(Income[Student=="No"],Balance[Student=="No"],col="red")
detach(credit)

#Auto data
data(Auto)
auto0<-Auto
dim(auto0)
head(auto0) #Look at a couple of rows to understand data
str(auto0) #Look at the types or modes of data
auto<-auto0[,-9]
SPM(auto)
dim(auto)
auto$horsepower=as.numeric(auto$horsepower)
attach(auto)
plot(horsepower,mpg) # polynomial regreesion / Y=b0+b1*x1^1+b2*x2^2+...

a<-poly(horsepower,2)
plot(horsepower,a[,1])
plot(horsepower,a[,2])
cor(a[,1],a[,2])

abline(lm(mpg~horsepower)->h,col="red")
library(car)
residualPlots(h)

h2=update(h,.~.+I(horsepower^2))
summary(h2)

par(mfrow=c(2,2))
plot(h2)
par(mfrow=c(1,1))
plot(horsepower,mpg)
curve(coef(h2)[1]+coef(h2)[2]*x+coef(h2)[3]*x^2,add=T,col="red")
abline(h,col="blue")

hp2=lm(mpg~poly(horsepower,2))
summary(hp2)
# summary(h2)와 결과가 다름! center와 scale이 다르다?
detach(auto)

newdata <- data.frame(horsepower=15)
predict(h2,newdata = newdata,interval = "prediction")
predict(hp2,newdata = newdata,interval = "prediction")
# orthogonal의 차이? p-value는 같다
# dx+e : poly(x,2)의 1st column / ax^2+bx+c : 2nd column
# x^2 넣어줄때 멀티코릴리니어리티 고민을 해야되는데 orthogonal 하게 해서 그 걱정을 할 필요가 없다는 소리지??
