# 1.사전만들어 사용하기
## 106. 사전 만들어 사용하는 방법

# 2.wordcloud, comparison cloud, commonality cloud
## 107. wordcloud 그리기

# 3.tidydata 변환처리 / join
## 07. Tidy Data 변환하여 다루기

# 4.변수와 데이터 타입이 다른 경우 join
## 07_1 날짜 형태가 다른 경우 결합

# 5.전자공시 API
## 27. 전자공시 API with R

# 3,4,5 : 1번 과제에 활용
# 전자공시시스템 - 사업보고서 - 이사의 경영진단 - 연설문
#                             -> 이사회~~ - 이사회회의록
# ================================================================

## 106. 사전 만들어 사용하는 방법.pdf

# 회사마다 기회와 위협의 단어가 다를 수도 있음 
# 기업에 맞는 사전 구축.

# install.packages("KoNLP")
# install.packages("tm")
library(KoNLP)
useNIADic()
library(tm)

# threat_samsung.txt :,까지 단어로 인식하므로 제거
# 이하 해볼 것.

# ================================================================

## 107. wordcloud 그리기.pdf

# install.packages("wordcloud")
library(wordcloud)

# 색깔넣기
?brewer.pal() 
display.brewer.all() # 색상 팔레트

pal <- brewer.pal(4, "Spectral")
wordcloud(words = names(wordFreq), freq=wordFreq, min.freq= 1, colors=pal, random.order=F)

# comparison cloud

tear_01 <-"내 피 땀 눈물 내 마지막 춤을 다 가져가 가내 ,
피 땀 눈물 내 차가운 숨을 다 가져가 가,
내 피 땀 눈물내 피 땀 눈물도 내 몸 마음 영혼도너의 것인 걸 잘 알고 있어,
이건 나를 벌받게 할 주문Peaches and creamSweeter than sweetChocolate,
cheeksand chocolate wingsBut 너의 날개는 악마의 것,
너의 그 sweet 앞엔 bitter bitterKiss me 아파도 돼 어서 ,
날 조여줘더 이상 아플 수도 없게Baby 취해도 돼 ,
이제 널 들이켜목 깊숙이 너란 위스키내 피 땀 눈물 ,
내 마지막 춤을 다 가져가 가내 피 땀 눈물 ,
내 차가운 숨을 다 가져가 가원해 많이 많이 많이 많이원해 ,
많이 많이 많이 많이 많이 많이원해 많이 많이 많이 ,
많이원해 많이 많이 많이 많이 많이 많이아파도 돼 "

tear_02 <-"날 묶어줘 내가 도망칠 수 없게꽉 쥐고 날 흔들어줘,
내가 정신 못 차리게Kiss me on the lips lips ,
둘만의 비밀너란 감옥에 중독돼 깊이니가 아닌 ,
다른 사람 섬기지 못해알면서도 삼켜버린 독이 든 성배,
내 피 땀 눈물 내 마지막 춤을 다 가져가 가내 ,
피 땀 눈물 내 차가운 숨을 다 가져가 가원해 ,
많이 많이 많이 많이원해 많이 많이 많이 많이 많이,
많이원해 많이 많이 많이 많이원해 많이 많이 많이 많이 ,
많이 많이나를 부드럽게 죽여줘너의 손길로 눈 감겨줘,
어차피 거부할 수조차 없어더는 도망갈 수조차 없어,
니가 너무 달콤해 너무 달콤해너무 달콤해서내 피 땀 눈물내 피 땀 눈물"

tear_01_p <- paste(tear_01, collapse=" ")

tear <- c(tear_01, tear_02 )

corpus_tear <- Corpus(VectorSource(tear))
corpus_tear

tdm_tear <- TermDocumentMatrix(corpus_tear)
tdm_tear

matrix_tear <- as.matrix(tdm_tear)
matrix_tear

colnames(matrix_tear) <- c("tear_front", "tear_back")
matrix_tear

comparison.cloud(matrix_tear, random.order=FALSE, colors = c(pal, "blue" ),
                 title.size=1.5, max.words=500)


# commonality cloud : 공통된부분을 워드클라우드.
commonality.cloud(matrix_tear, random.order=FALSE) # TDM형태로 넣어도 댐


# <과제> SWOT
library(tm)
strong_samsung <- readLines("c:/data/dic/strong_samsung.txt")
weak_samsung <- readLines("c:/data/dic/weak_samsung.txt")
opport_samsung <- readLines("c:/data/dic/opport_samsung.txt")
threat_samsung <- readLines("c:/data/dic/threat_samsung.txt")
s <- paste(strong_samsung, collapse=" ")
w <- paste(weak_samsung, collapse=" ")
o <- paste(opport_samsung, collapse=" ")
t <- paste(threat_samsung, collapse=" ")
swot <- c(s,w,o,t )
corpus_swot <- Corpus(VectorSource(swot))
corpus_swot
tdm_swot <- TermDocumentMatrix(corpus_swot)
tdm_swot
matrix_swot <- as.matrix(tdm_swot)
matrix_swot
class(matrix_swot)
write.csv(matrix_swot, "c:/data/dic/matrix_swot.csv")
colnames(matrix_swot) = c("strong", "weak", "opportunity", "threat")
library(wordcloud)
comparison.cloud(matrix_swot, random.order=FALSE,
                 colors = c("#00B2FF", "red", "#FF0099", "#6600CC"),
                 title.size=1.5, max.words=500)
commonality.cloud(matrix_swot)
commonality.cloud(matrix_swot, random.order=FALSE, colors = c("#00B2FF", "red", "#FF0099", "#6600CC"),title.size=1.5)
commonality.cloud(matrix_swot, random.order=FALSE, colors = brewer.pal(8, "Dark2"),title.size=1.5)

#======================================================================

## 07. Tidy Data 변환하여 다루기
# group_by()
# joins
# gather()
# spread()
# separate()
# unite()
# Missing values

# install.packages("dplyr")
library(dplyr)
# install.packages("ggplot2")
library(ggplot2)

data("diamonds")
diamonds

unique(diamonds$color)

diamonds %>% group_by(color) %>% summarise(mean(price))
diamonds %>% group_by(color) %>% summarise(Ave= mean(price))

diamonds %>%
  group_by(color)%>%
  summarise(Ave= mean(price), Median=median(price))

diamonds %>%
  group_by(color)%>%
  summarise(Ave= mean(price), Median=median(price))%>%
  arrange(desc(Ave))


# 데이터프레임 -> 티블
head(iris);class(iris)
as_tibble(iris)

# join , 데이터합하기
x <- tribble( ~key, ~val_x, 1, "x1", 2, "x2", 3, "x3" )
y <- tribble( ~key, ~val_y, 1, "y1", 2, "y2", 4, "y3" )
x;y

# tidy방식 / dataframe방식 : inner, left, right, full
inner_join(x, y, by = "key")
merge(x, y)

left_join(x, y, by = "key")
merge(x, y, all.x=TRUE)

right_join(x, y, by = "key")
merge(x, y, all.y=TRUE)

full_join(x, y, by = "key")
merge(x, y, all.x=TRUE, all.y=TRUE)


# semi_join(x, y) : x로 y데이터의 observation에 있는 값을 매치시켜 저장
# anti_join(x, y) : x로 y데이터의 observation에 있는 값을 매치시켜 삭제

# gather() : 변수를 특정변수의 값으로 모으기
# install.packages("tidyverse")
# library(tidyverse)
# table4a
# table4a %>% gather(`1999`, `2000`, key = "year", value = "cases")

# spread() : 값을 특정변수로 퍼트리기
# table2
# table2 %>% spread(key = type, value = count)

# 위 2개 조합해서 결측치 없애기
# stocks <- tibble(
#   year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
#   qtr = c( 1, 2, 3, 4, 2, 3, 4),
#   return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
# )
# stocks
# stocks %>%
#   spread(year, return) %>%
#   gather(year, return, `2015`:`2016`, na.rm = TRUE)

# separate() : 하나의 변수를 두 변수로 나누기
# table3
# table3 %>% separate(rate, into = c("cases", "population"), sep = "/")
# int형식으로 나누기를 원하면 옵션 convert = TRUE
# table3 %>% separate(year, into = c("century", "year"), sep = 2)
# sep 옵션 값이 숫자형식이면 그 갯수만큼 뽑고 나눔

# unite() : 두개의 변수를 하나의 변수로 합하기
# table5 
# table5 %>% unite(new, century, year)

#======================================================================

## 07_1 날짜 형태가 다른 경우 결합.pdf

# 날짜에 하이픈 있음
samsung <- read.csv("c:/data/samsung_20181015")
samsung
str(samsung)

# 날짜에 하이픈 없음
ss_disclosure <- read.csv("c:/data/ss_disclosure_20181015")
ss_disclosure
str(ss_disclosure)

samsung_03 <- samsung %>% select(date, close, volume)
ss_disclosure_02 <- ss_disclosure %>% select(rpt_nm, rcp_dt)

# 참고, 현재시간
Sys.Date()
Sys.time()

# 문자 -> 날짜
as.Date('2018-09-15')

# 따라서 숫자 -> 문자 -> 날짜 시켜줘야.
str(samsung_03)
str(ss_disclosure_02)

samsung_03$date <- as.Date(samsung_03$date, "%Y-%m-%d") # 이렇게 생긴 문자열을 날짜형식으로 변환
str(samsung_03)

ss_disclosure_02$date <- as.Date( 
                     as.character(ss_disclosure_02$rcp_dt)
                     ,"%Y%m%d") # 변수이름을 같게 / 원본데이터가 슬러시가 없으므로
str(ss_disclosure_02)
ss_disclosure_02

# 최종 병합
inner_join(samsung_03, ss_disclosure_02, by = "date")
merge(samsung_03, ss_disclosure_02)

#=====================================================================
## 27. 전자공시 API with R .pdf
library(jsonlite)

class(mtcars)
jsoncars <- toJSON(mtcars, pretty=TRUE) #데이터프레임 -> 제이슨
class(jsoncars)
#  제이슨 -> 데이터프레임
# 1.fromJSON
aa <- fromJSON(jsoncars)
class(aa)
# 2.write_json()과 read_json()



start_dt = "2018-10-10"
end_dt= "2018-10-15"
api_key <- "4261942c6f82d5add3fb21533ab429a5e53e1375"  # 내 api키
url <- "http://dart.fss.or.kr/api/search.json"
query <- paste0(url, "?auth=", api_key, 
                #기업별로 하기위해서는여기 기업옵션추가 
                "&start_dt=", format(as.Date(start_dt), "%Y%m%d"),
                "&end_dt=", format(as.Date(end_dt), "%Y%m%d"),
                "&page_set=100")

query

# 1. fromJSON(query)
# 2. 
page_1 <- read_json(query)
page_1
class(page_1)
str(page_1)
page_1$list[[1]][[3]] # 보기어렵

# 3. 
page_1_df <- read_json(query,simplifyVector = TRUE)
names(page_1_df)
write.csv(page_1_df$list, "c:/data/page_1_df.csv") # 한페이지만 출력.

#루프문으로 전체 페이즈를 출력하게 만들어 주어야
deliver1 <- page_1$list
i <- page_1$page_no
while (i < page_1$total_page) {
  i <- i+1
  query_i <- paste0(query, "&page_no=", i)
  page_i <- read_json(query_i)
  deliver1 <- c(deliver1, page_i$list)
}
deliver1

# 이렇게 만든 기업공시 데이터. 주식데이터와 결합시키자.

# 중복되있는 값은 하나만 써도?

# 다할필요없고 년도별로 뽑아서 그중 하나씩만?