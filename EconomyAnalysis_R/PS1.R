aa<-read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/PS1/spot_future.csv")
names(aa)

soybeans_log<-log(aa$soybeans)
soybeanf_log<-log(aa$soybeanf)
soybeans_logdiff<-diff(soybeans_log)
soybeanf_logdiff<-diff(soybeanf_log)

soyaoils_log<-log(aa$soyaoils)
soyaoilf_log<-log(aa$soyaoilf)
soyaoils_logdiff<-diff(soyaoils_log)
soyaoilf_logdiff<-diff(soyaoilf_log)

wheats_log<-log(aa$wheats)
wheatf_log<-log(aa$wheatf)
wheats_logdiff<-diff(wheats_log)
wheatf_logdiff<-diff(wheatf_log)

corns_log<-log(aa$corns)
cornf_log<-log(aa$cornf)
corns_logdiff<-diff(corns_log)
cornf_logdiff<-diff(cornf_log)

coffees_log<-log(aa$coffees)
coffeef_log<-log(aa$coffeef)
coffees_logdiff<-diff(coffees_log)
coffeef_logdiff<-diff(coffeef_log)

## (a)
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

## (b)
library(forecast)

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

## (c)
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
wheat_garch <- ugarchfit(spec=wheat_spec, data = wheats_logdiff, solver.control = list(trace=0))
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

## d

ols_var <- var(soybeans_logdiff - soybean_OLS$coefficients[[2]]*soybeanf_logdiff);ols_var
arima_var <- var(soybeans_logdiff - soybean_arima$coef[[length(soybean_arima$coef)]]*soybeanf_logdiff);arima_var
garch_var <- var(soybeans_logdiff - 0.922130*soybeanf_logdiff);garch_var
min(ols_var,arima_var,garch_var)

ols_var <- var(soyaoils_logdiff - soyaoil_OLS$coefficients[[2]]*soyaoilf_logdiff);ols_var
arima_var <- var(soyaoils_logdiff - soyaoil_arima$coef[[length(soyaoil_arima$coef)]]*soyaoilf_logdiff);arima_var
garch_var <- var(soyaoils_logdiff - 0.971533*soyaoilf_logdiff);garch_var
min(ols_var,arima_var,garch_var)

ols_var <- var(wheats_logdiff - wheat_OLS$coefficients[[2]]*wheatf_logdiff);ols_var
arima_var <- var(wheats_logdiff - wheat_arima$coef[[length(wheat_arima$coef)]]*wheatf_logdiff);arima_var
garch_var <- var(wheats_logdiff - 0.971533*wheatf_logdiff);garch_var
min(ols_var,arima_var,garch_var)

ols_var <- var(corns_logdiff - corn_OLS$coefficients[[2]]*cornf_logdiff);ols_var
arima_var <- var(corns_logdiff - corn_arima$coef[[length(corn_arima$coef)]]*cornf_logdiff);arima_var
garch_var <- var(corns_logdiff - 0.929099*cornf_logdiff);garch_var
min(ols_var,arima_var,garch_var)

ols_var <- var(coffees_logdiff - coffee_OLS$coefficients[[2]]*coffeef_logdiff);ols_var
arima_var <- var(coffees_logdiff - coffee_arima$coef[[length(coffee_arima$coef)]]*coffeef_logdiff);arima_var
garch_var <- var(coffees_logdiff - 0.719159*coffeef_logdiff);garch_var
min(ols_var,arima_var,garch_var)





##################3
bb <- read.table("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/PS1/housing.txt",header=T)

attach(bb)
# p area fl age sea bal ne se sw roof mtr swim shop
res1 <- lm(p ~ area+ fl+ age+ sea+ bal+ ne +se +sw+ roof +mtr+ swim +shop)
res1.s <- summary(res1)
res1.s
# 방이 하나 더 있으면 '평균적으로' 12천불의 가격이 올라감.
# 1스퀘어 핏이 올라갈때 '평균적으로' 0.13 천불의 가격이 올라감 (매우 시그니피컨트)


# 분위수 회귀로 해보자
library(quantreg)
taus <- seq(0.05, 0.95, length=100)
res2 <- rq(p~ area+ fl+ age+ sea+ bal+ ne +se +sw+ roof +mtr+ swim +shop,tau=taus)
res2.s <- summary(res2)
# Solution may be nonunique : 0이 많아서
res2.s
plot(res2.s)
# x축이 Y의 퀀타일
# 빨간색이 OLS선 / 빨간 점선이 OLS 신뢰구간
# bdrms : 가격이 많이 나가는 (한 0.77보다 크면 significant )집들이 배드룸이 하나 늘어나면 이 만큼 coefficient의 변동이 생기더라
# sqrfit : 가격이 많이 나가는 집들이  sqrfit 값들의 영향이 커지더라

