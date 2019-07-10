library(ISLR)
data(Auto)
attach(Auto)
x<-c(rep(1:10,each=39),1,2)
set.seed(100)
cvset<-sample(x,392)
ind<-list()
for (i in 1:10) ind[[i]]<-which(cvset==i)
testMSE<-numeric(10)
for (j in 1:10){
	testMSE[j]<-0
	for (i in 1:10){
		g<-lm(mpg~poly(horsepower,j),data=Auto,subset=-ind[[i]])
		pred<-predict(g,newdata=Auto[ind[[i]],])
		testMSE[j]<-testMSE[j]+sum((mpg[ind[[i]]]-pred)^2)
	}
	testMSE[j]<-testMSE[j]/392
}

plot(testMSE,type="o")
g<-lm(mpg~poly(horsepower,2),data=Auto)
summary(g)

detach(Auto)

data(Portfolio)

f<-function(X,Y){
res<-(var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y))
return(res)
}

B=1000
theta=numeric(B)
set.seed(1)
for (i in 1:B){
	ind<-sample(100,100,replace=TRUE)
	theta[i]<-f(X[ind],Y[ind])
}




