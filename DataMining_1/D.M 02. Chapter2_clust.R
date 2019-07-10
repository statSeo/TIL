


### Hierarchical clustering

head(USArrests)
str(USArrests)
?USArrests

#Select a distance between two subjects:
USArrests.dist <- dist(USArrests, method = "manhattan")
USArrests.dist

#Select a linkage (distance between clusters) and conduct a hierarchical clustering
USArrests.hclust <- hclust(USArrests.dist, method = "complete")

#Names of the results from hclust function
names(USArrests.hclust)
USArrests.hclust$height

#Plot Dendrogram
plot(USArrests.hclust)

#clustering classes when k=5
hc.class <- cutree(USArrests.hclust, k =5)
#Scatter plot matrix with the results of hierarchical clustering
#For more details, type ?dist ?hclust ?cutree
plot(USArrests, col = hc.class, pch = hc.class)

cov(USArrests)
# assault 가 분산이 크다! distance에 좀더 영향을 끼치는 요인

# 표준화를 시켜 단위에 영향을 받지 않게 해주려면
USArrests.scale = scale(USArrests)
cov(USArrests.scale)
cor(USArrests.scale)
# 위과정들에서 USArrests 을  USArrests.scale로 바꿔주면 ok



### K-means clustering
set.seed(123)

US.km <- kmeans(USArrests, centers = 2)
names(US.km)
US.km$cluster
which(US.km$cluster==2)

plot(USArrests, col = US.km$cluster, pch = US.km$cluster)
plot(prcomp(USArrests, center = TRUE)$x[,c(1,2)],col = US.km$cluster, pch = US.km$cluster)
# PC1 is largest loading

m=20
set.seed(1)
wss=numeric(m)
for (i in 1:m){
  US.km <- kmeans(USArrests, centers = i)
  wss[i]=US.km$tot.withinss
}
plot(wss,type="b",xlab="k (number of clusters)", ylab="Total within sum of squares")
# scree plot 모양, 경사가 완화되는 cluster 3~5 정도가 적절할듯

US.km <- kmeans(USArrests, centers = 5)
plot(USArrests, col = US.km$cluster, pch = US.km$cluster)

# 표준화 시켜주주지 않은결과



### Normal Mixture Models
#install.packages("mclust")
library(mclust)
fit<-Mclust(USArrests)
plot(fit,what="classification")
fit$classification
fitBIC<-mclustBIC(USArrests)
summary(fitBIC)
## VEI  
  help(package="mclust")
  ## p8 참고 

fitModel<-mclustModel(USArrests,fitBIC,G=1:5)

fitModel

names(fitModel)
fitModel[[1]]
fitModel[[2]]
fitModel[[3]]
fitModel[[4]]
fitModel[[5]]
fitModel[[6]]
fitModel[[7]]

fitModel[[8]]
# 결과가 각 데이터가 어느 클러스터에 포함 될지 확률 ~ 
# p41 에 (assigning each item into a grop)이 그 공식

?mclustModel


############# 변수의 수가 6000 많은 예제

# install.packages("ISLR")
library(ISLR)
str(NCI60)
ncol(NCI60)
head(NCI60)

nci.labs=NCI60$labs
nci.data=NCI60$data
#Each cell line is labeled with a cancer type.
#We do not make use of the cancer types in performing PCA and clustering,
#as these are unsupervised techniques.
#But after performing PCA and clustering, we will check to see the extent to which
# these cancer types agree with the results of these unsupervised techniques.
dim(nci.data)
nci.labs
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
#6000개의 변수들이 있으므로 산점도로 그리기엔 어려움 
#주성분 분석을 통해 클러스터링이 잘 작동하는 예제인지 관찰!
#z1,z2,z3 은 각각 PC1,2,3
#(principal component 주성분 분석은 변수들이 많을때 시각화를 위해 활용)


summary(pr.out)
plot(pr.out)
pve=100*pr.out$sdev^2/sum(pr.out$sdev^2)
par(mfrow=c(1,2))
plot(pve, type="o", ylab="PVE", xlab="Principal Component", col="blue")
plot(cumsum(pve), type="o", ylab="Cumulative PVE", xlab="Principal Component", col="brown3")
#PC의 수를 결정?

# Clustering the Observations of the NCI60 Data
sd.data=scale(nci.data) # 표준화
par(mfrow=c(1,3))
data.dist=dist(sd.data)
plot(hclust(data.dist), labels=nci.labs, main="Complete Linkage", xlab="", sub="",ylab="")
plot(hclust(data.dist, method="average"), labels=nci.labs, main="Average Linkage",
     xlab="", sub="",ylab="")
plot(hclust(data.dist, method="single"), labels=nci.labs, main="Single Linkage",
     xlab="", sub="",ylab="")
hc.out=hclust(dist(sd.data))
hc.clusters=cutree(hc.out,4)
table(hc.clusters,nci.labs)
par(mfrow=c(1,1))
plot(hc.out, labels=nci.labs)
abline(h=139, col="red")
hc.out

set.seed(2)
km.out=kmeans(sd.data, 4, nstart=20)
km.clusters=km.out$cluster
table(km.clusters,hc.clusters)
# diagonal에 별로 결과가 없다는 것은 어떤 분석 방식을 사용하느냐에따라 결과가 달라진다는 뜻?

hc.out=hclust(dist(pr.out$x[,1:5]))
plot(hc.out, labels=nci.labs, main="Hier. Clust. on First Five Score Vectors")
# first five score vectors = first five PC
table(cutree(hc.out,4), nci.labs)
