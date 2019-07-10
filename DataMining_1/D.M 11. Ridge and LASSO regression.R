
# Chapter 6 Lab 2: Ridge Regression and the Lasso

install.packages("glmnet")
library(ISLR)
library(glmnet)
sum(is.na(Hitters))
Hitters <- na.omit(Hitters)
sum(is.na(Hitters))
dim(Hitters)
names(Hitters)

# Ridge Regression
x <- model.matrix(Salary~.,Hitters)[,-1] #model matrix는 predictor term 을 보여주는것 (첫번째는 1,1,1,1 이니깐 빼준것)
dim(x)
y=Hitters$Salary # response term

library(glmnet)
grid=10^seq(10,-2,length=100)
grid # 첫 람다는 10^10 부터 제일 작은 10^-2 까지 100개 만들기

ridge.mod=glmnet(x,y,alpha=0,lambda=grid) # without interception X와 Y 그리고 alpha 0 은 ridge / alpha 1 이 라쏘 / (1-a)L^2 + aL' 라서 그럼
dim(coef(ridge.mod))

ridge.mod$lambda[50]
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2))

ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1,60]^2))

which(grid==50) # 람다가 50 인 값을 없지만 인위로 설정해줘서 돌리기?
predict(ridge.mod,s=50,type="coefficients")[1:20,]

set.seed(1)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]

ridge.mod=glmnet(x[train,],y[train],alpha=0,lambda=grid, thresh=1e-12)
ridge.pred=predict(ridge.mod,s=4,newx=x[test,])
mean((ridge.pred-y.test)^2)
mean((mean(y[train])-y.test)^2)
# training mse 둘중 뭐가?

ridge.pred=predict(ridge.mod,s=1e10,newx=x[test,]) # 람다를 댑따 크게해서 해보기
mean((ridge.pred-y.test)^2)

ridge.pred=predict(ridge.mod,s=0,newx=x[test,],exact=T)
mean((ridge.pred-y.test)^2)

CTMSE <- numeric(100)
for (j in 1:100){
  ridge.pred=predict(ridge.mod,s=grid[j],newx=x[test,],exact = T)
  CTMSE[j] <-mean((ridge.pred-y.test)^2)
}
plot(CTMSE)
which.min(CTMSE)
grid[64]

# 마지막 모델을 구할땐 training만 한걸로 말고 full모델로 생각하기
coef(ridge.mod)[,64]


## 수업 넘어감

lm(y~x, subset=train)
predict(ridge.mod,s=0,exact=T,type="coefficients")[1:20,]
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=0)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam # turning parameter / cv mean이 제일 작은애? 찾음!

ridge.pred=predict(ridge.mod,s=bestlam,newx=x[test,])
mean((ridge.pred-y.test)^2)
out=glmnet(x,y,alpha=0)
predict(out,type="coefficients",s=bestlam)[1:20,]


# The Lasso
lasso.mod=glmnet(x[train,],y[train],alpha=1,lambda=grid)
plot(lasso.mod)
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train],alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam # 1.turning parameter를 찾고

lasso.pred=predict(lasso.mod,s=bestlam,newx=x[test,])
mean((lasso.pred-y.test)^2) # 2.test mse 값을 구한것?

out=glmnet(x,y,alpha=1,lambda=grid) # 3.full model로 계수구하기!
lasso.coef=predict(out,type="coefficients",s=bestlam)[1:20,]
lasso.coef
lasso.coef[lasso.coef!=0]




# Chapter 6 Lab 3: PCR and PLS Regression

# Principal Components Regression

install.packages("pls")
library(pls)
set.seed(2)
pcr.fit=pcr(Salary~., data=Hitters,scale=TRUE,validation="CV")
# scale = T : stardardize 시켜서 / cross varidation : 10개의그룹 1개씩 빼가며 test mse 추정한거
summary(pcr.fit)
validationplot(pcr.fit,val.type="MSEP")
set.seed(1)

pcr.fit=pcr(Salary~., data=Hitters,subset=train,scale=TRUE, validation="CV")
validationplot(pcr.fit,val.type="MSEP")     # turning parameter : numer of PC 를 찾자!
pcr.pred=predict(pcr.fit,x[test,],ncomp=7)
mean((pcr.pred-y.test)^2)                   # 
pcr.fit=pcr(y~x,scale=TRUE,ncomp=7)
summary(pcr.fit)
coefficients(pls.fit)



# Partial Least Squares

set.seed(1)
pls.fit=plsr(Salary~., data=Hitters,subset=train,scale=TRUE, validation="CV")
summary(pls.fit)
validationplot(pls.fit,val.type="MSEP")
pls.pred=predict(pls.fit,x[test,],ncomp=2)
mean((pls.pred-y.test)^2)
pls.fit=plsr(Salary~., data=Hitters,scale=TRUE,ncomp=2)
summary(pls.fit)
coefficients(pls.fit)

