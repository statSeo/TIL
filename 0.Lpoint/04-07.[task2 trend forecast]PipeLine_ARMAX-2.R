
### ARMAX-1 먼저 하고와 

# arimaX 함수 만들기 ------------------------------------------------------------------

##############################################################
###################### ARMA-X GoGo ##########################
#############################################################

our_armax <- function(category_table) {
  new_week <- rep(41:43, each = 7, time = 1)[2:15]
  yy <- default_table$Direct_Buy
  dumm_weekday <- model.matrix(~ weekday - 1)
  xx <- cbind(default_table[, c(2, 4:7)], 
              poly(c(spline_week, new_week), 5)[1:dim(default_table)[1], ], 
              dumm_weekday)
  dim(xx) # 19개 변수
  
  # optimal order
  library(forecast)
  weekday <- factor(weekday1, ordered = F, levels = day_levels)
  week <- as.factor(rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183])
  res1 <- lm(default_table$Direct_Buy ~ week + weekday - 1)
  res1.s <- summary(res1)
  
  for_arima <- auto.arima(res1$residuals)
  arima_order <- arimaorder(for_arima)
  arima_order # p d q 3 0 2
  
  arima_category.train <- arima(yy[1:train_end],
                                order = arima_order,
                                xreg = xx[1:train_end, ],
                                include.mean = F,
                                optim.control = list(maxit = 500)
  )
  
  fc.train <- predict(arima_category.train, 
                      newxreg = xx[(train_end + 1):nrow(default_table), ], 
                      n.ahead = nrow(default_table)-(train_end + 1) + 1)
  
  plot(yy,
       type = "l", lty = 1, col = "gray",
       lwd = 2, ylab = "Sales", xlab = "Time",
       main = "Sales",
       xlim = c(100, 183),
       ylim = c(min(yy)*0.9, max(yy)*1.05)
  ) #
  lines(fc.train$pred, col = "blue", lty = 1, lwd = 2)
  lines(fc.train$pred + fc.train$se * 1.96, col = "red", lty = 2, lwd = 2)
  lines(fc.train$pred - fc.train$se * 1.96, col = "red", lty = 2, lwd = 2)
  # 끝
  
  # 작아야 좋은 aic
  aic <- arima_category.train$aic # 1407.559
  
  ##########################################################
  
  
  # forcast gogo~ ----
  
  arima_category.forecast <- arima(yy,
                                   order = arima_order,
                                   xreg = xx,
                                   include.mean = F,
                                   optim.control = list(maxit = 500)
  )
  
  fc.test <- predict(arima_category.forecast, 
                     newxreg = new_x,
                     n.ahead = 14)
  
  plot(yy,
       type = "l", lty = 1,
       col = "gray", lwd = 2,
       ylab = "Sales",
       xlab = "Time",
       main = "Sales",
       xlim = c(100, 197),
       ylim = c(min(yy[100:183],fc.test$pred)*0.9, max(yy[100:183],fc.test$pred)*1.05)
  )
  pred_y <- ts(c(yy[length(yy)], fc.test$pred), start = 183, frequency = 1)
  lines(pred_y, col = "blue", lty = 1, lwd = 2)
  lines(fc.test$pred + fc.test$se * 1.96, col = "red", lty = 2, lwd = 2)
  lines(fc.test$pred - fc.test$se * 1.96, col = "red", lty = 2, lwd = 2)
  
  plot(yy,
       type = "l", lty = 1,
       col = "gray", lwd = 2,
       ylab = "Sales",
       xlab = "Time",
       main = "Sales",
       xlim = c(1, 197),
       ylim = c(min(yy)*0.9, max(yy)*1.05)
  )
  pred_y <- ts(c(yy[length(yy)], fc.test$pred), start = 183, frequency = 1)
  lines(pred_y, col = "blue", lty = 1, lwd = 2)
  lines(fc.test$pred + fc.test$se * 1.96, col = "red", lty = 2, lwd = 2)
  lines(fc.test$pred - fc.test$se * 1.96, col = "red", lty = 2, lwd = 2)
  
  return(list(train.forecast = fc.train, 
              test.forecast = fc.test, 
              aic =aic,
              arima.order = arima_order)
  ) 
}
#############################################################################################

# 기본 옵션 설정하기 --------------------------------------------------------------
category_target = "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"

# train, test를 구분하는 기준을 정하자. 
library(tidyverse)
library(plotly)
train_end <- 153

# 필요한 데이터 불러오기 
# new_x를 불러오자
# setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint")
setwd("C:/Users/Jiwan/Dropbox/01.Lpoint")
loading_location <- paste0("01.Data/02.For_New_X/new_x_",
                           category_target,
                           ".RData")
load(loading_location)

# category_final data를 불러오자 
loading_location <- paste0("01.Data/01.Input_Data/", 
                           category_target,
                           "_final.RData")
load(loading_location)
default_table <- get( paste0(category_target, "_final"))
default_table <- default_table[, -1]


# 함수돌리기  ------------------------------------------------------------------

result1 <- our_armax(default_table)
result1$train.forecast$pred
result1$train.forecast$se
result1$arima.order

#################################################################
####################### result_save ############################
################################################################

maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")

for(category_target in maincategory){
  # new_X
  loading_location <- paste0("01.Data/02.For_New_X/new_x_",category_target,".RData")
  load(loading_location)
  
  # category_final data를 불러오자 
  loading_location <- paste0("01.Data/01.Input_Data/", category_target,"_final.RData")
  load(loading_location)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]
  
  result1 <- our_armax(default_table)
  pre1 <- result1$train.forecast$pred
  pre2 <- result1$test.forecast$pred

  assign(paste0("test_armax_",category_target),pre1)
  assign(paste0("predict_armax_",category_target),pre2)
}

save(
  test_armax_cardigan     ,predict_armax_cardigan,
  test_armax_trenchcoat   ,predict_armax_trenchcoat,
  test_armax_slipon       ,predict_armax_slipon,
  test_armax_slingback    ,predict_armax_slingback,
  test_armax_roper        ,predict_armax_roper,
  file = "C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/05.Unscale_result/ARMAX_unscale.RData"
)


###################################################################
############################## plotly ############################
###################################################################

t <- list(
  family = "Arial",
  size = 13)

### test set
x1 <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)
x1.pre <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)[(train_end+1):length(x1)]
pre1 <- result1$train.forecast$pred
ci1.u <- result1$train.forecast$pred + result1$train.forecast$se * 1.96
ci1.l <- result1$train.forecast$pred - result1$train.forecast$se * 1.96

plot_ly(x = x1) %>%
  add_trace(y = default_table$Direct_Buy, name = "Actual Sales", mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x1.pre ,y = pre1, name = "Predicted Sales",mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  add_trace(x=x1.pre ,y = ci1.u, name = "Confidence interval", mode = "lines" , showlegend = T, line=list(color="red",dash = 'dash')) %>%
  add_trace(x=x1.pre ,y = ci1.l, name = "Confidence interval", mode = "lines" , showlegend = F, line=list(color="red",dash = 'dash')) %>%
  layout(title=sprintf("<b>%s</b>",paste0("Compare_Test_Set by ARMAX"," (",category_target,")")),
         font=t,legend = list(x = 0.8, y = 100),yaxis = list(range = c(0, max(pre1,default_table$Direct_Buy)*1.1))) 



## predict
x2 <- seq(as.Date("2018-04-01"), as.Date("2018-10-14"), by =1)
x2.pre <- seq(as.Date("2018-10-01"), as.Date("2018-10-14"), by =1)
pre2 <- c(default_table$Direct_Buy[183],result1$test.forecast$pred)
ci2.u <- result1$test.forecast$pred + result1$test.forecast$se * 1.96
ci2.l <- result1$test.forecast$pred - result1$test.forecast$se * 1.96

plot_ly(x = x2) %>%
  add_trace(x=x1, y = default_table$Direct_Buy, name = "Actual Sales", 
            mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=c(as.Date("2018-09-30"),x2.pre) ,y = pre2, name = "Predicted Sales",mode = "lines" , 
            showlegend = T, line=list(color="blue")) %>%
  add_trace(x=x2.pre ,y = ci2.u, name = "Confidence interval", mode = "lines" , 
            showlegend = T, line=list(color="red",dash = 'dash')) %>%
  add_trace(x=x2.pre ,y = ci2.l, name = "Confidence interval", mode = "lines" , 
            showlegend = F, line=list(color="red",dash = 'dash')) %>%
  layout(title=sprintf("<b>%s</b>",paste0("Predict by ARMAX"," (",category_target,")")),
         font=t,legend = list(x = 0.8, y = 100),yaxis = list(range = c(0, max(pre2,default_table$Direct_Buy)*1.1))) 


## accuracy
assign( paste0(category_target,"_Accuracy") ,
      data.frame(  category_target,method="ARMAX",accuracy(pre1,default_table$Direct_Buy[(train_end+1):length(x1)] )))
get( paste0(category_target,"_Accuracy") )

# cardigan_Accuracy / trenchcoat_Accuracy
# "cardigan","trenchcoat","slipon","slingback","roper"
# 
accuracy_ARMAX <- rbind( cardigan_Accuracy,trenchcoat_Accuracy,slipon_Accuracy,slingback_Accuracy,roper_Accuracy )
write.csv(accuracy_ARMAX, file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ARMAX.csv")
