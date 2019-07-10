
# Chapter 6 Lab 1: Subset Selection Methods

# Best Subset Selection

library(ISLR)
fix(Hitters)
names(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary))
Hitters=na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters))
install.packages("leaps")
library(leaps)
regfit.full=regsubsets(Salary~.,Hitters) # Best Subset Selection 가 default
summary(regfit.full)
# p=1일땐 CRBI가 가장먼저 포함 이게 M1 , 그담에 Hits 포함! M2 , ~~

regfit.full=regsubsets(Salary~.,data=Hitters,nvmax=19) #2^19모델 전부 고려한거 stpewise x 
reg.summary=summary(regfit.full)
names(reg.summary)
reg.summary$rsq
par(mfrow=c(2,2))
plot(reg.summary$rss,xlab="Number of Variables",ylab="RSS",type="l")
plot(reg.summary$adjr2,xlab="Number of Variables",ylab="Adjusted RSq",type="l")
which.max(reg.summary$adjr2) # adj R^2 가 가장 큰건 M11
points(11,reg.summary$adjr2[11], col="red",cex=2,pch=20)

plot(reg.summary$cp,xlab="Number of Variables",ylab="Cp",type='l')
which.min(reg.summary$cp) # mellow cp 가장 작은건 M11
points(10,reg.summary$cp[10],col="red",cex=2,pch=20)

which.min(reg.summary$bic) # BIC가 가장작은건 M6
plot(reg.summary$bic,xlab="Number of Variables",ylab="BIC",type='l')
points(6,reg.summary$bic[6],col="red",cex=2,pch=20)

coef(regfit.full,6)
coef(regfit.full,11)

plot(regfit.full,scale="r2")
plot(regfit.full,scale="adjr2")
plot(regfit.full,scale="Cp")
plot(regfit.full,scale="bic")

## Forward and Backward Stepwise Selection
?regsubsets
regfit.fwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="forward")
summary(regfit.fwd)

summary.fwd <- summary(regfit.fwd) 
summary.fwd$cp -> cpf
which.min(cpf)
coef(regfit.fwd,10)
coef(regfit.full,10)
# 과정은 다르지만 결과는 같음

regfit.bwd=regsubsets(Salary~.,data=Hitters,nvmax=19,method="backward")
summary(regfit.bwd)

coef(regfit.full,7)
coef(regfit.fwd,7)
coef(regfit.bwd,7)
# 포함된 predictor가 다르므로 결과도 제각각

## Choosing Among Models
set.seed(1)

train=sample(c(TRUE,FALSE), nrow(Hitters),rep=TRUE) #train set
test=(!train) #test set

regfit.best=regsubsets(Salary~.,data=Hitters[train,],nvmax=19)
test.mat=model.matrix(Salary~.,data=Hitters[test,])

summary(regfit.best)
# regsubsets로 한 결과는 predict함수가 안먹으므로 직접 만들어주어야.
val.errors=rep(NA,19)
for(i in 1:19){
  coefi=coef(regfit.best,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean((Hitters$Salary[test]-pred)^2)
} 

val.errors #varidation error
which.min(val.errors)
coef(regfit.best,10) # 요건 training 데이터만 사용

# regsubsets로 한 결과는 predict함수가 안먹으므로 직접 만들어주어야.
predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form,newdata)
  coefi=coef(object,id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}
regfit.full=regsubsets(Salary~.,data=Hitters,nvmax=19)
coef(regfit.full,10) # 요건 전체 데이터이용 / 이게 진짜 결과?

# cross varidation
k=10
set.seed(1)
folds=sample(1:k,nrow(Hitters),replace=TRUE)
sum(folds==1)
sum(folds==2)
sum(folds==3)
sum(folds==4) # 이번엔 각각 k개의 fold의 숫자가 다르게 설정함

cv.errors=matrix(NA,k,19, dimnames=list(NULL, paste(1:19)))

for(j in 1:k){
  best.fit=regsubsets(Salary~.,data=Hitters[folds!=j,],nvmax=19)
  for(i in 1:19){
    pred=predict(best.fit,Hitters[folds==j,],id=i)
    cv.errors[j,i]=mean( (Hitters$Salary[folds==j]-pred)^2)
  }
}
mean.cv.errors=apply(cv.errors,2,mean)
mean.cv.errors
par(mfrow=c(1,1))
plot(mean.cv.errors,type='b')
reg.best=regsubsets(Salary~.,data=Hitters, nvmax=19)
coef(reg.best,11) #full 모델에 대해서 다시

## DIY / LOOCV의 방법으로

