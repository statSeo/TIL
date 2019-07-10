
## 5. Okun_GARCH_Reg.foler
# gdp vs 실업률

# 먼저 데이터 기초통계량들을 봐준결과
# 분산들이 시계열 상관이 있다?
# 제곱들이 시계열 상관이 있다 (ARCH effect) : 자기회귀 조건부 이분산

# 일반적인 오쿤
# -> ut - ut-1 = β0t + β1t (yt - yt-1) + dtr + εt
# -> ut - ut* = β0t + β1t (yt - yt*) + dtr + εt : 자연실업률 확용
# t별로 베타 계수값이 다른 모형이나 우리는 같다고 생각하고 해보자
# dt * r 은 gdp를 제외한 실업률에 영향을 주는 값.

# 경기가 좋아졌을때 남성의 실업률은 여성의 실업률보다 빠르게 감소
# 이런것들을 봐 줄것.

## read me_data.txt
# 실질gdp사용

#==================================================

## Korea quaterly
# diff_all diff_a15_24 diff_a25_34 diff_a35_44 diff_a45_54 diff_a55 diff_mall diff_m15_24  
# diff_m25_34 diff_m35_44 diff_m45_54 diff_m55 diff_fall diff_f15_24 
# diff_f25_34 diff_f35_44 diff_f45_54 diff_f55 diff_gdp 

data <- read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/5. Okun_GARCH_Reg/hp_diff_1.csv", header=T)

names(data)
data.ts <- ts(data,start=c(1980,2), end=c(2014,4),frequency=4) # 차분했으므로 2분기 부터
data.ts[1,20:38]
plot(data.ts[,1])

x <- data$diff_gdp # ln_gdp
y <- data$diff_all # all unemployment


##making seasonalized dummy (더비 라이브러리를 써도) 계절별로 실업률이 다를 수도 있으니?

D <- matrix(NA, ncol=3, nrow=length(y))
for(i in 1:3){
  dummy <- ts(rep(0,length(y)), frequency=4, start=c(1980,2))
  aa <- cycle(dummy)
  dummy[aa==i] <- 1
  D[,i] <- dummy
}

#
## OLS
#
res <- lm(y~x+D)
summary(res) 
# 더미변수의 해석
# 4/4분기에 비해서 1/4분기실업률이 이렇고 
# 4/4분기에 비해서 2/4분기실업률이 이렇고 
# 4/4분기에 비해서 3/4분기실업률이 이렇고 
resi <- res$residuals
plot(resi,type='l') # time(index)에 따라 residual의 변동성이 차이가 남. -> 조건부 분산의 변동성. -> GARCH모형으로 에러텀을 손보자

## GARCH Regression (GARCH + 알파)

#  conditional mean 모형.
# yt = β0 + β1 xt + δ1 d1t + δ2 d2t + δ3 d3t + εt
# εt = σt ut , ut ~ iid N(0,1) 이런가정을 사용
#  E(εt) = σt E(ut) 
#  Var(εt) = σt^2 Var(ut)   : 요런 식으로 편리 하므로 저 가정사용

#  variance 모형.
# 또한 분산은 GARCH(1,1) 모형
# σ^2t = C0 + C1 σ(t-1)^2t + C1 ε(t-1)^2t 

# 최우추정량으로 β1햇 구함 (즉 OLS가 아님.)

# OLS을 썼을때는 β1햇의 분산이 커짐 (∵이분산을 고려하지 않음)
# 이분산을 고려하는 모델을 사용시 β1햇의 분산이 작아짐
# 

#
## simple GARCH(1,1) Regression 
#
library(rugarch)

data.c <- cbind(y, D, x)


# 모형을 setup : ugarchspec 클래스
spec.c <- ugarchspec(
                     variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE), # external.regressors : 변동성에 영향을 주는 다른 변수를 사용하느냐 우리는 여기서 사용 x 
                     mean.model = list(armaOrder=c(1,0), include.mean = TRUE, external.regressors = cbind(D,x)), # armaOrder=c(1,0) : ρ y(t-1) 변수 추가, include.mean 상수 포함 여부 , external.regressors : x와 더미 변수들
                     distribution.model = "norm", start.pars = list(), fixed.pars=list())

# 위 셋업한 모형 사용하여 추정.
garch.c <- ugarchfit(spec=spec.c, data = data.c[,1], solver.control = list(trace=0))

garch.c
'''
GARCH Model	: sGARCH(1,1)
Mean Model	: ARFIMA(1,0,0)
Distribution	: norm 

        Estimate  Std. Error
mu      0.009047    0.053459 β0 
ar1     0.013297    0.098085 ρ
mxreg1  0.719467    0.072814 δ1
mxreg2 -0.463976    0.065924 δ2
mxreg3 -0.025064    0.056311 δ3
mxreg4 -0.070806    0.023211 β1 
# cbind(D,x) 로 넣어줬으니 이런식으로
omega   0.007934    0.004190 C0
alpha1  0.418816    0.113201 C1
beta1   0.580184    0.072205 C2 #C1+C2가 1과 가깝다?
'''
infocriteria(garch.c)

modelfor <- ugarchforecast(garch.c, data=NULL,
                           external.forecasts = list(mregfor = cbind(D,x), vregfor = NULL),
                           n.ahead = 30,
                           n.roll = 0,
                           out.sample = 30)
# modelfor <- ugarchforecast(spec.c, data=scale(yy),
#                            external.forecasts = list(mregfor = ff, vregfor = NULL),
#                            n.ahead = 30,
#                            n.roll = 0,
#                            out.sample = 30)

results1 <- modelfor@forecast$seriesFor + modelfor@forecast$sigmaFor * 1.96
results2 <- modelfor@forecast$seriesFor - modelfor@forecast$sigmaFor * 1.96


# par(new=F)
mean00<- c(rep(NA,length(data.c[,1])-30),modelfor@forecast$seriesFor)
results11 <- c(rep(NA,length(data.c[,1])-30),results1)
results22 <- c(rep(NA,length(data.c[,1])-30),results2)
ylim <- c(min(data.c[,1]), max(data.c[,1]))
plot(data.c[,1] , col="blue", ylim=ylim , type="l")
lines(mean00, col=3)
lines(results11, col=2)
lines(results22 ,col = 2)
