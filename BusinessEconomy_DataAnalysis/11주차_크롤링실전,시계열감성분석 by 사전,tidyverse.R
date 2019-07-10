## 31. 네이버 카페 요일별 검색.pdf 
# 여기서 제목 태그는 dt < dl < li < div 범위를 좁힐수록 우리가 찾고싶은애들
# 여기서 내용 태그는 dd < dl < li < div 범위를 좁힐수록 우리가 찾고싶은애들
library(rvest)
url<-"https://section.cafe.naver.com/CombinationSearch.nhn?query=%EC%9B%94%EC%9A%94%EC%9D%BC&where="
rhu <-read_html(url)
rhu

#방법1. tag selector
tag <-html_nodes(rhu, "dd")
tag
tag_text<-html_text(tag)
tag_text

#방법2. class selector
class <-html_nodes(rhu, ".txt_block")
class
class_text <- html_text(class)
class_text

#방법3. id selector
#content_srch_wrap
id <- html_nodes(rhu, "#content_srch_wrap")
id
id_text<-html_text(id)
id_text


## 32. 네이버 영화평점 크롤링.pdf
library(rvest)
url<- "https://movie.naver.com/movie/point/af/list.nhn?&page=1"
text <- read_html(url, encoding="CP949")
# 제목 추출하기
nodes <- html_nodes(text, ".movie")
title <- html_text(nodes)
title
# 영화평점 추출하기
nodes <- html_nodes(text, ".point")
point <- html_text(nodes)
point
# 영화리뷰 추출하기
nodes <- html_nodes(text, ".title")
review <- html_text(nodes, trim=T)
review

review <- gsub("\t", " ", review)
review <- gsub("\r\n", " ", review)
review <- gsub("신고", " ", review)
page <- cbind(title, point)
page
page <- cbind(page, review)
page
# 이를 100페이지 반복하는 loof문. 강의록에 


## 108. tidy approach for 한글
sonja <- c("손자가 말했다.", " 전쟁은 국가의 큰 일이다.",
           " 전쟁터는 병사의 생사가 달려있는 곳이며",
           "나라의 존재와 멸망이 달려있는 길이므로",
           " 세심히 관찰해야 한다.")
class(sonja) # 시험문제!
length(sonja)
sonja[1:3]
library(tidyverse)

#data_frame() : tibble형식의 데이터프레임 만들기
sonja_df <- data_frame(line = 1:5, text = sonja)
sonja_df

#unnest_tokens() : 스페이스 기준 단어분리 
#         :단어의 순서를 보존할수 있다는 장점(시계열)
library(tidytext)
sonja_df %>% unnest_tokens(word, text)
sonja_df %>% unnest_tokens(bigram, text, token= "ngrams", n=2)
sonja_df %>% unnest_tokens(trigram, text, token= "ngrams", n=3)

# 취임연설문 예제
moon01 <- readLines("C:/Users/Jiwan/NaverCloud/2018 수업자료/경영경제데이터분석 소프트웨어/01~. R 관련/Text 분석/moon01.txt")
length(moon01)
moon01

library(dplyr)
moon01_df <- data_frame(line = 1:64, text = moon01)
moon01_df

library(tidytext)
moon01_df %>%
  unnest_tokens(word, text)
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(line, sort = TRUE) # 각문장당 몇개의 어절로 있는지 구분.
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) # 해당하는 어절이 몇개 나와 있는지 구분.
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  filter(n > 3)
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  filter(n > 3) %>%
  ggplot(aes(word, n)) +
  geom_col()
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  filter(n > 3) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  coord_flip()
moon01_df %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  mutate(word = reorder(word, n)) %>% 
  #reorder : word를 n의 통계량(기본값 : 평균)의 수준에따라 펙터화.
  filter(n > 3) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  coord_flip()

## 109. tidy approach for english.pdf
# 예제: 제인오스틴 작품 분석.
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidytext)
library(ggplot2)

austen_books() %>%
  distinct(book)
austen_books() %>%
  distinct(book)
stop_words # 불용어사전 

austen_books() %>%
  unnest_tokens(word, text)
austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)
## anti_join / semi_join 시험!
# X에 대하여 Y가 영향을 주는 방식
austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(word, sort=TRUE) # 불용어 제거
austen_books() %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(word, sort=TRUE)%>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

## 110. 사전사용하여 시계열감성분석.pdf
library(janeaustenr)
library(tidyverse)
library(stringr)
library(ggplot2)
library(tidytext)
data(package='tidytext')
sentiments
get_sentiments("bing") # 2분류
get_sentiments("nrc") # 4분류
get_sentiments("afinn") # 점수구분

austen_books() %>%
  group_by(book)
austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() )
austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() )%>%
  unnest_tokens(word, text)
austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() ) %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing"))
# count에 여러 변수를 넣어주면 모두 겹치는 것을 하나로 센다. / 즉 넣은 변수와 n으로 데이터프레임을 만든다.
austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() ) %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(book, line = linenumber , sentiment)
austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() ) %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(book, line = linenumber , sentiment) %>%
  spread(sentiment, n, fill = 0) # fill => NA를 무엇으로 처리 할지.

austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number() ) %>%
  unnest_tokens(word, text) %>%
  inner_join(get_sentiments("bing")) %>%
  count(book, line = linenumber , sentiment) %>%
  spread(sentiment, n, fill = 0) -> books
books

# 책 중에서 Sense & Sensibility 골라내기
ss <- books %>% filter(book =="Sense & Sensibility")
ss
# 그림그리기
ggplot(ss, aes(line, positive)) + geom_col(show.legend = FALSE) # 긍정어 감정분석
ggplot(ss, aes(line, negative)) + geom_col(show.legend = FALSE) # 부정어 감정분석
