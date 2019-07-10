#  date.idx.for.matchn.fnl.output 테이블을 만들자. -------------- 
# search1테이블에서 매일의 검색어를 요약해야하는데, 
# 각 날짜가 어느 위치에 있는지 알지 못한다. 
# 2018-04-01의 데이터만 분석하고 싶으면, 2018-04-01의 데이터만 불러와야하는데, 그 index를 알 수가 없다. 
# date.idx.for.matchn.fnl.output 테이블을 통해 search1테이블의 각 행이 어느요일인지, 어느 idx에 ㅏ할당되는지 알 수 있게 된다. 


setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")
library(tidyverse)
load("search1.RData")
load("product.RData")
load("master.RData")
load("session.RData")
# 구매정보, 상품군(소분류), 검색어, 날짜를 확인할 수 있도록 merge한다. 

search1_product <- left_join(search1,
                             product[,c(1,2,4)], 
                             by=c("CLNT_ID","SESS_ID"))
search1_product_master <- left_join(search1_product, 
                                    master[,c(1,3,5)], 
                                    by="PD_C")
session<- to_date_format(session)
search1_product_master_sessDT <- left_join(search1_product_master, 
                                           session[,c(1,2,4)],
                                           by=c("CLNT_ID","SESS_ID"))


#  각 날짜를 추출할 수 있는 인덱스를 만들어놓자. 

date_list <- seq( as.Date("2018-04-01"),as.Date("2018-09-30"), by = 1) 
date.idx.for.matchn.fnl.output <- list()

for(d in 1:length(date_list)){
  date.clnt.sess <- search1_product_master_sessDT %>% 
    filter(SESS_DT == date_list[d]) %>% 
    select(CLNT_ID, SESS_ID)
  
  date.clnt.sess <- unique(date.clnt.sess)
  date.clnt.sess$match <- 1
  
  # search1과 인덱싱을 맞추기 위해 idx를 다시 뽑아내자. 
  search1_date.clnt.sess <- left_join(search1,
                                      date.clnt.sess,
                                      by=c("CLNT_ID","SESS_ID"))
  date.idx.for.matchn.fnl.output[[d]] <- which(!is.na(search1_date.clnt.sess$match))
}

head(date.idx.for.matchn.fnl.output)


save(date.idx.for.matchn.fnl.output, "/01-1.Feature_Engineering/date.idx.for.matchn.fnl.output.RData")
