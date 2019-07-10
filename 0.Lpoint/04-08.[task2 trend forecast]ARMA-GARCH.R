
library(tidyverse)
library(rugarch)

category_target = "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"

setwd("C:/Users/Jiwan/Dropbox/01.Lpoint")
loading_location <- paste0("01.Data/03.XXYY/xxyy_",
                           category_target,
                           ".RData")
load(loading_location) # xx / yy 
head(xx) ; head(yy)


loading_location1 <- paste0("01.Data/02.For_New_X/new_x_",
                           category_target,
                           ".RData")
load(loading_location1) # new_x
head(new_x)

##########################################################################################
########################## Method 1 : ARMA(3,2)-sGARCH(1,1) ############################
##########################################################################################
# arma_order <- c(3,2)
# 
# spec.c <- ugarchspec(variance.model = list(model = "sGARCH", #"iGARCH"
#                                            garchOrder = c(1,1), 
#                                            submodel = NULL, 
#                                            external.regressors = NULL, 
#                                            variance.targeting = FALSE), 
#                      mean.model = list(armaOrder=arma_order,
#                                        include.mean = TRUE, 
#                                        external.regressors = NULL ))
# garch.c <- ugarchfit(spec=spec.c, 
#                      data = yy, 
#                      solver.control = list(trace=0), 
#                      out.sample = 30)
# 
# 
# infocriteria(garch.c)
# garch.c
# # plot(garch.c)
# 
# modelfor <- ugarchforecast(garch.c, data=NULL,
#                            external.forecasts = list(mregfor = NULL, vregfor = NULL),
#                            n.ahead = 30,
#                            n.roll = 0,
#                            out.sample = 30)
# 
# results1 <- modelfor@forecast$seriesFor + modelfor@forecast$sigmaFor * 1.96
# results2 <- modelfor@forecast$seriesFor - modelfor@forecast$sigmaFor * 1.96
# 
# 
# # par(new=F)
# mean00<- c(rep(NA,153),modelfor@forecast$seriesFor)
# results11 <- c(rep(NA,153),results1)
# results22 <- c(rep(NA,153),results2)
# ylim <- c(min(yy), max(yy))
# plot(yy , col="blue", ylim=ylim, xlim = c(0,220) , type="l")
# lines(mean00, col=3)
# lines(results11, col=2)
# lines(results22 ,col = 2)


##########################################################################################
########################## Method : ARMAX(p,q)-sGARCH(1,1) ############################
##########################################################################################
# "cardigan","trenchcoat","slipon","slingback","roper"
# ARMAX 에서 가져온 order
{if(category_target=="cardigan"){arma_order <- c(3,2)}
  else if(category_target=="trenchcoat"){arma_order <- c(1,3)}
  else if(category_target=="slipon"){arma_order <- c(2,2)}
  else if(category_target=="slingback"){arma_order <- c(0,1)}
  else if(category_target=="roper"){arma_order <- c(2,1)}}

dim(xx)
# xx

spec.c <- ugarchspec(variance.model = list(model = "iGARCH", #"iGARCH"
                                           garchOrder = c(1,1), 
                                           submodel = NULL, 
                                           external.regressors = NULL, 
                                           variance.targeting = FALSE), 
                     mean.model = list(armaOrder=arma_order,
                                       include.mean = F, 
                                       external.regressors = scale(xx[1:153,1:10]) )
                     # ,distribution.model = "std"
                     )

garch.c <- ugarchfit(spec=spec.c, 
                     data = scale(yy)[1:153], 
                     solver.control =list(tol = 1e-12),
                     # fit.control = list(stationarity=0,scale=1,rec.init=0.5),
                     # numderiv.control = list(hess.zero.tol=1e-7),
                     solver = 'hybrid',out.sample=0)

modelfor <- ugarchforecast(garch.c, data=NULL,
                           external.forecasts = list(mregfor = scale(xx[154:183,1:10]), vregfor = NULL),
                           n.ahead = 30,
                           n.roll = 0,
                           out.sample = 0)

results1 <- modelfor@forecast$seriesFor + modelfor@forecast$sigmaFor * 1.96
results2 <- modelfor@forecast$seriesFor - modelfor@forecast$sigmaFor * 1.96


# par(new=F)
mean00<- c(rep(NA,153),modelfor@forecast$seriesFor)
results11 <- c(rep(NA,153),results1)
results22 <- c(rep(NA,153),results2)
ylim <- c(min(scale(yy)), max(scale(yy)))
plot(scale(yy) , col="blue", ylim=ylim, xlim = c(0,220) , type="l")
lines(mean00, col=3)
lines(results11, col=2)
lines(results22 ,col = 2)

df = data.frame(modelfor@forecast$seriesFor ,results1,results2)
names(df) <- c("pre","upper","lower")
saving_location <- paste0("01.Data/04.ARMA-GARCH_result/",
                            category_target,"_arma-garch_traintest",
                            ".csv")
write.csv(df,file = saving_location)


##########################################################################################
##################################### forcast #######################################
##########################################################################################


spec.c <- ugarchspec(variance.model = list(model = "iGARCH", #"iGARCH"
                                           garchOrder = c(1,1), 
                                           submodel = NULL, 
                                           external.regressors = NULL, 
                                           variance.targeting = FALSE), 
                     mean.model = list(armaOrder=arma_order,
                                       include.mean = F, 
                                       external.regressors = scale(xx[,1:10]) )
                     # ,distribution.model = "std"
)

garch.c <- ugarchfit(spec=spec.c, 
                     data = scale(yy), 
                     solver.control =list(tol = 1e-12),
                     # fit.control = list(stationarity=0,scale=1,rec.init=0.5),
                     # numderiv.control = list(hess.zero.tol=1e-7),
                     solver = 'hybrid',out.sample=0)

modelfor <- ugarchforecast(garch.c, data=NULL,
                           external.forecasts = list(mregfor = scale(new_x[,1:10]), vregfor = NULL),
                           n.ahead = 14,
                           n.roll = 0,
                           out.sample = 0)

results1 <- modelfor@forecast$seriesFor + modelfor@forecast$sigmaFor * 1.96
results2 <- modelfor@forecast$seriesFor - modelfor@forecast$sigmaFor * 1.96


# par(new=F)
mean00<- c(rep(NA,183),modelfor@forecast$seriesFor)
results11 <- c(rep(NA,183),results1)
results22 <- c(rep(NA,183),results2)
ylim <- c(min(scale(yy)), max(scale(yy)))
plot(scale(yy) , col="blue", ylim=ylim, xlim = c(0,220) , type="l")
lines(mean00, col=3)
lines(results11, col=2)
lines(results22 ,col = 2)

df = data.frame(modelfor@forecast$seriesFor ,results1,results2)
names(df) <- c("pre","upper","lower")
saving_location <- paste0("01.Data/04.ARMA-GARCH_result/",
                          category_target,"_arma-garch_forecast",
                          ".csv")
write.csv(df,file = saving_location)
