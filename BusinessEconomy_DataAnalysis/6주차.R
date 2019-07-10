# 과제2 수정사항 : 연설문분석
## 한사람의 일년치 분석
## 빨간색으로 표기된 부분은 안해도 됨



# 105. 사전사용하여 감성분석.pdf
positive <- read.csv('C:/Users/CAU/Downloads/positive-words.txt',skip=34,head=F)
str(positive)
head(positive)
?read.csv

## scan() : 벡터형식으로 불러오기
pos.words= scan('C:/Users/CAU/Downloads/positive-words.txt', what='character', comment.char = ';')
head(pos.words)
str(pos.words)

neg.words= scan('C:/Users/CAU/Downloads/negative-words.txt', what='character', comment.char = ';')
head(neg.words)

## 
Q3 <- c("You're awesome and I love you", "I hate and hate and hate. So angry. Die!",
"Impressed and amazed: you are peerless in your achievement of unparalled mediocrity",
"oh how i love being ignored", "Absolutely adore it when my bus os late")
sentence <- tolower(Q3) #소문자화
word_ist <- strsplit(sentence, ' ') #띄어쓰기 기준분리
words <- unlist(word_ist) #리스트가 된 것을 다시 벡터

pos.matches <- match(words, pos.words);pos.matches
neg.matches <- match(words, neg.words);neg.matches

pos.match_p <- !is.na(pos.matches);pos.match_p
neg.match_n <- !is.na(neg.matches);neg.match_n

pscore = sum(pos.match_p);pscore
nscore = sum(neg.match_n);nscore
pscore - nscore

words[which(!is.na(pos.matches))]
words[which(!is.na(neg.matches))]



# 05. 데이터프레임 다루기.pdf

head(airquality)
dim(airquality)
str(airquality)
summary(airquality)

## 예쁘게 기초통계량 보기
install.packages("prettyR)")
describe(airquality)

airquality[, 1]
airquality[, "Ozone"]

airquality[, c("Wind", "Month")]
Wind_month <- subset(airquality, select=c(Wind, Month))

names(airquality)
names(airquality) == "Solar.R"

names(airquality)[names(airquality) == "Solar.R"] <- c("Solar") # 변수이름 바꾸기 (시험!)
names(airquality)[names(airquality) == "Solar.R"] <- "Solar" # 같음

airquality$newcol <- NA
airquality$OS <- airquality$Ozone + airquality$Solar

rm(list=ls()) # 모든 저장된 변수 삭제

airquality[airquality$Ozone >=100, ]
airquality[airquality$Month == 5, ]
airquality[airquality$Month == 5 | airquality$Ozone == 100, ]
airquality[airquality$Month == 5 & airquality$Ozone >= 100, ]

## sort:순서정렬 / rank:색인 / order:애를 몇번째를 보내
a<-c(3,1,2)
rank(a)
sort(a)
order(a)
a[order(a)]

airquality[order(airquality$Ozone, decreasing = T), ]

table(is.na(airquality$Ozone))
mean(airquality$Ozone, na.rm= T)

air <- na.omit(airquality)
mean(air$Ozone)

boxplot(airquality$Ozone)
boxplot(airquality$Ozone)$stats
quantile(airquality$Ozone, na.rm=T)

UpperQ <- quantile(airquality$Ozone, na.rm=T)[4]
LowerQ <- quantile(airquality$Ozone, na.rm=T)[2]
IQR <- UpperQ - LowerQ

upperOutlier <- airquality$Ozone[ which( airquality$Ozone > UpperQ+IQR*1.5) ]
lowerOutlier <- airquality$Ozone[ which( airquality$Ozone < LowerQ-IQR*1.5) ]
upperOutlier
lowerOutlier


# 06. Tidy Data 다루기.pdf
## 현대적인 방식의 데이터프레임 다루기
## 행과 열을 바꾼 데이터를 바꿔진 데이터를 우리가 아는 버전으로도 바꿔줌.

# select(): 열선택
# mutate(): 열추가
# filter() : 행선택 by 조건
# slice() : 행선택 by 열번호
# arrange() 순서정리
# summarize(): 요약
# group_by(): 집합으로 처리

install.packages("tidyverse")
library(tidyverse)
## tidy -> tibble -> pipes

## tibble형식을 사용 
head(iris)
as_tibble(iris)

## pipes : 앞에나온결과를 뒤에서 자동으로 받아줌
##        default R : %>% 로 표현.
library(magrittr)



library(dplyr)
library(ggplot2)
data("diamonds")
diamonds # head 안써도.

## select(): 열선택
diamonds %>% select(carat, color, price) #c()안써도.
# mutate(): 열추가
diamonds %>% mutate(price * carat)
# 
unique(diamonds$cut)
# filter() : 행선택 by 조건
diamonds %>% filter(cut=="Premium")
diamonds %>% filter(price >= 400, color=="E")
# slice() : 행선택 by 열번호
diamonds %>% slice(c(1:5, 10))
c(1:5)
# arrange() 순서정리
diamonds %>% arrange(desc(price))
# summarize(): 요약
diamonds %>% summarise(Ave=mean(price), Median=median(price), n=n())
# group_by(): 집합으로 처리
diamonds %>% group_by(color)%>%summarise(mean(price))
