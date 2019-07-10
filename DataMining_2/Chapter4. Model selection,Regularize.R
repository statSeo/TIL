######## best subset selection  ########
library(ISLR)
library(leaps)

data(Hitters)
head(Hitters)
dim(Hitters)

regfit.full=regsubsets(Salary~., Hitters, nbest=1)
summary(regfit.full)  ## selected M_k , but max 8  (we can have upto 19 X's)

regfit.full=regsubsets(Salary~., Hitters, nvmax=22)
reg_summary=summary(regfit.full)   ## selected M_k
names(reg_summary)



par(mfrow=c(2,2))

plot(reg_summary$rss, ylab='RSS', xlab='p')
plot(reg_summary$adjr2,  ylab='adj_R2', xlab='p')
max_index=which.max(reg_summary$adjr2)
points(max_index, reg_summary$adjr2[max_index], col=2, cex=2, pch=20)

plot(reg_summary$cp,  ylab='Cp', xlab='p')
min_index= which.min(reg_summary$cp)
points(min_index, reg_summary$cp[min_index], col=2, cex=2, pch=20)

plot(reg_summary$bic,  ylab='BIC', xlab='p')
min_index=which.min(reg_summary$bic)
points(min_index, reg_summary$bic[min_index], col=2, cex=2, pch=20)

##print coeff when p=6
coef(regfit.full, 6)



########   Forward / Backward ########


regfit.fwd=regsubsets(Salary~., Hitters, nvmax=22, method='forward')
reg_summary=summary(regfit.fwd)   ## selected M_k
reg_summary
coef(regfit.fwd,7)

regfit.bwd=regsubsets(Salary~., Hitters, nvmax=22, method='backward')
reg_summary=summary(regfit.bwd)   ## selected M_k
reg_summary
coef(regfit.bwd,7)


coef(regfit.full, 7)




### Select M_k using validation / CV approach

## validation set
set.seed(1)
Hitters=na.omit(Hitters)
train=sample(c(TRUE, FALSE) , nrow(Hitters), rep=T)
test=(!train)

regfit.best=regsubsets(Salary~., data=Hitters[train,], nvmax=22)
test.mat=model.matrix(Salary~., data=Hitters[test,])

PE<-vector()
for(i in 1:19){
  beta_hat =coef(regfit.best, i)
  yhat=test.mat[, names(beta_hat )]%*% beta_hat
  PE[i]=mean(  (yhat -Hitters$Salary[test] )^2  )
  
}

coef(regfit.best, which.min(PE))




## CV
set.seed(1)
K=10
folds=sample(1:K, nrow(Hitters), replace=T)
PE<-matrix(NA, nrow=K, ncol=19)

for(j in 1:K){
  
  regfit.best=regsubsets(Salary~., data=Hitters[folds!=j,], nvmax=22)
  test.mat=model.matrix(Salary~., data=Hitters[folds==j,])
  for(i in 1:19){
    beta_hat =coef(regfit.best, i)
    yhat=test.mat[, names(beta_hat )]%*% beta_hat
    PE[j,i]=mean(  (yhat -Hitters$Salary[folds==j] )^2  )
  }
}

CV_error=apply(PE, 2, mean)

regfit.best=regsubsets(Salary~., data=Hitters, nvmax=22)
coef(regfit.best, which.min(CV_error))




########   Ridge ########
Hitters=na.omit(Hitters)
y=Hitters$Salary
x=model.matrix(Salary~., Hitters )[,-1]

library(glmnet)
ridge.mod=glmnet(x,y, alpha=0)  ## x are standardized by default option
plot(ridge.mod, xvar='lambda')
ridge.mod$lambda

round(  predict(ridge.mod, s=50, type='coefficients')  ,3)



## Estimate Test error using CV selected lambda

set.seed(1)
train=sample(c(1: nrow(Hitters))  , nrow(Hitters)/2)
test=(-train)
ridge.mod=glmnet(x[train,],y[train], alpha=0)

set.seed(1)
cv_out=cv.glmnet(x[train,], y[train], alpha=0)
plot(cv_out)
best_lam=cv_out$lambda.min#cv_out$lambda.1se
yhat= predict(ridge.mod, s= best_lam, newx=x[test,])
mean( ( yhat - y[test])^2 )

#coeff
ridge.mod=glmnet(x,y, alpha=0)
predict(ridge.mod, s= best_lam, type='coefficients')




########  LASSO  ########


y=Hitters$Salary
x=model.matrix(Salary~., Hitters )[,-1]

library(glmnet)
lasso.mod=glmnet(x,y, alpha=1)
plot(lasso.mod)



## Estimate Test error using CV selected lambda

set.seed(1)
train=sample(c(1: nrow(Hitters))  , nrow(Hitters)/2)
test=(-train)
lasso.mod=glmnet(x[train,],y[train], alpha=1)

set.seed(1)
cv_out=cv.glmnet(x[train,], y[train], alpha=1)
plot(cv_out)
best_lam=cv_out$lambda.min#cv_out$lambda.1se
yhat= predict(lasso.mod, s= best_lam, newx=x[test,])
mean( ( yhat - y[test])^2 )

#coeff
ridge.mod=glmnet(x,y, alpha=1)
lasso_coeff=predict(ridge.mod, s= best_lam, type='coefficients')
lasso_coeff
lasso_coeff[ which( lasso_coeff != 0 ), ]







## https://www4.stat.ncsu.edu/~post/josh/LASSO_Ridge_Elastic_Net_-_Examples.html

