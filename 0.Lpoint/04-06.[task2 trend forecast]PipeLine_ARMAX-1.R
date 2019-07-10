# 필요한 패키지 
library(tidyverse)

# 옵션
category_target = "cardigan"
#"cardigan","trenchcoat","slipon","slingback","roper"

# 필요한 데이터 불러오기 (아무데이터나 불러와도 됨. 카테고리가 중요하지 않음. )
# setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint")
setwd("C:/Users/Jiwan/Dropbox/01.Lpoint")
loading_location <- paste0("01.Data/01.Input_Data/",
                           category_target,
                           "_final.RData")
load(loading_location)

basic_table <- get(paste0(category_target,"_final"))
head(basic_table)

# 공휴일 api -----------------------------------------------------------------

##########################################################
#################### 공휴일 찾기 api #####################
##########################################################

library(glue)
library(XML)
library(stringr)

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

###############################################################
###############################################################

## 요일 & 휴일 변수 설정
holiday <- as.Date(holi[c(7:11,15), 2], format = "%Y%m%d")
holidays <- data.frame(SESS_DT = holiday, val = rep(1, length(holiday)))
holidays <- left_join(data.frame(SESS_DT = seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by = 1)), holidays, by = "SESS_DT")
holidays$val[is.na(holidays$val)] <- 0
holiday <- holidays$val
holiday <- grep(1, holiday)

## 요일 + 공휴일
date_list <- seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by = 1)
weekday1 <- weekdays(date_list)
weekday1[holiday] <- "공휴일"
weekday1[c(34:36, 174:178)] <- "긴연휴" # 어린이날,추석
# weekday1[c(37,52,67,74,137)] <- "공휴일"
# weekday1[c(34:36, 174)] <- "긴연휴"
day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "공휴일", "긴연휴")

weekday <- factor(weekday1, ordered = F, levels = day_levels)
dumm_weekday <- model.matrix(~ weekday - 1)

week <- as.factor(rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183])
res1 <- lm(basic_table$Direct_Buy ~ week + weekday - 1)
res1.s <- summary(res1)


# polynomial --------------------------------------------------------------

##########################################################
################ ploynomial fitting Test #################
##########################################################

# ols coefficient
week <- as.factor(rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183])
dumm_week <- model.matrix(~ week - 1)

res1 <- lm(basic_table$Direct_Buy ~ week + weekday - 1)
res1.s <- summary(res1)

coeff_week <- round(res1.s$coefficients[1:27], 2)
coeff_weekday <- round(res1.s$coefficients[28:35], 2)

weight_week <- dumm_week %*% coeff_week
weight_weekday <- dumm_weekday[, 2:9] %*% coeff_weekday


# ploynomial fitting
spline_week <- rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183] + 14

holiday_long <- which(date_list == "2018-05-04"|
                         date_list == "2018-05-05"|
                         date_list == "2018-05-06"|
                         date_list == "2018-09-21"|
                         date_list == "2018-09-22"|
                         date_list == "2018-09-23"|
                         date_list == "2018-09-24"|
                         date_list == "2018-09-25") # 어린이날연휴, 추석연휴

# date_list[holiday_long]
special_day_idx <- c(holiday, holiday_long)
yy <- basic_table$Direct_Buy
spline_yy <- yy
spline_yy[special_day_idx] <- yy[special_day_idx] - weight_weekday[special_day_idx]

#plotting
plot(spline_week, yy)
plot(spline_week, spline_yy)

################################
################################
fit <- lm(spline_yy ~ poly(spline_week, 5)) 

# plotting
weeklims <- range(spline_week)
week.gid <- seq(from = weeklims[1], to = weeklims[2])
preds <- predict(fit, newdata = list(spline_week = week.gid), se = TRUE)
se.bands <- cbind(preds$fit + 2 * preds$se.fit, preds$fit - 2 * preds$se.fit)

# plotting
plot(spline_week, spline_yy, cex = .5, col = "darkgrey", 
     xlim = c(15, 45),
     ylim = c(min(spline_yy)*0.9, max(spline_yy)*1.2))
lines(week.gid, preds$fit, lwd = 2, col = "blue")
matlines(week.gid, se.bands, lwd = 1, col = "blue", lty = 3)

rangepredict <- seq(41, 45, by = 1)
preds1 <- predict(fit, newdata = list(spline_week = rangepredict), se = TRUE)
se.bands1 <- cbind(preds1$fit + 2 * preds1$se.fit, preds1$fit - 2 * preds1$se.fit)
lines(rangepredict, preds1$fit, lwd = 2, col = "2")
matlines(rangepredict, se.bands1, lwd = 1, col = "2", lty = 3)

################################
################################
# 
# fit <- lm(yy ~ poly(spline_week, 5)+weekday)
# 
# # plotting
# weeklims <- range(spline_week)
# week.gid <- seq(from = weeklims[1], to = weeklims[2])
# preds <- predict(fit, newdata = list(c(spline_week = week.gid),c(weekday)), se = TRUE)
# se.bands <- cbind(preds$fit + 2 * preds$se.fit, preds$fit - 2 * preds$se.fit)
# 
# # plotting
# plot(1:183, spline_yy, cex = .5, col = "darkgrey", xlim = c( 1 ,  226),
#      ylim = c(min(spline_yy)*0.9, max(spline_yy)*1.2))
# lines(1:183, preds$fit, lwd = 2, col = "blue")
# matlines(1:183, se.bands, lwd = 1, col = "blue", lty = 3)

################################

# good

#################################################################

## 주별(계절) 효과는 poly fit으로 반영 / 검토

res1 <- lm(basic_table$Direct_Buy ~ poly(spline_week, 5) + weekday - 1)
res1.s <- summary(res1)

# 주별 계절효과를 확인해보자. 
fit.reg1 <- basic_table$Direct_Buy - res1$residuals
plot(basic_table$Direct_Buy,
  type = "l", lty = 2, col = "gray", lwd = 1,
  ylab = "Sales", xlab = "Time",
  main = "Fitted lines"
)
lines(fit.reg1, col = "blue", lty = 1, lwd = 2)
plot(res1$residuals, type = "l")


