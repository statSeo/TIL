#=========================================================================================================================================================================
## idea : 처음 띄어쓰기 기준으로 나눈 애들을 대조군으로 만들어 그 띄어쓰기로 나눈애들을 붙여썼을때 같은 검색키워드를 가진애들을 대조군처럼 띄워진 걸로 통일 시켜 바꿔 주기.


library(tidyverse)

setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")
load("search1.RData")
load("search2.RData")


# search1 검색키워드들을 띄어쓰기로 분리시켜 vector of list 화 
search1_split <- strsplit(search1$KWD_NM, " ")

search1_original <- as.list(search1$KWD_NM)

search1_paste <- gsub(" ","",search1_original)
search1_paste <- as.list(search1_paste)

head(search1_original) #  처음상태
head(search1_split) # 띄어쓰기로 분리
head(search1_paste) # 띄어진애들도 붙여서 표기 


# 본격적으로 띄어쓰기 대조군 만들기, list형식으로 index로 만들어 주자.

contrast_kwd_paste <- search1_paste[grepl(" ",search1_original)] 
contrast_kwd_split <- search1_split[grepl(" ",search1_original)] 


# order(A)[!duplicated(sort(A))]  : unique index파악
# unique index파악을 위해서 list를 잠시 vector로 바꿔 인덱스만 알아내자
contrast_kwd_paste_unlist <- unlist(contrast_kwd_paste)
unique_index <-  order(contrast_kwd_paste_unlist)[!duplicated(sort(contrast_kwd_paste_unlist))] 
unique_index[1:10]

# 최종적인 unique한 대조군(원래 띄어쓰기 존재하는 애들)의 paste 애랑 split한애 
unique_kwd_paste <- contrast_kwd_paste[unique_index] 
unique_kwd_split <- contrast_kwd_split[unique_index] 


## Start!! ==> search1_fnl_kwd_output : search1 키워드들 분리하기 
boolean_blank_use1 <- grepl(" ",search1_original) #처음엔 search1_original[1:10]로 검증하면서 
search1_fnl_kwd_output <- list()

a <- 0
for (i in boolean_blank_use1 ){
  a <- a + 1
  if (i == TRUE){
    search1_fnl_kwd_output[a] <- search1_split[a]
  }
  else {
    tmp <- (search1_original[[a]] == unique_kwd_paste)
    if (any(tmp)){
      search1_fnl_kwd_output[a] <- unique_kwd_split[tmp]
    }
    else {
      search1_fnl_kwd_output[a] <- search1_original[[a]]
    }
  }
}

tail(search1_fnl_kwd_output)
save(search1_fnl_kwd_output,file = "search1_fnl_kwd_output.RData")


# ==================================================================================
# ==================================================================================
# Search2에 대해서도 하자

dim(search2)
search2_split <- strsplit(search2$KWD_NM, " ")
search2_original <- as.list(search2$KWD_NM)

## Start!! ==> search2_fnl_kwd_output : 
boolean_blank_use2 <- grepl(" ",search2_original) 
search2_fnl_kwd_output <- list()
a <- 0
for (i in boolean_blank_use2 ){
  a <- a + 1
  if (i == TRUE){
    search2_fnl_kwd_output[a] <- search2_split[a]
  }
  else {
    tmp <- (search2_original[[a]] == unique_kwd_paste)
    if (any(tmp)){
      search2_fnl_kwd_output[a] <- unique_kwd_split[tmp]
    }
    else {
      search2_fnl_kwd_output[a] <- search2_original[[a]]
    }
  }
}
head(search2_fnl_kwd_output)


save(search2_fnl_kwd_output,file = "search2_fnl_kwd_output.RData")

# ==================================================================================
# ==================================================================================
# (X)그럼 이제 키워드들을 구분한 검색어들의 weigth가 가장 높은 대표 검색 키워드를 뽑자




