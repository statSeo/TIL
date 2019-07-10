
set.seed(2)
x=matrix(rnorm(20*2,0,2), ncol=2)
y=c(rep(-1,10), rep(1,10))
x[y==1,]=x[y==1,] + 1
y[which(x[,2]>0)]=-1
y[which(x[,2]<0.5)]=1
plot(x[,2],x[,1], col=(3-y))
dat=data.frame(x=x, y=as.factor(y))

library(e1071)
svmfit=svm(y~., data=dat, kernel="linear", cost=10,scale=FALSE)  
plot(svmfit, dat, ylim=c(-4,5), xlim=c(-6,5))
# X는 support vector를 의미함 / 검정색 하나가 핑크 영역으로 들어감.
table(y, svmfit$fitted)
summary(svmfit)

svmfit=svm(y~., data=dat, kernel="linear", cost=0.01,scale=FALSE) ## cost is lambda (tradeoff between margin & contraint)
plot(svmfit, dat, ylim=c(-4,5), xlim=c(-6,5))
# 람다를 늘렸더니 support vetor 가 줄은 것을 알 수 있음.
table(y, svmfit$fitted)


tune.out=tune(svm,y~.,data=dat,kernel="linear",ranges=list(cost=c(0.001, 0.01, 0.1, 1,5,10,100)))
summary(tune.out)
bestmod=tune.out$best.model
summary(bestmod)

## multiclass

set.seed(1)

x=matrix(rnorm(200*2), ncol=2)
x[1:100,]=x[1:100,]+2
x[101:150,]=x[101:150,]-2
y=c(rep(1,150),rep(2,50))
x=rbind(x, matrix(rnorm(50*2), ncol=2))
y=c(y, rep(0,50))
x[y==0,2]=x[y==0,2]+2
dat=data.frame(x=x, y=as.factor(y))
par(mfrow=c(1,1))
plot(x,col=(y+1))
svmfit=svm(y~., data=dat, kernel="radial", cost=10, gamma=1)
plot(svmfit, dat)
library(e1071)
svmfit=svm(y~., data=dat, kernel="linear", cost=10,scale=FALSE)  
plot(svmfit, dat, ylim=c(-4,5), xlim=c(-6,5))
table(y, svmfit$fitted)
summary(svmfit)



svmfit=svm(y~., data=dat, kernel="linear", cost=0.01,scale=FALSE) ## cost is lambda (tradeoff between margin & contraint)
plot(svmfit, dat, ylim=c(-4,5), xlim=c(-6,5))
table(y, svmfit$fitted)


