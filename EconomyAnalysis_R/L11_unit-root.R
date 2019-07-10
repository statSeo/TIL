
# (b) 국제유가가 다른 변수들에 의해 영향을 받는지를 분석하라.
# - conditional statistics
# - 그냥 리그레션 돌려보라

## 4. Eclass_ARCH
# 변동성이 심한 데이터 

# 리스크를 분산으로본다? (과거)
# 시변하는 분산 -> conditional variance -> 
# ARCH 모형 ( autoregussive conditional Heteroslcedastctg )
# : 자기회귀 조건부 이분산모형

# GARCH 모형 (generalized ~ )

# regreesion 은 conditional expectation 


#==========================================================

##  code_Ex_ARCH.R
# Unit-root tests 부분
# 단위근 테스트!

# 단위근이 무엇인가?  : 단위근을 갖는 시계열은 어디론가 흘러감
# AR(1) : 이 모형에서 yt는 "weak dependence" 해야함.
# cor(yt,yt+h) 가 0으로 천천히 수렴하면(h가 무한으로 갈때) weak dependence
# yt-1의 계수인 ρ가 1보다 작아지면 그러함.
# 따라서 AR(1)에서 ρ가 1이면 단위근을 갖는다고 표현함 (L = 1/ρ)
# = on the 유니서클 : ρ가 1 = yt-yt-1은 화이트 노이즈 = yt는 1차 차분 시계열
# = unit root process
# outside 유니서클 : stational process(ρ가 1보다 작음)
# inside 유니서클 : exposive process(ρ가 1보다 큼)

# yt = ρ yt-1 + ut
# H0 : ρ=1 / H1 : ρ<1

# Δyt = α yt + ut ( 가설을 0기준으로 하기위해 이렇게 바꿔서)
# H0 : α=0 / H1 : α<0

# t = (α햇 - 0) / se(α햇) ~ t(n-1) (X) / CLT (X)
#                         ~ DF     (O) / FCLT,Br (O) (왜냐면 귀무가설하 unit root process 이므로 iid가 아니다.)
# -> DF unit root test (우리가 아는 t test와 critical value만 다를뿐)
# 그전에 ut를 혹시모를 dependence를 제거하기위해 항을 하나 추가해서 (denpendence함을 다 가져가게) 할 수도 있음.
# -> ADF test (argumented ~)

# yt = α + βxt-1 + ut
# 가상 회귀 방정식 : yt ,xt가 I(1) 일때 ut가 I(1)이면  
#                 : GDP , 히말라야적설량 예제
# ut I(0)이면 공적분 회귀 방정식(Co-integrated) : 같이 움직이는 애들 long run~

# 1. xt와 yt 가 적분 시계열 데이터인지 먼저보고
# 2. ut가 적분시계열인지, 즉 공적분시계열인지 아닌지 확인 (먼저 회귀분석을 돌린후 나온 에러 햇을 ADF test해서 공적분 시계열인지 확인)
# (단위근이면 공적분시계열이 아님.)
# 3. 공적분시계열이 아닌면 정상성을 만족하게 데이터 (증가량으로 보는식으로)로 바꿔 테스트



