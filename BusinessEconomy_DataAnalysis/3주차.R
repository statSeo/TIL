

# 26.전자공시시스템에서 데이터 수집 20180918 . pdf

# 금융감독원 전자공시시스템 / 
#  1.OPEN API
#  2.공시서류검색

## 주가검색
# : 네이버 금융 / 구글 스프레드시트 (dd/mm/yyyy 대신 yyyy. mm. dd 사용) / 
#    / tqk library / quantmod library


# rtools 미리 설치
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("mrchypark/tqk")
library(tqk)

code<-code_get()
code

samsung <- tqk_get(code[grep("삼성전자", code[,2]),1] , from="2017-01-01")
p <- samsung
p
str(p)



## 01.R,RStudio Packages 설치와 이해.pdf

# Q1. 현재 패키지를 확인하는 명령어?
# Q2. 현재 로딩된 패키지를 확인하는 명령어는?
# Q3. 패키지 tm설치하는 명령어는?
# Q4. 패키지 tm메모리에 loading하는 명령어는?
# Q5. 패키지 tm메모리에 unloading하는 명령어는?
# Q6. 패키지 tm을 삭제하는 명령어는?



## 03.데이터 타입과 구조 이해.pdf

library(help=datasets)
AirPassengers

#integer : 정수
#double : 실수

#typeof : R에서 구분한 자료형 (저수준)
#class : 객체지향언어 관점에서 자료형 (고수준)
#mode : s1에서의 자료형(구)
#str : 종합적인구조


#      동종자료 / 이종자료
# 1차원 vector  /  list
# 2차원 matrix  /  Data.frame
# n차원 array   /

# page 10_벡터의 주 6가지 종류
y <- c(1,2,3,4,5,6,7,8,9,10)
str(y)
typeof(y)
class(y)
mode(y)
str(list(1,"k"))

?matrix
aa <- matrix(1:6,2,3)
aa
aa[2,2:3]

x <- list(data.frame(name="foo", value=1),
          data.frame(name="bar", value=2, way=2) )
x
x[1]
x[[1]]
# x[1][1]
x[[1]][1]

length(x[1])
length(x[[1]])


# page3 중요!!!! 이 페이지만 중점적으로
# 데이터타입 / 구조



### 101. 텍스트 분석명령어.pdf

tear_01 <- "내 피 땀 눈물 내 마지막 춤을 다 가져가"
tear <- strsplit(tear_01, " ")
tear
str(tear)
tear[[1]] # 데이터만 가져오기위해서는 대괄호 두번
