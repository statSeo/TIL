
## 메일 내용에 있던 것

http://rfriend.tistory.com/193
https://ko.wikisource.org/wiki/2016%ED%97%8C%EB%82%981_%EC%84%A0%EA%B3%A0%EB%AC%B8 



url <- "https://ko.wikisource.org/wiki/2016%ED%97%8C%EB%82%981_%EC%84%A0%EA%B3%A0%EB%AC%B8"

web <- read_html(url)

carInfos <- html_nodes(web, css='.poem') 

head(carInfos)

ahn <- carInfos  %>% html_text()

str(ahn)




## Validation Set approach
training<-sample(1:392,196)
training
g<-lm(mpg~horsepower,data=Auto,subset=training)
predict(g,newdata=Auto[-training,])->test.MSE
predict(g,newdata=Auto[-training,])->pred
pred2<-predict(g,newdata=Auto[-training,])
t.MSE<-numeric(10)
t.MSE[1]<-(1/196)*sum((Auto$mpg[-training]-pred2)^2)


# 정리
g1=lm(mpg~poly(horsepower,1),data=Auto,subset=training)
t.MSE[1]= mean((Auto$mpg-predict(g1,Auto))[-training]^2)

g2=lm(mpg~poly(horsepower,2),data=Auto,subset=training)
t.MSE[2]= mean((Auto$mpg-predict(g2,Auto))[-training]^2)

g3=lm(mpg~poly(horsepower,3),data=Auto,subset=training)
t.MSE[3]= mean((Auto$mpg-predict(g3,Auto))[-training]^2)

t.MSE


## k-Fold Cross-Validation
ind <-sample(1:392,40)
which(ind==1)

CVset<-list()
set.seed(1234)

for(i in 1:10){
  CVset[[i]]<-which(ind=i)
}
CVset

t.MSE<-numeric(10)
for(i in 1:10){
  g1<-lm(mpg~horsepower,data=Auto,subset=-CVset[[i]])
  pred<-predict(g1,newdata=Auto[CVset[[i]],])
  t.MSE[i]<-t.MSE[i]+(1/length(CVset[[i]]))*sum(Auto$mpg(CVset[[i]]-pred)^2)
}


################################ 새 시간

library(ISLR)
data(Auto)
attach(Auto)
x<-c(rep(1:10,each=39),1,2)

set.seed(100)
cvset<-sample(x,392)
ind<-list()
for ( i in 1:10) ind[[i]]<-which(cvset==i)
testMSE<-numeric(10)
for (j in 1:10){
  testMSE[j]<-0
  for(i in 1:10){
    g<-lm(mpg~poly(horsepower,j),data=Auto,subset=-ind[[i]])
    pred<-predict(g,newdata=Auto[ind[[i]],])
    testMSE[j]<-testMSE[j]+sum((mpg[ind[[i]]]-pred)^2)
  }
  testMSE[j]<-testMSE[j]/392
}
plot(testMSE,type="o")
detach(Auto)
testMSE



##### bootstrap

data(Portfolio)
attach(Portfolio)
plot(Y)
(var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y))

f <- function(X,Y){
  res<-(var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y))
  return(res)
}

B=1000
theta=numeric(B)
set.seed(1)
for(i in 1:B){
  ind <- sample(100,100,replace=TRUE)
  theta[i]<-f(X[ind],Y[ind])
}
theta
hist(theta)
sd(theta) #bootstrap standard error 가 바로 이것

?boot.ci
