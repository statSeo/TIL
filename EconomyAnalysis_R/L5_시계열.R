
## Forecasting_Reviews.pdf

# page2
# Et : noise
# X(w,t), 확률변수란 사실 함수! 
# t를 fix시키면 일반적으로 쓰이는 X
# w를 fix시키면 시계열에서 쓰이는 Xt
#
# x-11ARIMA : 데이터의 계절성을 제거하는 방법
#
# 1번째텀 time / 2번째텀 Seasonality 는 쉽게 제거 가능
# yt-(β0+β1t)-(∑δi Dit) = Cycle + Et : 우상향하는애, 계절에 따라 달라지는애
#
# 남은 Cycles만 제거하면 남은 값은 완전하게 지들끼리도 랜덤한 노이즈만 남게됨
# -> Cycle을 어떻게 모델링 할 것 인가 

# page3
# 싸이클은 정상성을 만족함. / 우리가 예측하는 바에서 움직임
# Suppose the underlying prob structure were changing over time. Then we cannot predict the future accurately.

# page4
# 이 세가지 조건을 만족하면 정상성을 만족한다고 봄. = stationary
# 1. 모든 시점에서 yt의 기대값은 μ
# 2. 모든 시점에서 yt의 분산도 동일
# 3. 오늘시점과 일년전 gdp는 오늘이나 일년전 영향이 아닌 그 사이시간에만 영향을 받음 / 자기공분산이 시차 τ로만 영향 / 
#
# Mean-reverting 하는 시계열에 우리는 관심이 있음
# ex. 비정상적 시계열 I(1) : 한번 차분시키면 정상시계열이 되는 모델
# https://www.quantinsti.com/wp-content/uploads/2017/03/Mean-Reversion-in-Time-Series-3.png

# page5
# 공분산 / 분산 = correlation 
# -> Autocorrelation 
#
# βτ가 의미하는 것 : y(t-τ)가 y(t)에 얼마나 영향을 미치는가? 
#                        (+ 나머지는 전부 fix되었을 때!!)
#                       = partial Autocorrelation 
#
# 비정상 시계열 : 10만년전 화산이 터진게 지금에도 영향을 주고 있음 -> 지금 GDP에 영향
# τ가 증가할 수록 0으로 감

# page6
# 비정상 시계열.

# page7
# y축을 로그 디퍼레이션 시켜 증가율로 바꿔줌
# stationary 해짐

# page8
# x축:τ(타우)/ y축:Auto correlation
# τ가 조금만 커져도 오토 correlation이 제로가 되어야
# non stationary

# page9
# stationary

# page 10
# White Noice
# Auto correlation이 0이 됨 : inear dependance 가 없음
# independent! : non linear dependance 까지 없음

# iid 추가 strong WN / normal,iid 추가 Gaussian WN.

#  Ω(t-1): t−1 시점에 모든 정보를 가지고 있음
# 조건부 평균 : 0
# 조건부 분산 : σ^2

#즉 화이트 노이는 조건부 평균과 그냥 평균이 같음
#즉 Ω(t-1)는 화이트노이즈를 계산하는데 아무런 도움이 안됨
#즉 디펜던스가 없음

#page12~13 (중요)

#page14 (중요)
#어떤 an any zero-mean covariance stationary process 형식도 요렇게 표현할수 있음
#즉, 어떤 약 정상성을 만족시키는 시계열을 자료를 가져오든 이런식으로 표현가능
# where b0 = 1 , ∞ ∑ bi ^2 = 0 (bi가 매우 빨리 0으로 감소 하므로 이런 식으로도 쓸수 있다.) 

#page15
# linaer process만으로 분석해도 똑같애

#page18(중요)
# 무한한 B(L)을 유한한 이 두개의 유한한 Θ(L)/Φ(L) 비로 approxiate할 수 있음
# Θ(L)yt = Φ(L)εt?

#다시 page14보고

#Yt = B(L)εt = ∑bi εt-i
#어떤 time series도 MR(∞)으로 approximate 할 수 있고

#Yt = Θ(L)/Φ(L) * εt
#이것을 유한한 ARMA(p,q)로 다시 approximate 가능


# page22 (중요)
# 간단한 모형은 잘맞춤
# 복잡한 모형은 잘맞춘다는 보장x (in-sample에선 잘하겠지만, 미래도 예측 가능한지)

# page23
# MA는 다이나믹스가 세지않음, 굉장히 weak함
# page24-> Θ가 0.4든 0.95든 그 그래프 차이가 크지않음

## code_Forc_Rev_1.R / Go

#-----------------------------

## page48 (ARmA)
# εt에서 cycle을 분리하자?
# Θ(L)εt = Φ(L)ηt
# εt는 yt역할 / ηt 진정한 노이즈

# page51
# 굉장히 심한 계절성

# page52
# 로그를 취함 : smooth해짐

# page54
# 회색이그냥 / 파랑색이 로그취한애? ^2(Quadratic)한애?

# page55
# trend를 제거

# page57 
# constant가 없어서 다중공성선이 없음?
# seasonality를 제거

## page 66 까지 복습해