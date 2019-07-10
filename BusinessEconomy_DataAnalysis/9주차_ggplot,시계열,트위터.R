
## 프로젝트 3
# 정치,경제,사회,문화가 기업에 어떤 영향? 시나리오 그리고
# 숫자 분석
# 그에 대한 insight
# 관찰 분석 전략 실행


## 09.4 날짜가 연속된 데이터 그리기.pdf

library(readxl)
visit <- read_excel("c:/data/visit.xlsx")
visit
plot(Visits ~ Date, visit) # 에러 : 캐릭터형식이 x축

visit$Date <- as.Date(visit$Date, "%m/%d/%Y")
plot(visit$Date, visit$Visits, type = "l")

# lubridate 패키지 활용
library(lubridate)
today()
now()
ymd("2017-01-31")
mdy("January 30th, 2017")
dmy("31-Jan-2017")
ymd(20170131)
?mdy

# 축내용 수동설정하기
plot(Visits ~ Date, visit, xaxt = "n", type = "l")
axis(1, visit$Date, format(visit$Date, "%b %d"), cex.axis = .7)

# make_date() & make_datetime()
library(tidyverse)
library(lubridate)
library(nycflights13)
flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(depart_day = make_date(year, month, day))
?make_date # lubridate 내장

# seewave로 데이터 변화 양상 표시하기

# ts함수이용 : 같은 간격 데이터
# zoo함수이용  : 데이터 간격이 다른 경우
# xts함수 이용 : zoo함수 하위 패키지 + data클래스를 색인으로 사용가능.


### 10.visual with ggplot2.pdf
# rstudio - help - cheatsheet - ggplot2 참

head(mtcars)
str(mtcars)
summary(mtcars)
library(ggplot2)

## 변수가 하나여도 되는 그래프2 : 히스토그램, 막대그래프

## bar plot : geom_bar - x의 값을 count
#          : geom-col - x와y의 값을 represent
# mtcars %>% group_by(cyl) %>% summarise(sum(mpg)) : geom_col barplot
# mtcars %>% group_by(cyl) %>% count() : geom_bar barplot

ggplot() #빈 캔버스 
ggplot(mtcars, aes(x=cyl, y=mpg)) #축 기준 설정
ggplot(mtcars, aes(x=cyl, y=mpg)) + geom_col() # 그래프 선택
ggplot(mtcars, aes(x=cyl, y=mpg)) + geom_col(aes(fill=gear)) # 변수 정보 추가
ggplot(mtcars, aes(x=cyl, y=mpg)) + geom_col(aes(fill=gear)) + ggtitle("mtcars") # 제목넣기
ggplot(mtcars, aes(x=cyl, y=mpg)) + geom_col(aes(fill=gear)) + ggtitle("mtcars") + theme_void() # 테마넣기

ggplot(mtcars, aes(factor(cyl))) + geom_bar()
ggplot(mtcars, aes(factor(cyl))) + geom_bar(aes(fill=factor(gear)))


## 히스토그램 : geom_histogram()
ggplot(mtcars, aes(mpg)) + geom_histogram() # bin(계급구간) 갯수 30 자동으로 설정
ggplot(mtcars, aes(mpg)) + geom_histogram(binwidth = 1.5)
ggplot(data = mtcars) + geom_histogram(mapping = aes(x = mpg), binwidth = 1.5) #같은 결과


## 빈도선그래프 : geom_freqpoly
ggplot(data = mtcars, mapping = aes(x = mpg))+
  geom_freqpoly(binwidth = 0.1)

mtcars$gear <- as.factor(mtcars$gear)
ggplot(data = mtcars, mapping = aes(x = mpg, colour = gear)) +
  geom_freqpoly(binwidth = 0.1)


## 산점도 : geom_point()
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point(colour="red", size=3)


## 박스플롯 : geom_boxplot()
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) + geom_boxplot(aes(fill=factor(gear)))
# 여기까지는 필수


## 문자표현하기 : geom_text()
ggplot(mtcars, aes(x=wt, y=mpg, label= rownames(mtcars))) +
  geom_point() +
  geom_text(aes(x=wt+ 0.2), size=2)

ggplot(mtcars, aes(x=wt, y=mpg, label= rownames(mtcars))) +
  geom_point() +
  geom_text(aes(x=wt+ 0.2, colour=factor(cyl)),size=2)


## 선 그래프 : geom_line()
ggplot(economics, aes(x = date, y = unemploy)) + geom_line()

# 두개변수를 동시에 표현
library(reshape2)
library(tidyr)
psa_uem <- economics %>% select(date, psavert, uempmed)
head(psa_uem)
psa_uem <- psa_uem %>% gather(psavert, uempmed, key = "variables", value = "rates")
psa_uem

ggplot(psa_uem, aes(date, rates)) + geom_line(aes(group=variables))
ggplot(psa_uem, aes(date, rates)) + geom_line(aes(group=variables, colour=variables))

# 두개의 그래프를 하나의 화면에 
library(ggplot2)
library(grid)
library(gridExtra)
data(mtcars)
ggplot(mtcars) + aes(x = hp, y = mpg) + geom_point() -> p1
ggplot(mtcars) + aes(x = factor(cyl), y = mpg) + geom_boxplot() +
  geom_smooth(aes(group = 1), se = FALSE) -> p2
grid.arrange(p1, p2, ncol = 2)

# 화면을 분할하여 여러화면 동시에 그리기
ggplot(df_melt, aes(x = year, y = value)) + geom_col() + facet_wrap(~ variable, scales = 'free_y', ncol = 1)


### 29.트위터 API with R .pdf

# apply -> standard APIs -> ...
library(twitteR)

APIkey <- "Cz58rKVPmaw4zG5KXta4AwwoU"
APIsecret <- "Nb5ZcK1E6WFPTwsm0w4hW87RweTaMBFmvL728Osm2ujEc4tEzi"
AccessToken <- "1040956844552802305-O0n3SQADHTbVcjAc7ajigE5zcYTPGK"
AccessTokenSecret <- "7YVwKJSfE3xK78gfEk1ElLFG9SIcVSGIV6XelhIMRusQb"
options(httr_oauth_cache = T)
setup_twitter_oauth(APIkey, APIsecret, AccessToken, AccessTokenSecret)

keyword <- enc2utf8("삼성전자 기회")
result <- searchTwitter(keyword, n=100, lang='ko')
head(result)
str(result)

df <- twListToDF(result) # dataframe 변환
str(df)
df$text



# 이하예제

# 날짜, 지역옵션
tw <- searchTwitter(keyword, since='2018-01-01', geocode='35.874, 128.246, 400km', lang='ko', n=100)
head(tw)

ssgalaxy = searchTwitter("Samsung galaxy", since='2017-01-01')
ssgalaxy
#
amazon = searchTwitter("Amazon.com", since='2017-01-01')
amazon
# dataframe으로 바꾸는 방법
twListToDF(amazon)
do.call('rbind', lapply(amazon, as.data.frame))
galaxy.df <- do.call('rbind', lapply(ssgalaxy, as.data.frame))

# 저장하기
write(galaxy.df$text, "c:/data/galaxy.df.txt")
write(unique(galaxy.df$text), "c:/data/galaxy.df.txt")


## 지역별 트렌드 받기
library(twitteR)
library(Unicode)

# 지역별 코드 알아내기
locs <-availableTrendLocations()
head(locs, 20)

woeid <-1132599 # woeid = seoul
current_trends <- getTrends(woeid)
head(current_trends)

woeid <-1132466 # daegu
current_trends <- getTrends(woeid)
head(current_trends)

close = closestTrendLocations(lat, long) # 위도 경도 넣으면 된다.
close


## 과제와 비슷한 예제

rm(list=ls())
library(KoNLP)
library(wordcloud)
library(plyr)
library(twitteR)
library(tm)
library(Unicode)
library(wordcloud2)
setwd("C:/data")

APIkey <- "Cz58rKVPmaw4zG5KXta4AwwoU"
APIsecret <- "Nb5ZcK1E6WFPTwsm0w4hW87RweTaMBFmvL728Osm2ujEc4tEzi"
AccessToken <- "1040956844552802305-O0n3SQADHTbVcjAc7ajigE5zcYTPGK"
AccessTokenSecret <- "7YVwKJSfE3xK78gfEk1ElLFG9SIcVSGIV6XelhIMRusQb"

setup_twitter_oauth(APIkey, APIsecret, AccessToken, AccessTokenSecret)

download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")

# 키워드 설정
keyword <- enc2utf8("삼성전자")
fromTw <- '2018-01-01'
nTw <- 100
# 트위터에서 키워드로 검색, 시작날짜, 지역코드(우리나라만 적용), 가져올 개수를 옵션에 대입
tw <- searchTwitter(keyword, since=fromTw, geocode='35.874,128.246,400km', lang='ko', n=nTw)
head(tw)
# 검색된 내용을 데이터 프레임으로 변환하고, 텍스트 부분만 추출
tw.df <- twListToDF(tw)
tw.text <- tw.df$text
head(tw.text)

write.csv(tw.text, file = "tw.csv")
tw.text = readLines("tw.csv")

head(tw.text)
# 전처리 (Preprocessing). 불필요한 문자를 필터링
tw.text = gsub("&amp", "", tw.text)
tw.text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tw.text)
tw.text = gsub("@\\w+", "", tw.text)
tw.text = gsub("[[:punct:]]", "", tw.text)
tw.text = gsub("[[:digit:]]", "", tw.text)
tw.text = gsub("http\\w+", "", tw.text)
tw.text = gsub("[ \t]{2,}", "", tw.text)
tw.text = gsub("^\\s+|\\s+$", "", tw.text)
tw.text = gsub("[\r\n]", " ", tw.text)
head(tw.text)

# 방법1 문장에서 명사 추출하여 처리하기
nouns <- extractNoun(tw.text)
head(nouns)
wordcount <- table(unlist(nouns))
head(wordcount)
df_word <- as.data.frame(wordcount, stringAsFactors=F)
head(df_word)
df_word <- rename(df_word, word = Var1, freq= Freq)
head()
df_word <- filter(df_word, nchar(Var1) >=2)
library(dplyr)
df_word <- rename(df_word, word = Var1, freq = Freq)
head(df_word, 20)
