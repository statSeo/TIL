
#==================================================
## GARCH_reg_EX.file

data <- read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/5. Okun_GARCH_Reg/hp_diff_1.csv", header=T)

names(data)
[1] "hp_all"      "hp_a15_24"  
[3] "hp_a25_34"   "hp_a35_44"  
[5] "hp_a45_54"   "hp_a55"     
[7] "hp_mall"     "hp_m15_24"  
[9] "hp_m25_34"   "hp_m35_44"  
[11] "hp_m45_54"   "hp_m55"     
[13] "hp_fall"     "hp_f15_24"  
[15] "hp_f25_34"   "hp_f35_44"  
[17] "hp_f45_54"   "hp_f55"     
[19] "hp_gdp"      "diff_all"   
[21] "diff_a15_24" "diff_a25_34"
[23] "diff_a35_44" "diff_a45_54"
[25] "diff_a55"    "diff_mall"  
[27] "diff_m15_24" "diff_m25_34"
[29] "diff_m35_44" "diff_m45_54"
[31] "diff_m55"    "diff_fall"  
[33] "diff_f15_24" "diff_f25_34"
[35] "diff_f35_44" "diff_f45_54"
[37] "diff_f55"    "diff_gdp"  
# 성별,나이별 별로 회귀예측치와 예측구간 그래프로 나타내기

# 내가쓴것 실패.
# mean_m15<-mean(data$hp_a15_24)
# se_m15<- 1.96 * sd(data$hp_a15_24) / length(data$hp_a15_24)
# 
# library(ggplot2)
# library(tidyverse)
# 
# data %>% gather(8:12,14:18,key = 'age',value = 'unemploy')%>%
#   select(age,unemploy) -> data1
# 
# dim(data1)
# data_m <- data1[1:695,]
# data_f <- data1[696:dim(data1)[1],]
# 
# data_m <- data.frame(data_m,gender=c(rep('male',dim(data_m)[1])))
# data_f <- data.frame(data_f,gender=c(rep('female',dim(data_f)[1])))
# 
# data_mf <- rbind(data_m,data_f)
# 
# data_mf %>% select(gender,age,unemploy) %>%
#   group_by(age) %>%  # 지역별
#   summarise(unemploy.mean= mean(unemploy),
#             s.d=sd(unemploy),
#             n=length(unemploy))%>% #평균, 표준편차, 자료 수 
#   mutate(s.e=s.d/sqrt(n)) %>%
#   
#   mutate(gender=factor(c("male","male","male","male","male"
#                   ,"female","female","female","female","female")))-> aa
#  
# ggplot(aa,aes(x=age, y=unemploy.mean,group=1))+
#   geom_errorbar(aes(x=age, ymin=unemploy.mean-s.e, ymax=unemploy.mean+s.e))+
#   geom_line() +
#   facet_wrap( ~ gender)
# 
# ?facet_wrap


#==============================================================
## 일반적 회귀분석 : 조건부 평균 모형
# yi = a + b xi + ui
# E(y|x) = a + bx
# regression b : x가 한단위 올라 갈때 y가 한단위 평균적으로 떨어져.
# but, 극단치들이 있는데 평균을 믿을수 있는냐? (ex. 평균소득)

# 중위수 같은 quantile을 활용 하자. -> 중위소득
## quantile regression : 조건부 분위수(ex.중위수) 모형
# distribution function 의 역함수가 quantile function / 타우 : τ (0~1) 
# Qy(τ|X) = a + b(τ) X + Fu-1(τ)
#         = a + Fu-1(τ) + b(τ) X 
#         =     a(τ)    + b(τ) X 

# quantile regression b : x가 τ-quantile에서는 y에 이러한 영향을준다

# install.packages("quantreg")
library(quantreg)
?rq # Quantile Regression의 lm역할

# example (패키지내 복사붙여넣기.)
#plot of engel data and some rq lines see KB(1982) for references to data
data(engel)
attach(engel)
plot(income,foodexp,xlab="Household Income",ylab="Food Expenditure",type = "n", cex=.5)
points(income,foodexp,cex=.5,col="blue")
taus <- c(.05,.1,.25,.75,.9,.95)
xx <- seq(min(income),max(income),100)
f <- coef(rq((foodexp)~(income),tau=taus)) ## rq.
yy <- cbind(1,xx)%*%f
for(i in 1:length(taus)){
  lines(xx,yy[,i],col = "gray")
}
abline(lm(foodexp ~ income),col="red",lty = 2)
abline(rq(foodexp ~ income), col="blue")
legend(2200,700,c("mean (LSE) fit", "median (LAE) fit"),
       col = c("red","blue"),lty = c(2,1))
# 빨간애가 조건부 평균
# 파란애가 조건부 중위수

# 위 오쿤 예제를 lm이 아닌 rq로 돌린다면?!
rq(male.y[1]~x,tau=c(0.05,05,0.95))
plot(summary(rq))
# 실업률이 낮은 애들한테는 이런 영향 높은 애들한테는 이런 
