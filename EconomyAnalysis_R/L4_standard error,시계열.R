
## 구글 데이터 관련 논문 필수로 읽어야하는!
# Varian2014.pdf
# CHOI_et_al-2012-Economic_Record.pdf

## forecasting : AskitasZimmermann2009.pdf



## EXample 8 

# indiviual data
# 2016년 데이터에서 텔레비전 소비 수요함수를 추정하고 싶을때
# Q = α +β P + d I + ε
# 내부재(자동차,TV)를 안사는 사람들이 많음에도(Y=0) 사는 사람들의 데이터만 가지고 비교하므로 외곡이 발생 
# 담배도 마찬가지
# -> (Heckman) Sample Selection Model
# Sample을 랜덤하게 뽑아야 하는데 의도적으로 흡연자만 뽑았으므로 특수 모델

## 우리는 이정도만 알고 재미로 그냥 봐보자.

data1 <- read.table("C:/Users/CAU/Downloads/R/eclass_L1/SMOKE.raw", header = F)
head(data1)
name <- c("educ","cigpric","white" , "age" , "income"
          ,"cigs" ,"restaurn","lincome","agesq" ,"lcigpric" )
length(name)
names(data1) <- name

# 담배가격을 올리는 이유 : 담배의 수요탄력성이 낮기 때문

# C = α + β P + ε 
# (C:담배수요, P:담배가격)
# Yp : 담배의 수요탄력성
# Yp = (dQ/dP) x (P/Q)
# aC/aP = β

# YP햇 = β햇 X (P바/Q(P바) / P바 : 기준가격

# 이러지 말고 로그를 씌워서 하면 간단
# log(C) = α + β log(P) + ε 

# but C가 0인 case가 많기때문에 단조증가 함수이므로 -값이 나온다!
# https://ko.wikipedia.org/wiki/%EB%A1%9C%EA%B7%B8#/media/File:Logarithms.svg
# 따라서 어렵더라도 정석적으로 Sample Selection Model 을 사용 하는 것이 타
attach(data1)
age2 <- age^2
res2 <- lm(cigs~log(income)+log(cigpric)+educ+age+age2+restaurn)
res2.s <- summary(res2)
# standard error 를 위해 summary 사용
# age2 term이 (-) : 밥통 둥근 그래프 모양 but 어느 위치세어 fit된 값이 모르므로 더 봐야함

# 여기서 나온 std.Error 정확?
# εi ~ iid N(0,σ^2) 라는 가정으로
# β햇 ~ N (β , σ^2/∑(xi-x바)^2 ) 라는 결과가 나온것
# loot (  ∑(xi-x바)^2  ) 가 std.Error 보여줌 
# 잔차검정으로 얼마나 신뢰할지 알 수 있을 것.

# 8.(a) : β1=1인지 검정
ccf <- res2.s$coef
dim(ccf)

test.t <- (ccf[2,1]-1/ccf[2.2])

df <- dim(data1)[1] -7 

pvalue <- 2*pt(test.t,df)
# 다시


# 8.(b) : 머라머라해서 weight값을 구한뒤 WLS 사용
install.packages("sandwich")
library(sandwich)
?vcovHC
# summary에서 **는 significient 하다는 의미이나
# 각각의 standard error 에 의존한 결과. 
# ε에 분산이 같다는 가정을 믿을수 있어 그 standard error 값이 정확하느냐?
# 어떠한 통계량을 고려하더라도 표준오차는 매우 중요한값
# 표준오차 -> 공분산행렬로? : 로버스트 standard error

# Test using HC
rsd <- sqrt(diag(vcovHC(res2, type="HC")))
# vcovHC(res2, type="HC") : 7x7 의 공분산 행렬이 나올것
# v( (β1햇,β2햇)' ) = (7x7)
# 대각원소의 있는애들만 variance : diag / (나머지는 cov)
# 로버스트 standard error로 t값 구하기
t2 <- (res2.s$coef[2,1]-1)/rsd[2]

t2.pv <- 2*dt(-t2,length(cigs)-6) # pt gives us lower tail
t2

t2.pv
# 따라서 β1 = 1이라고 cannot reject
## 이분산이 있으므로 한 예제


## Example 10 : 계량경제학에서 쓴 IV 라는데? 
# 그래서 패스한대



## Example 14 : timeseries regression  / ChickensEggs.pdf 관련
# 자기회귀모형
# AR(p) : yt = P1 y(t-1) + P2 y(t-2) + ... + Pp y(t-p) + εt

# 이동평균모형
# MA(q) : yt = 

# 자기회귀이동평균모형
# ARMA(p,q) : yt =

# (Integrated : 적분된 시계열모형) = d만큼 적분된 ARMA모형
# ARIMA(p,d,q) :
# Ya ~ ARIMA(1,1,1)
# ΔYa ~ ARMA(1,1)

## 다른 학문에서 나오는 평범한 시계열 모형은 
#  : 정상시계열모형
## 경제학에서 나오는 점차증가,점차감소 (ex.집값) 시계열 모형은 
#  : 비정상시계열모형 (적분시계열) 
# ex. Yt~I(1) : 한번 차분(or 로그차분)을 시켜주면 정상시계열이 되는 모형
#     Y(t)-Y(t-1) = ΔY(a) ~ I(0) : 정상시계열 모형이 됬다.

# ex. 수익률 예측할때


# 구글 트렌드 또한 타임시리즈 데이터


# ChickensEggs.pdf 해석
# ARIMA는 단일 변수임 / 경제학에서는 적어도 두개이상 변수

# 이 예제를 풀어보면
# Y(t) = α1 Y(t-1) + β1 X(t-1) + εt
# Y: egg / X: Chicken
# β1=0 이면 치킨은 애그를 그랜드 코즈 하지 않는다

# X(t) = α2 X(t-1) + β2 Y(t-1) + Yt
# 반대로 이 모형을 생각해보면 애그는 치킨을 그랜드 코즈한다고 볼수있다.
# but, (평균적으로) !!!  우리는 sample mean으로 결과를 본거지
# 모든 sample이 그러한 결과를 나타낸다고 볼 수 없다.
# Granger cause : http://intothedata.com/02.scholar_category/timeseries_analysis/granger_causality/\


