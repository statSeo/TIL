install.packages("rgl")


# Chapter 4 Lab: Logistic Regression, LDA, QDA, and KNN
#Default data in ISLR package
library(ISLR)
attach(Default)
str(Default)
dim(Default) # 샘플사이즈가 크므로 spilt 
head(Default) # 채무불이행 데이터 

set.seed(1234)
train=sample(1:10000,5000)
length(train)

# phat(Y=1|X)를 구해주는것
Default[9996,] # 하나의 sample
# perfomance 측정
length(score)



##3 LDA
library(MASS)
h=lda(default~balance)
plot(h)
h

predict(h)$class
#2x1
predict(h,data.frame(balance=c(3000))) # posterior 확률을 구할 수 있음 / 둘의 합은 1 / P(Y=1|X)
 
h2=lda(default~student+balance)
plot(h2)
h2
predict(h)$posterior[1:10,]

# 2x2 confusion Matrix
predict(h2,data.frame(balance=c(2000,3000),student=c("Yes","No"))) 

t.pred=predict(h2)$class
table(t.pred,default)
mean(t.pred==default)
#ROC curve
a0=seq(0,1,by=0.01)
PPR=numeric(length(a0))
NPR=PPR
h2=lda(default~student+balance,CV=T)
for (i in 1:length(a0)){
  cPPR=sum(h2$posterior[,2]>a0[i] & default=="Yes")
  cNPR=sum(h2$posterior[,2]>a0[i] & default=="No")
  PPR[i]=cPPR/sum(default=="Yes")
  NPR[i]=cNPR/sum(default=="No")
}
pdf("~/desktop/ROC.pdf")
plot(NPR,PPR,type="l",col=2,xlab="1-specificity",ylab="sensitivity",main="ROC curve")
abline(0,1,lty=2)
dev.off()
q2=qda(default~student+balance)
q2
t.predq=predict(q2)$class
table(t.predq,default)
#knn
library(class)
nstudent=rep(0,dim(Default)[1])
nstudent[student=="Yes"]=1
m=sample(c(rep(0,900),rep(1,100)),1000)
mtrain=which(m==0)
mtest=which(m==1)
knn.fit=knn(train=cbind(nstudent,balance)[mtrain,],test=cbind(nstudent,balance)[mtest,],cl=Default[mtrain,1],k=1)
table(default[mtest],knn.fit)
k=3
knn0.fit=knn(train=cbind(nstudent,balance),test=cbind(nstudent,balance),cl=Default[,1],k=k)
table(default,knn0.fit)
detach(Default)

#Mower from Wichern
mow=read.table(file="~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/CAU/Multivariate Analysis/Wichern_data/T11-1.DAT")
names(mow)<-c("Income","Lot","OWN")
head(mow)
str(mow)
mow$OWN[mow$OWN==2]=0
mow
plot(mow)
attach(mow)
#Scatter plot
m0=which(OWN==0)
m1=which(OWN==1)
plot(Income[m0],Lot[m0],xlim=c(min(Income)-1,max(Income)+1),ylim=c(min(Lot)-1,max(Lot)+1),col=1,xlab="Income",ylab="Lot Size")
points(Income[m1],Lot[m1],pch=2,col=2)
legend(120,15, pch=c(2,1),c("OWN=YES","OWN=NO"),col=c(2,1))

#Simple logistic regression
g1=glm(OWN~Lot,family=binomial)
summary(g1)
coef(g1)
vcov(g1)
g1$fitted
#Plot fitted logistic curve
plot(Lot,OWN)
summary(g1)$coef
a=summary(g1)$coef[1,1]
b=summary(g1)$coef[2,1]
curve(exp(a+b*x)/(1+exp(a+b*x)),add=T,col=2)

#Multiple logistic regression
g2=glm(OWN~Income+Lot,data=mow,family=binomial)
summary(g2)

#Hypothesis test
anova(g1,g2,test="LRT")

#prediction
predict(g2,data.frame(Income=120,Lot=20))
est=coef(g2)
sum(est*c(1,120,20))
predict(g2,data.frame(Income=120,Lot=20),type="response")
sum(est*c(1,120,20))->d
exp(d)/(1+exp(d))

#Scatter plot with classification curve
m0=which(OWN==0)
m1=which(OWN==1)
plot(Income[m0],Lot[m0],xlim=c(min(Income)-1,max(Income)+1),ylim=c(min(Lot)-1,max(Lot)+1),col=1,xlab="Income",ylab="Lot Size")
points(Income[m1],Lot[m1],pch=2,col=2)
legend(120,15, pch=c(2,1),c("OWN=YES","OWN=NO"),col=c(2,1))
h0=(-coef(g2)[1])/coef(g2)[3]
h1=-coef(g2)[2]/coef(g2)[3]
abline(a=h0,b=h1,col=3)

#LDA
library(MASS)
g.lda=lda(OWN~Income+Lot)
g.lda

detach(mow)




# The Stock Market Data

library(ISLR)
data(Smarket)
head(Smarket)
str(Smarket)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
cor(Smarket)
cor(Smarket[,-9])
attach(Smarket)
plot(Volume)

# Logistic Regression

glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
summary(glm.fit)
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts(Direction)
glm.pred=rep("Down",1250)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction)
(507+145)/1250
mean(glm.pred==Direction)
train=(Year<2005)
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
mean(glm.pred!=Direction.2005)
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76)
predict(glm.fit,newdata=data.frame(Lag1=c(1.2,1.5),Lag2=c(1.1,-0.8)),type="response")

# Linear Discriminant Analysis      

library(MASS)
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=train)
lda.fit
plot(lda.fit)
lda.pred=predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class=lda.pred$class
table(lda.class,Direction.2005)
mean(lda.class==Direction.2005)
sum(lda.pred$posterior[,1]>=.5)
sum(lda.pred$posterior[,1]<.5)
lda.pred$posterior[1:20,1]
lda.class[1:20]
sum(lda.pred$posterior[,1]>.9)
