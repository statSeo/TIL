n
# 기본 옵션들을 지정하자. 
#  여성트렌치코트 /  여성원피스 // 여성로퍼 / 여성슬링백 / 여성슬립온
category='여성트렌치코트' # 검색하고자 하는 카테고리  
category_target = 'trenchcoat'
option = '트렌치코트' # weight1로 설정할 검색어 기준. 
rm_item = "여성"  # 키워드에서 제외할 검색어. 

setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")
library(tidyverse)
load("search1.RData")
load("product.RData")
load("master.RData")
load("session.RData")


to_date_format <- function(df){
  if(lubridate::is.Date(df$SESS_DT)){
    df <- as.data.frame(df)
  } else {
    df$SESS_DT <- as.Date(as.character(df[["SESS_DT"]]), "%Y%m%d")
    df <- as.data.frame(df)
  }
}


# 0.구매정보, 상품군(소분류), 검색어, 날짜를 확인할 수 있도록 merge한다. 
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



# 1. search1 : 분자
category.clnt.sess <- search1_product_master_sessDT %>% 
  filter(CLAC3_NM == category) %>% 
  select(CLNT_ID, SESS_ID)

category.clnt.sess <- unique(category.clnt.sess)
category.clnt.sess$match <- 1

head(search1_fnl_kwd_output)

# search1과 인덱싱을 맞추기 위해 idx를 다시 뽑아내자. 
search1_category.clnt.sess <- left_join(search1,
                                        category.clnt.sess,
                                        by=c("CLNT_ID","SESS_ID"))
category.idx.for.matchn.fnl.output <- which(!is.na(search1_category.clnt.sess$match))


# 가디건 실구매 세션의 index
category.idx.for.matchn.fnl.output #search1_category.clnt.sess[329404,]

# search1에서 검색어에 가디건이 포함된 세션의 index 
main.kwd.included.idx <- grep(option, search1$KWD_NM) #search1_category.clnt.sess[316573,] 

# 가디건을 검색했고 구매까지한 index & flag (분자)
category.idx <- data.frame(x = category.idx.for.matchn.fnl.output)
main.kwd.included.idx <- data.frame(x = main.kwd.included.idx)
category.idx.main.kwd.included <- inner_join(category.idx, main.kwd.included.idx, 
                                             by="x")
# dim(category.idx.main.kwd.included)[1]
sum(search1[category.idx.main.kwd.included$x,4]) -> son

# 2. search2 : 분모 
main.kwd.included.idx_search2 <- grep(option,search2_kwd_table$x)
# search2_kwd_table[main.kwd.included.idx_search2,1]
search2_kwd_table[main.kwd.included.idx_search2,2:ncol(search2_kwd_table)] -> search2_kwd_table_main
search2_kwd_table_main_matrix <- as.matrix(search2_kwd_table_main)
apply(search2_kwd_table_main_matrix,2,sum,na.rm = T) -> daily_search2_kwd_table_main
sum(daily_search2_kwd_table_main) -> mother

# 3. 구매지수계산
son/mother -> main_kwd_search_weight

# length(daily_search2_kwd_table_main)
daily_search2_kwd_table_main * main_kwd_search_weight -> main_search_kwd_index
data.frame(SESS_DT=sort(unique(session$SESS_DT)),main_search_kwd_index) -> main_search_kwd_index_df
main_search_kwd_index_df
row.names(main_search_kwd_index_df) <- 1:183



assign(paste0("main_search_kwd_index_df_",category_target), main_search_kwd_index_df)
save_location <- paste0("./",category_target ,"/main_search_kwd_index_df_", category_target, ".RData")
save(get(paste0("main_search_kwd_index_df_",category_target)), 
     file= save_location)