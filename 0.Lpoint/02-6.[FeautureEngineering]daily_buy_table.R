##########################
# daily 상품군 구매 table
##########################
library(tidyverse)
left_join(product,session,by=c("CLNT_ID","SESS_ID")) -> product_session
left_join(product_session,master  ,by="PD_C") -> product_session_master
product_session_master %>% filter(!is.na(PD_BUY_CT)) -> product_session_master
date_list <- sort(unique(product_session_master$SESS_DT))
table_list <- list()

d=1
j=1

for( d in 1:length(date_list)){  #length(date_list)
  idx <- which(product_session_master$SESS_DT == date_list[d])
  
  # make_kwd_table_per_day(){
  kwd_list <- list()
  leng_idx <- length(idx)
  for(j in 1:leng_idx){ 
    index <- idx[j]
    if( is.na(product_session_master$CLAC3_NM[index])) {
      kwd_cnt <- rep(product_session_master$CLAC3_NM[index], times = 0)
    } else {
      kwd_cnt <- rep(product_session_master$CLAC3_NM[index], times = product_session_master$PD_BUY_CT[index])
      # kwd_list <- list(kwd_list, kwd_cnt)
      kwd_list[[j]] <- as.character(kwd_cnt)
    }
  }
  
  kwd_list <- unlist(kwd_list)
  
  table_list[[d]] <- plyr::count(kwd_list)
  colnames(table_list[[d]])[2] <- date_list[d] #여기서 에러였음
  # 183일의 kwd_table을 합치기 -
  if(d != 1){
    # joined_table <- full_join(joined_table, table_list[[d]], by="x")
    joined_table <- merge(joined_table, table_list[[d]], by="x", all=TRUE)
  } else if ( d == 1){
    joined_table <- table_list[[1]]
  }
}

head(joined_table)

daily_buy_table <- joined_table ; rm(joined_table)
colnames(daily_buy_table)[-1] <- as.character(date_list)

# save(daily_buy_table, file="daily_buy_table.RData")

###############################################