##############################################################
################# 라이브러리 및 함수준비  ##################
##############################################################
  
library(vars)
library(forecast)
library(MTS)
library(tidyverse)
library(plotly)

setwd("C:/Users/Jiwan/Dropbox/01.Lpoint") # 

ReadnOrder <- function(category) {
    # setwd("C:/Users/Jiwan/Dropbox/01.Lpoint") 
    target_location <- paste0("01.Data/01.Input_Data/",category,"_final.RData")
    load(target_location)
    xt_location <- paste0("01.Data/02.For_New_X/forxt.RData")
    load(xt_location)
    newxt_location <- paste0("01.Data/02.For_New_X/fornewxt.RData")
    load(newxt_location)
    data_final <- get(paste0(category,"_final"))

    xx_varx <- data_final[,c("Indirect_Buy","Indirect_Search","Naver","Community_PC")]
    tt.xx <- dim(xx_varx)[1]
    VARXorder(xx_varx, forxt, maxp = 5, maxm = 3, output = T)
    return(list(data = data.frame(data_final),
             vector = data.frame(xx_varx),
             exog = data.frame(forxt),
             new_exog = data.frame(fornewxt) ))
}

our_varx <- function(ReadnOrder,p=1,m=3,h=14){
  # forcasting
  x_varx <- ReadnOrder$vector
  forxt <- ReadnOrder$exog
  fornewxt <- ReadnOrder$new_exog
  
  res.varx <- VARX(x_varx, p=p, xt = forxt, m = ss, output = F) 
  res.forcx <- VARXpred(res.varx, newxt = fornewxt, hstep = h)
  forc.vx <- res.forcx$pred
  forc.vx_df <- as.data.frame(forc.vx)
  forc.vx_df[(forc.vx_df)<0] <- 0
  return(forc.vx_df)
}

make_newx <- function(varx){
  # 온도 
  temperature_location <- paste0("01.Data/02.For_New_X/weather.csv")
  temperature <- read.csv(temperature_location,skip=6)
  temperature <- temperature[,c(1,3)]
  names(temperature) <- c("Date","temperature")
  temperature<-temperature[184:197,]
  
  # 주별 효과
  spline_week <- rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183] + 14
  new_week <- rep(41:43,each=7,time=1)[2:15]
  new_poly <- poly(c(spline_week,new_week),5)[184:length(c(spline_week,new_week)),]
  
  # 요일,연휴 
  newday <- seq(as.Date("2018-10-01"), as.Date("2018-10-14"), by =1)
  weekday_new <- weekdays(newday)
  weekday_new[c(3,9)] <- "공휴일" # 개천절,한글날 
  day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "공휴일","긴연휴")
  weekday_new_facor <- factor(weekday_new, ordered=F,levels=day_levels)
  dumm_weekday_new <- model.matrix(~weekday_new_facor-1)
  # VARX
  IS_IB_Na <- varx[,c("Indirect_Search","Indirect_Buy","Naver")]
  CP <- varx[,"Community_PC"]
  # cbind
  newx <- cbind(IS_IB_Na,temperature$temperature,CP,new_poly,dumm_weekday_new)
  return(newx)
}



##############################################################
############### 데이터 준비 그리고 파라미터 설정  ############
##############################################################
category_target = "roper"
data_final <- ReadnOrder(category = category_target)
# example : "cardigan","trenchcoat","slipon","slingback","roper"
# ReadnOrder를 "$" 로 원소들 탐색 가능

# 파라미터 선택 
pp <- 1		# VAR(5) 
ss <- 3   # lag 2 
hh <- 14		# forecasting horizon (14 days)


##############################################################
######################### GOGO VARX  #########################
##############################################################
new_4vari_varx <- our_varx( ReadnOrder = data_final,
                            p=pp,
                            m=ss,
                            h=hh)
new_4vari_varx

###################################################################
##################### 시각화 및 탐색 #############################
###################################################################
x_varx <- data_final$vector
forc.vx_df <- new_4vari_varx

Indirect_Buy_forplot <- c(x_varx$Indirect_Buy, forc.vx_df$Indirect_Buy)
Indirect_Search_forplot <- c(x_varx$Indirect_Search, forc.vx_df$Indirect_Search)
Naver_forplot <- c(x_varx$Naver, forc.vx_df$Naver)
Community_Index_forplot  <- c(x_varx$Community_PC, forc.vx_df$Community_PC)
x <- seq(as.Date("2018-04-01"), as.Date("2018-10-14"), by =1)

t <- list(
  family = "Arial",
  size = 14)

max(0,1)

plot_ly(x = x) %>%
  add_trace(y = Indirect_Buy_forplot, name = "Indirect_Buy", mode = 'lines',showlegend = F) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(max(min(Indirect_Buy_forplot)-10,0), max(Indirect_Buy_forplot)+15), mode = "lines" , showlegend = F, line=list(color="grey",dash = 'dash')) %>%
  layout(title=sprintf("<b>%s</b>",paste0("Variables Forcasting by VARX"," (",category_target,")"))) -> p1

plot_ly(x = x) %>%
  add_trace(y = Indirect_Search_forplot, name = "Indirect_Search", mode = 'lines',showlegend = F) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(max(min(Indirect_Search_forplot)-10,0), max(Indirect_Search_forplot)+15), mode = "lines" , showlegend = F, line=list(color="grey",dash = 'dash'))  -> p2

plot_ly(x = x) %>%
  add_trace(y = Naver_forplot, name = "Naver_Trend", mode = 'lines',showlegend = F) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(max(min(Naver_forplot)-10,0), max(Naver_forplot)+15), mode = "lines" , showlegend = F, line=list(color="grey",dash = 'dash')) -> p3

plot_ly(x = x) %>%
  add_trace(y = Community_Index_forplot, name = "Community", mode = 'lines',showlegend = F) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(max(min(Community_Index_forplot)-10,0), max(Community_Index_forplot)+15), mode = "lines" , showlegend = F, line=list(color="grey",dash = 'dash')) -> p4

subplot(p1, p2,p3, p4, nrows = 2,margin = 0.03 ,heights = c(0.45,0.45)) %>% 
  layout(annotations = list(
    list(x = 0.18 , y = 0.97, text = sprintf("<b>%s</b>","Indirect_Buy"), showarrow = F, xref='paper', yref='paper',font=t),
    list(x = 0.82 , y = 0.97, text = sprintf("<b>%s</b>","Indirect_Search"), showarrow = F, xref='paper', yref='paper',font=t),
    list(x = 0.18 , y = 0.4, text = sprintf("<b>%s</b>","Naver_Trend"), showarrow = F, xref='paper', yref='paper',font=t),
    list(x = 0.82 , y = 0.4, text = sprintf("<b>%s</b>","Community_Index"), showarrow = F, xref='paper', yref='paper',font=t)
  ))


###################################################################
##################### new_input data 생성 #########################
###################################################################
new_x <- make_newx(new_4vari_varx)
new_x

###################################################################
##################### 경로에 맞게 설정  ###########################
###################################################################

save_location <- paste0("01.Data/02.For_New_X/","new_x_",category_target,".RData")
save(new_x , file=save_location)




