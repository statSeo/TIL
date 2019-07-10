


########################################################################
########################################################################  2


## 산술연산자
5+49
5-49
5*49
5/49
-49
3 ^ 4
7 %/% 2 #몫
7 %% 2  #나머지
2 ^ (1/2)
((1 + (2 * 3)) / (4 + 1)) ^ 3
## 비교연산자
3 < 4
3 > 4
3 == 4
3 <= 3
3 >= 3
TRUE
FALSE
T
F


## 논리연산자
(3 < 4) | (5 > 6) #or
(3 < 4) & (5 > 6) #and
!(3 < 4) & (5 > 6)
A&(!B)|B&(!A)     #xor

interest.30 <- 1.0025^30
interest.30
1000 * interest.30
2000 * interest.30
interest.30 <- 1.0015^30
interest.30
# 변수 : 첫글자 소문자 알파벳
x <- NULL
x
x <- 3
y <- 5
x == y
x / y
typeof( x )
class( x )
is.numeric( x )
xi <- as.integer( x )
typeof( xi )
x <- xi
x
typeof( x )
typeof( 1.23 )             #double
typeof( 1 )                #double
typeof( as.integer(1) )    #integer 
typeof( 1L)                #integer  (   as.integer(4)=4L   )
typeof( TRUE )             #logical
typeof( "abc" )            #character
'TOM\'s shoes'

objects()                  #value 보여줌
rm("y")
objects()
ls()
rm( list=objects() )       #전체삭제
ls()
x <- 123
(x <- 123)
typeof( x )                #double
class( x )                 #numeric (class)

height <- c(172, 184, 194, 178)
height
1:20
5:2
str(height)                #벡터의구조 표현 
length(height)             #벡터의 원소수
2 * height



########################################################################
########################################################################  3


#       typeof   class 
# 1L    integer  integer
# 1     double   numeric

height <- c( 172,168,182,176 )
length( height )
str ( height )
height[c(1,4)]

height[-c(1,4)]                     # vector [-1] : 1번째 벡터 제외한값
height.m <- mean( height )
height.m
height < height.m                   # 벡터와 하나의 값에 비교는 하나씩 대조돼서 결과
height [ height < height.m ]        # vector [T,T,F,F] : 1,2번째 벡터만 보여줌 원소수같아야

height
tmp <- c(10,20)
height*tmp                          # 원소 큰애에 원소 작은애가 배수이면 작은애 반복
rep( tmp, each=2  )                 # 10,20 each=2 : 10 10 20 20
rep( tmp, times=2 )                 # 10,20 each=2 : 10 20 10 20
tmp
height*rep( tmp, each=2  )          # 활용가능

length( height )
length( tmp )
length( height ) %% length( tmp )
t <- length( height ) %/% length( tmp ) # 몫값은 당연히 integer
t
height * rep(tmp, times=t)          # 활용가능 / 위 값을 해석하면 이렇게 한거임

tmp2 <- c(10,20,30)
height
height * tmp2

x <- -3:3                          # dnorm(x) : x의 표준정규분포값 반
plot(x, dnorm(x), type="l")        # plot(x축,y축)

x <- seq(-3,3,by=0.01)             # seq -3 ~ 3 까지 0.01 간격으로
plot(x, dnorm(x), type="l")        # type small L : 자료를 선으로 이어줌

x <- seq(-3,3,by=0.0001)
plot(x, dnorm(x))

str( x )
head(x)
tail(x)

grp <- c("control","treatment","control","treatment")
grp
grp.f <- factor( grp )             # factor : 범주형 자료에서 levels를 지들이 정해서 묶음
grp.f
levels( grp.f )
?factor

gender <- c("M","F","F","M")
g.f <- factor(gender)
g.f
g.f2 <- factor (gender,levels=c("F","M","R"))        # levels 를 직접지정가능
g.f2
table(g.f2)

grd <- c("B","C","A","A","F")
grd.f <- factor(grd,levels=c("A","B","C","F"),ordered=TRUE) #levels 의 순서도 지정가능
# 순위형 자료
grd.f

levels(grd.f)
str(grd.f)

c(1,2,3,TRUE)
c(1,2,3,"A")
c("A",TRUE)                                # 하나의 벡터는 하나의 자료형 밖에 표현못함
# character numeric logical 강력한 순서

m1 <- matrix(1:12, nco=4)                  # matrix / 자료는 하나의 열을 채우고 다음열이동
m1
str(m1)
m2 <- matrix(1:12, nco=4, byrow=TRUE)      # byrow 옵션을 주면 열부터가 아닌 행부터 채움
m2
str(m2)

v1 <- 1:3
v2 <- 4:6
v3 <- 7:9
v4 <- 10:12

v1
v2
v3
v4

m3 <- cbind(v1,v2,v3,v4)                 # cbind : 벡터를 열로 해서 결합    매트릭스
m3

m4 <- rbind(v1,v2,v3,v4)                 # rbind : 벡터를 행으로 해서 결합  매트릭스
m4

str(m4)                                  # 매트릭스의 구조는 이러함

colors <- c("red","yellow","blue")
substr(colors,1,2)                      # substr : 문자형자료를 1번째문자부터 2개를 가져옴
paste(colors,"flower")                  # paste : 문자열로 합해줌
paste(colors,"flower",sep="-")          # sep 옵션 : 사이를 이것으로 이어줌 기본은 띄어씀
paste(colors,"flower",sep="")
paste(1:12,"월달의 약어는", month.abb,"입니다") #month.abb : 달의 약어 벡터



########################################################################
########################################################################  4


gender<- c("M","F","M","M","M")
str(gender)
g.f<- factor(gender)
str(g.f)
g.f2 <- factor(gender, levels=c("F","M","E"))
g.f2
str(g.f2)
g.f3 <- factor(gender,levels=c("F","M","E"),ordered=TRUE)
str(g.f3)
## 복습

################################################### 데이터 프레임
h <- c(178,182,174,168,180)
w <- c(80,54,70,50,75)
s <- c("M","M","F","F","M")
h
w
s
students <- data.frame(heights = h,weights = w,genders = s)  # 데이터 프레임 : 표,매트릭스랑 비슷
students
class( students )                                 # data.frame
typeof(students)                                  # list
str(students)                                      # 문자형 character 형태를 factor로 표현
str(s)


dim(students)                                      # 몇행 몇열?
dim(students)[1]                                   # 몇행몇열의 1번째 원소 : 몇행?
nrow(students)                                     # real 몇행
ncol(students)                                     # real 몇열
names(students)                                    # 열이름?
names(students) <-c("키","몸무게","성별")          # 열이름 바꾸기
students    
row.names(students )                               # 행이름
row.names(students ) <- c("jin","kim","park","yumn","seo")  
##다시 열이름 복구
students


##특정 행,열만 불러오기
students[ , ]
students[ c(1,5) , c(1,2) ]                        # 특정 열,행 불러올땐 by벡터
students[ c(1,5) ,  ]


str(students[  , 2])
class(students[  , 2])

# 사실 여기서 열이란 case 를 뜻함
students[  , 2]                                   # 특정 행,열 불러올때 by숫자
students$weights                                  # 특정 열 불러올때 by열이름
students[[2]]                                     # 특정 열 불러오기 by 더블 중광호
students[2]                                       # 중괄호 하나써도 열 불러오나 세로 나열


##성별이 남자인 자료만 가져와라!
students[students$genders == "M",c(1,2)]
subset(students,genders=="M")                     # subset : 조건에 맞는 데이터 가져오기


student.M <- subset(students,genders=="M")
student.M


file <- "http://medis.hallym.ac.kr/data/airsample2.csv"       ## 외부 데이터 불러오기
as <- read.csv(file, header=TRUE)                              # header 옵션 : 첫행 변수명

as
str( as )
head(as)
tail(as)
head(as,n=10)                                     # head tail : 갯수도 지정가능한 확인
##자료를 대충 잘있나 확인할라믄 head tail 사용


as2 <- read.csv(file,
                header=TRUE,
                stringsAsFactors=FALSE)       #stringsAsFactors 옵션 char자료를 펙터로 건들 ㄴㄴ
str( as2 )
##맘대로 factor로 불러오지 못하도록 설정


as2$sensor.f <-                               # 새로운 열 만들기 방법2가지
  factor(as2$sensor)                          # 1.새로운열이름 <- / 2. transform
str( as2 )
head(as2)
as2 <- transform(as2 , sensor.f2=factor(as2$sensor))
head(as2)
## 내가 factor 열을 직접 설정 방법 1,2 2가 함수값을 사용하여 하는것 프로그래밍시 사용


summary(as2)                                 # 기술통계량


age <- sample(19:100, 160 ,replace=TRUE)     # 랜덤 샘플링 / 복원추출
str(age)
class(age)
head(age)
length(age)
## 160명의 나이 자료를 뽑았다 , 19 ~ 100 숫자중 160개 복원추출


cut(age,breaks=c(0,30,40,50,60,Inf))
table(cut(age,breaks=c(0,30,40,50,60,Inf)))         
##자료(나이)를 분류하고싶다 / 연속형자료에 구간을 주자 / cut함수!
##한쪽 무한대로 하고싶으면 INF 사용
# 명목형의 구분은 factor / 연속형의 구분은 cut

b <- sample(1:49,25)
b
sink("classB.a")                       # sort : 순서대로 나열 / sink : 자료 저장
sort(b)               
sink()
cat("Hi")
## 특정한 랜덤 값을 구하고 싶을 때 sample 함수 사용
## R에서 특정한 결과값을 저장하고자할 때 드래그해서 sink("classB.a")부터 cat의 값을 실행시키면 sink전에 있는 sink("classB.a")부터~sink()까지 값을 classB.a라는 파일명으로 저장
## 다시말해 sink함수를 저장할명으로 실행시키고 다시 sink 함수를 입력해서 함수를 종료시키고 값을 저장하는것임! cat은 저장못


cat("Hi\nHi")
paste("Hi\nHi")
## cat은 paste랑 비슷하나 \n(칸넘기는 명령어=엔터) 같이 는 읽으나 paste는 그냥 문자로 인식


str(as2)
row.names(as2)
names(as2)
head(as2)
write.csv(as2,"as2.csv")
## 저장 되긴하나 1,2,3,4같은 순서(행넘버)도 같이저장됌


write.csv(as2, "as3.csv", row.names=FALSE)
## write.csv 특정한 파일을 특정한 파일형으로 저장!
## csv형태는 "큰따옴표안이 문자 형태라는것을 뜻함 , 들어가도 구분하지 않고 문자로 인식



##################################### 3장 그래프 p50
str(VADeaths)  ##R에 내장된 데이터
VADeaths  
barplot(VADeaths,
        besid=TRUE,
        legend=TRUE,
        ylim=c(0,90),
        ylab="Deaths per 1000",
        main="Death rates in VA")
## besid:가로로나열 / legend:범례 / ylim:y축이 0~90까지 나열 / ~


dotchart(
  VADeaths,
  xlim=c(0,75),
  xlab="Deaths per 1000",
  main="Death rates in Virginia")
##점그래프는 좀더 비교용이 
# 막대그래프 : barchart(x,y) barchart(매트릭스/데이터프레임 이름)
# 점 그래프  : dotchart(x,y) dotchart(매트릭스/데이터프레임 이름)
x <- rnorm(1000)
x <- rnorm(1000)
x
hist(x)
hist(x,breaks=8)                                 # 히스토그램은 빈도수므로 하나만 보여주면됌
## 히스토그램 / breaks:면적을 세줌
#         rnorm -> 정규분포 난수 반환
#         dnorm -> 표준정규분포의 값 해당 x에서


str(cars)
head(cars,n=4)
plot(cars$speed, cars$dist)                      # plot(x,y) or plot(그래프이름)
# 산점도
# cars$speed:car데이터 안에 speed 데이터



##여태까진 고수준 그래프 +파이그래프 까지 (한번해보기) / 다음시간엔 저수준 그래프



########################################################################
########################################################################  5




### 결측치와 다른 특수한 값들

################################################### NA
x <- c(1, 4, 8, NA)
mean(x)
# x는 벡터 / 결과는 na가 나옴 (na값을 모르기때문)

mean (x,na.rm=TRUE)
# na값은 제외하고 계산해라는 함수 

is.na(x)
# x의 개별 원소들이 na 이냐(is함수) 

!is.na(x)
# 위 값에 반대 자주쓰임!

x[!is.na(x)]
# na값을 제외하고 반환해줌

sum( !is.na(x) )
# 각 벡터 값을 더하는것이 아니라 TRUE(실측값)의 갯수를 반환해줌

sum( is.na(x) )
# 결측치의 갯수

sum(x)
sum(x, na.rm=TRUE)
sum(x, na.rm=TRUE) / sum( !is.na(x))
# mean
sum( x[!is.na(x)])/sum( !is.na(x) ) 

x
is.na(x)
which(is.na(x))
# 몇번째 데이터가 결측값이냐!

# 그러면 데이터 프레임에선 어떻게?? 
y <- c(NA, 1, 4, 8)
x
y
d <- data.frame(x,y)
d
# 완성되지 않은 행을 제거해보자! ex)1,4행
d.no <- na.omit(d)
d.no
################################################### NA







### 저수준 그래픽 함수 (점)

# 한줄한줄 천천히 변화를 살펴보자

# x,y 벡터를 미리 정의해 주기!                                              # rep(1:5) 12345 / rep(1,5) : 11111
(x <- rep(1:5, each=5))
#소괄호 안에 데이터를 넣어주면 다시 x를 칠 필요없이 만들면서 데이터를 보여줌
(y <- rep(1:5, times=5))

# 고차원 그래픽 함수를 만들어서 저수준 그래픽 함수를 넣어야함

## plot으로 고차원 그래픽 함수를 미리 만들어 주기!
plot(1:5, type="n",
     xlim=c(0, 7.5),
     ylim=c(0.5, 5.5),
     xlab="",
     ylab="",
     main="points")
# 1:5는 x,y가 들어가야하나 그냥 1:5처럼 범위를 지정하여 주면 y값을 의미하는것이고 x값은 그 y에 맞춰 알아서 대응 되는값으로 정의
# type:선의 종류 / xylim:xy축의 범위, xylab:가로세로축 이름 공백을 안넣어주면 지들이 축이름을 지어냄, main:표제목
?points
?plot
x
## points 이미 만들어진 고차원 그래픽함수에 점을 찍어주자! 
points(x, y, pch=1:25, cex=1.5)
# 기준대비 크기를 1.5배로 해라 : cex / pch : 1-25 이미 정의된 심볼로 / 각기 다른 모양으로 점을 찍자라고 정의해준것!

## txet 점찍은것에 대한 설명을 텍스트로 살짝 왼쪽에 넣어주는 과정!
text(x-0.4, y,
     labels=as.character(1:25),
     cex=1.2)

# 아래 예제들이 Week 05 파일에 더 있으니 한번 해보자! 55 ~ 63

pchs <- c("&","z","z","1","가")
points(rep(7,5),5:1,pch=pchs,cex=1.5,col=1:5)
# col="red" 이런식으로 컬러 지정 가능

# points(x,y,pch= ,옵션)
# text(x,y,labels= ,옵션)
# cex , col , adj  0 / 0.5 /1 좌 우 중앙 정렬

text(1,6,labels="aaa",adj=1)

text(rep(7,5)-0.4, 5:1, 
     labels=paste("'", pchs, "'", sep=""), 
     cex=1.2)

points(rep(6, 5), 5:1, pch=65:69, cex=1.5)
text(rep(6,5)-0.4, 5:1, 
     labels=as.character(65:69), cex=1.2)




### 저수준 그래픽 함수 (선)
## abline : 처음부터 끝까지 그리는 선

head(cars)
#이미 만들어진 데이터

plot(cars,main="ablline")

# abline 수직(v) 혹은 수평(h)선을 그려보자
abline(h=20)

# lty:라인타입 2번은 점선, 1번은 생략해서 사용 가능한 실선
abline(h=30, lty=2)

# 수직선을 색깔을 줘서 넣어보기
abline(v=20, lty=3, col="blue")

# 기울기를 가진 선을 그려보기 a절편 b기울기
abline(a=40,b=4,col="red")

# 회귀모형의 기울기와 절편으로
lm(dist ~ speed, data=cars)
m <- lm(dist ~ speed, data=cars)                                      # lm (어떤 자료의 회귀모형을 구하라)
abline(m, lty=2, lwd=1.5,                                             # 두 변수에 대한 y절편과 기울기 보여줌
       col="green")                                                   # lm(y~x,data=)
abline(m$coef-0.2, lty=3, lwd=2, col="yellow")
# lwd : 라인두께
# lm : 선형모델 / 회귀 분석시 사용                                    # m$coef : m의 회귀모형
m$coef
coef(m)

## 퀴즈 : 아버지와 아들의 키
father.son=read.table("http://www.math.wustl.edu/~jmding/math3200/codes/pearson.dat")
head(father.son)                                             # 이름 <- read.table(csv)("경로",옵션)
# header=TRUE,  첫행 변수명
# stringsAsFactors=FALSE 문자형 자료를 factor로 ㄴ
names(father.son)=c("fheight","sheight")                     # 데이터프레임의 열이름 바꾸기

mean(father.son$fheight)
mean(father.son$sheight)

median(father.son$fheight)
median(father.son$sheight)

min(father.son$fheight)
max(father.son$fheight)
range(father.son$fheight)

quantile(father.son$fheight)
quantile(father.son$fheight,prob=seq(from=0,to=1,by=0.1))

var(father.son$fheight)
sd(father.son$fheight)


plot(father.son,
     xlab="Father's Height (inche)",
     ylab="Son's Height (inche)",
     main="F & S")

regfit <- lm(sheight ~ fheight,
             data=father.son)

abline(a=0,b=1,lty=2,lwd=2)
abline(regfit,lty=1,lwd=2,col="red")

# 아들대의 키의 수평선 
# 71.5~72.5인치
# 63.5~64.5인치의 수직선
# 회귀가 의미하는것은?

abline(v=71.5, lty=2,col="blue")
abline(v=72.5, lty=2,col="blue")

abline(h=73,col="red")

abline(v=63.5, lty=2,col="blue")
abline(v=64.5, lty=2,col="blue")





## line 

plot(0:6,0:6,type="n",             # plot 옵션 type="n" 산점도에서 점을 감춤
     xlim=c(0,7),
     ylim=c(0,20),
     xlab="",
     main="lines")
# 고차원그래픽함수를 미리 깔아주고

lines(c(1,3),c(20,20),lty=1)
# line[c(시작점의x좌표,종료점의x좌표), c(시작점의 y좌표,종료점의 y좌표)]

text(4,20,"1")
text(4,20,labels = "1")


#기울어진 직선
lines(c(5,6),c(20,15),lty=2,lwd=1.5,col="blue")

lty_text <- c("blank", "solid", 
              "dashed", "dotted", 
              "dotdash", "longdash", 
              "twodash")
lines(c(1,3), c(14, 14), lty=lty_text[2])
text(4, 14, lty_text[2])                                        # 벡터 + line text


## arrow() : 화살표
# 인수는 x0,y0,x1,y1의 형태
# code 화살표 방향 (1:왼쪽 화살표 / 2:오른쪽화살표 / 3:양쪽 화살표) , 앵글은화살표 각도 랭스는 각도의 길이
arrows(1,7,3,7,angle=30,length=0.25,code=2)


## box() : 그래프의 영역을 그려보자 / 
par(mar=c(2,2,2,2), oma=c(2,2,2,2))
# 마진 / 아웃터마진 / outer,inner,plot,figure 사이 거리 설정 / 순서는 아래부터 시계방향 아래/왼/위/오른
set.seed(1)
# 랜덤이지만 정해진 일정한 랜덤에 따라서 
hist(rnorm(50),axes = F,xlab = "",ylab = "",main="box")
hist(rnorm(50),axes = T,xlab = "",ylab = "",main="box")       
whichs <- c("outer","inner","plot","figure")
mycol <- c("red","black","blue","green")
box(which=whichs[1], lty = 1, lwd=1.2, col=mycol[1])
box(which=whichs[2], lty = 1, lwd=1.2, col=mycol[2])
box(which=whichs[3], lty = 1, lwd=1.2, col=mycol[3])
box(which=whichs[4], lty = 1, lwd=1.2, col=mycol[4])                 # box (which=) : outer 같은 위치 지정

?hist                     # hist : axes옵션 아래 옆 척도를 없애줌

legend(locator(1),legend=whichs,lwd=1.2,lty=1:4,col=mycol)
# legend : 범례 / locator(1) : 위치를 클릭해서 쓸수 있음




########################################################################
########################################################################  6


## 복습

# 함수를 잘 모를때 :  ?box / 'R box funtion' 구글링 / ??box : 도움말 내용중 box 검색



######## 저수준 그래픽함수 이어서

locator(2)
locator(1)
# locator() : 포인트 찍은 점의 x,y 좌표를 보여줌
# 파랑 영역 안에만 표시가능 : 다른 영역(margin)에도 표시 가능 한건 오늘 배울 함수

par(mar=c(0, 2, 2, 2))
# par : mar(마진영역) : 아래 왼 위 오른 영역의 크기 

hist(rnorm(50), axes=F, xlab="", ylab="", 
     main="box")


####   직사각형 만들기+ 테두리색 내부색     ####

rect(xleft=1, ybottom=7, xright=3, ytop=9)
rect(1, 4, 3, 6, col="gold")
# 정사각형그리기 위에 줄처럼 직접 써줘도 돼구 아래처럼 콤마로 이어서 나가도 됌

#################################
op <- par(no.readonly=TRUE)
par(mar=c(0, 2, 2, 2))
plot(1:10, type="n", main="rect", xlab="", ylab="", axes=F)
rect(xleft=1, ybottom=7, xright=3, ytop=9)
text(2, 9.5, "default")
rect(1, 4, 3, 6, col="gold")
text(2, 6.5, "col=\"gold\"")
rect(1, 1, 3, 3, border="gold")
text(2, 3.5, "border=\"gold\"")
#################################

#border : 테두리 (색)



#### 직사각형 만들기 + 내부를 사선으로 채우기 ####         # rect ( , , , ,boder= ,col= ,density= )

##################################
rect(4, 7, 6, 9, density=10)
text(5, 9.5, "density=\"10\"")
rect(4, 4, 6, 6, density=10, angle=315)
text(5, 6.5, "density=\"10\", angle=315")
rect(4, 1, 6, 3, density=25)
text(5, 3.5, "density=\"25\"")
##################################


#### 직사각형 만들기 + 테두리 컨트롤  ####

##################################
rect(7, 7, 9, 9, lwd=2)
text(8, 9.5, "lwd=2")
rect(7, 4, 9, 6, lty=2)
text(8, 6.5, "lty=2")
rect(7, 1, 9, 3, lty=2, density=10)
text(8, 3.5, "lty=2, density=\"10\"")
##################################
par(op)
# lwd:굻기 lty:종류





##################################
par(mar = c(4, 4, 4, 4), oma = c(4, 0, 0, 0))
set.seed(2)

plot(rnorm(20), type = "o", xlab = "", ylab = "")           # plot type=o : 선을 이어줌 
title(main = "Main title on line1", line = 1)
title(main = "Main title on line2", line = 2)
title(main = "Main title on line3", line = 3)
title(sub = " subtitle on line1", line = 1, outer = T)
title(sub = " subtitle on line2", line = 2, outer = T)
title(sub = " subtitle on line3", line = 3, outer = T)
title(xlab = "X lable on line1", line = 1)
title(xlab = "X lable on line2", line = 2)
title(xlab = "X lable on line3", line = 3)
title(ylab = "Y lable on line1", line = 1)
title(ylab = "Y lable on line2", line = 2)
title(ylab = "Y lable on line3", line = 3)
##################################
par(op)

# 메인타이틀 위에 보여주고 서브타이틀 아래 보여줌
# 서브타이틀 옵션 outter : T(true) 로 하면 바깥 마진으로 넘어감
# 엔터 : 문단바꿈 / 쉬프트엔터 : 줄바꿈
# xlab / ylab : x축이름 / y축이름



#### 마진 영역 출력 mtext (제목은 아니나 마진영역에 text 넣어줄수있음)  ####

par(mar = c(4, 4, 4, 4), oma = c(4, 0, 0, 0))
set.seed(5)
plot(rnorm(20), type = "o", xlab = "", ylab = "")
mtext("Position3 on line1", line = 1)
mtext("Position3 on line2", side = 3, line = 2)
mtext("Position3 on line3", side = 3, line = 3)
mtext("Outer position1 on line1", side = 1, line = 1, outer = T)
mtext("Outer position1 on line2", side = 1, line = 2, outer = T)
mtext("Outer position1 on line3", side = 1, line = 3, outer = T)
mtext("Position1 on line1", side = 1, line = 1, adj = 0)
mtext("Position1 on line2", side = 1, line = 2, adj = 0.5)
mtext("Position1 on line3", side = 1, line = 3, adj = 1)
mtext("Position2 on line1", side = 2, line = 1, adj = 0)
mtext("Position2 on line2", side = 2, line = 2, adj = 0.5)
mtext("Position2 on line3", side = 2, line = 3, adj = 1)
mtext("at 0, Posion4 on line1", side = 4, line = 1, at = 0)
mtext("at 0, adj 0, Position4 on line2", side = 4, line = 2, at = 0, adj = 0)
mtext("at 0, adj 1, Position4 on line3", side = 4, line = 3, at = 0, adj = 1)
mtext("at 0, Posion4 on line1", side = 4, line = 1, at = 1)
mtext("at 0, adj 0, Position4 on line2", side = 4, line = 2, at = 0, adj = 2)
mtext("at 0, adj 1, Position4 on line3", side = 4, line = 3, at = 0, adj = 0.5)
par(op)
# side 값이 없으면 mtext는 위로
# adj : 왼쪽 오른쪽 가운데 정렬 시키는 것/기본값은 adj 0.5 인(가운데)/ 0, 0.5 ,1 : 왼쪽,오른쪽,가운데 순서


## 범례
plot(1:10, type = "n", xlab = "", ylab = "", main = "legend")
legend("bottomright", "(x, y)", pch = 1, title = "bottomright")
legend("bottom", "(x, y)", pch = 1, title = "bottom")
legend("bottomleft", "(x, y)", pch = 1, title = "bottomleft")
legend("left", "(x, y)", pch = 1, title = "left")
legend("topleft", "(x, y)", pch = 1, title = "topleft")
legend("top", "(x, y)", pch = 1, title = "top")
legend("topright", "(x, y)", pch = 1, title = "topright")
legend("right", "(x, y)", pch = 1, title = "right")
legend("center", "(x, y)", pch = 1, title = "center")
legends <- c("Legend1", "Legend2")
legend(3, 8, legend = legends, pch = 1:2, col = 1:2)
legend(7, 8, legend = legends, pch = 1:2, col = 1:2, lty = 1:2)
legend(3, 4, legend = legends, fill = 1:2)
legend(7, 4, legend = legends, fill = 1:2, density = 30)
legend(locator(1), legend = "Locator", fill = 1)





# www.gapminder.org : 데이터의 시각화



################################################# R프로그래밍
#### for()  ####
x<- c(162,170,178,168)
for(i in x) {
  print( i )
}
# 1번째는 1번째 원소의 값 / 2번째는 2번째 원소의값 ~

x<- c(162,170,178,168)
for(i in x) {
  print( paste("현재 벡터의 값은",i,"입니다") )
}

y<-c()
x<- c(162,170,178,168)
for(i in x) {
  y <-c(y, paste("현재 벡터의 값은",i,"입니다") )
}
y


#### 내가 몇번째 반복인지 알고 싶을때  ####
# cat 하기전에 글로벌옵션 text를 ask 에서 utf-8

loop.no <- 0
for(i in x){
  loop.no <- loop.no + 1
  cat(loop.no,"번째 반복값은",i,"입니다.\n")      # 루프 반복되는 문자 이외에 문자를 +1시키면 세짐
}

loop.no <- 1
for(i in x){
  cat(loop.no,"번째 반복값은",i,"입니다.\n")
  loop.no <- loop.no + 1
}


#### 프로그래밍으로 sum 함수 만들기  ####
x
mySum <- 0
for(i in x){
  mySum <- mySum + i
}
cat("합은",mySum,"입니다")           # cat을 밖으로 빼면 반복값이 아닌 마지막 값만 출력


#### 프로그래밍 으로!(factorial) 함수 만들기  ####
factorial(8)

n <- 8
fact <- 1
for(i in n:1){
  fact <- fact * i
}
cat(n,"팩토리얼은",fact,"입니다.")    # i in 반복되는 벡터에 숫자 하나만 들어가게 해놓자
# i 가 반복되는 값이다!
# n:1 은 8,7,6,5,4,3,2,1 벡터


#### 프로그래밍으로 구구단 2단 함수 만들기  ####
2 * (1:9)

n <- 2
for(i in 1:9){
  fact <- n * i
  cat(n,"곱하기",i,"은",fact,"입니다.\n")
}

# paste 는 행번호 등 기타 요소가 포함돼이있지만 print도 해줘야됌
# cat은 아무런 덧붙임 없이 자체를 표시해준다 따라서 \n같이 띄어쓰기도 직접 입력해줘야함!

# 책에있는 for 구문 예제 해보자 p69~



###### for 의 중복 표현 #########

for(i in 1:4){
  cat(i,"\n")
}

for(i in 1:4){
  cat(i,"\n")
  for(j in 1:3) {
    cat(j,"===\n")
  }
}                                         # for 가 두개라면 밖에 1 안에 1~3 / 밖2 안1~3 안에껀 되게 자주 박복 실행되게

for(i in 1:4){
  cat(i,"\n")
  for(j in 1:3) {
    cat("i=", i , ",j=", j ,"===\n")
  }
}
# 테이블로 생각 해보자 in노트


#### for 루프로 구구단 만들어보자

for(j in 2:9){
  cat(j,"단\n")
  for(i in 1:9){
    fact <- j * i
    cat(j,"x",i,"은",fact,"입니다.\n")
  }
}                                                # for 다음 바로 for 나가지말고 cat으로 구분해줘도 됌
# cat에 바로 i,j 같은 반복 문자를 넣지말고 미리 계산돼는 문자를 지정  fact
### for 예제 : 누적분포 함수를 생각해보자

x <- c(3, 4, 6, 7)
p <- c(0.1, 0.2, 0.3, 0.4)


###
x
mySum <- 0
for(i in x){
  mySum <- mySum + i
}
cat("합은",mySum,"입니다")
###
# 이걸 이용해서

### for 예제 : but 순서가 다르다면?

x <- c(4, 3, 7, 6)
p <- c(0.1, 0.2, 0.3, 0.4)

order(x)
sort(x)
which(x)

# order : 제일작은 값은 2번째 있고 두번째 작은값은 1번째있고~
# sort : 작은값부터 순서대로 나열시켜줌

x

p[order(x)]             # 무언가를 계속 더하거나 포함하고 싶을때는 0이나 공벡터로부터 시작
d.p <- 0
for(i in 1:length(x)){
  d.p <- d.p + p[order(x)[i]]
  cat(sort(x)[i],"=",d.p,"\n")            # 다시해보자 까다롭
}

p[order(x)]
d.p <- 0
for(i in 1:length(x)){
  d.p <- d.p + p[order(x)[i]]
  cat(x[ order(x)[i] ],"=",d.p,"\n")
}
# 1내가 , 2교수님

############# for에의해 바뀌는값과 for에의해 고정되는 값을 구분할 수 있게 하자!

#### 그래프 평탄화 시키기 3 point average
plot(cars$dist, type="o")
## 한점의 값을 자기 앞뒷 값의 평균값을 갖게 하면 그래프는 위 그래프는 평탄화 그러나 처음과 마지막값은 할수 없음 

start <- 2
end <- length(cars$dist) - 1
ma.3 <- c()
for(i in start:end){
  ma.tmp <- (cars$dist[i-1] + cars$dist[i] + cars$dist[i+1]) / 3
  ma.3 <- c(ma.3 , ma.tmp)
}                                                                     # 일단 빈벡터를 만들어주고해야 안꼬임
par(mfrow=c(2,1))                                                     # 빈 벡터가 벡터안에 포함돼도됌

plot(cars$dist, type="o")
plot(ma.3, type="o")
ma.3

################## 코드개선

start <- 2
end <- length(cars$dist) - 1
ma.3 <- c()
for(i in start:end){
  ma.tmp <- mean(cars$dist[(i-1):(i+1)])
  ma.3 <- c(ma.3 , ma.tmp)
}
par(mfrow=c(2,1))


#### 피보나치 수열 반드시 / 해보기 p70


fio <- function( n=12 ){
  fi<-c()
  fi[1] <- fi[2] <- 1
  for(i in 3:n){
    fi[i]=fi[i-1]+fi[i-2]
  }
  return(fi)
}


########################### 조건함수 #############################
#### -9 는 보통 설문조사에서 대답을 안한값 NA로 바꿔보자
data <- c( 1 , 4 , 3 , 2 , -9 , 4 , 3 , -9 )
data == -9
ifelse( data == -9, NA ,data)
# ifelse (조건식, TRUE일때 값 , FLASE일때 값)
ifelse( data[i] == -9, NA ,data[i])
# 실제론 프로그래밍에선 이런식으로 인식한다!

any(data == -9)
#    any (조건식) : 어느하나라도 조건식을 만족하면 TRUE

all(data == -9)
#    all (조건식) : 모든 내용이 조건식을 만족하면 TRUE

which(data == -9)
#    which (조건식) : 데이터가 which 인 순서


####################


# 공부 다하고 요약 노트 만들자 특히 프로그래밍 부분



########################################################################
########################################################################  7


## p87 : 단을입력받아 해당하는 단을 출력

for( i in 2:9){
  mul <- 5 * i
  cat(5, "곱하기", i , "는",mul,"\n")
}
# 전시간에 해봤던것 5같은 단을 직접 입력해줘야함! / 프로그래밍이 아님

goo <- function( dan ){
  cat(dan,"을 출력합니다\n")
}
# 직접 만드는 function / 함수의 정의

goo(3)

## !!
goo <- function( dan ){
  cat(dan,"단을 출력합니다\n")
  for( i in 2:9 ){
    mul <- dan * i
    cat(dan, "곱하기", i , "는", mul , "입니다.\n")
  }
}                                                        # function 부터 for들어가기 전에 있는 cat은 첨부적인것

goo(3)
# 이함수는 반환하는 값 없이 단지 구구단의 값을 출력만 해준다! result 값이 null
result <- goo (3)

# print( paste( , , ) ) : 데이터를 문자열 데이터의 형태들을 붙여줌
# cat( , , , sep="서로 사이에 붙일값 기본은 띄어쓰기")

goo <- function( dan ){
  cat(dan,"단을 출력합니다\n",sep="")
  res <- c()
  for( i in 2:9 ){
    mul <- dan * i
    cat(dan, "곱하기", i , "는", mul , "입니다.\n")
    res <- c(res,mul)
  }
  return(res)
}

# return : 전달된 값을 반환해줌 / return에서 함수가 종료됨
goo(3)
result2 <- goo(4)
result2
# 위값과는 달리 이렇게 해서 왼쪽 에 result 는 null값 result2 는 벡터값

### ifelse(조건,T,F) : 지난시간
### p74 if / 조건문
## if(조건식){ T } else{ F }  : 조건문을 만족하면 {T} 를 수행함 만족하지못하면 {F} 수행 / 양자택일문

# 구구단에서 짝수 곱하는것만 구하자면?
goo <- function( dan ){
  cat(dan,"단을 출력합니다\n",sep="")
  res <- c()
  for( i in 2:9 ){
    if( i %% 2 == 0){
      mul <- dan * i
      cat(dan, "곱하기", i , "는", mul , "입니다.\n")
      res <- c(res,mul)
    }
  }
  return(res)
}
# == 두개 주의
goo(3)

## else 값도 추가
goo <- function( dan ){
  cat(dan,"단을 출력합니다\n",sep="")
  res <- c()
  for( i in 2:9 ){
    if( i %% 2 == 0){
      mul <- dan * i
      cat(dan, "곱하기", i , "는", mul , "입니다.\n")
      res <- c(res,mul)
    } else {
      cat ("홀수곱은 지나가유~\n")
    }
  }
  return(res)
}

goo(3)

2:n


## p76 소수값을 출력해보자 / 에라토스테네스의 체
ES <- function( n=10 ) { # n=10이라고 던져준건 ES()라고 입력하면  / 10은 기본인자
  if( n>=2 ){
    sieve <- seq(2,n)  # 2~n 까지 숫자중에
    primes <- c() # 프라임이라는 빈벡터를 만들어 놓음 소수들을 집어놓을꺼
    for ( i in seq(2,n)){ 
      if (any( sieve == i)){ # sieve안에 i값이 있으면 아래 에서 제거 안됐으면
        primes <- c(primes,i)# 2라는 값을 입력하면 2는 seq안에 포함됨 / 다음 남은 값이 3이므로 3포함 / 다음에 4는 이미 아래 과정에서x / 5입력
        sieve <- c(sieve[(sieve %% i) !=0], i) ## i 로 나눴을때 나머지가 0이아닌 값과 그 i 값으로 새롭게 sieve 벡터를 짬
      }
    }
    return( primes )  
  } else {
    stop("2보다 작은 수를 입력하셨습니다.")                     # 자기자신을 빼므로 2개의 벡터를 만들어 앞벡터에서 미리 넣어줌
  }                                                             # 각각을 검정하는것이므로 벡터를 for구문이 된 수에나누자
}                                                               # 벡터에 vector[TRUE,FLASE으로 구성된 벡터]가 들어가면 TRUE값만 보여 
# 2보다 큰애 중에 2의 배수들을 제거                             # 위 c(vector1[vector1 = ~~ ]) 이런식으로 true false 수랑 vector의 length가 같아야함
# 3보다 큰애 중에 3의 배수들을 제거
# 5보다 ~
# 7보다 ~
# stop 상황이 나오면 에러를 출력하면서 저 멘트를 보여줌

ES()
ES( 20 )
pn <- ES(50)
## return 문은 하나에 벡터로 만들어 주기때문에 하나에 대입해서 계산을 하기위해 사용
## return 과 반대 되는건 print


x <- c(2 ,4 ,1 ,NA)
mean( x )
mean( x , na.rm=T)
mean( x , na.rm=F)
# 참고 : 기본인자를 쓰는 이유? 

#p81 뉴튼의 방법을 이용한 방정식 해 찾기 / 뉴튼 메소드
f <- function(x){
  return( 2 * x^2 -1)
}
f(2)
# 미분값
fp <- function(x){
  return( 4 * x )
}
fp(2)

x.old <- 5
x.new <- NULL
eps <- 0.000001
for( i in 1:30 ){
  x.new <- x.old - ( f(x.old) / fp(x.old) )
  if(abs(x.new - x.old )< eps ){
    cat("해는", x.new, "입니다.\n")
    cat("반복수는", i ,"회 입니다.\n")
    break  #break : 자기자신의 루프를 탈출
  }
  x.old <- x.new #새로나온값을 초기값으로! 중요!!! 변수 두개만으로...    # if문뒤에 있어야 정상적 값나옴
}


1 / sqrt(2) # 이값과(해) 같아야함.

## 거쳐온 값을 할고 싶을 때
x.old <- 5
x.new <- NULL
eps <- 0.000001
tmp <- c()
for( i in 1:30 ){
  x.new <- x.old - ( f(x.old) / fp(x.old) )
  if(abs(x.new - x.old )< eps ){
    cat("해는", x.new, "입니다.\n")
    cat("반복수는", i ,"회 입니다.\n")
    break  #break : 자기자신의 루프를 탈출
  }
  tmp <- c(x.new,tmp)
  x.old <- x.new #새로나온값을 초기값으로! 중요!!! 변수 두개만으로...
}
tmp



## 거쳐온 값을 할고 싶을 때

x <- 3
typeof(x) # double 은 컴퓨터적인 저장형태 (저장방법)
class(x) # numeric 숫자 계산을 위한 형태  (R의 사용방법)
y <- 1L  # integer와 double 은 다름 /integer 끼리의 연산은 integer
typeof( y )
x <- 1


### while ()안이 참인 동안 {}무한반복 / 잘못하면 주화입마에 빠져 무한루프
while(){}
##
i <- 2
while(i < 10){
  cat(i)
  i <- i+1
}
##
i <- 2
while(i < 10){
  if( i == 5){break}
  cat(i)
  i <- i+1
}
##
i <- 2
while(i < 10){
  if( i == 5){
    i <- i + 1
    next ## next를 만나는 순간 아래 코드를 패스 하고 다음 loop 실행
  }
  cat(i)
  i <- i+1
}


# 진입조건 루프 : while,for
# 탈출조건 루프 : repeat 유일

# 함수   - function   / 구구단,에라토스테네스 체,뉴튼메소드
# 반복문 - for while
# 조건문 - if

## 알아두면 좋을 10가지! / 이걸 알았으면 좀더 빨리 풀었을텐데... 코드 빵꾸 채우기 + o,x




######################################################################################### 8강

# 1번
# 첫줄은 변수명 hear = T
# 문자열은 그대로 stringsAsFactors = F
# 첫번째 몇줄을 패스할때 skip=5

# 2번
na.omit(data)

# 3번
levels=c("Mon",,,, order=T)

# 4,5번
# while(0) 아니오 실행 ㄴ

# 6번
x <- seq(-3,3,by=0.01)
z <- dnorm(x)
dof <- C(2,6,16,30)
par(oma=c(0,0,2,0))
plot(x.z typer="l")
col <- c("yellow","green","red","blue")
for(i in 1:length(dof)){
  tmp <- dt(x,df=dof[i])
  lines(x,tmp,col=dof[i])
}
mtext("t-distribution",outer=T)




#####진도
## p91

a <- 3
f <- function(x){
  cat(x+a)
}
f(3)

f2 <- function(x){
  k <- x + a
  cat(k)
}
f2(5)
cat(k)

# k는 함수f2 안에 있는 수이므로 실제로 존재하지 않는 값
# return 함수를 쓰면 지역에서 생산한 데이터를 전역으로 돌려주는 역할도 수행

# 지역에서 a를 불렀을때 없으면 전역에서 a를 찾음
# 전역과 지역의 개념 p91

# 전단인자 (여기서는 x) 를 지역내에서 지정해주면 함수 출력

## 따라서 프로그래밍은 메모리상의 데이터 관리 
# 스코프!! (유효범위)


f <- function(){
  x <- 1
  cat(x,"\n")
  g()
  return(x)
}

g <- function() {
  x<-2
  cat(x,"\n")
}

f()

# x는 두번 쓰이지만 서로 있는 영역, 지역이 다름

# p91 먼저들어간 녀석이 나중에 나옴 / Last In First Out


# p91 a와 b 사람의 자리 바꾸기 무언가 대가,또다른 변수,의자를 지불해야함 
a <- 3
b <- 2
cat(a, ":" ,b)

temp <- a
a <- b
b <- temp
cat(a, ":" ,b)


# 함수로 만들어보자
a
b
swap <- function(a,b){
  cat(a,":",b,"\n")
  temp <- a
  a <- b
  b <- temp
  cat(a,":",b,"\n")
}
swap(a,b)

cat(a, ":",b,"\n")
# 다시 cat 을 해도 값은 바뀌지는 않음 function 지역안에 있는 값을 출력한것이므로 전역에 잇는 ab에 영향 ㄴ

# 값에 의한 전달 : swap(a,b)는 사실 swap(3,2)를 입력해준거임 



f <- function(){
  x <- g(2) + 3
  cat(x,"\n")
}


g <- function( x ){
  cat(x,"\n")
  return(x + 2)
}

f()
# 함수는 return 을 만났을때 값을 남기나 return이 없으면 cat만 출력
# g가 f에 영향을 줄려면 return 함수 필수


x <- 3
ff <- function( i ){
  x <- i + x
  cat(x)
}
ff(2)
x
# 지역에서는 전역의 값을 통산적으로 바꾸지못하나, 굳이 바꿔야 한다면 <<- 사용

ff <- function( i ){
  x <<- i + x
  cat(x)
}
ff(2)
x


# swap 함수로 전역에서 값을 바꿔자???
a <- 3
b <- 2
swap <- function(a,b){
  temp <- a
  a <<- b
  b <<- temp
}
swap(a,b)
cat(a, ":",b,"\n")


# p94 직접 프로그래밍 도출하기

#(2, 1, 4, 3, 0) 를 프로그래밍으로 정렬해보자 
# 제일작은녀석을 왼쪽 그다음을 그 오른쪽 ~~~
# 2 1 4 3 0
# 1 2 4 3 0
# 1 2 3 4 0
# 1 2 3 0 4
x <- c(2, 1, 4, 3, 0)
x[1] > x[2]
x[2] > x[3]
x[3] > x[4]
x[4] > x[5]
x[5] > x[6] 안됌!# 
  # 반복횟수를 먼저 정해보자
  for(i in 1:(length(x)-1)){
    cat( x[i] > x[i+1], "\n")
  }
# 다시 정리해서
for(i in 1:(length(x)-1) ){
  if( x[i] > x[i+1]){
    temp <- x[i]
    x[i] <- x[i+1]
    x[i+1] <- temp
  }
}
x

# 약간 이상함 / 큰녀석을 뒤로 두자 / 그렇게하고 for를 두번 해줘야 완벽하게 순서 정렬가능 / "더블sort" !!!!!

mysort <- function( x ) {
  for( last in length(x):2){
    for( first in 1:(last-1)){         # -1을 시켜주면 마지막 녀석은 어차피 첫번째 반복때 제일 작은것이 뒤로갔으므로 건들 ㄴ
      if(x[first] > x[first+1]){
        save <- x[first]
        x[first] <- x[first+1]
        x[first+1] <- save
      }
    }
  }
  return(x)
}
mysort(x)

mysort(3)
# 다만 벡터를 넣어야만 돼므로 스칼라를 일때 에러 메세지를 출력하게 해보자 / stop 이 아닌 false도 사용가능
mysort <- function( x ) {
  if(length(x) < 2){
    cat("scalar!")
    return(FALSE)
  }
  for( last in length(x):2){
    for( first in 1:(last-1)){
      if(x[first] > x[first+1]){
        save <- x[first]
        x[first] <- x[first+1]
        x[first+1] <- save
      }
    }
  }
  return(x)
}

mysort(3)


# 문자열도 에러 메세지 출력 시키기
mysort <- function( x ) {
  if(length(x) < 2){
    cat("scalar!")
    return(FALSE)
  }
  if(is.character(x)){
    cat("character!")
    return(FALSE)
  }
  for( last in length(x):2){
    for( first in 1:(last-1)){
      if(x[first] > x[first+1]){
        save <- x[first]
        x[first] <- x[first+1]
        x[first+1] <- save
      }
    }
  }
  return(x)
}

mysort(c("hi","bby"))



## 서로 다른 자료형 묶어 주기 list! / 여러개의 정보를 줄 수 있음(여기선 return 값을 list로 결합)
# error code : 정수
# MSG : 문자
# 1.scalar
# 2.character

mysort <- function( x ) {
  if(length(x) < 2){
    return(list(Status=FALSE,ErrCode=1,MSG="Scalar!"))
  }
  if(is.character(x)){
    return(list(Status=FALSE,ErrCode=2,MSG="Character!"))
  }
  for( last in length(x):2){
    for( first in 1:(last-1)){
      if(x[first] > x[first+1]){
        save <- x[first]
        x[first] <- x[first+1]
        x[first+1] <- save
      }
    }
  }
  return(x)
}


mysort(c("hi","bby"))


############################################################################ 9강


# 저번시간은 오름차순에 대해서 해봤음 / 내림차순에 관해서 해보자!

### sum() 함수를 만들어보자 by for 구문
x <- c(2,5,1,7)
sum(x) 

mySum <- function( x ){               # 반드시 x 로
  cum.sum <- 0                        # 덧셈의 항등원
  for(i in 1:length(x)){              # 1:length(x) 를 x로 표현 가능
    cum.sum <- cum.sum + x[i]         # 위 대로 해놓으면 x[i]를 i로 표현
  }
  return( cum.sum)
}

mySum(x)
SS <- mySum( x )

# return 을 통해서 변수값 지정가능 여기선 SS에 15란 값을 지정함

# 곱셈도 동일
mygob <- function( x ){
  cum.gob <- 1
  for(i in 1:length(x)){
    cum.gob <- cum.gob * x[i]
  }
  return(cum.gob)
}

mygob(x)


### 재귀호출
# for를 제거 하고 저 함수를 만들수 있는가?! (재귀호출 : 자기자신을 똑같이 부르는 것 / Recursive)
# 노트에 그림으로 필기해놓음 꼭 참조

csum <- function( x ){
  cs <- 0
  if(length(x) > 1){
    cs <- csum( x[1:(length(x)-1)]) + x[length(x)]  # 자기자신을 호출함 / # 메모리 스텍에서 위에 쌓임 처음 csum은 대기를 하고 두번째 csum 실행
  } else {
    return(x)
  }
  return(cs)
}
x <- c(5,4,1,2)
csum( x )

# 과정을 보여줘~
csum <- function( x ){
  cs <- 0
  if(length(x) > 1){
    cat(x," :, ")    # 중간값이 어떻게 나오는지 알기위해 삽입
    cs <- csum( x[1:(length(x)-1)]) + x[length(x)]  # 자기자신을 호출함 / # 메모리 스텍에서 위에 쌓임 처음 csum은 대기를 하고 두번째 csum 실행
  } else {
    cat(x," ;;; ")    # 중간값이 어떻게 나오는지 알기위해 삽입
    return(x)
  }
  cat( cs ,"\n")
  return(cs)
}

x <- c(5,4,1,2)
csum( x )

# return 을 만나면 stop 처럼 함수가 끝




######## merge sort
# 응용 : p98 하향식 설계 (Merge sort) : double sort 와 비교하여 속도는 빠르나 별도의 공간이 필요함 
# 분할 : 벡터를 반으로 나눈다./ 나누어진 벡터를 또 다시 반으로 나누는 과정을 반복하여 원소의 개수가 1이 될 때까지 나눈다.
# 병합 : 나누어진 벡터들을 정렬하면서 합친다./ 두 벡터의 첫번째 값을 비교하여 결과 벡터의 맨 뒤에 넣는다./ 나머지 값들을 결과 벡터의 넣는다.

# 380214
#  380  214
# 3 80  2 14
# 3 8 0 2 1 4
# 3 08  2 14 (1차 병합후) + 정렬을 동시에
# 038 124    (2차 병합후) + 정렬을 동시에
# 두 집단의 첫자리 끼리 작은수를 새로운 벡터에 순서대로 나열 (0,1 비교 / 3,1 비교 / 3,2 비교 ~)

# Step1 : 일단 함수 모형을 만들어 주기
mergesort <- function(x){
  return(result)
}

# Step2 : x를 반으로 나눈다
mergesort <- function(x){
  len <- length(x)
  half <- len %/% 2
  x1 <- x[1:half]
  x2 <- x[(half+1):len]
  # 발생할수있는 문제점은? : len이 1이 될때
  return(result)
}

# Step3 : if문을 써서 발생할 수 있는 문제점을 제거
mergesort <- function(x){
  len <- length(x)
  if( len < 2){
    result <- x
  } else {
    half <- len %/% 2
    x1 <- x[1:half]
    x2 <- x[(half+1):len]
  }
  return(result)
}

# Step4 : 더 나누기!
mergesort <- function(x){
  len <- length(x)
  if( len < 2){
    result <- x
  } else {
    half <- len %/% 2
    x1 <- x[1:half]
    x2 <- x[(half+1):len]
    x1 <- mergesort(x1)
    x2 <- mergesort(x2)   # 자기자신을 되 불러서 더 나눌 수 있음
  }
  return(result)
}

# Step5 : 순서를 바꿔주는 코드 작성
mergesort <- function(x){
  len <- length(x)
  if( len < 2){
    result <- x
  } else {
    half <- len %/% 2
    x1 <- x[1:half]
    x2 <- x[(half+1):len]
    x1 <- mergesort(x1)
    x2 <- mergesort(x2)   # 자기자신을 되 불러서 더 나눌 수 있음
  }
  return(result)
}

+
  
  x2 <- mergesort(x2)
result <- c()
# 양쪽의 벡터 중 하나라도 있으면
while(min(length(x1),length(x2)) > 0){
  # 두 벡터의 첫번째 원소 중 작은 것을 result 로
  if(x1[1] < x2[1]){
    result <- c(result,x1[1])
    # 결과 벡터에 넣고 해당 원소는 원래 벡터에서
    x1 <- x1[-1]
  } else {
    result <- c(result, x2[1])
    x2 <- x2[-1]
  }
}



# Step6 : 하나의 집합의 값이 다떨어지고 나머지 집합이 남았을경우 바로 붙이기

+
  
  if(length(x1) > 0 ){
    result <- c(result, x1)
  } else {
    result <- c(result,x2)
  }
# 강의 노트에 올라온것보고 만들어보자


############ debug
# 중간과정 상세히 알수있음
# 중간에 엔터누르면서 진행하다가 궁금한 변수를 len x1 같이 쳐서 확인 가능
# 왼쪽 아래에 쌓인값 확인가능
# Q 엔터로 디버그창 끝냄
debug(mergesort)
mergesort(x)




################################################################################### 10강



############################### today: 범주형자료 요약
######################### TABLE 관련 함수들

# 가상의 자료 만들기
treat <- c(
  rep("yes",90),
  rep("no",100)
)

str(treat)
factor(treat)
factor(treat,ordered=TRUE)
treat <- factor(treat,
                levels=c("yes","no"),
                ordered=TRUE)

disease <- c(
  rep("occur",10),
  rep("none",80),
  rep("occur",40),
  rep("none",60)
)

disease <- factor(disease,
                  levels=c("occur","none"),
                  ordered=TRUE)
str(disease)
# 두개의 벡터를 만들었음 순서를 고려해서 생각해보자

df <- data.frame(
  treat,
  disease
)

head(df)

## 몇개의 treat인지 알고싶을때!
# 단순방법
length( treat[treat=="yes"] )
# table로 보는법
table(treat)

## 표로 만들어보고 싶음! (단순 빈도만)
t1 <- table(df$treat,df$disease)
t1
#행을먼저쓰고, 그다음열

## 자세히 비율을 보고싶음
prop.table(t1)
# 전체대비 해당셀의 비율

prop.table(t1,margin=1)
# margin을 1로 두면 행별로 비율을 보여줌
prop.table(t1,margin=2)
# margin을 2로 두면 열별로 비율을 보여줌

margin.table( t1 )
# 전체 갯수를 보임
t1 / margin.table( t1 )
# prop.table(t1) 과 같은결과
margin.table(t1, margin=1)
# 각행의 합계를 보임
margin.table(t1, margin=2)
# 각열의 합계를 보임

# barplor 열로 스텍을 쌓음
barplot( c(1,1,2) )
barplot( t1 )
barplot(t(t1))
# transfors 함수로 행열 변환(전치) 가능
# 세개의 그래프 비교해보자

addmargins(t1)


##### 자료의 관리 / 재배치
WorldPhones
# 실험단위(사람)(연도+대륙) / 관찰단위(키,몸무게)(전화기댓수)
# 관찰단위를 행으로 / SAS에서 데이터셋 에서 했던것처럼
colnames(WorldPhones)
# R패키지 활용을 해보자
.libPaths()                                     # 설치경로보기
installed.packages()                            # 설치된 패키지보기
install.packages(                               # 패키지 다운로드하기
  c("reshape2","plyr")
)
update.packages("reshap2")                      # 패키지 업데이트하기
remove.packages("reshap2")                      # 패키지 제거하기
?melt                                           # 아직은 설치x

library(reshape2)                               # 다운받은거 설치하기
?melt                                           # 설치O

str(WorldPhones)
# 구조를 보니 데이터프레임이 아니다. / 행이름이 붙은 매트릭스이긴함
as.data.frame(WorldPhones)
# 데이트프레임화 시키자
row.names(WorldPhones)
year <- row.names(WorldPhones)
WP <- data.frame(
  year,
  as.data.frame(WorldPhones)
)
WP
str(WP)
m.WP <- melt(WP,
             id="year")
#year는 행으로서 존재하고 나머지를 짜게보자
str(m.WP)
head(m.WP)

# 참고 옵션
m.WP <- melt(WP,
             id="year",
             variable.name="Cnt",
             value.name="np")

# wide format 을 long format으로 바꾼것
# 이러한 형태로 데이터를 변경하면 중간에 update / insert 시키기 쉽다

m.i[m.i$Species == "setosa"
    & m.i$variable == "Petal.Length"]

## 실습
head(iris)
str(iris)
row.names(iris)

m.i <- melt(iris,
            id="Species")
m.i

head(iris[,-5])
head(m.i)



####################### 기존의 자료에 특정한 함수 적용으로 자료 요약 
####### 행열(1,2) 별로의 함수 값을 보여줌
mean(
  iris[iris$Species == "setosa",1]
)

i.s <- 
  iris[iris$Species == "setosa",-5]

i.s1 <- apply(i.s, 1, mean)
# i.s의 행들의 평균을 산출

str(i.s1)
length(i.s1)
i.s2 <- apply(i.s, 2, mean)
# i.s의 열들의 평균을 산출
str(i.s2)
head(i.s1)
i.s2

t1
margin.table(t1,margin=1)
apply(t1,1,sum)

# Sp별로(당연히 범주형 자료가 들어갈 자리) S.L의 평균 값을 보여줌
tapply(iris$Sepal.Length,
       iris$Species,
       mean)

## dcast : long format 을 Wide format으로
# melt 시키기 전 포맷으로 바꿔보자 약간 바꿔서(Species는 행을 유지 한채로)
d.i <-dcast(m.i,
            Species ~ variable,
            mean, na.rm=T)
# na.rm 옵션 안넣어두 넣어도 작동
# index 변수가 없기에 mean(집계함수) 또한 원래는 없어도 돼는데 이 경우엔 넣어줘야댐
d.i

# 환자 회차 측정  값
# 1    1    bp    120
# 1    1    pulse 156
# 1    2    bp    125
# 1    2    pulse 158
# 1    3    bp    123
# 1    3    pulse 159

# 환자 ~ 측정 + 회차  / bp_1 , pulse_1 이런식으로

d.WP <- dcast(m.WP,
              year~variable)
d.WP
# 집계함수가 없어도 합쳐지는 사례

# 집계함수 있어도 되는것과 없어도 돼는것 생각해보자


## 이부분은 시험x (독립성vs동일성)
# 독립성검정
ct <- chisq.test(
  df$treat,
  df$disease
)
# 동일성





########################################################################  11강


## project
# 일단 프로젝트를 만들고 주어진 엑셀 데이터 입력
# 이때 측정단위는 bp0 , pulse0 , ~ / 관찰단위는 p1, p2, p3
# 자료를 수정 가공 분석엔 long format / 요약해서 보여줄땐 wide format
# 측정단위가 행으로 가는 것이 long format
# 관찰단위가 행이면지금 이 데이터는 wide format
# 만든 엑셀 데이터를 같은 R project 안에 csv파일로 저장

bp <- read.csv(
  "bp.csv",
  header=T,
  na.strings = "NA"
)
# NA라고 써져있는 값은 NA로 저장하자
bp
str(bp)

# reshapes 패키지를 가져와 wide 를 long 으로 바꿔보자
install.packages("reshape2")
library(reshape2)
m.bp <- melt(
  bp,
  id = "name"
)
m.bp

# 이렇게 만든 데이터는 원자적이지 않으므로 variable 열을 두개로 나눠주자(조사명+회차)
# bp0   pulse0
# 123   123456

library(stringr)
# 문자열중에서 일부를 가져오자 substr 의 강화판
# str_sub(대상문자열,2,3) : 대상문자열의2~3 자리 문자만 가져오자
# str_sub(대상문자열,-2,-1) : 뒤에 첫번째 것부터 두번째 것을 가져오자
# str_sub(대상문자열,2) : 두번째부터 끝까지 
# str_sub(대상문자열,-1) : 마지막 문자부터 끝까지(마지막 문자만) 가져오자
m.bp$variable
followup <- str_sub(m.bp$variable,-1)
type <- str_sub(m.bp$variable,1,-2) 

m.bp <- data.frame(m.bp,followup,type)
m.dp

# m.bp : Long -> Wide 해보자
# 1. 환자별로 정리
d.bp <- dcast(m.bp,
              name ~ type+followup)
d.bp

# d.dp : Wide -> Long 으로 바꿔 보자
# 새로운 열을 추가 시켜주고 롱으로 바꿔보자
treat <- c("no","yes","yes")
d.bp <- data.frame(d.bp,treat)
d.bp

mbp <- melt(d.bp,
            id="name")   # 에러남

# treat는 관찰대상이 아니라 속성이므로 name과 같이 id로 만들어줌
mbp <- melt(d.bp,
            id=c("name","treat"))
mbp

# 2. 처리군/대조군 별로 정리 하고픔
dcast(mbp , treat ~ variable)  #에러!
# 집계함수를 넣어줘야 지!
dcast(mbp,treat ~ variable,mean,na.rm=T)
# na.rm을 na값이 있으니깐 넣어주고

# 이 방법이 복잡하므로 더 간단한방법은 ? 
### plyr
install.packages("plyr")
library(plyr)

iris
ddply(iris , .(Species) , nrow)
# ddply : 데이터프레임 형태를 받아서 데이터 프레임형태로 저장
# 아이리스를 species 별로 나눠 nrow 함수 적용 시켜보자

ddply(iris , .(Species) , mean) # 에러!
# mean(iris) : 가 에러나는 것과 같은이치 mean 함수는 벡터만 받을수있음

summarise(iris,meanSL=mean(Sepal.Length))
ddply(iris, .(Species), summarise, 
      meanSL=mean(Sepal.Length),
      meanSW=mean(Sepal.Width),
      meanPL=mean(Pepal.Length)
)
# 이건 너무 단수 노가다이다! 다른 방법

### colwise(mean, is.numeric)(iris)  : 여기까지 함수명 생성 즉 colwise(~)(iris):mean(iris)
# 데이터프레임 형태 에서 사용
# is.numeric : 상수 연산이 가능 하면!
colwise(mean, is.numeric)(iris)

ddply( iris, .(Species) , colwise(mean,is.numeric) )
# 왜 여기서 끝나나면 아까도 mean쓰고 괄호는 안써줬자나
# ddply 에서 사용자 지정 함수도 사용 가능

### 더 개선된버전
install.packages(c("dplyr","ggplot2"))
library(dplyr)
library(ggplot2)

head(diamonds)

# tbl_df : 테이블을 보기 좋게 만들어줌
diaDF <- tbl_df(diamonds)
diaDF

# filter(df,행선택조건) : 데이터프레임내 특정행 선택 해줌

filter(diaDF,cut=="Premium" , color=="E")
filter(diaDF,cut=="Premium" | color=="E")

# select(df,열선택조건) : 데이터프레임내 특정열 선택 해줌
select(diaDF, cut , color)

names(diaDF) # 여기서 나오는 값은 숫자 역할 도 함
select(diaDF,price:z)
select(diaDF,8:10)
select(diaDF,c(carat,price,x))

# arrange(df,열) : 데이터 정렬 (오름차순,내림차순)
arrange(diaDF, price)
arrange(diaDF, desc(price))

# mutate(df,계산식) : 기존열로 계산된 새로운 열 보여줌
mutate(diaDF,d=x+y+z)
# 새로운 열은 만드는것이 아니라 결과만 반환해주는것

# summarise() : 기본 summarise 함수와 스펠링이 같기 때문에 dplyr:: 로 dplyr내 함수이라알려줌
dplyr::summarise(diaDF,
                 xMean=mean(x),
                 yMean=mean(y) )

# group_by() : 그룹별 데이터 
df <- group_by(diaDF,cut)
str( df )
head(df)
# 외부로 볼땐 똑같으나 cut 값 별로 그룹화댐

attr(df,"labels")
# attr : group_by 로 나눠진 값을 보여줌
dplyr::summarise(df,N=n(),meanPrice=mean(price) )

# chain %>%
tmp <- filter(diaDF, carat>1 , carat<1.5 )    # 캐럿의 조건을 주고
tmp <- group_by(tmp,color)                    # 색별로 나누고
tmp <- summarise(tmp, m.price = mean(price))  # 원하는 값을 뽑아내서
result <- arrange(tmp, m.price)               # 정렬 시켜보자
result


# 과제 : 서울특변시 대기환경정보 (cleanair.seoul.go.kr)
# 정보마당 -> 통합대기환경지수  : 계산식 제공
# 기후대기통계 -> 대기환경 : 데이터 제공 / -> 기간별 -> 기간별 -> 엑셀다운로드 




##############################################################################    12강


###################### 과제 풀

sa <- read.csv(
  "air.csv",
  skip=6,
  header=FALSE
)

# 변수가 8개인지 알아보기 위해 str
str(sa)

# 열이름을 바꿔주기
names(sa)
names(sa) <- c("date", "obs.p", "pm10", "pm25", "o3", "no2", "co", "so2")
names(sa)

head(sa)

# 패키지 설치
install.packages(c("reshape2",
                   "dplyr",
                   "ggplot2"))

library(reshape2)
library(dplyr)
library(ggplot2)

# 날짜 열을 data형태로 바꾸기
dt <- as.Date("2015-11-25")
str(dt)

sa$date <- as.Date(sa$date)

# dt의 포맷을 월단위로 바꾸자!
format(dt,"%m")

sa <- transform(
  sa,
  month = format(date,"%m")
)

# wide 를 long 포맷으로
m.sa <- melt(sa,
             id=c("date","month","obs.p")
)

# 보기편한 tbl_df로 한번바꿔줄수도 있음
sa.df <- tbl_df(m.sa)
sa.df

## 간단한 기술통계(자료요약 보기)
# summary : 간단한 기술 통계량을 보여줌 (저번시간 colwise 랑 비슷) / 자료의 문자가 들어있는지도 확인가능하다
summary(sa)

# 범주형 자료 형태로 보기 : table (자료의 갯수 볼 수 있음)
table(sa$obs.p)

# !(~ == ~)
# ~ != ~

## 행제거 방법 3가지
sa.df[ sa.df$obs.p != "평균", ]
subset(sa.df , obs.p != "평균" )
filter(sa.df , obs.p != "평균" )

tmp <- filter(sa.df , obs.p != "평균" )

# 줄어든걸 확인 할 수 있음 (열갯수보기:nrow)
nrow(sa.df)
nrow(tmp)

# month와 오염물질별로 그룹화!
tmp <- group_by(tmp, month, variable)

# 그룹화 시킨별로 결과 보이기! 
tmp <- summarise(tmp,m.value=mean(value,
                                  na.rm=T))

tmp

# 정렬을 월별로 한뒤
result <- arrange(tmp,month) 

# 다시 wide format 으로 (행~열,)
d.sa <- dcast(result , month ~ variable, value.var="m.value")

d.sa

# 데이터 가져 올 때 이러이러한 문자열들을 na로 취급
na.strings = c("NA","조사할때 모르던값들","~~")




####################### 오늘꺼시작
# http://rpubs.com/yoonani/ggplot2 : 

# R에서 선그래프를 그리기위해선 산점도에 type 을 넣어줘야댐
BOD
plot(BOD)
plot(BOD,type="l")

# barplot은 매트릭스여야 작동 dataframe이 아니라
barplot(BOD)
str(BOD)
barplot(as.matrix(BOD))

# 열이 두개니깐 두개가 나오고 각 값이 적층 : 이런걸 원한게 아니야 행열을 뒤바꿔보자

barplot(t(as.matrix(BOD)))

# time은 우리가 그래프에 필요없는 자료자나!
barplot(BOD$demand)

## grammar of graphics : ggplot2 패키지활용 효과적인 그래프를 위해선
# 
ggplot() +
  layer(data = iris,
        mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species),
        geom = 'point',
        stat = 'identity',
        position = 'identity')
# data     : ~ 데이터에서
# mapping  : 좌표를 원하는데 찍는 도구 / x= ,y= , colour = ~ / ~ 별로 색깔을 다르게 해줘라(+그룹화)
# geom     : 그래프종류!
# stat     : 변환하지말고 있는그대로 (생략가능)
# position : 변환하지말고 있는그대로 (생략가능)




################## 너무 복잡해, ggplot2 패키지이용
#### ggplot() + Layer + Scale + Coordinate System + (Facet) + (Guide)

#### Layer 파트
### point
library(ggplot2)
gp <- ggplot(data=iris,
             aes(x=Sepal.Length,
                 y=Sepal.Width,
                 colour = Species))
gp
# 레이어가 없대, 레이어만 붙여주자

gp <- ggplot(data=iris,
             aes(x=Sepal.Length,
                 y=Sepal.Width,
                 colour = Species)
)+ geom_point()
gp
# ggplot안에 넣어주니 아까랑똑같은 값 나옴
summary(gp)
# gp 그래프의 정보를 보여줌

## 옵션도 넣어보자
gp <- ggplot(data=iris,
             aes(x=Sepal.Length,
                 y=Sepal.Width,
                 colour = Species)
) + geom_point() + geom_smooth(method='lm')

gp
# geom_smooth(method='lm') : 선형회귀모형도 보여주돼 (95퍼 신뢰구간) 쫙쫙펴서 직선으로!

# geom 시리즈 일람
apropos("geom_")

# 옵션(parameter) 알고 싶을때
?geom_ponint




## 단순 산점도 약점 : 한 포인트에 몇개가 중첩돼있는지 모름
ggplot(data = mpg, aes(displ, hwy)) +
  geom_point()

## 찍히는 점마다 약간 위치를 바꿔주자 (겹쳐있는걸 알수있다!)
ggplot(data = mpg, aes(displ, hwy)) +
  geom_point(position = "jitter")

## 
ggplot(data = mpg, aes(displ, hwy)) +
  geom_point(position = "jitter") +
  geom_smooth()




###  bar
ggplot(mtcars,
       aes(factor(cyl), fill = factor(vs))) +
  geom_bar(position="stack")

# position="stack" 위로 데이터를 쌓겠다
# position="fill"  백분위(비율)로 꽉채워서 보임
# position="dodge" 약간 피해서 따로 따로 보여줌

# 포지션 건 바깥에 fill은 채울 색상 : factor별로 다르게 색상을 채운다!







# position 시리즈 일람 여기선 dodge
apropos("position_")

str(sleep)
# group 을 그룹별로 나눈것

ggplot(sleep, aes(x=ID, y=extra, group=group)) + 
  geom_line() + 
  geom_point(size=4, fill='white', shape=21)

# 5쯤에서 겹쳐서 알아보기가 힘들어!


# 살짝 그래프를 피하게 하자!
dodge = position_dodge(0.3)

ggplot(sleep, aes(x=ID, y=extra, group=group)) + 
  geom_line(position = dodge) + 
  geom_point(position = dodge, size=4, fill='white', shape=21)


## scale : x축 y축과 관련돼있는거

ggplot(data = mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth()

# x를 4~6까지 스케일해서 x가 4~6인 부분만 보여
ggplot(data = mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth() +
  scale_x_continuous(limits=c(4,6))




####### dia bar 그래프
dia_bar <- ggplot(diamonds,
                  aes(x=cut,fill=cut)) + geom_bar()
dia_bar

# 그래프를 xy축을 바꾸기
dia_bar + coord_flip()

# 극 좌표 형태로 바꾸기
dia_bar + coord_polar()



####### Facet

# 연비와 차량의 관계
mtc_point <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
mtc_point

# 색별로 더 확실히 구분하자
mtc_point <- ggplot(mtcars, aes(mpg, wt,colour=cyl)) + geom_point()
mtc_point

# 그래를 아예 나눠서 구하기
mtc_point <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
f <- mtc_point + facet_wrap(~cyl)

summary(f)


## Layer, position , scale , coord~


################################################################################ 13강 




# 패키지 설치
install.packages(c("reshape2",
                   "plyr",
                   "dplyr",
                   "ggplot2",
                   "maptools",
                   "rgeos",
                   "rgdal"))

library(reshape2)
library(plyr)
library(dplyr)
library(ggplot2)
library(maptools)
library(rgeos)
library(rgdal)

SName <- c("Kim","Kang","Ko","Kwon","Kwak")
SID <- 116:120
Student <- data.frame(SName,SID)

gradeA <- c("a","a","b","a")
subjA <- data.frame(
  SID=c(116,117,119,122),gradeA)

gradeB <- c("a","c","a","d")
subjB <- data.frame(
  SID=c(116,117,118,120),
  gradeB)

Student
subjA
subjB


### join (left,right / inner,full)
plyr::join(Student,subjA,by="SID",type="left")  # 왼쪽 기준으로 (여기선 Student 연결)
join(Student,subjA,type="right")           # by 값을 넣어주지 않으면 지들끼리 파악해서 함
join(Student,subjA,type="inner")           # 양쪽에 있는것 들 끼리만 연결 
join(Student,subjA,type="full")            # 존재하는 모든 것을 연결

join(subjA,subjB,type="inner")
join(subjA,subjB,type="full")

### dplyr : *_join()  / 더 빠르대
left_join(Student, subjB, by="SID",by=c("SID" = "SNO"))
right_join(Student, subjB, by="SID")
inner_join(Student, subjB, by="SID")
full_join(Student, subjB, by="SID")


##### 서울시대기환경점보
getwd() # 어디서 작업하는지보기 여기다가 파일을 넣어주면 읽어드림


## pm10의 구별 평균
sa <- read.csv("sa.csv",
               header=F,
               skip=6,
               stringsAsFactors = F,
               strip.white = T) # 눈에 안띄는 엔터제거

names(sa) <- c("date","obs.p","pm10","pm25","o3","no2","co","so2")
names(sa)
str(sa)

sa$date <- as.Date(sa$date)      # chr을 date 형식으로
sa <- subset(sa,obs.p!="평균")
sa$obs.p <- factor(sa$obs.p)     # chr 을 평균제거후 factor 형식으로
str(sa)

m.sa <- melt(sa, id=c("date","obs.p"))
str(m.sa)
sa.df <- dplyr::tbl_df(m.sa)

tmp <- dplyr::filter(sa.df, variable=="pm10")
tmp <- group_by(tmp,obs.p)
head(tmp)
result <- dplyr::summarise(tmp,
                           m.value=mean(value,na.rm=T))

## A %>% B 체인연산자 : 앞에껄 뒤에 함수와 연결 /  똑같은걸 새로운방식으로 한거임
# 반복해서 tmp를 써줄 필요없음
# A %>% B() = B(A)
result <- sa.df %>% filter(variable=="pm10") %>% group_by(obs.p) %>% dplyr::summarise(
  m.value=mean(value, na.rm=T))

result


## 지리정보파일얻기 www.diva-gis.org/gdata   
KOR_adm2.shp

shp2 <- readShapePoly(
  "./KOR_adm/KOR_adm2.shp"
)

# 일단 불러오기!
slotNames(shp2)

str(shp2@data)
# 점으로찍어주기
plot(shp2)

## 데이터 프레임으로 바꾸기
shp2_df <- fortify(shp2)
head(shp2_df)
# 시,군,구를 기준으로 데이터프레임으로 바꾸기
shp2_df2 <- fortify(shp2,region = "NAME_2")
head(shp2_df2)

# .shp -> readShapepoly -> S4객체 -> fortify -> 데이터프레임  (여태까지한것)

ggplot(shp2_df2,aes(x=long,y=lat,group=group)) + geom_path()   # 선으로만 구분
ggplot(shp2_df2,aes(x=long,y=lat,group=group)) + geom_polygon(aes(fill=id))   # 색으로 구분

## 서울만 빼어오기
shp2_se <- shp2[shp2$NAME_1 == "Seoul",]      # 서울만빼서
se_df <- fortify(shp2_se, region="NAME_2")    # 데이터프레임화시키기
str(se_df)

ggplot(se_df,
       aes(x=long,y=lat,
           group=group)) + geom_path()

# result랑 se_df랑 조인시켜서 연결시켜주기! 연결고리를 찾아보자


levels(se_df$group)
as.integer(se_df$group)
# 숫자로 되어있네?

levels(result$obs.p)
result$distID <- plyr::mapvalues( result$obs.p,
                                  from = c("도봉구","동대문구","동작구","은평구",
                                           "강동구","강북구","강남구","강서구",
                                           "금천구","구로구","관악구","광진구",
                                           "종로구","중구","중랑구","마포구",
                                           "노원구","서초구","서대문구","성북구",
                                           "성동구","송파구","양천구","영등포구",
                                           "용산구"),to=as.factor(1:25))
se_df <- transform(se_df,
                   distID=factor(
                     as.integer(se_df$group)))

se_re <- join(se_df,result,by="distID",type="left")

se_re

ggplot(se_re,aes(x=long,y=lat,group=group)) + geom_polygon(aes(fill=m.value))

# sgis.kostat.go.kr 회원가입하기
# 과제 cleanair 에서 또...



###########################################################################   14강


# project 만들어 new 폴더로 3개의 폴더 만들

# data   : 사용할 데이터
# R      : 작성한 R 코드
# output : 만든 이미지등 저장

# option - general - text encoding


install.packages(c("reshape2","plyr","dplyr"))

library(reshape2)
library(plyr)
library(dplyr)

sa <- read.csv("./data/sa.csv",
               header=F,
               skip=6,
               stringsAsFactors = F,
               strip.white = T) 

str(sa)
head(sa)
summary(sa)
# 자료를 불러드린후 잘 불러왔는지 위 세 명령어로 확인

names(sa)
names(sa) <- c("date","obs.p","pm10","pm25","o3","no2","co","so2")

str(sa)

sa$date <- as.Date(sa$date)    
# 운좋게 date의 표준 형식으로 date 행이 되어있음 
# 안돼어 있으면 paste("v",1:31,sep="-") 이처럼

sa <- subset(sa,obs.p!="평균")

sa <- transform(sa,
                month=format(sa$date,"%m"))

sa$obs.p <- factor(sa$obs.p)     # 
str(sa)

m.sa <- melt(sa, id=c("date","month","obs.p"))
str(m.sa)
head(m.sa)
?melt           # 어느 패키지인지 알고 싶을 때

sa.df <- tbl_df(m.sa)
#date.frame( sa.df )

result <- sa.df %>% filter(variable=="pm10") %>% group_by(obs.p) %>% dplyr::summarise(m.value=mean(value, na.rm=T))
# dplyr 의 summarise 를 쓰기 위해서 dplyr:: 까지 써주는게 안정

tmp <- dplyr::filter(sa.df, variable=="pm10")
tmp <- group_by(tmp,obs.p)
head(tmp)
result <- dplyr::summarise(tmp,
                           m.value=mean(value,na.rm=T))

# http://sgis.kostat.go.kr
# shp포맷 제공 / 3개의 파일이 한 세트 / .shp : 실제지도파일 / ,shx : 목차 / .dbf : 추가정보


install.packages(c("maptools","rgeos","rgdal","ggplot2"))
install.packages("foreign")
library(maptools)
library(rgeos)
library(rgdal)
library(ggplot2)
library(foreign)

dbf2 <- read.dbf("./data/2013/2013/2013_level2/temp.dbf")

str(dbf2)
dbf2 <- transform(dbf2,
                  codeInt=as.integer(
                    as.character(code)
                  ))


se_dbf2 <- dbf2[dbf2$codeInt <= 11250, ]
se_dbf2

shp2 <- readShapePoly("./data/2013/2013/2013_level2/temp.shp")
head( shp2$code )
shp2_se <- shp2[shp2$code %in% se_dbf2$code, ]
# shp2$code 가 sh_dbf2$code 안에 있으면 참
head( shp2_se@data )
se_df_tmp <- fortify(shp2_se,region="name")
head( se_df_tmp )

result

se_df_4 <- inner_join(x=se_df_tmp,
                      y=result,
                      by=c("id"="obs.p"))
head(se_df_4)

ggplot(se_df_4,
       aes(x=long, y=lat, group=group)) + geom_polygon(aes(fill=m.value),col="gray") 


### 웹에서 데이터 바로 불러들이기
# data.seoul.go.kr
# 실시간 자치구별 대기환경 정보 - open API - 
# Key         :
# Type        : json
# Service     :
# Start index : 1
# End index   : 25

url <- 'http://openAPI.seoul.go.kr:8088'
key <- '6666517958736a74353753786c587a'
type <- 'json'
service <- 'ListAirQualityByDistrictService'
Start <- '1'
end <- '26'

install.packages(c("jsonlite","stringr","curl"))
library(jsonlite)
library(stringr)
library(curl)

query <- paste(url,key,type,service,Start,end,sep="/")
cat(query)
tr1 <- jsonlite::fromJSON(query)
res <- tr1$ListAirQualityByDistrictService$row
# 파일$서비스명$row
str(res)

res$NITROGEN  <- as.numeric(
  gsub("점검중",NA,res$NITROGEN)
)
# 뒤 항목중에 점검중이란 문자열이 나오면 NA로 바꿔라
res$OZONE <- as.numeric(
  gsub("점검중",NA,res$OZONE)
)
res$CARBON <- as.numeric(
  gsub("점검중",NA,res$CARBON)
)
res$SULFUROUS <- as.numeric(
  gsub("점검중",NA,res$SULFUROUS)
)
res$PM10 <- as.numeric(
  gsub("점검중",NA,res$PM10)
)
res$PM25 <- as.numeric(
  gsub("점검중",NA,res$PM25)
)

str(res)

head(se_df_tmp)

se_df_5 <- inner_join(
  x=se_df_tmp,
  y=res,
  by=c("id"="MSRSTENAME"))

ggplot(se_df_5,
       aes(x=long, y=lat, group=group)) + geom_polygon(aes(fill=PM10),col="gray") 


# 시험 다음주 4시 
# 문제 통으로 1개 , 풀어나가는 과정 잘 기술
# 시험제출에 소스 데이터 파일 둘다 존재
# 어디까지 잘돼고 안돼느냐



