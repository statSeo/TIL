#### PCA
dim(USArrests) # 50x4
head(USArrests)


## 방법1. using prcomp function

pcfit=prcomp(USArrests, scale=TRUE) # scale 옵션 : 평균을 0으로 두는 것은 무조건이지만 분산까지 1로 두는 scale을 적용시킬 것이냐.
pcfit$rotation   ## PC loadings
pcfit$x   ##   PCs = (Make.Z(as.matrix(USArrests) ) %*% pcfit$rotation ) / 그냥 USArrests랑 곱하면 결과가 다름. 왜냐면 평균을 0으로 맞췄으므로 , 심지어 여기선 분산까지 0으로 맞춤 
pcfit$sdev ## square root of lambda
pve=pcfit$sdev/sum(pcfit$sdev)*100
cumsum(pve)
biplot(pcfit, scale=0)
screeplot(pcfit, type='lines')

## 방법2. using svd (Spectum decomposition)
data_c=scale(USArrests, center = TRUE, scale = TRUE) #svd는 표준화 안해주므로 따로 scale 함수.
# apply(data_c,2,var); apply(data_c,2,mean)
# apply(USArrests,2,var); apply(USArrests,2,mean)

cor.mat<- svd(cov(data_c))
names( cor.mat )

pc_loading=cor.mat$u   ## PC loadings  
pc_loading # 부호만 다르고 같음. 
apply(pc_loading^2,2,sum)

lambda=cor.mat$d  ##square of sdev of prcomp
lambda # = pcfit$sdev^2 = apply(pc,2,var)
sum(lambda) # = sum(diag(var(data_c)))

dim( data_c ) 
pc =  data_c %*% pc_loading   ## PC score
#  nxp =  nxp  pxp  
dim(pc)
pc[,c(1,2)]
var(pc)



################### PCR####################################################


library(pls)
library(ISLR)
head(Hitters)
dim(Hitters)
Hitters=na.omit(Hitters)

set.seed(2)
pcr.fit=pcr(Salary~., data=Hitters,scale=TRUE,validation="CV") # scale 옵션 : 평균을 0으로 두는 것은 무조건이지만 분산까지 1로 두는 scale을 적용시킬 것이냐.
summary(pcr.fit)
validationplot(pcr.fit,val.type="MSEP")
which.min(MSEP(pcr.fit)$val[1,1,])  ## CV prediction ERROR according to number of PC

names(pcr.fit) 
q=5
pcr.fit$coefficients[,,q]   ## beta_PCR of X using 4 PC (note that coeff of X not Z)
# 강학상이 아닌 X와의 관계를 설명해주기 위해서.

## above is same as
#fit_pcr=lm((Hitters$Salary)~pcr.fit$scores[,1:q] -1) 
#pcr.fit$loadings[,1:q]%*%fit_pcr$coefficient

head(pcr.fit$fitted.values[,,q])  ## same as  (scale(x) %*% pcr.fit$coefficients[,,q]    + pcr.fit$Ymeans) = Yhat_PCR
dim(pcr.fit$scores)
dim(pcr.fit$scores[,1:q])




## 데이터셋이 충분하다면 train test로 나눠서
set.seed(20)
train=sample(c(TRUE, FALSE) , nrow(Hitters), rep=T)
test=(!train)
pcr.fit=pcr(Salary~., data=Hitters,subset=train,scale=TRUE, validation="CV")
validationplot(pcr.fit,val.type="MSEP")
which.min(MSEP(pcr.fit)$val[1,1,])

x=model.matrix(Salary~., Hitters )[,-1]
pcr.pred=predict(pcr.fit,x[test,],ncomp=6) #predict
y.test=Hitters$Salary[test] #true

mean((pcr.pred-y.test)^2) #testMSE
