# Data import
library(readr)
master <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-06.Master.csv")
# custom <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-04.Custom.csv")
# product <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-01.Pruduct.csv")
# search1 <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-02.Search1.csv")
# search2 <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-03.Search2.csv")
# session <- read_csv("~/Desktop/DataAnalysis/lpointData/제5회 Big Data Competition-분석용데이터-05.Session.csv")

# data structure exploring
head(master_clac1);tail(master_clac1)

# 잘못 분류된 데이터를 탐색한다.
master_clac1 <- unique(master$CLAC1_NM[1:37])
master_clac1

# options(scipen=999) 과학적인 숫자 타입을 제거한다.

# master data
head(master);tail(master)
str(master)
dim(master) # 85만개 제품, 5개 열로 구성되어있다.
length(unique(master$PD_NM))  # 817405개가 중복되지 않은 고유 제품이름이다.
sum(is.na(master)) # 결측치 없습니다


# master 데이터에서 대분류가 잘못 들어간 데이터 행을 제거한 master2를 만들었다.
master[which(nchar(master$CLAC1_NM) > 15),] # 20 글자 이상 대분류는 제거한다

# 대분류에 잘 못 들어간 것이 18개 있음
# 14802  28743  31286  81765  86047  93932 167641 169189 237469 265173 276550 414028 427880 595884 677405 698269 731519 758704 행이 잘못되었음

# 18개 대분류를 중분류와 동일하게 변경하였다.
master[14802,3] <- "여성의류"
master[28743,3] <- "스포츠패션"
master[31286,3] <- "패션잡화"
master[81765,3] <- "남성의류"
master[86047,3] <- "패션잡화"
master$CLAC1_NM[93932] <- "남성의류"
master$CLAC1_NM[167641] <-"속옷/양말/홈웨어"
master$CLAC1_NM[169189] <- "패션잡화"
master$CLAC1_NM[237469] <- "여성의류"
master$CLAC1_NM[265173] <- "패션잡화"
master$CLAC1_NM[276550] <- "여성의류"
master$CLAC1_NM[414028] <- "아웃도어/레저"
master$CLAC1_NM[427880] <- "여성의류"
master$CLAC1_NM[595884] <- "여성의류"
master$CLAC1_NM[677405] <- "남성의류"
master$CLAC1_NM[698269] <- "남성의류"
master$CLAC1_NM[731519] <- "스포츠패션"
master$CLAC1_NM[758704] <- "여성의류"





