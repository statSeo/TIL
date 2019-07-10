
##### 1번 

library(xlsx)
library(quadprog)
data1 <- read.xlsx("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/기말고사/Econ_R_Final_2018/data_port_FINAL.xlsx",sheetIndex=1,startRow=1,stringsAsFactors=F)

str(data1)
nrow(data1)
head(data1)
data2 <- data1[,-1]

#### Case1 : Minimum Variance Portfolio
return_Q1 <- c(rep(NA,nrow(data1)-120))
ppi_Q1 <- NULL

Amat <- cbind(matrix(rep(1,5),ncol = 1), diag(5))
bvec <- c(1, rep(0, 5))

for (i in 1:(nrow(data1)-120)){
  Q1 <- solve.QP(cov(data2[i:(119+i),]), c(0,0,0,0,0),
                 Amat,bvec,0)
  ppi_Q1 <- cbind(ppi_Q1,Q1$solution)
  return_Q1[i] <- t(Q1$solution) %*% t(data2[(i+120),])
}
Sharpe_Q1 <- mean(return_Q1) / (sd(return_Q1)/ length(return_Q1) )
Sharpe_Q1

plot(ts(ppi_Q1[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "Case1 : Minimum Variance Portfolio",ylab="phi")
lines(ts(ppi_Q1[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q1[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q1[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q1[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)


#### Case2 : Resampled Portfolio
library(MASS)
return_Q2 <- c(rep(NA,nrow(data1)-120))
ppi_Q2 <- NULL
sim_all_phi <- NULL
sim.n <- 500

Amat <- cbind(matrix(rep(1,5),ncol = 1), diag(5))
bvec <- c(1, rep(0, 5))

for (i in 1:(nrow(data1)-120)){
  
  sam_mean <- rbind(mean(data2[i:(119+i),1]),mean(data2[i:(119+i),2]),mean(data2[i:(119+i),3]),mean(data2[i:(119+i),4]),mean(data2[i:(119+i),5]))
  
  sam_cov <- cov(data2[i:(119+i),])
  
  for (j in 1:sim.n){
    forresample <- mvrnorm( 120 , sam_mean , sam_cov ) # 120x5
    sim.phi <- solve.QP( cov(forresample)  , c(0,0,0,0,0) ,
                         Amat , bvec , 0) 
    sim_all_phi <- cbind(sim_all_phi,sim.phi$solution) # 5x10
  }
  Q2 <- apply(sim_all_phi,1,mean)
  sim_all_phi <- NULL
  
  ppi_Q2 <- cbind(ppi_Q2,Q2)
  return_Q2[i] <- t(Q2) %*% t(data2[(i+120),])
}
Sharpe_Q2 <- mean(return_Q2) / (sd(return_Q2)/ length(return_Q2) )
Sharpe_Q2

plot(ts(ppi_Q2[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "Case2 : Resampled Portfolio",ylab="phi")
lines(ts(ppi_Q2[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q2[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q2[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q2[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)


#### Case3 : Naive Portfolio
return_Q3 <- c(rep(NA,nrow(data1)-120))
for (i in 1:(nrow(data1)-120)){
  return_Q3[i] <- t(c(rep(1/5,5))) %*% t(data2[(i+120),])
}
Sharpe_Q3 <- mean(return_Q3) / (sd(return_Q3)/ length(return_Q3))
Sharpe_Q3


ppi_Q3 <- matrix(rep(1/5,5*225),ncol = 225)
zero <- c(rep(0,225))

plot(ts(ppi_Q3[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "Case3 : Naive Portfolio",ylab="phi")
lines(ts(ppi_Q3[5,],start=1990,frequency = 12), col="yellow")
lines(ts(ppi_Q3[2,],start=1990,frequency = 12)-0.01, col="blue")
lines(ts(ppi_Q3[3,],start=1990,frequency = 12)+0.01, col="red")
lines(ts(ppi_Q3[4,],start=1990,frequency = 12)+0.015, col="green")
lines(ts(zero,start=1990,frequency = 12), lty=2)

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)

Sharpe_Q1
Sharpe_Q2
Sharpe_Q3

#=============================================================
#============================================================
##### 2번 

aa<-read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/기말고사/Econ_R_Final_2018/spot_future.csv")
names(aa)
head(aa)

soybeans_log<-log(aa$soybeans)
soybeanf_log<-log(aa$soybeanf)
soybeans_logdiff<-diff(soybeans_log)
soybeanf_logdiff<-diff(soybeanf_log)
B_soybean <- (aa$soybeans-aa$soybeanf)
# B_soybean <- B_soybean[-1]

soyaoils_log<-log(aa$soyaoils)
soyaoilf_log<-log(aa$soyaoilf)
soyaoils_logdiff<-diff(soyaoils_log)
soyaoilf_logdiff<-diff(soyaoilf_log)
B_soyaoil <- (aa$soyaoils-aa$soyaoilf)
# B_soyaoil <- B_soyaoil[-1]

wheats_log<-log(aa$wheats)
wheatf_log<-log(aa$wheatf)
wheats_logdiff<-diff(wheats_log)
wheatf_logdiff<-diff(wheatf_log)
B_wheat <- (aa$wheats-aa$wheatf)
# B_wheat <- B_wheat[-1]

corns_log<-log(aa$corns)
cornf_log<-log(aa$cornf)
corns_logdiff<-diff(corns_log)
cornf_logdiff<-diff(cornf_log)
B_corn <- (aa$corns-aa$cornf)
# B_corn <- B_corn[-1]

coffees_log<-log(aa$coffees)
coffeef_log<-log(aa$coffeef)
coffees_logdiff<-diff(coffees_log)
coffeef_logdiff<-diff(coffeef_log)
B_coffee <- (aa$coffees-aa$coffeef)
# B_coffee <- B_coffee[-1]

## 5-1 
soybean_OLS <- lm(soybeans_logdiff~soybeanf_logdiff)
summary(soybean_OLS)
soyaoil_OLS <- lm(soyaoils_logdiff~soyaoilf_logdiff)
summary(soyaoil_OLS)
wheat_OLS <- lm(wheats_logdiff~wheatf_logdiff)
summary(wheat_OLS)
corn_OLS <- lm(corns_logdiff~cornf_logdiff)
summary(corn_OLS)
coffee_OLS <- lm(coffees_logdiff~coffeef_logdiff)
summary(coffee_OLS)



##  5-2 
arimaorder( auto.arima(soybeans_logdiff , xreg=soybeanf_logdiff) ) -> soybeans_arimaoreder
soybean_arima <- Arima(soybeans_logdiff,
                       order = soybeans_arimaoreder,
                       xreg = soybeanf_logdiff,
                       method = "ML")
summary(soybean_arima)

arimaorder( auto.arima(soyaoils_logdiff , xreg=soyaoilf_logdiff) ) -> soyaoils_arimaoreder
soyaoil_arima <- Arima(soyaoils_logdiff,
                       order = soyaoils_arimaoreder,
                       xreg = soyaoilf_logdiff,
                       method = "ML")
summary(soyaoil_arima)

arimaorder( auto.arima(wheats_logdiff , xreg=wheatf_logdiff) ) -> wheats_arimaoreder
wheat_arima <- Arima(wheats_logdiff,
                     order = wheats_arimaoreder,
                     xreg = wheatf_logdiff,
                     method = "ML")
summary(wheat_arima)

arimaorder( auto.arima(corns_logdiff , xreg=cornf_logdiff) ) -> corns_arimaoreder
corn_arima <- Arima(corns_logdiff,
                    order = corns_arimaoreder,
                    xreg = cornf_logdiff,
                    method = "ML")
summary(corn_arima)

arimaorder( auto.arima(coffees_logdiff , xreg=coffeef_logdiff) ) -> coffees_arimaoreder
coffee_arima <- Arima(coffees_logdiff,
                      order = coffees_arimaoreder,
                      xreg = coffeef_logdiff,
                      method = "ML")
summary(coffee_arima)

##
library(rugarch)
soybean_spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE),
  mean.model = list(armaOrder=soybeans_arimaoreder, include.mean = TRUE, external.regressors = t(t(soybeanf_logdiff)) ),
  distribution.model = "norm", start.pars = list(), fixed.pars=list())
soybean_garch <- ugarchfit(spec=soybean_spec, data = soybeans_logdiff, solver.control = list(trace=0))
soybean_garch

soyaoil_spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE),
  mean.model = list(armaOrder=soyaoils_arimaoreder, include.mean = TRUE, external.regressors = t(t(soyaoilf_logdiff)) ),
  distribution.model = "norm", start.pars = list(), fixed.pars=list())
soyaoil_garch <- ugarchfit(spec=soyaoil_spec, data = soyaoils_logdiff, solver.control = list(trace=0))
soyaoil_garch

wheat_spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE),
  mean.model = list(armaOrder=wheats_arimaoreder, include.mean = TRUE, external.regressors = t(t(wheatf_logdiff)) ),
  distribution.model = "norm", start.pars = list(), fixed.pars=list())
wheat_garch <- ugarchfit(spec=wheat_spec, data = wheats_logdiff, solver.control = list(tol = 1e-1))
wheat_garch

corn_spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE),
  mean.model = list(armaOrder=corns_arimaoreder, include.mean = TRUE, external.regressors = t(t(cornf_logdiff)) ),
  distribution.model = "norm", start.pars = list(), fixed.pars=list())
corn_garch <- ugarchfit(spec=corn_spec, data = corns_logdiff, solver.control = list(trace=0))
corn_garch

coffee_spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE),
  mean.model = list(armaOrder=coffees_arimaoreder, include.mean = TRUE, external.regressors = t(t(coffeef_logdiff)) ),
  distribution.model = "norm", start.pars = list(), fixed.pars=list())
coffee_garch <- ugarchfit(spec=coffee_spec, data = coffees_logdiff, solver.control = list(trace=0))
coffee_garch


##



ols_var <- var(soybeans_logdiff - soybean_OLS$coefficients[[2]]*soybeanf_logdiff);ols_var
garch_var <- var(soybeans_logdiff - coef(soybean_garch)[[5]]*soybeanf_logdiff);garch_var

ols_var <- var(soyaoils_logdiff - soyaoil_OLS$coefficients[[2]]*soyaoilf_logdiff);ols_var
garch_var <- var(soyaoils_logdiff - coef(soyaoil_garch)[[3]]*soyaoilf_logdiff);garch_var

ols_var <- var(wheats_logdiff - wheat_OLS$coefficients[[2]]*wheatf_logdiff);ols_var
garch_var <- var(wheats_logdiff - coef(wheat_garch)[[4]]*wheatf_logdiff);garch_var

ols_var <- var(corns_logdiff - corn_OLS$coefficients[[2]]*cornf_logdiff);ols_var
garch_var <- var(corns_logdiff - coef(corn_garch)[[2]]*cornf_logdiff);garch_var

ols_var <- var(coffees_logdiff - coffee_OLS$coefficients[[2]]*coffeef_logdiff);ols_var
garch_var <- var(coffees_logdiff - coef(coffee_garch)[[3]]*coffeef_logdiff);garch_var


# 바꿔가며 시각화
coef(coffee_garch)[[3]]
aaa<-rep(coef(coffee_garch)[[3]],2)
plot(c(0,1),aaa,main = "Model2 : Condition (5) + (8)",ylab="beta",xlab="",type = "l",ylim=c(0.2, 1),xaxt='n',lwd=5)



