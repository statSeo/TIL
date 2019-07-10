
## MLE_optimization 
# opti_ex2


# 쌍봉형태의 분포를 사용.
x1 <- rnorm(500,0,1)
x2 <- rnorm(500,3,1)

z<- c(x1,x2)
n<- length(z)

hist(z)
plot(density(z)) # 비모수 커널방법으로 그린 pdf


#
## MLE : Normal
#

# log likelihood sum의 최대화 =  likelihood(결합확률분포) 최대화
# -는 후에 최적화 과정에서 사용 (기본 최소화 -> 최대화)
norm <- function(x){
  -sum(log(dnorm(x=z,x[1],x[2])))
}
# 초기 mean과 분산을 1,1 로 주고 
# smooth하고 연속적이고 무한대까지 쓸수있고~~ : 그래서 optim 사용?
# 헤시안 옵션또한 여기서는 중요할수 있음.
# 헤시안(정보행렬)의 역행렬 이 MLE의 분산,공분산 행렬.
norm.est <- optim(c(1,1), fn=norm)
norm.par <- norm.est$par
norm.est # par : mean,s.d 추정치 , value:dnehrkqt , count : 반복횟수 converse 0 성공적 수행

xx <- seq(min(z),max(z),length=20)
lines(xx,dnorm(xx,norm.par[1],norm.par[2]),col="blue",lwd=2)
# 추정된 MLE추정치로 모수적 norm pdf 덧그림.
# 발생한 오차들을 어떻게 줄일 것이냐.


#
## MLE : Quartic dist
#

opti_ex2 참고

#Quartic dist : 노말pdf에서 자연상수 지수에 3승,4승 값포함 : 좀더 유연 -> 결론 : 더 flexible한 분포 필요 (6승까지 8승까지 좀더 늘려봐야)

# 사진참조.
# -12~12 까지(무한대가 아닌) integrate: 왜 그랬을까???