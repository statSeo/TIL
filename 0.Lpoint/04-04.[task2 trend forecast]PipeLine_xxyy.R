# 1. 기본옵션 :: 카테고리 정해주기 ----
category_target = "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"

# 2. 라이브러리 불러오기 ---------
library(tidyverse)
library(glue)
library(XML)
library(stringr)


# 3. train, test를 구분하는 기준을 정하자. -------------
train_end <- 153

##########################################################
#################### 공휴일 찾기 api #####################
##########################################################

holiday_api <- function(){
  api.key <- "GJdKU2SKJ6oYQgTSsQrkT9BH2hIF%2FG6qtztAeyJHv9Zp31YlWhl%2FCKMmz0fKJnmxtPyQT9TY49AQqtpEeFCw9A%3D%3D"
  url.format <-
    "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?ServiceKey={key}&solYear={year}&solMonth={month}"
  
  holiday.request <-
    function(key, year, month) glue(url.format)
  
  days <- c()
  date <- c()
  for (m in 1:12) {
    data <- xmlToList(holiday.request(api.key, 2018, str_pad(m, 2, pad = 0)))
    items <- data$body$items
    for (item in items) {
      if (item$isHoliday == "Y") days <- append(days, item$dateName)
      date <- append(date, item$locdate)
    }
  }
  holi <- data.frame(days, date)
  holi$date <- as.character(holi$date)
  holi
  holiday <- as.Date(holi[c(7:11,15), 2], format = "%Y%m%d")
  date_list <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by = 1)
  
  holiday <- which(date_list == holiday[1]|
                     date_list == holiday[2]|
                     date_list == holiday[3]|
                     date_list == holiday[4]|
                     date_list == holiday[5]
  )
  return(holiday)
} 

  # 4. 필요한 데이터 불러오기-----------
  setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint")
# setwd("C:/Users/Jiwan/Dropbox/01.Lpoint")
loading_location <- paste0("01.Data/02.For_New_X/new_x_",
                           category_target,
                           ".RData")
load(loading_location)
head(new_x)

loading_location <- paste0("01.Data/01.Input_Data/01.csv_Data/", 
                           category_target,
                           "_final.csv")
cardigan_table1 <- read_csv(loading_location)
default_table <- cardigan_table1
default_table <- default_table[, -1] # X1인 행을 없애자. 
head(default_table) # 잘 불러졌는지 살펴보자. 
# colnames(default_table)



yy <- default_table$Direct_Buy


# 5. xx를 만들자 -------

# week dummy를 만들자. -----------
date_list <- seq(as.Date("2018-04-01"),as.Date("2018-09-30"), by=1)
weekday1 <- weekdays(date_list)


holiday_api()
weekday1[holiday] <- "공휴일"
long.holiday.index <- which(date_list == "2018-05-04"|
                              date_list == "2018-05-05"|
                              date_list == "2018-05-06"|
                              date_list == "2018-09-21"|
                              date_list == "2018-09-22"|
                              date_list == "2018-09-23"|
                              date_list == "2018-09-24"|
                              date_list == "2018-09-25") # 어린이날연휴, 추석연휴
# date_list[long.holiday.index]

weekday1[long.holiday.index] <- "긴연휴" # 어린이날,추석
day_levels <- c("일요일", "월요일", "화요일", 
                "수요일", "목요일", "금요일", 
                "토요일", "공휴일", "긴연휴")
weekday <- factor(weekday1, ordered = F, levels = day_levels)

dumm_weekday <- model.matrix(~ weekday - 1)
spline_week <- rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183] + 14
new_week <- rep(41:43, each = 7, time = 1)[2:15]

xx <- cbind(default_table[, c(3, 5:8)], 
            poly(c(spline_week, new_week), 5)[1:dim(default_table)[1], ], 
            dumm_weekday)
dim(xx) # 183, 19

saving_location <- paste0("01.Data/03.XXYY/xxyy_",
                           category_target,
                           ".RData")

save(xx,yy,file = saving_location )

