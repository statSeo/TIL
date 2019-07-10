
## R
# 시계열 4요소중

# 디터미머시기 트렌드 ; 트랜드 제거

# 더미 베리어블 ; 시즌너리티 제거 

# 우리가 흔히 얘기하는 사이클이 아닌 두요소를 제거한 애애 노이즈가 아닌 것들 ; 사이클
# AR등으로 표현가능

# Wold's representation theorem
# 정상성을 만족하는 시계열을 이렇게 표현가능 
# 아래 조건을 만족할때

#-> page 18
# 무한히가 아닌 q 와 p로 끝나는 시그마를 해도 approximate함

# p58
# code_Forc_Rev_3.R 파일


# p67
# 예측을 할때 매 시간에 요런 다이나믹스를 따랐음을 가정한것. 
# 특정시점에 저 다이나믹스를 따르지 않으면 아예 쓸모없는 추정치가 된것.
# ex. 2008년 글로벌금융 위기 전후로 시장의 성격이 달라졌으므로 stable하지 않음!
#  yt = ρ1 y(t-1) + ρ2 y(t-2) + ρ3 y(t-3) + β1 t + β2 t^2 + δ1 D1t + ... + δ12 D12t
# 각변수가 stationary 한지 봐주자?
# 기타 CUSUM 방법등이 있음(참고만)


# p77
# y의 T+h 시점의 값을 예상하려면 X의 T+h 값을 가지고 있어야?
# conditional forecast

# p81
# unconditional forecast
# x또한 forecast하고 그 값으로 다시 y를 forecast : 많이 쓰지않음
# X의 t-1을 이용하여 Y를 forecast함 : 요즘 뜨고 자주 사용 (Predictive Regression)


# code_Forc_Rev_3.R 파일, forecast부분.
# 추정한(forecast) 값들은 랜덤함 /  분포를 가짐  / 허나 분포를 보여줄수 없을시 confidence interval이라도 보여주어야?
# confidence interval : upper bound , lower bound
