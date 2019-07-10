

library(tidyverse)
library(readr)
# product <- read_csv("C:/Users/Jiwan/Desktop/Big Data Competition-Digital Trend Analyzer/01.Product.csv")
# session <- read_csv("C:/Users/Jiwan/Desktop/Big Data Competition-Digital Trend Analyzer/05.Session.csv")
dim(product) #  5024906       8
dim(session)

unique(session$ZON_NM)
unique(session$CITY_NM)

raw_brand_num <- length(unique(product$PD_BRA_NM))

# 대괄호표시 없애주기
product$PD_BRA_NM <- gsub("\\[", "", product$PD_BRA_NM)
product$PD_BRA_NM <- gsub("\\]", "", product$PD_BRA_NM)
brand_num1 <- length(unique(product$PD_BRA_NM))

# 소괄호안에 들어간 세부분류 없애기
gsub("[\\(\\)]", "", regmatches(product$PD_BRA_NM, gregexpr("\\(.*?\\)", product$PD_BRA_NM))) -> xx
ifelse(xx == "character0", product$PD_BRA_NM, xx) -> product$PD_BRA_NM
# product$PD_BRA_NM
brand_num2 <- length(unique(product$PD_BRA_NM))

## 세부 브랜드를 하나의 대표브랜드명으로 통합 (브랜드명이 고유명사로 되어 있거나 세부브랜드명일 경우 제외)
tmp <- plyr::count(product, vars = "PD_BRA_NM")
tmp %>% arrange(desc(freq)) -> tmp
tmp[, 1] -> brand_name
brand_name[1:140] -> aa

product$PD_BRA_NM[grep("텐텐", product$PD_BRA_NM)] <- "텐텐"
product$PD_BRA_NM[grep("나이키", product$PD_BRA_NM)] <- "나이키"
product$PD_BRA_NM[grep("아디다스", product$PD_BRA_NM)] <- "아디다스"
product$PD_BRA_NM[grep("코데즈컴바인", product$PD_BRA_NM)] <- "코데즈컴바인"
product$PD_BRA_NM[grep("헤지스", product$PD_BRA_NM)] <- "헤지스"
brand_num3 <- length(unique(product$PD_BRA_NM))

aa[c(-2, -4, -5, -6, -12, -15, -16, -27, -33, -43, -56, -57, -62, -70, -90, -91, -94, -95, -105, -114, -116, -128, -129, -133, -135, -136, -138)] -> aa
for (i in aa) {
  product$PD_BRA_NM[grep(i, product$PD_BRA_NM)] <- i
}
dim(product)
brand_num4 <- length(unique(product$PD_BRA_NM))

# names(product)
# product %>%
 #  plyr::count(CLNT_ID, SESS_ID)

## 검토용 코드

#
# grep("코데즈컴바인",unique(product$PD_BRA_NM),value=T)
# grep("엘르",unique(product$PD_BRA_NM),value=T)
# View(grep("\\(",unique(product$PD_BRA_NM),value=T))
# grep("\\/",unique(product$PD_BRA_NM),value=T)
#
# product %>%
#   filter(nchar(PD_BRA_NM)>15) %>%
#   count(PD_BRA_NM) %>%
#   View()
#
# product %>%
#   filter(PD_BRA_NM=="맥") %>%
#   View()



# 180도 좌우회전/스위블헤드/2단스팀조절/초경량 -> 한경희생활과학
# 2000W / 3단계 풍속|풍온 조절가능 / 쿨샷기능 / 2중 안전장치 -> 유닉스전자
# 3 color / 95~105 size -> 패션플러스
# 3단계풍량 / 이온케어 / BHD-007 -> 필립스
# 갤럭시탭 포함된 브랜드 -> 삼성전자
# 내솥코팅:무쇠가마(외)/블랙다이아몬드코팅(내) -> 쿠첸
# 노스페이스화이트라벨(프리미엄) -> 노스페이스
# 드러그 위드아웃 사이드 이펙트 -> 드러그 위드아웃 사이드 이펙트(DWSE)
