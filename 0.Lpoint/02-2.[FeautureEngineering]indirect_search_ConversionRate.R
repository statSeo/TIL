# 0. 기본 옵션들을 지정하자. 

# 0-1. 필요한 데이터를 불러온다.
library(tidyverse)
setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")
load("date.idx.for.matchn.fnl.output.RData")
load("search1_product_master_sesDT.RData")
load("search2_kwd_table.RData")
search2_kwd_table$x <- as.character(search2_kwd_table$x)

# 0-2. 기본 옵션들을 지정한다. 
category_target = "trenchcoat" # 영어로 표기된 키워드 
category='여성트렌치코트' # 검색하고자 하는 카테고리
option = '트렌치코트' # weight1(직접검색어)로 설정할 검색어 기준. 
rm_item = "여성"  # 키워드에서 제외할 검색어. 

# 0-3. 분석에 필요한 함수들을 지정한다. 
delete_given_kwd <- function(vector){ 
  gsub(vector , "", kwd_list)}
delete_given_kwd2 <- function(vector){ 
  gsub(vector , "", kwd_list_perday)}
to_date_format <- function(df){
  if(!lubridate::is.Date(df$SESS_DT)){
    df$SESS_DT <- as.Date(as.character(df[["SESS_DT"]]), "%Y%m%d")
    df <- as.data.frame(df)
  } else {
    df <- as.data.frame(df)
  }
}


# 2. 원하는 카테고리의 데이터만 추출한다 --------------------------------------------------
# 카테고리와 일치하는 데이터를 추출한다. 
# 이때 추출하는 idx는 search1_product_master_sessDT테이블과 일치하는 index이므로, 
# search1_fnl_kwd_output의 인덱스와 일치하지 않는다. 
# 우리가 추출하고자 하는 데이터의 정확한 
# clnt_id와 sess_id를 추출하는 것을 목적으로 두자. 
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



# 3. 검색어에 해당 '카테고리'명이 포함되어 있으면 weight1로 구분한다.------
# 얘네는 미리 빼놓을 것 
# 우리가 분석할 내용은 검색어에 카테고리가 직접적으로 표현되어 있지 않은 것들이다. 

# option = '가디건' # weight1로 설정할 검색어 기준. 
main.kwd.included.idx <- grep(option, search1$KWD_NM)

category.idx <- data.frame(x = category.idx.for.matchn.fnl.output)
main.kwd.included.idx <- data.frame(x = main.kwd.included.idx)

# 일치하는(교집합)을 추출. :: '가디건'을 산 사람들의 검색 vs. 실제로 '가디건'을 검색한 사람
category.idx.main.kwd.included <- inner_join(category.idx, main.kwd.included.idx, 
           by="x")

category.idx.main.kwd.included$flag <- 1
category.idx.wo.main.kwd <- left_join(category.idx, category.idx.main.kwd.included,
          by="x")

category.idx.wo.main.kwd <- category.idx.wo.main.kwd[is.na(category.idx.wo.main.kwd$flag),]
category.idx.wo.main.kwd$flag <- NULL





# 4. 전체 prior을 구해보자 ----------------------------------------------------------

kwd_list <- list()
for(i in 1:nrow(category.idx.wo.main.kwd)){
  index<- category.idx.wo.main.kwd$x[i]
  kwd.cnt <- rep(search1_fnl_kwd_output[[index]], 
                 times= search1$SEARCH_CNT[index]
  )
  kwd_list <- list(kwd_list, kwd.cnt)
}
  
kwd_list <- unlist(kwd_list)
  

# 4-1. 검색어kwd를 정제하자 ------------------------------------------------------------

# delete_given_kwd <- function(vector){ 
#   gsub(vector , "", kwd_list)}

# 검색어 데이터를 정제하자. 
kwd_list <- sapply(rm_item, delete_given_kwd)
kwd_list <- gsub(' ', "", kwd_list)
kwd_list <- kwd_list[!kwd_list==""]
kwd_list <- kwd_list[!is.na(kwd_list)]

kwd_tbl <- plyr::count(kwd_list)
kwd_tbl <- kwd_tbl[order(kwd_tbl$freq, decreasing = T),]


# 4-2. prior prob 확률구하기 -----------------------------------------------------

# 확률구하기 
# d=1
for(i in 1:dim(kwd_tbl)[1]){
  # n <- sum(colSums(search2_kwd_table[,-1], na.rm = T))
  # n <- n[[1]]
  
  related.kwd.prop <- rowSums(search2_kwd_table[
    search2_kwd_table$x == as.character( kwd_tbl[i,1]),
     -1])
  
  if(identical(related.kwd.prop, numeric(0))){
    kwd_tbl$related.kwd[i] <- NA
  } else {
    kwd_tbl$related.kwd[i] <- related.kwd.prop
  }
  kwd_tbl$related_plus_bought[i] <-  kwd_tbl[i,2] 
  
}

kwd_tbl$flag <- 1
kwd_tbl$flag[is.na(kwd_tbl$related.kwd)] <- NA

kwd_tbl$prior[!is.na(kwd_tbl$flag)] <- kwd_tbl$related_plus_bought[!is.na(kwd_tbl$flag)] /
  kwd_tbl$related.kwd[!is.na(kwd_tbl$flag)]      

# conversion.rate[d] <- sum(kwd_tbl$prior * kwd_tbl$freq, na.rm=T)


## association rule을 위해 기준을 정하자. 


head(kwd_tbl)
# order by suppot
head(kwd_tbl[order(kwd_tbl$related_plus_bought, decreasing = T), ],100)
# order by prior
head(kwd_tbl[order(kwd_tbl$prior, decreasing = T), ],100)

# n = 5506052
support.thrs =  10# 해당검색어를 입력한 사람이 해당 category를 구매한 횟수(개수)
conf.thrs = 0.001

# support 작은 값도 OK,  conf 보수적 

# 기준 정리 -------------------------------------------------------------------

#여성가디건 
support.thrs =  200; conf.thrs = 0.001

# 여성로퍼 
support.thrs =  100;  conf.thrs = 0.001

# 여성슬립온
support.thrs =  150; conf.thrs = 0.001 # 13개 연관검색어

#여성슬링백
support.thrs =  50; conf.thrs = 0.001 # 8개 연관검색어

#여성 트렌치코트
support.thrs =  30; conf.thrs = 0.001



# 계속 ----------------------------------------------------------------------



kwd_tbl2 <-  kwd_tbl %>% 
  filter(related_plus_bought > support.thrs) %>%
  arrange(desc(prior)) %>% 
  filter(prior > conf.thrs)

head(kwd_tbl2); dim(kwd_tbl2)
# kwd_tbl2

kwd_tbl <- kwd_tbl2


# 5. 원하는 카테고리의 원하는 날짜 인덱스를 만든다. ---------------------------------------------

# d = 1
target.idx <- list()

for(d in 1:length(date_list)){
  date.idx <- data.frame(x= date.idx.for.matchn.fnl.output[[d]])
  # category.idx.wo.main.kwd
  target.idx[[d]] <- inner_join(date.idx, 
                                category.idx.wo.main.kwd, 
                                by="x")$x
}
# head(target.idx)




# 6. 데이터를 추출하고 분석해보자.  ----------------------------------------------------

conversion.rate <- vector()

for(d in 1:183){
  
  # d=1
  kwd_list_perday <- list()
  for(i in 1:length(target.idx[[d]] )){
    index <- target.idx[[d]][i]
    if( identical(index, integer(0))){
      kwd.cnt <- ""
    } else {
      kwd.cnt <- rep(search1_fnl_kwd_output[[index]], 
                     times= search1$SEARCH_CNT[index]
      )
      kwd_list_perday <- list(kwd_list_perday, kwd.cnt)
    }
  }
  kwd_list_perday <- unlist(kwd_list_perday)
  
  
# 7. 검색어kwd를 정제하자 ------------------------------------------------------------
  
  # delete_given_kwd <- function(vector){ 
  #   gsub(vector , "", kwd_list)}
  
  # 검색어 데이터를 정제하자. 
  kwd_list_perday <- sapply(rm_item, delete_given_kwd2)
  kwd_list_perday <- gsub(' ', "", kwd_list_perday)
  kwd_list_perday <- kwd_list_perday[!kwd_list_perday==""]
  kwd_list_perday <- kwd_list_perday[!is.na(kwd_list_perday)]
  
  kwd_tbl_perday <- plyr::count(kwd_list_perday)
  kwd_tbl_perday <- kwd_tbl_perday[order(kwd_tbl_perday$freq, decreasing = T),]
  
  
# 8. prior prob table과 조인하기-----------------------------------------------------
  kwd_tbl$x <- as.character(kwd_tbl$x)
  kwd_tbl_perday$x <- as.character(kwd_tbl_perday$x)
  
  prior.prob.tbl_perday <- left_join(kwd_tbl_perday, kwd_tbl, by="x")
  prior.prob.tbl_perday <- left_join(prior.prob.tbl_perday, 
                                     search2_kwd_table[,c(1,d+1)], 
                                     by = "x")
  prior.prob.tbl_perday
  
  
  conversion.rate[d] <- sum(prior.prob.tbl_perday$prior * prior.prob.tbl_perday[,8],
                            na.rm=T)
  
}


head(conversion.rate)

cvr <- data.frame(SESS_DT= date_list,
                 cvr = conversion.rate)



# 9. 저장하기 --------------------------------------------------------------------

filename <- paste0(category_target, ".cvr")
assign(paste0(category_target, ".cvr"), cvr)
save_location <- paste0("./",category_target ,"/", category_target, ".cvr.RData")

save(get(paste0(category_target, ".cvr")), file= save_location)
