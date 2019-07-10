
## 지난시간에 한 것 +
## example 1 를 몬테카를로 / 부스트래핑으로 추정량 여러개 구해서 분포찾기

# M1 : yi=β0+β1x+εi
# M2 : yi=δ1x1+vi 

## 우리가 알고 싶은 것 β1(hat) 의 분포 -> 정규 분포, 평균이 β1 , 분산이 뭐시기

# Q) ε를 200개 뽑은 난수추출을 10000번해서 각각의 만개의 β1햇 을 찾아보자 
# 부스트래핑 (x) / 걍 몬테카를로 임

b0 <- 1
b1 <- 1
x <- rnorm(200,0.7,0.1)
e <- rnorm(200,0,0.1)

y <- b0+b1*x+e
plot(x,y)

res1 <- lm(y~x)
res1$coefficients[1]

b0hat <- rep(NA,10000)
for(i in 1:10000){
  res1 <- lm(y~x)
  b0hat[i] <-res1$coefficients[1]
}
b0hat
# 이까지는 내가


### sol
b0 <- 0
b1 <- 1
x.mean <- 0.7
x.sd <- 0.1
sd <- 0.1
eps <- rnorm(200,0,sd)
x <- rnorm(200,x.mean,x.sd)
y <- b0+b1*x+eps
res <- lm(y~x)

sim.n <- 10000
b1.v <- rep(NA,sim.n)

# 위 과정을 요걸 반복
sim.n <- 10000
b1.v <- rep(NA,sim.n)
for( i in 1:sim.n){
  eps <- rnorm(200,0,sd)
  y.sim <- b0+b1*x+eps
  res <- lm(y.sim~x)
  b1.v[i] <-res$coefficients[2]
}
summary(b1.v)
## mean과 median 이 비슷 하니 대칭

hist(b1.v)
# b1이 정규분포를 따름을 알 수 있듬
# 세로축이 여기선 frequency지만 pdf에선 확률일 것

plot(density(b1.v)) #히스토그램을 smoothd 시킨것 -> Kernel density (비모수)
# Bandwidth : weight를 얼만큼 줄지에 대한 문제(삼각형의 뾰족정도) rule of sum으로 자동으로 결정해준 값
# x축에 값을 점이 아닌 작은 삼각형으로 세우고 위로 점점 누적시켜 완만하게
?density


# Q) 랜덤으로 뽑았던 esp로 200개를 복원추출해서 이 200개의 조합을
#    10000개를 다시 뽑고 그것을 가지고 다시 추정량을 구해보자
# ---> 부스트래핑

eps <- rnorm(200,0,sd) #한번만 랜덤해서 구해주고 이걸 계속 쓸 것
sim.n <- 10000
res.o <- lm(y~x)
ce.o <- res.o$coefficients

for ( i in 1:sim.n){
    eps.b <- sample(eps,200,replace=TRUE)
    y.b <- ce.o[1]+ce.o[2]*x+eps.b
    res.b <- lm(y.b~x)
    b1.v[i] <-res.b$coefficients[2]
}
summary(b1.v)
hist(b1.v)
plot(density(b1.v)) 
# 좀더 노말처럼 안생겼음

# sample이 400개 밖에 없고 x의 분포를 몰라 b1의 분포를 몰라..
# 이 결과로 나온 b1.v의 값이 approxiate한 b1의 분포값




## example 2 /  β1 : 퍼센티지 체인지? / IQ가 한단위 올라갈때 로그 월급의 값의 변화

?read.table
wage2 <- read.table("C:/Users/CAU/Downloads/eclass_L1/WAGE2.raw", header = F)
dim(wage2)
head(wage2)
tail(wage2)

names(wage2)<-c("wage","hours","IQ","KWW","educ","exper","tenure","age",    
                "married","black","south","urban","sibs","brthord","meduc",
                "feduc","lwage")

head(wage2)
attach(wage2)
wage
plot(IQ,wage)
plot(IQ,log(wage))
# 두그래프를 한 패널 안에 넣으려면?
par(mfrow=c(1,2),mex=0.8) #패널,멀티 플레인 로우,mex:마진 줄이기

res <- lm(log(wage)~IQ)
summary(res)

