
library(tidyverse)
cardigan_table1 <- read_csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/01.Input_Data/01.csv_Data/cardigan_final.csv")
# plot(cardigan_table1$pref,type = "l")
cardigan_table1[,-1] -> cardigan_table1

data.frame(Date=seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1),cardigan_table1) -> cardigan_table2

# cardigan_table2$month <- substr(as.character(cardigan_table2$Date),6,7)

head(cardigan_table2)
cardigan_table2

cardigan_table2 %>%
  select(Date,direct_buy)




## 계절효과를 일주일 간격으로 해주자.
week <- as.factor(rep(1:(183%/%7+1),each=7,time=1)[1:183]) # 1주
# week <- as.factor(rep(1:(183%/%7+1),each=14,time=1)[1:183]) # 2주
dumm_week <- model.matrix(~week-1)
res_week <- lm(cardigan_table2$direct_buy~dumm_week-1)
summary(res_week)
tail(dumm_week)

## 요일 효과
# day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일")
# weekday<-factor(weekdays((cardigan_table2$Date)), levels=day_levels, ordered=F)
weekday<-factor(weekdays((cardigan_table2$Date)), ordered=F)
dummies2 = model.matrix(~weekday-1)

## 추석효과
ThxGiv <- rep(0,183)
ThxGiv[174:177] <- 1 

## 어린이날 효과
Child <-  rep(0,183)
Child[34:36] <- 1 

## 기타 공휴일 효과
holiday<-as.Date(holi[c(7:11),2],format = "%Y%m%d")
data.frame(Date = holiday , val=rep(1,length(holiday))) -> holidays
left_join(data.frame(Date=seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)),holidays,by="Date") -> holidays
holidays$val[is.na(holidays$val)] <- 0
holidays$val -> holiday
grep(1,holiday) -> holiday

## 요일 + 공휴일 
weekdays(cardigan_table2$Date)->weekday1
weekday1[holiday] <- "공휴일"
# weekday1[34:36] <- "어린이날"
# weekday1[174:177] <- "추석연휴"
# day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일",
#                 "공휴일","어린이날","추석연휴")
weekday1[c(34:36,174:177)] <- "긴연휴"
day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일",
                "공휴일","긴연휴")

weekday <- factor(weekday1, ordered=F,levels=day_levels)
dumm_weekday <- model.matrix(~weekday-1)

# res_week <- lm(cardigan_table2$direct_buy~dumm_weekday)
# summary(res_week)

# res <- lm(cardigan_table2$direct_buy~dumm_week+dumm_weekday-1)
# summary(res)
res1 <- lm(cardigan_table2$direct_buy~week+weekday-1)
res1.s <- summary(res1)


## 차원문제의 해소를 위해 더미변수들을 각 회귀계수로 변수에 넣자
coeff_week <- round( res1.s$coefficients[1:27] , 2)
coeff_weekday <- round( res1.s$coefficients[28:36] , 2)

weight_week <- dumm_week %*% coeff_week   
weight_weekday <- dumm_weekday[,2:10] %*% coeff_weekday


#################################################
# # 계절(주별) + 요일 + 추석효과  < x>
# res1 <- lm(cardigan_table2$pref~week+ThxGiv+Child-1)
# plot(res1$residuals,type = "l",ylim=c(-0.4,0.4))
# summary(res1)
# 
# fit.reg1 <- cardigan_table2$pref - res1$residuals
# plot(cardigan_table2$pref, type="l",lty=2,col="gray",lwd=1,ylab="Sales",xlab="Time", main="Fitted lines")
# lines(fit.reg1, col="blue", lty=1,lwd=2)
# 
# 
# # 계절(주별) + 요일 + 추석효과  < x >
# res2 <- lm(cardigan_table2$pref~week+weekday+ThxGiv+Child-1)
# plot(res2$residuals,type = "l",ylim=c(-0.4,0.4))
# 
# fit.reg2 <- cardigan_table2$pref - res2$residuals
# plot(cardigan_table2$pref, type="l",lty=2,col="gray",lwd=1,ylab="Sales",xlab="Time", main="Fitted lines")
# lines(fit.reg2, col="blue", lty=1,lwd=2)


## 계절(주별) + 요일 + 추석 + 어린이날 + 추석 효과  < x >
res1 <- lm(cardigan_table2$direct_buy~week+weekday-1)
plot(res1$residuals,type = "l",ylim=c(-0.4,0.4))
summary(res1)
cardigan_deseason <- res1$residuals

fit.reg1 <- cardigan_table2$direct_buy - res1$residuals
plot(cardigan_table2$direct_buy[1:153], type="l",lty=2,col="gray",lwd=1,ylab="Sales",xlab="Time", main="Fitted lines")
lines(fit.reg1, col="blue", lty=1,lwd=2)

########################################
########################################
cardigan_table2[,2] -> yy
# cbind(cardigan_table2[,3:8],weight_week,weight_weekday)-> xx
cbind(cardigan_table2[,6:8],weight_week,weight_weekday)-> xx

library(forecast)
auto.arima(res1.s$residuals) -> for_arima
arimaorder(for_arima) -> arima_order
arima_order

arima(yy[1:160], order=arima_order 
      ,xreg = xx[1:160,],
      include.mean = F,optim.control = list(maxit=500) ) -> arima_cardigan

fc <- predict(arima_cardigan,newxreg = xx[161:183,], n.ahead = 23)

plot(yy,
     type="l",lty=1,col="gray",lwd=2,ylab="Sales",xlab="Time", main="Log-Liquor Sales",xlim=c(150,183))#
lines(fc$pred, col="blue", lty=1, lwd=2)
lines(fc$pred+fc$se*1.96, col="red", lty=2, lwd=2)
lines(fc$pred-fc$se*1.96, col="red", lty=2, lwd=2)

# this idea! 다시 시작. 회귀계수 변수도 training set만으로 가자.
# 미래의 주별 회귀변수는 non linear 회귀분석으로 구하자!

###########################
## Quntile Regression ## 
###########################
library(quantreg)
qrdata = data.frame(pref = cardigan_table2$pref, weekday = weekday , ThxGiv = ThxGiv)
taus <- seq(0.05, 0.95, length=10)
resq2<-rq(pref+0.01 ~ weekday, tau = taus, data = qrdata)
resq2.s <- summary(resq2)
plot(resq2.s, xlim=c(0.001,1), ylim=c(-0.5,0.5))
# 성수기에 있어서 요일별 영향이 크다. 
