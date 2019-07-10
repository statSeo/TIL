
#  기본 옵션들을 지정한다. 
category_target = "trenchcoat" # 영어로 표기된 키워드 
category = "여성트랜치코트"

library(tidyverse)
setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")
load("product.RData")
load("master.RData")
load("session.RData")
load("custom.RData")


# left join해서 테이블을 만든다. 
product1 <- left_join(product, session, by = c("CLNT_ID","SESS_ID"))
product1 <- left_join(product1, master, by = c("PD_C"))
product1 <- left_join(product1, custom, by = c("CLNT_ID"))


# 직접 구매량구하기 
direct_buy <- product1 %>%
  filter(CLAC3_NM == category) %>%
  group_by(SESS_DT) %>%
  mutate(TOTAL_BUY_CT = sum(PD_BUY_CT)) %>% 
  select(SESS_DT, TOTAL_BUY_CT)

head(direct_buy)


assign(paste0("direct_buy_",category_target), direct_buy)
save_location <- paste0("./",category_target ,"/direct_buy_", category_target, ".RData")
save(get(paste0("direct_buy_",category_target)), file= save_location)