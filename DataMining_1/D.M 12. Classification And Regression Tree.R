


# Chapter 8 Lab: Decision Trees

# Fitting Classification Trees

install.packages("tree")
install.packages("MASS")

library(tree)
library(ISLR)


# Fitting Regression Trees

library(MASS)
dim(Boston)

set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston=tree(medv~.,Boston,subset=train)
summary(tree.boston)
plot(tree.boston)
text(tree.boston,pretty=0) # 8 terminal nodes

cv.boston=cv.tree(tree.boston) # alpha value, turning parameter 찾기
plot(cv.boston$size,cv.boston$dev,type='b')
prune.boston=prune.tree(tree.boston,best=3)
plot(prune.boston)
text(prune.boston,pretty=0)

yhat=predict(prune.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
plot(yhat,boston.test)
abline(0,1)
mean((yhat-boston.test)^2)

yhat=predict(tree.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
plot(yhat,boston.test)
abline(0,1)
mean((yhat-boston.test)^2)



##

set.seed(1)
library(ISLR)
Hitters
Hitters <- na.omit(Hitters)
sum(is.na(Hitters))
str(Hitters)

train<-sample(1:263,131)
h.tree <- tree(log(Salary)~. , data=Hitters,subset=train )
plot(h.tree)
text(h.tree)

cv.h<-cv.tree(h.tree)
plot(cv.h$size,cv.h$dev,type='b') # turning parameter : 8

prune.h<-prune.tree(h.tree,best = 8)
plot(prune.h)
text(prune.h)

yhat <- predict(prune.h,newdata=Hitters[-train,])
ytest <- log(Hitters$Salary[-train])
mean((ytest-yhat)^2)
plot(yhat,ytest)
abline(0,1)



# Fitting Classification Trees
install.packages("tree")
library(tree)
library(ISLR)
attach(Carseats)

High=ifelse(Sales<=8,"No","Yes")
Carseats=data.frame(Carseats,High)

tree.carseats=tree(High~.-Sales,data=Carseats) # default 가 gini index
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats,pretty=0)
tree.carseats # 어떤 항목이 misclassification 확률을 트리에선 모르지만 이걸 활용하면알수있음

set.seed(2)
dim(Carseats)
train=sample(1:nrow(Carseats), 200) # 전체 400이므로 200개만?
Carseats.test=Carseats[-train,]
tree.carseats=tree(High~.-Sales,Carseats,subset=train)

tree.pred=predict(tree.carseats,Carseats.test,type="class")
High.test=High[-train]
table(tree.pred,High.test)
(86+57)/200

## 수업여기까지

set.seed(3)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass)
names(cv.carseats)
cv.carseats
par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type="b")
plot(cv.carseats$k,cv.carseats$dev,type="b")
prune.carseats=prune.misclass(tree.carseats,best=9)
plot(prune.carseats)
text(prune.carseats,pretty=0)
tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(94+60)/200
prune.carseats=prune.misclass(tree.carseats,best=15)
plot(prune.carseats)
text(prune.carseats,pretty=0)
tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(86+62)/200




# Bagging and Random Forests

library(randomForest)
set.seed(1)
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,importance=TRUE)
bag.boston
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
plot(yhat.bag, boston.test)
abline(0,1)
mean((yhat.bag-boston.test)^2)
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,ntree=25)
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
set.seed(1)
rf.boston=randomForest(medv~.,data=Boston,subset=train,mtry=6,importance=TRUE) # m=6 / p= 13 이게 Random forest
yhat.rf = predict(rf.boston,newdata=Boston[-train,])

predict(rf.boston) # OOB error

mean((yhat.rf-boston.test)^2)
importance(rf.boston)
varImpPlot(rf.boston)

names(rf.boston)
summary(rf.boston)
rf.boston[[3]]



# Boosting

install.packages("gbm")
library(gbm)
set.seed(1)
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4) 
# n.trees=100(default), interaction.depth : numer of split (default:1)
summary(boost.boston)
par(mfrow=c(1,2))
plot(boost.boston,i="rm")
plot(boost.boston,i="lstat")
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2) # test mse 

boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=500)
mean((yhat.boost-boston.test)^2)
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=50)
mean((yhat.boost-boston.test)^2)
# ntree에따라 U-shape 형태 test MSE 최적의 값은 어딘가에...



