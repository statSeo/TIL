
### Forecasting_Example_debt.zip

# page 19
# EMS의 y값은 1,2,3,4,5

# page 20
# 1은 constant / 두개의 설명변수 -> 히든레이어 1층 -> Y 하나의 종속변수
# 인공신경망 : 해석의 어려움,blackbox (이게 경제학이냐? 그냥 데이터 피팅.)
# y = α + βx + ε
#    ↓↓↓↓↓
# y = f(α + βx )
# f-1(y) = α + βx

# page 24
# 생각보다 correlation이 크지않음
# index와는 오히려 음의 상관
# 9개의 변수를 다 쓰지않고 PCA

# pca.pdf (R_lib)
# 변수를 끼리 share하고 있는 hidden structure를 찾자
#PCA Principle 1: 상관관계가 높은 놈들은 버림
#PCA Principle 2: 분산이 큰놈이 좋다.
#Cov(PX) is diagonal and the entries on the diagonal are in descending order
#즉 여기서(1,1)이 제일 좋은값

## factor model (PCA아이디어 사용.)
## y = α + β unemploy + ε
## ozal relationship 이 되기위해서는 β , ε 들이 orthogonal해야
## y = α + (υ f) + β unemploy + ε
## unknown factor, f 삽입 (β,ε 을 orthogonal하게 만들어주는) -> factor model

# page 25
# 9개의 새로운 PCA 변수 중 몇개까지 사용? 여기선 1개
# page 29
# 신문PCA를 디트랜드시켜서

# page 30
# L1 : 즉 경보지표를 위한 lag 1 변수 사용.

# page 31
# 빨간색이 예측값, 파란색이 실제 EMS값

# page 32 
# lag 2 까지 사용


# EWS_q_M2.r 이 Lag 2 까지 사용한 모델.,

## 시험 : ~~방법이 있는데 추정해라 
## ~~ 하고싶은데 추정해라.
## 데이터를 받아서 이런현상에대하서 리포트를 써라
# 함수만들고 루프돌리기.
# 수업시간에 라이브러리사용해라.
# regression / time series / PCA / 

