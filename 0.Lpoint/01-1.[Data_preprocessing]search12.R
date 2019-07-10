# 1. 데이터 불러오기--------------------------------
library(readr)
search1 <- read_csv("E:/Dropbox/2017/06.job_recruitment/13.programming/05.Lpoint/data/2018/02.Search1.csv",
                    locale = locale()
)
search2 <- read_csv("E:/Dropbox/2017/06.job_recruitment/13.programming/05.Lpoint/data/2018/03.Search2.csv")

# 2. 데이터 잘 불러졌나 살펴보기----------------------------
dim(search1) ; head(search1) #2884943 4
dim(search2) ; head(search2) #8051172 3

# 3. 결측치를 살펴보자. --------------------------------
sum(is.na(search1))
sum(is.na(search2))

### 결측값이 많이 몰린 '검색어'들을 살펴보자.
is.na.index <- which(rowSums(is.na(search2))!=0)
na_search <- plyr::count(search2[is.na.index,'KWD_NM'])

#결측치가 많은 검색어들은 아예 삭제하도록 한다. 
# "원피스" 2건 존재 9/22 9/23  
# "여성샌들"  67건의 결측값, 116개의 데이터만 존재
# "블라우스"  55건의 결측값, 128개의 데이터만 존재. 데이터의 1/4 이상이이 결측값이다. 
# ->> 삭제
removing_kwd <- na_search[order(na_search$freq,decreasing = T)[1:3],'KWD_NM']
for(kwd in removing_kwd){
  search2 <- search2[search2$KWD_NM != kwd,]
}

# 시스템 로케일이 말썽일 때 요 코드 쓸 것
Sys.setlocale("LC_ALL", "C")
Sys.setlocale("LC_ALL", "korean")

# 4. 데이터를 정제하자. --------------------------------
# 대괄호표시&슬래시표시 없애주기
search2$KWD_NM <- gsub('\\[', '' ,search2$KWD_NM)
search2$KWD_NM <- gsub('\\]', '' ,search2$KWD_NM)
search2$KWD_NM <- gsub('\\-', ' ' ,search2$KWD_NM)

search1$KWD_NM <- gsub('\\[', '' ,search1$KWD_NM)
search1$KWD_NM <- gsub('\\]', '' ,search1$KWD_NM)
search1$KWD_NM <- gsub('\\-', ' ' ,search1$KWD_NM)

# 괄호를 삭제하고, 괄호()안에 들어간 글자 없애기 
xx <- gsub("[\\(\\)]", "", 
           regmatches(search2$KWD_NM, gregexpr("\\(.*?\\)", search2$KWD_NM)) ) 
search2$KWD_NM <- ifelse( xx=="character0" , search2$KWD_NM , xx )

xx <- gsub("[\\(\\)]", "", 
           regmatches(search1$KWD_NM, gregexpr("\\(.*?\\)", search1$KWD_NM)) ) 
search1$KWD_NM <- ifelse( xx=="character0" , search1$KWD_NM , xx )

# 검색어에 인터넷 주소가 들어간 것이 있다. 수정하자. 
search2[search2$KWD_NM =="루펜제습기http://m.lotte.com/search/m/mobile_search_list.do?keyword=700",'KWD_NM'] <- '루펜정수기' 


# 5.SESS_DT를 date형식으로 저장해주자.  ------------------------------------------------
# YYYYMMDD 형태를 날짜 변수로 바꾸는 함수를 정의하자. 
to_date_format <- function(df){
  if(!lubridate::is.Date(df$SESS_DT)){
    df$SESS_DT <- as.Date(as.character(df[["SESS_DT"]]), "%Y%m%d")
    df <- as.data.frame(df)
  } else {
    df <- as.data.frame(df)
  }
}

search2 <- to_date_format(search2) # 날짜로 변환!!



# 6 .CLNT_ID를 character로 바꾸어주자.  ---------------------------------------------
 
search1$CLNT_ID <- sprintf("%07d", search1$CLNT_ID)
search1$CLNT_ID <- as.character(search1$CLNT_ID)




# 7.대문자를 모두 소문자로 바꾸어준다 ------------------------------------------------------
search1$KWD_NM <- tolower(search1$KWD_NM)
search2$KWD_NM <- tolower(search2$KWD_NM)


# 8. 동일한 검색어를 합친다.  -------------------------------------------------------

library(dplyr)

#search1
tmp <- search1 %>% 
  group_by(CLNT_ID, SESS_ID,KWD_NM) %>% 
  dplyr::summarise(SEARCH_CNT = sum(SEARCH_CNT))

head(tmp)
dim(tmp) # 2884487행으로 줄었다. (처음엔 #2884943행)

search1 <- tmp
rm(tmp)

#search2
tmp <- search2 %>% 
  group_by(SESS_DT,KWD_NM) %>% 
  dplyr::summarise(SEARCH_CNT = sum(SEARCH_CNT))

head(tmp)
dim(tmp) # 7988036행으로 줄었다.  (처음엔 8051172행 )

search2 <- tmp
rm(tmp)



# 9. 정제된 데이터를 저장한다. ----------------------------
save(search1,file=".../../../../../01.Lpoint/임예림/search1_preprocessed.RData")
save(search2,file=".../../../../../01.Lpoint/임예림/search2_preprocessed.RData")


