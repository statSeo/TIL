########################################################################
################## Chapter 3. Sampling ########################
########################################################################


## 1. training set and test set

library(ISLR)
set.seed(2)
train=sample(nrow(Auto),196)

lm.fit=lm(mpg~horsepower ,data=Auto,subset=train)
lm.fit2=lm(mpg~poly(horsepower ,2),data=Auto,subset=train)
lm.fit3=lm(mpg~poly(horsepower ,3),data=Auto,subset=train)

## test MSE
attach(Auto)
test_mse<-vector()
test_mse[1]=mean((mpg-predict(lm.fit,Auto))[-train]^2)
test_mse[2]=mean((mpg-predict(lm.fit2,Auto))[-train]^2)
test_mse[3]=mean((mpg-predict(lm.fit3,Auto))[-train]^2)

plot(test_mse, xlab='flexibility', ylab='MSE', pch=15,col=2, cex=2, ylim=c(15, 30))

## training MSE
train_mse<-vector()
train_mse[1]=mean((mpg-predict(lm.fit,Auto))[train]^2)
train_mse[2]=mean((mpg-predict(lm.fit2,Auto))[train]^2)
train_mse[3]=mean((mpg-predict(lm.fit3,Auto))[train]^2)

points(train_mse,pch=15,col=3, cex=2)

legend('topright',c('training','test'), pch=15, col=c(2,3))



## 2. LOOCV
error<-vector()

for(i in 1:nrow(Auto)){
  train=Auto[-i,]
  lm.fit=lm(mpg~horsepower ,data=train)
  yhat=predict(lm.fit, Auto[i,])
  error[i]= (Auto$mpg[i]-yhat)^2
}

mean(error)


library(boot)
glm.fit=glm(mpg~horsepower ,data=Auto)
cv.err=cv.glm(Auto,glm.fit)
cv.err$delta[1]


## 3. K-fold CV

library(boot)
set.seed(17)
glm.fit=glm(mpg~horsepower ,data=Auto)
cv.err=cv.glm(Auto,glm.fit, K=10)
cv.err$delta[1]


MSE_k<-vector()
n=nrow(Auto)
K=10
set.seed(17)
kfold=sample(rep(1:K, ceiling(n/K)),n)

for(k in 1:10){
  train=Auto[which(kfold!=k),]
  test=Auto[which(kfold==k),]
  lm.fit=lm(mpg~horsepower ,data=train)
  yhat=predict(lm.fit, test)
  MSE_k[k]= sum( (test$mpg-yhat)^2 )/nrow(test)
}
((MSE_k)%*%table(kfold))/n


## 4. bootstrap

boot.fn=function(data,index){
  coef=coef(lm(mpg~horsepower ,data=data,subset=index) )
  return(coef)
}

boot.fn(Auto ,1:392)
boot(Auto ,boot.fn ,1000)













##############################
#####  wrong way to apply CV ### ### 
##############################



y=rnorm(50)
x=matrix(rnorm(50*5000), nrow=50, ncol=5000)


cor_result<-vector()
for(i in 1:ncol(x)){
  cor_result[i]=cor(y,x[,i])
}
newx=x[ , order(cor_result, decreasing=T)[1:10] ]
data=data.frame(y=y,newx=newx)

library(boot)
glm.fit=glm(y~., data, family='gaussian')
cv.err=cv.glm(data=data, glmfit=glm.fit, K=5)
cv.err$delta[1]




MSE_k<-vector()
data=data.frame(y=y,x=x)
n=nrow(data)
K=10
kfold=sample(rep(1:K, ceiling(n/K)),n)

for(k in 1:10){
  train=data[which(kfold!=k),]
  test=data[which(kfold==k),]
  
  cor_result<-vector()
  for(i in 2:ncol(train)){
    cor_result[i]=cor(train$y,train[,i])
  }
  newx=train[,-1][ , order(cor_result, decreasing=T)[1:10] ]
  data2=data.frame(y=train$y,newx=newx)
  
  lm.fit=lm(y~. ,data=data2)
  yhat=as.matrix( cbind(1, test[,-1][ , order(cor_result, decreasing=T)[1:10] ]) ) %*% lm.fit$coefficients
  MSE_k[k]= sum( (test$y-yhat)^2 )/nrow(test)
}
((MSE_k)%*%table(kfold))/n

