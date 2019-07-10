
########################################################################
################## Polynomial regression ########################
########################################################################

library(ISLR)
attach(Wage)

## polynomial
fit=lm(wage~poly(age,4),data=Wage) 
coef(summary(fit))
cov(fit$model)

fit2=lm(wage~poly(age,4,raw=T),data=Wage) ##lm(wage~age+I(age^2)+I(age^3)+I(age^4),data=Wage)
coef(summary(fit2))
cov(fit2$model)

agelims=range(age)
age.grid=seq(from=agelims[1],to=agelims[2])
preds=predict(fit,newdata=list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit+2*preds$se.fit,preds$fit-2*preds$se.fit )

par(mfrow=c(1,2))
plot(age,wage,cex=.5,col="darkgrey")
lines(age.grid,preds$fit,lwd=2,col="blue")
matlines(age.grid,se.bands,lwd=1,col="blue",lty=3)


## step function
table(cut(age,4))
fit=lm(wage~cut(age ,4),data=Wage) 
coef(summary(fit))
#age.grid=seq(from=agelims[1],to=agelims[2], by=0.01)
preds=predict(fit,newdata=list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit+2*preds$se.fit,preds$fit-2*preds$se.fit )
plot(age,wage,cex=.5,col="darkgrey")
lines(age.grid,preds$fit,lwd=2,col="blue")
matlines(age.grid,se.bands,lwd=1,col="blue",lty=3)



## spline

library(splines)
fit=lm(wage~bs(age,knots=c(25,40,60)),data=Wage) ## cubic spline
pred=predict(fit,newdata=list(age=age.grid),se=T)
plot(age,wage,col="gray")
lines(age.grid,pred$fit,lwd=2)
lines(age.grid,pred$fit+2*pred$se ,lty="dashed")
lines(age.grid,pred$fit-2*pred$se ,lty="dashed")

fit2=lm(wage~ns(age,df=4),data=Wage) ## natural spline
pred2=predict(fit2,newdata=list(age=age.grid),se=T) 
lines(age.grid, pred2$fit,col="red",lwd=2)
lines(age.grid,pred2$fit+2*pred2$se ,lty="dashed", col=2)
lines(age.grid,pred2$fit-2*pred2$se ,lty="dashed", col=2)


plot(age,wage,xlim=agelims ,cex=.5,col="darkgrey")
fit2=smooth.spline(age,wage,cv=T)
lines(fit2,col="blue",lwd=2)
