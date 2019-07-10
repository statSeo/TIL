
### 5.2.1

states=row.names(USArrests)
states
names(USArrests)
apply(USArrests, 2, mean)
apply(USArrests, 2, var)
pr.out=prcomp(USArrests, scale=TRUE)  # scale 표준화 옵션을 준것! 
?prcomp
names(pr.out)
pr.out$center
pr.out$scale
pr.out$rotation
is.list(pr.out)
pr.var=pr.out$sdev^2
pr.var  # 각각 eigenvalue

pr.out$scale^2 # variance와 같다
pr.out$rotation # pai11 (동그라미에 슬러시 그은거) ~ 파이 44 까지

pr.out$x    # 각각 case의 principal component 스코어
dim(pr.out$x)
biplot(pr.out, scale=0) # 빨간색 화살표는 각각의 rotation 에서 보여지는 어떤 변수에 PC들이 영향이 큰지 보여주는것

pr.out$rotation=-pr.out$rotation

pr.out$x=-pr.out$x
biplot(pr.out, scale=0)

pr.out$sdev
pr.var=pr.out$sdev^2
pr.var  # 각각 eigenvalue
sum(pr.var)

pve=pr.var/sum(pr.var)
pve

plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained",
     ylim=c(0,1),type='b')
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Proportion of
Variance Explained"
     , ylim=c(0,1),type='b')

a=c(1,2,8,-3)
cumsum(a) # 누적합 함수


### 5.2.2

install.packages("ISLR")
library(ISLR)
is.list(NCI60)
nci.labs=NCI60$labs
nci.data=NCI60$data
#Each cell line is labeled with a cancer type.
#We do not make use of the cancer types in performing PCA and clustering,
#as these are unsupervised techniques.
#But after performing PCA and clustering, we will check to see the extent to which
# these cancer types agree with the results of these unsupervised techniques.
dim(nci.data)
nci.labs[1:4]
table(nci.labs)
pr.out=prcomp(nci.data, scale=TRUE)

Cols=function(vec){
  cols=rainbow(length(unique(vec)))
  return(cols[as.numeric(as.factor(vec))])
}
par(mfrow=c(1,2))
plot(pr.out$x[,1:2], col=Cols(nci.labs), pch=19,xlab="Z1",ylab="Z2")
plot(pr.out$x[,c(1,3)], col=Cols(nci.labs), pch=19,xlab="Z1",ylab="Z3")
# linear dependence 하기 때문에 변수들을 줄여서 가능
# 3개의 PC 로 전부 설명 할수 없음 

summary(pr.out)
# p(64)개의 PC존재

plot(pr.out)
pve=100*pr.out$sdev^2/sum(pr.out$sdev^2)
par(mfrow=c(1,2))
plot(pve, type="o", ylab="PVE", xlab="Principal Component", col="blue")
plot(cumsum(pve), type="o", ylab="Cumulative PVE", xlab="Principal Component", col="brown3")


