
### Forecasting_Example_debt.zip

# 가계부채가 늘었다? -> 부실대출이 늘어나면 문제
#                    -> 금리가 늘어나면 상환어려움
# but, 경제성장을 위해서는 필수적

## 강종구 2017.pdf (literature)
# 가계부채를 유량과 저량효과로 나눌수 있음

#  ↓ 가계부채를 유량과 저량으로 생각해서 하나의 index로 bound 시켜 일정 수치를 넘는지 안넘는지

# 1. 어떻게 bound 시켜 만듬?
# 2. 어떤 macro 변수를 사용? ex 대출금리
# 3. 이 macro 변수가 설명하는데 충분함?

## Data.folder
# 신문기사에서 우리가 생각한 단어 인용횟수를 새주고 timeseries화
# 근데 이 단어들을 전부 사용하면 자유도의 문제가 생기는데? (n-p-1)
# 애네들이 같이 움직이는 'common factor'가 존재할 것.
# -> PCA 사용.

# 4. Cycle을 어떻게 모델화 시킬 것인가?
# -> 전통적 : 프로빗 / 로짓 / 사인
# -> 머신러닝 : Decision Tree / SVM / 인공신경망(ANN)

## 한은_금융안정국_중간발표_박성용_v5.pdf
# Page 7 : gdp대비 가계부채 증가추이 / 가처분소득대비 가계부채 
#   -> 증가하고있음,진짜 부정적현상인가?, 언론에서 말하는 위기시점은 언제?
# page 8 : y변수, 즉 GDP나 DPI대비 가계부채로 계산하는것은 문제
#        : 증가율차로 것도 약점 존재. 부채최대치가 존재하므로 감소하는 경향.  일단 다음페이지에서는 봐주긴함 
# page 9 :  ΔHD / ΔGDP / 그차 (index1)
# page 10 : 유량과 저량효과로 나눠 생각
# page 10 : 유량은 증가율 / 저량은 비율 -> 로그화 시켜서
#         : (index2) : ω(오메가)가 커질수록 저량 / 작을수록 유량에 가까움
# loof문으로 0~1 사이에 오메가 값들을 GDP와 index와 상관관계가 가장 작은 ω(절대값으로 봤을때 가장 큰)를 선택.
## likewise, 
## Shrinkage estimator :μ햇 이 unbiased하지 않으면 
##                     :ω μ햇 + (1-ω)π 이렇게 페널티텀을 넣어줘서 unbiasted하게 만들어줌 
# page 12 : GDP증가율와 index간 상관관계 가장음이면 절대값으로했을때 1에 가까움
# 즉 index2는 trend와 variation을 더 잘 설명해줌 

# 어느정도 index여야 위기수준??
# condition한 baseline을 잡고 (use moving average)  or  시간에대한 조건부 가중치줘서 그 값이 변해야
# 나중에 EWS 라는 1~5 각기 다른 위험수준으로 잡고 5개의 biary regression 사용. -> 여기선 인공신경망.

