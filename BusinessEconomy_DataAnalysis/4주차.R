
## 101. 텍스트 분석 paste / strsplit, scan /  table  /  sort    / plot .pdf
#                 합하기/     분리하기   /단어수세기/정렬하기/워드클라우드
# -> 단어를 카운트해서 그림그리기

# Basic R : 띄어쓰기 구분(or 음절단위)으로 쪼갬
# KoNLP : 사전에 따라 단어단위로 쪼갬

letters[1:26]
tolower("Strategy Management")
toupper("strategy in action")
nchar('Korea')
nchar('Korea ')
length('Korea')

bts <- c("RM, 진, 슈가, 제이홉, 지민, 뷔, 정국")
length(bts)
nchar(bts)

bts <- c("RM", "진", "슈가", "제이홉", "지민", "뷔", "정국")
length(bts)
nchar(bts)

# 벡터는 숫자도 문자열로 인식
ve <- c(1:6,'a', 'b')
ve

# 리스트는 개별로 인식, 심지어 매트릭스도 포함가능
li <- list(1:6,'a', 'b')
li[[1]]
li[[1]][1:2]

l <- "my list"
i <- 1:4
s <- matrix(1:10, nrow=5)
t <- c("one", "two")
list <- list(l, i, s, t)
list
list[[3]][1,2]


### unlist() : List -> Vector 변환
li <- list(1:6,'a', 'b')
li
unlist(li) # 다 문자열이 되버림

### do.call() : 데이터 프라임 결합 / 같은 리스트내 종류끼리 함수실행하기? / or   문자살리기?
x <- list(data.frame(name="foo", value=1),
          data.frame(name="bar", value=2) )
x

unlist(x)         #(X) : name,즉 문자가 사라져버림
do.call(rbind, x) #(O)

# 만약 리스트가 아니고 각 벡터였다면 이런식으로?
x <- data.frame(name="foo", value=1)
y <- data.frame(name="bar", value=2)
rbind(x,y)

### paste() : 붙이
paste("Liability", "Capital", sep=" ") #default

# 벡터값을 하나, 그 이상 이어 붙일 수 있다.
bts <- c("RM", "진", "슈가", "제이홉", "지민", "뷔", "정국")
bts
paste(bts, sep = " ")
paste(bts, collapse=" ") # 결과값이 두개 이상일 때, 각각을 이어붙일 때
cena <- c(1:7)
paste(cena,bts,sep = ".",collapse=" -> ")
?paste

### strsplit() : 분리하기 / 리스트형식으로
x <- "data sensing"
strsplit(x, " ")

swot <- "강점(Strength), 약점(Weakness), 기회(Opportunity), 위기(Threat)의 앞글자를 따서 SWOT분석이라 부른다.기업의 강점과 약점, 환경적 기회와 위기를 열거하여 효과적인 기업 경영전략을 수립하기 위한 분석방법이다. 간단하지만 분석에 빈틈이 없어, 학생들의 프리젠테이션에서부터 경영학 관련 서적에 이르기까지 자주 볼 수 있다. 사실 형식 자체는 간단하지만 빈틈없이 제대로 하려면 엄청난 시간과 노력을 필요로 한다. 현황을 정확히 진단해야 하는 작업이기 때문에 오만가지 자료들을 추려내서 분석한 뒤에 결론을 도출해내야 하기 때문.
 SWOT는 강점(Strength), 약점(Weakness), 기회(Opportunity), 위협(Threat)의 머리글자를 모아 만든 단어로 경영 전략을 수립하기 위한 분석 도구이다. 내적인 면을 분석하는 강점/약점 분석과, 외적 환경을 분석하는 기회/위협 분석으로 나누기도 하며 긍정적인 면을 보는 강점과 기회 그리고 그 반대로 위험을 불러오는 약점, 위협을 저울질하는 도구이다. 보통 X,Y축으로 2차원의 사분면을 그리고 각각 하나의 사분면에 하나씩 배치하여 연관된 사항들을 우선 순위로 지배한다."
swot_para <- strsplit(swot, split='\n') # 문단 단위로 분리
swot_sent <- strsplit(swot_para[[1]], split='\\.')
strsplit(swot_sent[[1]], split=' ') # 스페이스 공란 단위로 분리
strsplit(swot_sent[[2]], split=' ') # 스페이스 공란 단위로 분리


### cat(): 파일로 만들기+따로저장하기 / scan() : 단위로 불러들이기

cat("내 피 땀 눈물 내 마지막 춤을 다 숨을 다 가져가", file="c:/data/bts_tear_01.csv")
bts_tear_01 <- read.csv("c:/data/bts_tear_01.csv")
scan("c:/data/bts_tear_01.csv", what="character", comment.char = "")

##
sc <- c("主孰有道주숙유도", "將孰有能장숙유능", "天地孰得천지숙득", "法令孰行법  령숙행","兵衆孰强병중숙강", "士卒孰鍊사졸숙련", "賞罰孰明상벌숙명")
sc
sc_split <- strsplit(sc, "")
sc_split #합하지 않고 쪼깻을때 문제
table(sc_split)

##
sc <- c("主孰有道주숙유도", "將孰有能장숙유능", "天地孰得천지숙득", "法令孰行법령숙행","兵衆孰强병중숙강", "士卒孰鍊사졸숙련", "賞罰孰明상벌숙명")
sc
sc_paste <- paste(sc, collapse=" ")
sc_paste
sc_split <- strsplit(sc_paste, "")
sc_split
table(sc_split) #붙이고 합하니 가능

#<참고> library(stringr)의 str_count()
tear_01 <- "내 피 땀 눈물 내 마지막 춤을 다 가져가"
library(stringr)
str_count(tear_01, "내") 
# 결과 : [1] 2


### sort() : 내림,오름차순 정리
tear_01 <- "내 피 땀 눈물 내 마지막 춤을 다 가져가"
tear_split <- strsplit(tear_01, " ")
bts_tear_tb <- table(tear_split)
tear <- sort(bts_tear_tb, decreasing = TRUE)

### barplot() : 빈도분석 by 막대그래프
barplot(tear)
barplot(tear, horiz = TRUE, las=2, cex.names = 0.5)
?barplot #las:x축범례회전


### wordcloud
install.packages("wordcloud")
library(wordcloud)
wordcloud(words = names(tear), freq=tear, min.freq= 1, random.order=F)


#============================================================================
# 102. 텍스트 분석 substr gsub grep match.pdf

# -> 원하는 단어를 뽑아내서 매칭시켜 카운트 (by 사전)

# example
# 경영자 전략 성향분류 : 매니저형 경영자등 
# 정치성향분류 : 진보 , 보수
# 정부정책: positive , negative 단어 빈도수 분석

# 단어빈도분석 -> 시간별로 어떤 변화가 있는지 시계열분석?

### substr() : 텍스트 일부 추출
args(substr)
mission <- "기업으로서 어떻게 존재하야 하는가?"
substr(mission, start=7, nchar(mission))

day <- "2018-09-01"
substr(day, 1, 7)
dau.start.payment$use_month <- substr(dau.start.payment$use_date, 1, 7)
dau.start.payment$start_month <- substr(dau.start.payment$start_date, 1, 7)
head(dau.start.payment)


### gsub() : 텍스트를 교
# sub()는 최초로 등장한 표현만 교체 / gsub()는 모두를 교체시킴

mission <- "기업으로서 어떻게 존재하야 하는가?"
gsub('어떻게', '어떤 가치를 가지고' ,mission)


### grep() & grepl() : 벡터원소들 中 문자 위치한 객체 정보 / 순서 & 논리
bts <- c("RM", "진", "슈가", "제이홉", "지민", "뷔", "정국")
grep("정국", bts)
grepl("정국", bts)
which(bts=="정국") # 이 논리연산자가 맞는 위치는?

swot <- c('strong+A' , 'strong+B', 'Weak-A', 'Weak-B', 'oppor+A')
grep("strong", swot)
grepl("strong", swot)
which(swot=="strong") #포함하는 문자는 못 표현해줌

which(c(1:7)==7)




### regexpr(), gregexpr(), regexec() : 하나의 원소,문자열 中
sr <- "Strategic R is so strategic planning"

regexpr('ic',sr) # 첫 번째 표현 한 번만
# 해당표현이 등장하는 문자열 위치
# 원하는 패턴의 총 문자 수
# 원하는 패턴의 모드
# 보고된 결과가 바이트 수로 표현되었는지 여부

gregexpr('ic',sr) # 전체에서 표현 여러번 가능

regexec("so (strategic) ", sr) # 전체에서 여러표현 검색




### str_extract(), str_extract_all()
install.packages("stringr")
library(stringr)
# str_extract()함수는 지정된 표현이 처음으로 등장할 경우 표현을 찾아주고,
# str_extract_all()함수는 지정된 표현이 등장한 모든 표현을 찾아 출력해준다.

sc <- c("主孰有道주숙유도", "將孰有能장숙유능", "天地孰得천지숙득", "法令孰行법령숙행","兵衆孰强병중숙강", "士卒孰鍊사졸숙련", "賞罰孰明상벌숙명")
sc
str_extract(sc, "有" ) # 각각의 문장에 대해 첫 번째 "有" 출력
str_extract_all(sc, "有" ) # 각각의 문장에 대해 모든 "有" 리스트로 출력




### 2.7 :  중요 !!!
### match : 텍스트 매칭 / 이 단어가 사전에 몇 번째 존재하는가?
doc <- c("a1" ,"b2" ,"c1" ,"d2")
dic <- c("g1" ,"x2" ,"d2" ,"e2" ,"f1" ,"a1" ,"c2" ,"b2" ,"a2")
match(doc, dic)
# match(단어, 사전)


# 위치 찾고 직접표현까지
doc <- c("a1" ,"b2" ,"c1" ,"d2")
dic <- c("g1" ,"x2" ,"d2" ,"e2" ,"f1" ,"a1" ,"c2" ,"b2" ,"a2")
is_match <- match(doc, dic)
is_match
length(is_match)
sum(is.na(is_match))
sum(!is.na(is_match))
ol <- which(!is.na(is_match)) # na가 아닌 값이 있는 위치는?
ol
doc[ol] # # na가 아닌 값이 있는 위치에 있는 텍스터는?
