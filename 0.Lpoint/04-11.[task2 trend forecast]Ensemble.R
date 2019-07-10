#################################################################
#########################  ensemble  ############################
#################################################################

library(tidyverse)
library(forecast)
library(plotly)
library(DMwR)
# setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data/02.ann_result/")
setwd("C:/Users/Jiwan/Dropbox/01.Lpoint/")

load("01.Data/05.Unscale_result/GARCH_unscale.RData")
# unscale_test_garch_cardigan     ,unscale_predict_garch_cardigan,
# unscale_test_garch_trenchcoat   ,unscale_predict_garch_trenchcoat,
# unscale_test_garch_slipon       ,unscale_predict_garch_slipon,
# unscale_test_garch_slingback    ,unscale_predict_garch_slingback,
# unscale_test_garch_roper        ,unscale_predict_garch_roper,

load("01.Data/05.Unscale_result/ANN_unscale.RData")
# unscale_test_ann_cardigan     ,unscale_predict_ann_cardigan,
# unscale_test_ann_trenchcoat   ,unscale_predict_ann_trenchcoat,
# unscale_test_ann_slipon       ,unscale_predict_ann_slipon,
# unscale_test_ann_slingback    ,unscale_predict_ann_slingback,
# unscale_test_ann_roper        ,unscale_predict_ann_roper,

load("01.Data/05.Unscale_result/ARMAX_unscale.RData")
# test_armax_cardigan     ,predict_armax_cardigan,
# test_armax_trenchcoat   ,predict_armax_trenchcoat,
# test_armax_slipon       ,predict_armax_slipon,
# test_armax_slingback    ,predict_armax_slingback,
# test_armax_roper        ,predict_armax_roper,


# best
ANN_weight <- 0.65
ARMAX_weight <- 0.25
GARCH_weight <- 0.1


maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")

for(category_target in maincategory){
  garch. <- get(paste0("unscale_test_garch_",category_target))
  ann. <- get(paste0("unscale_test_ann_",category_target))
  armax. <- get(paste0("test_armax_",category_target))
  for(data in c("garch.","ann.","armax.")){ 
    aa <- get(data)
    aa[is.na(aa)|aa<0] <- 0 
    assign( data ,  aa)
  }
  ensemble <- GARCH_weight * garch.  + ANN_weight * ann. + ARMAX_weight * armax.
  
  assign( paste0(category_target,"_ensemble_test") , ensemble  )
  
  loading_location1 <- paste0("01.Data/01.Input_Data/", 
                              category_target,
                              "_final.RData")
  load(loading_location1)
  default_table <- get( paste0(category_target, "_final"))
  default_table <- default_table[, -1]
  actual3 <- default_table$Direct_Buy[154:183]
  
  assign( paste0(category_target,"_Accuracy") ,
          data.frame(  category_target,method="Ensemble",
                       accuracy(ensemble,actual3)))
  get( paste0(category_target,"_Accuracy") )
}

accuracy_Ensemble <- rbind(cardigan_Accuracy,trenchcoat_Accuracy,slipon_Accuracy,slingback_Accuracy,roper_Accuracy );accuracy_Ensemble

# write.csv(accuracy_Ensemble, file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_Ensemble.csv")

accuracy_Ensemble <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_Ensemble.csv" )
accuracy_GARCH <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_GARCH.csv" )
accuracy_ANN <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ANN.csv" )
accuracy_ARMAX <- read.csv(file = "file:///C:/Users/Jiwan/Dropbox/01.Lpoint/05.PPT/Accuracy/accuracy_ARMAX.csv")

# accuracy_Ensemble ; accuracy_GARCH ; accuracy_ANN ; accuracy_ARMAX

ACC <- rbind(accuracy_Ensemble,accuracy_GARCH,accuracy_ANN,accuracy_ARMAX)
ACC <- ACC[,-1]
ACC <- ACC %>% arrange(category_target)
ACC

#########################################################################
########## plot_ly
#########################################################################

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

train_end <- 153

category_target <- "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"
{if(category_target == "cardigan"){category_Kor ="여성가디건"}
  else if(category_target == "trenchcoat"){category_Kor ="여성트렌치코트"}
  else if(category_target == "slipon"){category_Kor ="여성슬립온"}
  else if(category_target == "slingback"){category_Kor ="여성슬링백"}
  else if(category_target == "roper"){category_Kor ="여성로퍼"}
}

title_test <- paste0("9월1일 ~ 9월30일 Validation"," (",category_Kor,")")
title_predict <- paste0("10월1일 ~ 10월14일 Forecast"," (",category_Kor,")")

##
loading_location1 <- paste0("01.Data/01.Input_Data/", 
                            category_target,
                            "_final.RData")
load(loading_location1)
default_table <- get( paste0(category_target, "_final"))
default_table <- default_table[, -1]

## test
x1 <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)
x1.pre <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by =1)[(train_end+1):length(x1)]
pre1 <- get(paste0(category_target,"_ensemble_test"))
pre1[is.na(pre1)|(pre1<0)] <- 0

plot_ly(x = x1) %>%
  add_trace(y = default_table$Direct_Buy, name = "Actual Sales", mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x1.pre ,y = pre1, name = "Predicted Sales",mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  layout(title=sprintf("<b>%s</b>",title_test),
         font=t,legend = list(x = 0.8, y = 100,font = re),
         xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
         yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                      range = c( 0, max(default_table$Direct_Buy,pre1)*1.1))) 


### predict

ANN_weight <- 0.65
ARMAX_weight <- 0.25
GARCH_weight <- 0.1

maincategory <- c("cardigan","trenchcoat","slipon","slingback","roper")

for(category_target in maincategory){
  garch. <- get(paste0("unscale_predict_garch_",category_target))
  ann. <- get(paste0("unscale_predict_ann_",category_target))
  armax. <- get(paste0("predict_armax_",category_target))
  for(data in c("garch.","ann.","armax.")){ 
    aa <- get(data)
    aa[is.na(aa)] <- 0 
    assign( data ,  aa)
  }
  ensemble <- GARCH_weight * garch.  + ANN_weight * ann. + ARMAX_weight * armax.
  
  assign( paste0(category_target,"_ensemble_predict") , ensemble  )
}

category_target <- "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"
{if(category_target == "cardigan"){category_Kor ="여성가디건"}
  else if(category_target == "trenchcoat"){category_Kor ="여성트렌치코트"}
  else if(category_target == "slipon"){category_Kor ="여성슬립온"}
  else if(category_target == "slingback"){category_Kor ="여성슬링백"}
  else if(category_target == "roper"){category_Kor ="여성로퍼"}
}

title_test <- paste0("9월1일 ~ 9월30일 Validation"," (",category_Kor,")")
title_predict <- paste0("10월1일 ~ 10월14일 Forecast"," (",category_Kor,")")

## 
loading_location1 <- paste0("01.Data/01.Input_Data/", 
                            category_target,
                            "_final.RData")
load(loading_location1)
default_table <- get( paste0(category_target, "_final"))
default_table <- default_table[, -1]



##
x2 <- seq(as.Date("2018-04-01"), as.Date("2018-10-14"), by =1)
x2.pre <- seq(as.Date("2018-09-30"), as.Date("2018-10-14"), by =1)
pre2 <- get(paste0(category_target,"_ensemble_predict"))
pre2[is.na(pre2)] <- 0

plot_ly(x = x2) %>%
  add_trace(x=x1, y = default_table$Direct_Buy, name = "Actual Sales", 
            mode = 'lines',showlegend = T,line=list(color="grey")) %>%
  add_trace(x=x2.pre ,y = c(default_table$Direct_Buy[183],pre2), name = "Predicted Sales",
            mode = "lines" , showlegend = T, line=list(color="blue")) %>%
  add_trace(x = as.Date("2018-09-30"), y = c(0, max(default_table$Direct_Buy,x2.pre)*0.9), 
            mode = "lines" , showlegend = F, 
            line=list(color=RColorBrewer::brewer.pal(9,'PuBuGn')[8],dash = 'dash')) %>% 
  layout(title=sprintf("<b>%s</b>",title_predict),
         font=t,legend = list(x = 0.8, y = 100,font = re),
         xaxis = list(title ="Date",titlefont = ax,tickfont = f1),
         yaxis = list(title ="Demand",titlefont = ax,tickfont = f1,
                      range = c(0, max(pre2,default_table$Direct_Buy)*1.1))) 

