# eclass_L1 폴더에
# SMOKE , WAGE1 , hprice1


## SMOKE example
data <- read.table("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/eclass_L1/SMOKE.raw")
names(data) <- 
c("educ", "cigpric", "white", "age",       "income", "cigs", "restaurn", "lincome", "agesq", "lcigpric"  
)
head(data)

attach(data)
res1 <- lm(cigs ~ educ + cigpric + income + age + white)
res1.s <- summary(res1)
res1.s
# but cigs(Y)이 0이 너무 많은 문제.


# 분위수 회귀로 해보자
library(quantreg)
taus <- seq(0.05, 0.95, length=100)
res2 <- rq(cigs ~ educ + cigpric + income + age + white,tau=taus)
res2.s <- summary(res2)서
# Solution may be nonunique : 0이 많아서
res2.s
plot(res2.s) # 애초에 y가 0이 많아 유의한 결과 값을 볼수 없음 다른 데이터로 해보자 


## house price example
data <- read.table("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/0. eclass_L1/hprice1.raw")
names(data) <- 
  c("price", "assess", "bdrms", "lotsize",       "sqrft", "colonial", "lprice", "lassess", "llotsize", "lsqrft")
head(data)

attach(data)
res1 <- lm(price ~ bdrms + sqrft + colonial)
res1.s <- summary(res1)
res1.s
# 방이 하나 더 있으면 '평균적으로' 12천불의 가격이 올라감.
# 1스퀘어 핏이 올라갈때 '평균적으로' 0.13 천불의 가격이 올라감 (매우 시그니피컨트)


# 분위수 회귀로 해보자
library(quantreg)
taus <- seq(0.05, 0.95, length=100)
res2 <- rq(price ~ bdrms + sqrft + colonial,tau=taus)
res2.s <- summary(res2)
# Solution may be nonunique : 0이 많아서
res2.s
plot(res2.s)
# x축이 Y의 퀀타일
# 빨간색이 OLS선 / 빨간 점선이 OLS 신뢰구간
# bdrms : 가격이 많이 나가는 (신뢰구간이 0에 걸치지 않음. 한 0.77보다 크면 significant )집들이 배드룸이 하나 늘어나면 이 만큼 coefficient의 변동이 생기더라
# sqrfit : 가격이 많이 나가는 집들이  sqrfit 값들의 영향이 커지더라

res2.bs<-summary(res2,se="boot")
plot(res2.bs) # bootstrap 방법이 더 표분오차가 크므로 아까 significant한 값이 significant 하지 않음 
