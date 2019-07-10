library(tidyverse)
library(forecast)
library(plotly)
library(DMwR)
# setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data/02.ann_result/")
setwd("C:/Users/Jiwan/Dropbox/01.Lpoint/")


#####################################################################################
############################## ANN Accuracy ##########################################
######################################################################################
maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")
for(category_target in maincategory){
  # category_target <- "cardigan"
  # category_final data를 불러오자 
  loading_location1 <- paste0("01.Data/01.Input_Data/", 
                              category_target,
                              "_final.RData")
  load(loading_location1)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]
  
  # ANN_data
  loading_location2 <- paste0("01.Data/02.ann_result/",category_target,"_annresult_traintest.csv")
  df <- read.csv(file = loading_location2)
  df <- df[,-1]
  colnames(df) <- c("actual","predicted")
  
  predict1 <- c(unscale(df$predicted,scale(default_table$Direct_Buy)))
  actual1 <- default_table$Direct_Buy
  assign( paste0(category_target,"_Accuracy") ,
          data.frame(  category_target,method="ANN",
                       accuracy(predict1[154:183],actual1[154:183])))
  get( paste0(category_target,"_Accuracy") )
  
}
accuracy_ANN <- rbind(cardigan_Accuracy,trenchcoat_Accuracy,slipon_Accuracy,slingback_Accuracy,roper_Accuracy );accuracy_ANN

# write.csv(accuracy_ANN, file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ANN.csv")


#####################################################################################
########################### ARMAX-GARCH Accuracy ####################################
#####################################################################################
maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")
for(category_target in maincategory){
  # category_target <- "cardigan"
  # category_final data를 불러오자 
  loading_location1 <- paste0("01.Data/01.Input_Data/", 
                              category_target,
                              "_final.RData")
  load(loading_location1)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]

  # ANN_data
  loading_location2 <- paste0("01.Data/04.ARMA-GARCH_result/",category_target,"_arma-garch_traintest.csv")
  df <- read.csv(file = loading_location2)
  df <- df[,-1]
  
  predict2 <- c(unscale(df$pre,scale(default_table$Direct_Buy)))
  actual2 <- default_table$Direct_Buy[154:183]
  
  assign( paste0(category_target,"_Accuracy") ,
          data.frame(  category_target,method="ARMAX-GARCH",
                       accuracy(predict2,actual2)))
  get( paste0(category_target,"_Accuracy") )
  
}
accuracy_GARCH <- rbind(cardigan_Accuracy,trenchcoat_Accuracy,slipon_Accuracy,slingback_Accuracy,roper_Accuracy );accuracy_GARCH

# write.csv(accuracy_GARCH, file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_GARCH.csv")

accuracy_GARCH <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_GARCH.csv" )
accuracy_ANN <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ANN.csv" )
accuracy_ARMAX <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ARMAX.csv")

accuracy_GARCH ; accuracy_ANN ; accuracy_ARMAX


#####################################################################
############################## plotly-ANN ############################
#####################################################################

train_end <- 153

t <- list(
  family = "나눔고딕 ExtraBold",
  size = 14)
re <- list(
  family = "-윤고딕330",#"나눔바른고딕"
  size = 16,
  color=RColorBrewer::brewer.pal(9,'Greys')[8]
)
ax <- list(
  family = "-윤고딕330",#"-윤고딕330"
  size = 16,
  color=RColorBrewer::brewer.pal(9,'Greys')[9]
)
f1 <- list(
  family = "Arial, sans-serif",
  size = 15,
  color = RColorBrewer::brewer.pal(9,'Greys')[6]
)

  
category_target <- "slingback"
# "cardigan","trenchcoat","slipon","slingback","roper"
{if(category_target == "cardigan"){category_Kor ="여성가디건"}
  else if(category_target == "trenchcoat"){category_Kor ="여성트렌치코트"}
  else if(category_target == "slipon"){category_Kor ="여성슬립온"}
  else if(category_target == "slingback"){category_Kor ="여성슬링백"}
  else if(category_target == "roper"){category_Kor ="여성로퍼"}
}

title_test <- paste0("9월1일 ~ 9월30일 Validation"," (",category_Kor,")")
title_predict <- paste0("10월1일 ~ 10월14일 Forecast"," (",category_Kor,")")

loading_location1 <- paste0("01.Data/01.Input_Data/", 
                            category_target,
                            "_final.RData")
load(loading_location1)
default_table <- get( paste0(category_target, "_final"))
default_table <- default_table[, -1]


### test set
loading_location2 <- paste0("01.Data/02.ann_result/",category_target,"_annresult_traintest.csv")
df <- read.csv(file = loading_location2)
df <- df[,-1]
colnames(df) <- c("actual","predicted")

x1 <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)
x1.pre <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)[(train_end+1):length(x1)]
pre1 <- unscale(df$predicted,scale(default_table$Direct_Buy))

plot_ly(x = x1) %>%
  add_trace(y = default_table$Direct_Buy, name = "Actual Sales", mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x1.pre ,y = pre1[154:183], name = "Predicted Sales",mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  layout(title=sprintf("<b>%s</b>",title_test),
         font=t,legend = list(x = 0.8, y = 100,font = re),
         xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
         yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                      range = c( 0, max(default_table$Direct_Buy,pre1)*1.1))) 

### predict
loading_location2 <- paste0("01.Data/02.ann_result/",category_target,"_annresult_forecast.csv")
df <- read.csv(file = loading_location2)
df <- df[,-1]
colnames(df) <- c("actual","predicted")

x2 <- seq(as.Date("2018-04-01"), as.Date("2018-10-14"), by =1)
x2.pre <- seq(as.Date("2018-09-30"), as.Date("2018-10-14"), by =1)
pre2 <- unscale(df$predicted,scale(default_table$Direct_Buy))

plot_ly(x = x2) %>%
  add_trace(x=x1, y = default_table$Direct_Buy, name = "Actual Sales", 
            mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x2.pre ,y = c(default_table$Direct_Buy[183],pre2[184:197]), name = "Predicted Sales",
                            mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(0, max(default_table$Direct_Buy,x2.pre)*0.9), 
            mode = "lines" , showlegend = F, 
            line=list(color=RColorBrewer::brewer.pal(9,'PuBuGn')[8],dash = 'dash')) %>% 
  layout(title=sprintf("<b>%s</b>",title_predict),
         font=t,legend = list(x = 0.8, y = 100,font = re),
         xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
         yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                      range = c(0, max(pre2,default_table$Direct_Buy)*1.1))) 


#########################################################################
############################## plotly-GARCH ############################
#########################################################################
category_target <- "slipon"
# "cardigan","trenchcoat","slipon","slingback","roper"
{if(category_target == "cardigan"){category_Kor ="여성가디건"}
  else if(category_target == "trenchcoat"){category_Kor ="여성트렌치코트"}
  else if(category_target == "slipon"){category_Kor ="여성슬립온"}
  else if(category_target == "slingback"){category_Kor ="여성슬링백"}
  else if(category_target == "roper"){category_Kor ="여성로퍼"}
}

title_test <- paste0("9월1일 ~ 9월30일 Validation"," (",category_Kor,")")
title_predict <- paste0("10월1일 ~ 10월14일 Forecast"," (",category_Kor,")")

train_end <- 153

loading_location1 <- paste0("01.Data/01.Input_Data/", 
                            category_target,
                            "_final.RData")
load(loading_location1)
default_table <- get( paste0(category_target, "_final"))
default_table <- default_table[, -1]

## test
loading_location2 <- paste0("01.Data/04.ARMA-GARCH_result/",category_target,"_arma-garch_traintest.csv")
df <- read.csv(file = loading_location2)
df <- df[,-1]

x1 <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)
x1.pre <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)[(train_end+1):length(x1)]
pre1 <- unscale(df$pre,scale(default_table$Direct_Buy))
ci1.u <- unscale(df$upper,scale(default_table$Direct_Buy))
ci1.l <- unscale(df$lower,scale(default_table$Direct_Buy))
pre1[is.na(pre1)|(pre1<0)] <- 0
ci1.u[is.na(ci1.u)|(ci1.u<0)] <- NA
ci1.l[is.na(ci1.l)|(ci1.l<0)] <- NA


plot_ly(x = x1) %>%
  add_trace(y = default_table$Direct_Buy, name = "Actual Sales", mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x1.pre ,y = pre1, name = "Predicted Sales",mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  add_trace(x=x1.pre ,y = ci1.u, name = "Confidence interval", mode = "lines" , 
            showlegend = T, line=list(color="red",dash = 'dot')) %>%
  add_trace(x=x1.pre ,y = ci1.l, name = "Confidence interval", mode = "lines" , 
            showlegend = F, line=list(color="red",dash = 'dot')) %>%
  layout(title=sprintf("<b>%s</b>",title_test),
         font=t,legend = list(x = 0.8, y = 100,font = re),
         xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
         yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                      range = c( 0, max(default_table$Direct_Buy,pre1)*1.1))) 


### predict
loading_location2 <- paste0("01.Data/04.ARMA-GARCH_result/",category_target,"_arma-garch_forecast.csv")
df <- read.csv(file = loading_location2)
df <- df[,-1]

x2 <- seq(as.Date("2018-04-01"), as.Date("2018-10-14"), by =1)
x2.pre <- seq(as.Date("2018-09-30"), as.Date("2018-10-14"), by =1)
pre2 <- unscale(df$pre,scale(default_table$Direct_Buy))
ci2.u <- unscale(df$upper,scale(default_table$Direct_Buy))
ci2.l <- unscale(df$lower,scale(default_table$Direct_Buy))
pre2[is.na(pre2)] <- 0

plot_ly(x = x2) %>%
  add_trace(x=x1, y = default_table$Direct_Buy, name = "Actual Sales", 
            mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x2.pre ,y = c(default_table$Direct_Buy[183],pre2), name = "Predicted Sales",
            mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  add_trace(x=x2.pre[-1] ,y = ci2.u, name = "Confidence interval", mode = "lines" , 
            showlegend = T, line=list(color="red",dash = 'dot')) %>%
  add_trace(x=x2.pre[-1] ,y = ci2.l, name = "Confidence interval", mode = "lines" , 
            showlegend = F, line=list(color="red",dash = 'dot')) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(0, max(default_table$Direct_Buy,x2.pre)*0.9), 
            mode = "lines" , showlegend = F, 
            line=list(color=RColorBrewer::brewer.pal(9,'PuBuGn')[8],dash = 'dash')) %>% 
  layout(title=sprintf("<b>%s</b>",title_predict),
          font=t,legend = list(x = 0.8, y = 100,font = re),
          xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
          yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                       range = c(0, max(pre2,default_table$Direct_Buy)*1.1))) 



#########################################################################
######################### SAVE-unscale-ANN ############################
#########################################################################

maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")

for(category_target in maincategory){
  loading_location1 <- paste0("01.Data/01.Input_Data/", 
                              category_target,
                              "_final.RData")
  load(loading_location1)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]
  
  loading_location2 <- paste0("01.Data/02.ann_result/",category_target,"_annresult_traintest.csv")
  df <- read.csv(file = loading_location2)
  df <- df[,-1]
  colnames(df) <- c("actual","predicted")
  pre1 <- unscale(df$predicted,scale(default_table$Direct_Buy))
  pre1 <- pre1[154:183]
  
  loading_location3 <- paste0("01.Data/02.ann_result/",category_target,"_annresult_forecast.csv")
  df <- read.csv(file = loading_location3)
  df <- df[,-1]
  colnames(df) <- c("actual","predicted")
  pre2 <- unscale(df$predicted,scale(default_table$Direct_Buy))
  pre2 <- pre2[184:197]
  
  assign(paste0("unscale_test_ann_",category_target),pre1)
  assign(paste0("unscale_predict_ann_",category_target),pre2)
}

save(
  unscale_test_ann_cardigan     ,unscale_predict_ann_cardigan,
  unscale_test_ann_trenchcoat   ,unscale_predict_ann_trenchcoat,
  unscale_test_ann_slipon       ,unscale_predict_ann_slipon,
  unscale_test_ann_slingback    ,unscale_predict_ann_slingback,
  unscale_test_ann_roper        ,unscale_predict_ann_roper,
  file = "C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/05.Unscale_result/ANN_unscale.RData"
)



#########################################################################
######################### SAVE-unscale-GARCH ############################
#########################################################################

maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")

for(category_target in maincategory){
  loading_location1 <- paste0("01.Data/01.Input_Data/", 
                              category_target,
                              "_final.RData")
  load(loading_location1)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]
    
  loading_location2 <- paste0("01.Data/04.ARMA-GARCH_result/",category_target,"_arma-garch_traintest.csv")
  df <- read.csv(file = loading_location2)
  df <- df[,-1]
  pre1 <- unscale(df$pre,scale(default_table$Direct_Buy))
    
  loading_location3 <- paste0("01.Data/04.ARMA-GARCH_result/",category_target,"_arma-garch_forecast.csv")
  df <- read.csv(file = loading_location3)
  df <- df[,-1]
  pre2 <- unscale(df$pre,scale(default_table$Direct_Buy))
  
  assign(paste0("unscale_test_garch_",category_target),pre1)
  assign(paste0("unscale_predict_garch_",category_target),pre2)
}

save(
  unscale_test_garch_cardigan     ,unscale_predict_garch_cardigan,
  unscale_test_garch_trenchcoat   ,unscale_predict_garch_trenchcoat,
  unscale_test_garch_slipon       ,unscale_predict_garch_slipon,
  unscale_test_garch_slingback    ,unscale_predict_garch_slingback,
  unscale_test_garch_roper        ,unscale_predict_garch_roper,
  file = "C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/05.Unscale_result/GARCH_unscale.RData"
)


