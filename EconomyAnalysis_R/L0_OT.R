
## 경제분석 R프로그래밍

## 1일차
# Introduction to machine learning with R
# Data Mining with R / Brett Lantz / Seond edition
# Data Mining

# 부동산가격분석 / 1.회귀 / 2.시계열 / 3.머신러닝 / 방법中
# 시계열 : ARMIA model / AR model
# 로지스틱 회귀분석 - 프로빗 모형?
# Deep learing
# Artificial neural network - ANN 모형?(인공신경망)
# BigData : LASSO - 많은 sample & 독립변수가 多 (ex.10만개)   
#                Large Dimention (10만,10만) 역행렬구하기 어려움
#                -> 필요없는 독립변수를 줄이자

## Yt = a + bXt + cYt-1 + et -> ARX(1) 한 term 전에 Y자료를 사용하고(AR1) X또한 사용(+X)
# consistent 일치추정량(n이 무한대로 갈때 모수로 수렴하는 추정량)
# 언제 a,b,c이 일치추정량이 되는가?
# -> 이론상 : E(et|ft)=0 이 되는경우
# -> 변수끼리 correlation 이 있을때
# -> 보통 누락된 변수 (dZt)가 있을 때 일치추정량이 아니게 됨 
# ex. Yt 실업률 : Xt GDP , Yt-1 전해실업률 , Zt 구글트랜드/네이버트랜드/25개수신문사의키워드빈도수사이트

# Report : table 만들어서 최고 양질의 visualize된 자료 / 명확,깔끔 