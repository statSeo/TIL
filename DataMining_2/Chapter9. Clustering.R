

############ ch9 . clustering


library(ISLR)
str(NCI60)
names(NCI60)
nci.labs=NCI60$labs # 암이름
nci.data=NCI60$data # 암이름 x 유전자
                    #   Y       X 
table(nci.labs)

pr.out=prcomp(nci.data, scale=TRUE) # PCA를 한번 해본것

Cols=function(vec){
  cols=rainbow(length(unique(vec)))
  return(cols[as.numeric(as.factor(vec))]) 
  # 같은이름은 같은색이 되도록 표현 
}

par(mfrow=c(1,2))
plot(pr.out$x[,1:2], col=Cols(nci.labs), pch=19,  xlab="Z1",ylab="Z2")
plot(pr.out$x[,c(1,3)], col=Cols(nci.labs), pch=19, xlab="Z1",ylab="Z3")
# 즉 PC가 클러스터링을 하지 않아도 비슷한 성질의 애들을 묶어주는 성질이 있음.



par(mfrow=c(1,3))
data.dist=dist(nci.data)
plot(hclust(data.dist), labels=nci.labs, main="Complete Linkage", xlab="", sub="",ylab="")
plot(hclust(data.dist, method="average"), labels=nci.labs,main="Average Linkage", xlab="", sub="",ylab="")
plot(hclust(data.dist, method="single"), labels=nci.labs, main="Single Linkage", xlab="", sub="",ylab="") # 보통 single은 이렇게 하나씩 도해주는 현상이 자주 나타남.

hc.out=hclust(dist(nci.data))
hc.clusters=cutree(hc.out,4) 
table(hc.clusters,nci.labs)
rect.hclust(hc.out, k = 4, border = "red") # 4개의 그룹으로 보여주어라!



## kmeans
set.seed (12)
km.out=kmeans(nci.data, 4)
km.clusters=km.out$cluster

table(km.clusters,hc.clusters) # 임의로 1,2,3,4를 주어서 달라보이지 상당히 일치함? 


## PCA -> clustering : 6830 개를 바로 클러스터링 하지않고 PCA로 차원 축소후 클러스터링.
par(mfrow=c(1,1))
hc.out=hclust(dist(pr.out$x[,1:5]))
plot(hc.out, labels=nci.labs, main="Hier. Clust. on First  Five Score Vectors ")


## pam 
library(cluster)
pam_result = pam(nci.data,4) # data matrix자리에 distance를 넣어줘도 작동. / k mean 도 마찬가지.
pam_result$clustering
dim(pam_result$medoids )
table(pam_result$clustering, km.clusters)