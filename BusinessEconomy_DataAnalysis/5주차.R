# 새 텍스트파일 -> .csv 다른이름으로 저장
## 04. 파일 읽기.pdf

install.packages("AER")
library(AER)
data(package='AER')
data(CreditCard)
str(CreditCard)

write.csv(CreditCard, "c:/data/creditcard.txt")
write.csv(CreditCard, "c:/data/creditcard.csv")

# readLines() : 전체를 한 줄씩 문자형식으로 데이터 읽기
cc_txt <- readLines("c:/data/creditcard.txt")
head(cc_txt)

cc_line <- readLines("c:/data/creditcard.csv")
head(cc_line)

# read.table() : 데이터프레임형식으로 데이터 읽기 / header,sep,skip 옵션
args(read.table)
cc_tb <- read.table("c:/data/creditcard.csv")
head(cc_tb)

cc_tb <- read.table("c:/data/creditcard.csv",header = T ,sep=",")
head(cc_tb)

# read.delim() : 디폴트가 sep = "\t" / delim:구분문자라는 뜻
cc_delim <- read.delim("c:/data/creditcard.csv", sep=",")
head(cc_delim)

# read.csv() : header = TRUE, sep = "," 가 디폴트
cc <- read.csv("c:/data/creditcard.csv")
head(cc)

# read_csv() : tidydata 계열의 명령어 / tibble 형식의 데이터로 불러짐
install.packages("readr")
library(readr)

card<-read_csv("c:/data/creditcard.csv")
head(card)

# read_excel() :
install.packages("readxl")
library(readxl)
abc <- read_excel()

# Read SPSS Files into R
library(foreign)
SPSSData <- read.spss("example.sav")
#Read Stata Files into R
library(foreign)
mydata <- read.dta("<Path to file>")
#Read Minitab Files into R
library(foreign)
myMTPData <- read.mtp("example2.mtp")
#Read SAS Files into R
library(sas7bdat)
mySASData <- read.sas7bdat("example.sas7bdat")


# 웹에서 데이터 불러오기
# https://vincentarelbundock.github.io/Rdatasets/datasets.html 
# csv에서 포인트올려놓고 우클릭 링크주소복사
url <- "https://vincentarelbundock.github.io/Rdatasets/csv/boot/acme.csv"
acme <- read.csv(url)
head(acme)

# 탭으로 구분된 데이터
my_data <- read.delim("http://www.sthda.com/upload/boxplot_format.txt")
head(my_data)

# 웹에서 데이터 다운로드 받기
args(download.file)

url<-"https://github.com/mrchypark/sejongFinData/raw/master/codeData.csv"
download.file(url, destfile = "c:/data/codeData_01.csv")
code <- read.csv("c:/data/codeData_01.csv")

## readr::guess_encoding()
as.character( guess_encoding("c:/data/codeData_01.csv")[1,1] )

code <- read.csv("c:/data/codeData_01.csv", encoding = "UTF-8", quote="", header = T)
head(code)

#-----------------

## 참고
library(readr)
codeData<-read_csv("c:/data/codeData_01.csv")
head(codeData)

# HTML 읽기
install.packages("rvest")
library(rvest)

rhu <-read_html("c:/data/test03.html")
rhu
body<-html_nodes(rhu, "body")
body
body_text<-html_text(body)
body_text

table<-html_nodes(rhu, "table")
table
table_text<-html_text(table)
table_text

# or
library(XML)
rhu <- htmlParse("c:/data/test03.html", encoding = "UTF-8")
rhu


# XML 파일 읽기
install.packages("xml2")
library(xml2)

uri = 'http://www.w3schools.com/xml/simple.xml'
download.file(uri, destfile = "c:/data/bond02.xml")
bond <- read_xml("c:/data/bond02.xml")
bond

xml_name(bond)
xml_children(bond)
xml_text(bond)


# json 파일
require(jsonlite)
mtcars
class(mtcars)

jsoncars <- toJSON(mtcars, pretty=TRUE)
class(jsoncars)
cat(jsoncars)
fromJSON(jsoncars)

# =======================================================================

# tm패키지, KoNLP패키지 중 어떤 패키지를 사용하느냐에따라 방식이 달라짐
# 하나의 벡터로 / 여러개의 벡터로
# 띄어쓰기로 구분 : 1. 텍스트분석.PDF중 2페이지 에서 
#                 : Basic R , tm , tidytext
# ex. 나는 / 학교에 / 간다
# 단어로 구분 : KoNLP

## 103. TM 사용한 텍스트분석 20181002.pdf (영어 주로)

## 내장 R업그레이드
#if(!require(installr)) {
#  install.packages("installr"); require(installr)} 
# using the package:
#updateR()

install.packages("tm")
library(tm)

# Corpus : 문장들의 집합구조 / (VCorpus : 더 큰 구조에서도 사용가능)

doc3 <- c("I work for UOE", "You work for NIA", "We work for KOREA")  #벡터3개 문장
doc3

myCorpus3 <- Corpus(VectorSource(doc3)) # 벡터소스인 x에 대해서 코퍼스로 변환~
myCorpus3 
inspect(myCorpus3)

myCorpus3 <- tm_map(myCorpus3, tolower)
inspect(myCorpus3)

myCorpus3 <- tm_map(myCorpus3, stripWhitespace) #공백제거
myCorpus3 <- tm_map(myCorpus3, removePunctuation) #구두점을 제거
myCorpus3 <- tm_map(myCorpus3, removeNumbers) #숫자제
myCorpus3 <- tm_map(myCorpus3, removeWords, stopwords("english"))  #english 불용어 사전에 등재된 단어를 제
inspect(myCorpus3)

tdm3 <- TermDocumentMatrix(myCorpus3)
#myCorpus3 <- tm_map(myCorpus3, PlainTextDocument) # 오류발생시 사용.
tdm3

inspect(tdm3)

# 일정빈도이상 단어 추출
findFreqTerms(tdm3)
m3 <- as.matrix(tdm3)
m3
rowSums(m3)
sort(rowSums(m3), decreasing=T)
wordFreq <- sort(rowSums(m3), decreasing=T)
names(wordFreq)
# install.packages("wordcloud")
library(wordcloud)
wordcloud(words = names(wordFreq), freq=wordFreq, min.freq= 1, random.order=F)

#한글을 tm패키지사용.
tear <-"내 피 땀 눈물 내 마지막 춤을 다 가져가 가내 피 땀 눈물 내 차가운 숨을,
다 가져가 가내 피 땀 눈물내 피 땀 눈물도 내 몸 마음 영혼도너의 것인 걸,
잘 알고 있어이건 나를 벌받게 할 주문,
Peaches and creamSweeter than sweetChocolate cheeksand chocolate
wingsBut ,
너의 날개는 악마의 것너의 그 sweet 앞엔 bitter bitterKiss me ,
아파도 돼 어서 날 조여줘더 이상 아플 수도 없게Baby 취해도 돼,
이제 널 들이켜목 깊숙이 너란 위스키내 피 땀 눈물 내 마지막 춤을 다 가져"
corpus_tear <- Corpus(VectorSource(tear))
class(corpus_tear)
summary(corpus_tear)
inspect(corpus_tear)
tdm_tear <- TermDocumentMatrix(corpus_tear)
tdm_tear
inspect(tdm_tear)
matrix_tear <- as.matrix(tdm_tear )
matrix_tear
wordFreq <- sort(rowSums(matrix_tear), decreasing=T)
wordFreq
names(wordFreq)
library(wordcloud)
wordcloud(words = names(wordFreq), freq=wordFreq, min.freq= 1, random.order=F)


#==============================================================

## 104. KoNLP 사용 텍스터 데이터 처리.pdf (한국어 전용)
# KONLP에서는 자바가 깔려있어야. / 컴퓨터와 자바와 R의 32,64비트를 맞춰야댐

install.packages(c("rJava","memoise"))
library(rJava)
library(memoise)

install.packages("KoNLP")
library(KoNLP)
useNIADic()

tear_01 <- "내 피 땀 눈물 내 마지막 춤을 다 가져가"
extractNoun(tear_01)

# vs
tear_02 <- "내 피 땀 눈물 내 마지막 춤을 다 가져가"
strsplit(tear_02, " ")

repub <- readLines("C:/Users/Jiwan/Desktop/moon01.txt")
length(repub) # 7개의 문장으로 구성.

# 하나의문장으로 묶어분석하는 방법부터 
repub_06 <- paste(repub, collapse="")
length(repub_06)
noun <- extractNoun(repub_06)
noun
length(noun)
noun_2 <- noun[nchar(noun) >=2]
length(noun_2)
length(unique(noun_2)) # 중복값은 빼고 세

noun_tb <- table(noun_2)
head(noun_tb, 20)

noun_tb_sort <- sort(noun_tb, decreasing = T)
head(noun_tb_sort, 20)

class(noun_tb_sort)
barplot(head(noun_tb_sort, 20) , las=2) #글자를 세로로 만들고 출력
wordcloud(words = names(noun_tb_sort), freq=noun_tb_sort, min.freq= 1, random.order=F)


# 하나의문장으로 묶지않고.
class(repub)
minu_list <- sapply(repub, extractNoun, USE.NAMES = F)
minu_list <- lapply(repub, extractNoun) # 같음
?sapply

head(minu_list)
class(minu_list)



# 리스트,벡터에 함수를 적용하는 sapply(->벡터) lapply(->리스트) / simpe,list
# 매트릭스에 함수를 적용하는 apply
x<-list(c(1,2,3),c(4,5,6))
sapply(x,rbind) # rbind(x[[1]])->벡터 ;  rbind(x[[2]]) -> 벡터
lapply(x,rbind) # rbind(x[[1]]) ;  rbind(x[[2]])
do.call(rbind,x) # rbind(  x[[1]],x[[2]]  )

mylist<-list(x=c(1,5,7), y=c(4,2,6), z=c(0,3,4))
mylist
sapply(mylist,mean)
lapply(mylist,mean)
# do.call(mean,x)



mini_tb <- table(minu_list) # 리스트는 에러
minu_vec <- unlist(minu_list) # 리스트 -> 벡터 : unlist
head(minu_vec)
minu_vec_2 <- minu_vec[nchar(minu_vec) >=2]
mini_tb <- table(minu_vec_2)
mini_tb
