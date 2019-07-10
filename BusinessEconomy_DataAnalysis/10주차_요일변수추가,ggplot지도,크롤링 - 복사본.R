
# front-end : HTML CSS javascript
# back-end : php sever

## 09.5 날짜에 요일변수 추가하기.pdf (시험무조건)
# ex. 월요일중 가장 많은단어, 가장 높은 값 
# weekdays()
my_date_list <- as.Date(c('2014-07-30', '2014-08-01', '2014-08-02'))
weekdays(my_date_list)

# 가나다순이 아닌 월~토순서를 지정하기위해 factor로 지정
day_levels <- c("일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일")
factor(weekdays((my_date_list)), levels=day_levels, ordered=TRUE)

# 요일대신 숫자 출력
as.numeric(factor(weekdays((my_date_list)), levels=day_levels, ordered=TRUE) - 1)
           
# 실전 (시험과 직결)
samsung <- read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경영경제데이터분석 소프트웨어/01~. R 관련/samsung_20181015")
samsung
str(samsung)

samsung$date <- as.Date(samsung$date, "%Y-%m-%d")
samsung$day <- weekdays(samsung$date)
head(samsung)
str(samsung)

#================================================
## 11. 지도정보 표현하기.pdf
library(maps)
library(ggplot2)

# map_data()
world_map <- map_data("world")
head(world_map$region)
head(sort(unique(world_map$region)), 20)
sk <- world_map[world_map$region == "South Korea", ]
sk$subregion

# 세계지도
world <- map_data("world")
ggplot(world, aes(x=long, y=lat, group=group)) + geom_path() # 진하게
ggplot(world, aes(long, lat)) + borders() #연하게
# geom_polygon() : 채움 색깔을 fill 변수를 설정함으로써 정할수 있다.
# colour="black", size=0.1 : 경계선의 색과 굵기를 지정한다
# theme(legend.position = "none"): 색깔 구분에 따른 범례를 없앤다
ggplot(world, aes(x=long, y=lat, group=group, fill=region)) +
 geom_polygon(colour="black", size=0.1) +
 theme(legend.position = "none")

# 동아시아1
east_asia <- map_data("world", region=c("North Korea", "South Korea", "China", "Japan"))
ggplot(east_asia, aes(x=long, y=lat, group=group)) + geom_path()
ggplot(east_asia, aes(x=long, y=lat, group=group, fill=region))+
  geom_polygon(colour="black", size=0.1)

# 동아시아2
world <- map_data("world")
ggplot(east_asia, aes(long, lat)) +
  borders("world", c("North Korea", "South Korea", "China", "Japan"))

# 한국
korea <- map_data("world", region=c("North Korea", "South Korea"))
ggplot(korea, aes(long, lat)) + borders("world", c("North Korea", "South Korea")) # 방법1
ggplot(korea, aes(x=long, y=lat, group=group)) + geom_path() # 방법2
ggplot(korea, aes(x=long, y=lat, group=group, fill=region))+
  geom_polygon(colour="black", size=0.1)+theme(legend.position = "none")

# 지도에 데이터 넣기
world <- map_data("world")
korea_data <- world.cities[world.cities$country.etc == "Korea South", ]
ggplot(korea_data, aes(long, lat)) +
  coord_map()+ # 가로세로비율 유지하며 투영
  borders("world", "South Korea", fill="white") +
  geom_point(aes(size = pop), colour="blue", alpha=0.8)

# 지도와 여러개 데이터 결합하기. (1개변수)
# 1단계
states_map <- map_data("state")
ggplot(states_map, aes(x=long, y=lat, group=group))+geom_path()
# 2단계 (방법1 : geom_map )
state <- tolower(rownames(USArrests))
crimes <- data.frame(state, USArrests)
head(crimes); head(states_map)
ggplot(crimes) +
  # geom_map : 주석 역할 /
  # ggplot()의 data에 map_id : 그룹 / fill : 필 // map=data.frame : 열이름이 다음과 같은 값을 포함 하고 있어야. x or long / y or lat / region or id
  geom_map(aes(map_id=state, fill=Murder), map=states_map)+
  # expand_limits : 축의 값이나 범례값의 범위 혹은 특정값을 설정함. 굳이 states_map이 아닌 범위를 따로 지정해줘도 됨.
  expand_limits(x=states_map$long, y=states_map$lat)+
  coord_map()
# 2단계 (방법2 : merge후 geom_ploygon)
crime_map <- data.frame(region = tolower(rownames(USArrests)), USArrests) %>%
  merge(states_map, by = "region")

ggplot(crime_map,aes(long, lat, group = group, fill = Murder)) + 
  geom_polygon() +
  coord_map("polyconic") +
  scale_fill_continuous(low = "pink", high = "black")

# 지도와 여러개 데이터 결합하기. (4개변수)
head(crimes)
library(reshape2)
crimesm <- melt(crimes, id.vars = "state")
head(crimesm)
ggplot(crimesm) +
  geom_map(aes(map_id=state, fill=value), map=states_map, colour='grey50', size=0.1)+
  expand_limits(x=states_map$long, y=states_map$lat)+
  scale_fill_gradientn(colours=c("white", "green", "blue", "red"))+  # 연속형 항목 n개의 색으로 scale
  facet_wrap( ~ variable)+ coord_map() # 명목변수 기준으로 그래프 나누기

#================================================
## 30. HTML.hwp
#크롬화면에서 F12누른뒤 왼쪽위 화살표로 화면 갔다대면 언어나옴
# 실제로 html에서 경로만 지정하고 자바스크립트로만 쓰여져있는 경우가 있으므로 자바스크립트를 알아야.
# 알스튜디오 스크립트 우측하단에서 다른 언어로 쓸 수 있음. -> preview로 미리보기기 / 물론 메모장에서도 .html로 저장하면 에디터로 활용가능

# 10주차_HTML : 실습

#================================================
## 30. CSS.hwp
# CSS로 특정 스타일을 지정하고 HTML 콘텐츠에 적용시키는 방식.

# html에 css 연결하는 3가지 방식
# css가 특정 element를 선택하는 4가지 방식.

# html - (head,body) - div - section - (h1,p)

#================================================
## 30. Javascript.hwp
#10주차_HTMtoJS
#10주차_fromJS

#================================================
## 30. Crawling.pdf
#test03.html 파일을 알스튜디오로 열자. 이런구조구나~
library(rvest)
url<-"C:/Users/Jiwan/NaverCloud/2018 수업자료/경영경제데이터분석 소프트웨어/20. 데이터 수집 관련/test03.html"

# 태그요소 사용한 크롤링 
rhu <-read_html(url)
rhu

head<-html_nodes(rhu, "head")
head
head_text<-html_text(head)
head_text

title<-html_nodes(rhu, "title")
title
title_text<-html_text(title)
title_text

body<-html_nodes(rhu, "body")
body
body_text<-html_text(body)
body_text

table<-html_nodes(rhu, "table")
table
table_text<-html_text(table)
table_text

article<-html_nodes(rhu, "article")
article
article_text<-html_text(article)
article_text

# 선택자 중 클래스를 사용한 크롤링
rhu <-read_html(url)
rhu
class <-html_nodes(rhu, ".text1")
class
class_text<-html_text(class)
class_text

# 선택자 중 아이디를 사용한 크롤링
rhu <-read_html(url)
rhu
id <-html_nodes(rhu, "#logo")
id
id_text<-html_text(id)
id_text

