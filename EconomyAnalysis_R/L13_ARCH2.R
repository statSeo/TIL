
## Example_ARCH_CAU.pdf
## page 9

# AR(1) 
# Yt = β0 + β1 yt-1 + εt / εt ~ N(0,δt^2)
# E(yt | yt-1) 햇  = β0햇 + β1햇 yt-1

# ( εt | Ft-1 ) ~ N(0,δt^2)  : 조건부 분산.
# Ft-1 : Information avaliable at t-1


# δt^2 = c0 + (i=1~p)∑ ci ε(t-i)^2
# 각각 시점의 이분산은 각각 시점의 오차의 제곱의 영향을 받음
# -> ARCH(p) : 자기회귀 조건부 이분산 모형

# δt^2 = c0 + (i=1~p)∑ ci ε(t-i)^2 + (i=1~q)∑ βj δ(t-j)^2
# 뿐만 아니라 자기 자신의 이분산의 영향도 받음
# -> GARCH(p,q)

# GARCH(1,1) = ARCH (∞)

# stock return이 주어졌을때 stock return 자체는 예측하기 힘들지만
# 조건부분산(변동성)은 예측 하기 쉽다 

## page 10
# return은 autocorrelation이 없다. 
# 제곱은 시킨애들은 autocorrelation은 autocorrelation이 있다. 즉 과거로 예측 할 수 있다.


# page 14 
# 변동성 예측

## code_Ex_ARCH.R

