

## 8.결측치와 이상치 정리.pdf

library(dplyr)
stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66),
  per = c(20, 19, 15, NA, 19, 12, NA)
)
stocks
mean(stocks$return) # NA
sum(stocks$return) # NA
is.na(stocks) 
table(is.na(stocks)) # 결측치 갯수
table(is.na(stocks$return)) ; table(is.na(stocks$per))


## 결측치처리 : 기말에 무조건 나온대.
stocks %>% filter(is.na(return)) # 'return 변수'에서 결측치 있는 행 추출
stocks %>% filter(!is.na(return)) # return 변수에서 결측치 없는 행 추출

stocks %>% filter(!is.na(return) & !is.na(per)) # 두 변수의 결측치 제거하기 1
na.omit(stocks) # 데이터 전체의 결측치 제거하기 2

## 방법1. filter 함수사용
stocks_nomissing <- stocks %>% filter(!is.na(return))
stocks_nomissing
mean(stocks_nomissing$return)

## 방법2. 함수내 옵션 파일 사용
mean(stocks$return, na.rm=T) # 1
stocks %>% summarise(mean(return, na.rm=T)) # 2

# 결측치 평균값으로 대체하고 결과보기
stocks$return <- ifelse(is.na(stocks$return), 1.095, stocks$return )
stocks

# 이상치 : 시험에 무조건나옴 / 시각적확인 -> boxplot
boxplot(airquality$Ozone) # 이 그림안에 텍스트 넣는방법!! (시험)

boxplot(airquality$Ozone,main="dd")

boxplot(airquality$Ozone)$stats
# [1.] 박스 아래 있는 극단치 경계
# [2,] 박스 밑변 : 하위 25%
# [3,] 박스안에 있는 중간값 : 하위 50%
# [4,] 박스 위변의 값 : 하위 75%
# [5,] 박스 위에 있는 극단치 경계
quantile(airquality$Ozone, na.rm=T)

# 이상치를 결측치로 바꾸기.
airquality1 <- airquality
airquality1$Ozone <- ifelse(airquality1$Ozone > 122, NA, airquality1$Ozone )
table(is.na(airquality$Ozone))
table(is.na(airquality1$Ozone))
airquality1 %>% summarise(mean(Ozone, na.rm= T))


## 09.1 그래프_고수준.pdf

# 고수준 그래프에 저수준그래프가 입혀
win.graph() #그래프의 크기를 맞춰주기 위해 새창을 띄
x<-1:10
y<-rnorm(10,5)
plot(x, y)

win.graph(4,4)
plot(x, y, main="주제목", sub="부제목", xlab="x-axis" ,ylab="y-axis")

win.graph(8,4)
par(mfrow=c(1,2))
plot(x,y,main="왼쪽 한 칸만 사용한 상태")

plot(0:10, 0:10, type="n", main="title", xlab="X", ylab="Y") # type="n" hides the points
box("figure", col="forestgreen")
box("outer", col="blue")
mtext("Outer Margin Area", side=3, line=1, cex=1, col="blue", outer=TRUE)
mtext("Margins", side=3, line=3, cex=1, col="forestgreen")

par(oma=c(3,3,3,3)) # oma: outer margin / 밑에서 시계방향
par(mar=c(5,4,4,2) + 0.1) # mar: margin

plot(0:10, 0:10, type="n", main="title", xlab="X", ylab="Y") # type="n" hides the points
box("figure", col="forestgreen")
box("outer", col="blue")
mtext("Outer Margin Area", side=3, line=1, cex=1, col="blue", outer=TRUE) # 마진에 글자넣기 / side:아래부터 시계반대방향 / line:마진끝과의 거리 / cex:글자크기
mtext("Margins", side=3, line=3, cex=1, col="forestgreen")

op<-par(no.readonly = TRUE)
par(op) # 현재 그래프 상태값 저장하고 불러오기.

par(mfrow=c(1,3))
par(las=0) # x축,y축 숫자 설정하기
plot(trees$Height)
par(las=1)
plot(trees$Height)
par(las=2)
plot(trees$Height)

par(mfrow=c(2,3))
par(mar=c(3,2,2,2),oma=c(0,0,0,0))

# 그래프모양
plot(trees$Girth, type="p", main="points")
plot(trees$Girth, type="l", main="lines")
plot(trees$Girth, type="b", main="points & lines")
plot(trees$Girth, type="h", main="high density")
plot(trees$Girth, type="s", main="steps")
plot(trees$Girth, type="n", main="None")

# 선모양
plot(trees$Girth, type="l", lty= 1, main="solid")
plot(trees$Girth, type="l", lty= 2, main="dashed")
plot(trees$Girth, type="l", lty= 3, main="dotted")
plot(trees$Girth, type="l", lty= 4, main="dotdash")
plot(trees$Girth, type="l", lty= 5, main="longdash")
plot(trees$Girth, type="l", lty= 6, main="twodash")

# 점모양 / x범위설정
par(mfrow=c(1,3))
plot(trees$Height, pch=1, main="Height",xlim = c(0,50))
plot(trees$Height, pch=2, main="Height",xlim = c(0,100))
plot(trees$Height, pch=3, main="Height",xlim = c(0,200))

# y축에 그래프 두개 그리기
x <- 1:20
y <- rnorm(20)
z <- runif(20, min=1000, max=10000)
par(mar = c(5, 4, 4, 4) + 0.3) # Leave space for z axis
plot(x, y) # first plot
par(new = TRUE)
plot(x, z, type = "l", axes = FALSE, bty = "n", xlab = "", ylab = "")
axis(side=4, at = pretty(range(z)))
mtext("z", side=4, line=3)

## 고수준 그래프
# 산점도와 회귀추정선
plot(Volume ~ Girth, trees)
plot(trees$Girth, trees$Volume)
abline(coef(lm(Volume ~ Girth, trees)))

# 막대그래프
barplot(airquality$Ozone, main="Ozon of NewYork")
barplot(airquality$Ozone, horiz= T, main="Ozon of NewYork")
barplot(as.matrix(airquality)) # 데이터 전체를 각 변수별로 누적해서 그리기

# 히스토그램
hist(airquality$Ozone)

# 박스플롯
boxplot(trees)
boxplot(trees, horizontal =T)

# 파이차트
table(airquality$Month)
pie(table(airquality$Month)) # 테이블 형식이여야만 가능.

# 닷 차트
banana <- c(100, 120, 130, 140, 150)
cherry <- c(120, 130, 140, 150, 160)
orange <- c(140, 150, 160, 170, 180)
sale_volume <- data.frame(banana, cherry, orange)
sale_volume
dotchart(as.matrix(sale_volume))


## 09.2 그래프_저수준.pdf

# 점
par(mfrow=c(1,1))
plot(1:5, type= "n") 
points(2,2, pch=5, cex= 3)
points(2,4, pch=8, cex= 5)
points(4,2, pch=17, cex= 7)
points(4,4, pch=16, cex= 10)

# 글자
# pos: 지정한 좌표축을 기준으로 아래, 왼쪽, 위, 오른쪽 위치
# offset : pos 인자와 함께 사용하면서 pos 방향으로 지정한 값만큼 떨어
# adj : 정렬방
text(2,2, labels="Dog", pos= 1)
text(2,4, labels="Question", pos= 2)
text(4,2, labels="CashCow", pos= 3, offset=1) 
text(4,4, labels="Star", pos= 4, adj=3)
?text

# 선
plot(0:5, type="n", xlab="", ylab="")
lines(c(1, 2), c(1, 1), lty = 1, lwd=20)
lines(c(2, 3), c(2, 2), lty = 2, lwd=10, col="blue")
lines(c(3, 4), c(3, 3), lty = 3, lwd=5, col="green")
lines(c(4, 5), c(4, 4), lty = 4, lwd=3, col="red")

# 화살표
plot(1:5, type = "n", xlab = "", ylab = "")
arrows(1, 2, 2, 2, angle = 30, length = 0.25, code = 1)
arrows(2, 3, 3, 3, angle = 10, length = 0.5, code = 2)
arrows(3, 4, 4, 4, angle = 30, length = 0.2, code = 3)
plot(1:5, type = "n", xlab = "", ylab = "")
arrows(1, 2, 2, 2, lty=1, lwd=10, col="blue")
arrows(2, 3, 3, 3, lty=1, lwd=20, col="green")
arrows(3, 4, 4, 4, lty=1, lwd=30, col="red")

# 사각형
plot(1:5, type = "n", xlab = "", ylab = "")
rect(xleft = 1, ybottom = 4, xright = 2, ytop = 5)
rect(2, 2, 3, 3, density=10, lwd=3)
rect(3, 4, 4, 5, density=20, lwd=1)
rect(4, 2, 5, 3, density=5, lty=2)

# 다각형
plot(1:6, type = "n", xlab = "", ylab = "")
theta <- seq(-pi, pi, length = 6)
x <- cos(theta)
y <- sin(theta)
x1 <- x + 2
y1 <- y + 4.5
polygon(x1, y1)


## 09.3 고수준과 저수준 그래프 결합하기.pdf
plot(airquality$Ozone, type="l", lty=1 , ylim=c(0, 500))
lines(airquality$Solar.R, type="l", lty=2,col="red")
legend("top", legend=c("Ozone", "Solar.R"), lty=c(1,2),col=c(1,2))

plot(mpg ~ cyl, mtcars, xlim=c(3, 10))
text(mpg ~ cyl, mtcars, row.names(mtcars), pos=4, cex=0.5, offset=0.5)

# 이 박스플롯 예제는 시험에!!!!
boxplot(airquality$Ozone)
bb<-boxplot(airquality$Ozone)$stats
aa<-c("극단치 경계","하위 25%","하위 50%","하위 75%","극단치 경계")

# 방법1
text(x=1,y=bb,aa, pos=4, offset=7)

# 방법2
dd<-c(1,1,1,1,1)
cc<-data.frame(bb,dd)
text(bb~dd,cc,aa, pos=4, offset=7)

# 방법3
for (i in 1:5){
  text(bb[i],aa[i], pos=4, offset=7)
}


## 28. Naver API with R .pdf

# 내 애플리케이션 -> ~ -> 사용API:검색 -> 환경추가:WEB설정 -> 비로그인 오픈 API 서비스 환경 : ? 

# 내부구조 반영 X
rhu <- readLines("c:/data/test03.html", encoding = "UTF-8")
rhu

# 방법1 : XML 패키지
library(XML)
rhu <- htmlParse("c:/data/test03.html", encoding = "UTF-8")
rhu # 깨지지만 무시
text <- xpathSApply(rhu, "//body", xmlValue)
text

# 방법2 : rvest 패키지
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


# 실전 
library(RCurl)
library(rvest)
search_url <- "https://openapi.naver.com/v1/search/news.xml"
query <- URLencode(iconv("삼성전자 위기", "euc-kr", "UTF-8"))
url <- paste(search_url, "?query=", query, "&display=2", sep="")
url
Client_ID <- "pP3RCBvFI37TVv0PpuOi"
Client_Secret <- "dCqD4SEeTS"
doc <- getURL(url,
              httphead=c('Content-Type'= "application/xml",
                         'X-Naver-Client-id'=Client_ID,
                         'X-Naver-Client-Secret'=Client_Secret))
doc
# 다운 받은 자료 구조보기
library(XML)
htmlTreeParse(doc, encoding="UTF-8", asText = TRUE)
# 자료 내용보기
rhu <-read_html(doc, encoding="UTF-8")
rhu
body<-html_nodes(rhu, "body")
body
body_text <- html_text(body)
body_text

# ~ 

