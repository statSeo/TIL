install.packages("rgl")


# Chapter 4 Lab: Logistic Regression, LDA, QDA, and KNN
#Default data in ISLR package
library(ISLR)
attach(Default)
str(Default)
par(mfrow=c(1,2))
boxplot(balance~default,col=c(2,6),ylab="balance",xlab="default")
boxplot(income~default,col=3:4,ylab="income",xlab="defautlt")
library(rgl)
plot3d(balance,income,default)
m0=which(default=="No")
m1=which(default=="Yes")
plot3d(balance[m0],income[m0],rep(0,length(m0)),col="red",xlab="balance",ylab="income",zlab="default",zlim=c(-0.01,1.01))
plot3d(balance[m1],income[m1],rep(1,length(m1)),add=T,col="blue")
s00=which(student=="No" & default=="No")
s01=which(student=="No" & default=="Yes")
s10=which(student=="Yes" & default=="No")
s11=which(student=="Yes" & default=="Yes")
plot3d(balance[s00],income[s00],rep(0,length(s00)),col=2,xlab="balance",ylab="income",zlab="default",zlim=c(-0.01,1.01))
plot3d(balance[s10],income[s10],rep(0,length(s10)),add=T,col=6)
plot3d(balance[s01],income[s01],rep(1,length(s01)),add=T,col=3)
plot3d(balance[s11],income[s11],rep(1,length(s11)),add=T,col=4)
table(student,default)
chisq.test(student,default)
y=rep(0,length(default))
y[default=="Yes"]=1
plot(balance,y,ylab="default",col=1)
gb=glm(default~balance,family=binomial)
summary(gb)
a=coef(gb)[1]
b=coef(gb)[2]
curve(exp(a+b*x)/(1+exp(a+b*x)),add=T,col=2)
gs=glm(default~student,family=binomial)
summary(gs)
g=glm(default~student+income+balance,family=binomial(link=logit))
summary(g)
boxplot(balance~student,col=2:3,xlab="student",ylab="balance")
t.test(balance~student)
wilcox.test(balance~student)
library(MASS)
h=lda(default~balance)
plot(h)
h
predict(h)$class
predict(h,data.frame(balance=c(3000)))
h2=lda(default~student+balance)
plot(h2)
h2
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
