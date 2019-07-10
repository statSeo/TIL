
# 서비스 예시용 코드 --------------------------------------------------------------
#install.packages('dplyr') #패키지 설치
library(dplyr) # 패키지 불러오기

# 브랜드 순으로 정렬 --------------------------------------------------------------
product_session_master_custom %>%
  filter(CLAC3_NM == '여성트렌치코트') %>%
  count(PD_BRA_NM) %>%
  arrange(desc(n)) -> brand_order


# 옵션 : 색상 순으로 정렬 ---------------------------------------------------------------
product_session_master_custom %>%
  filter(CLAC3_NM == '여성트렌치코트') %>%
  count(PD_ADD_NM) %>%
  arrange(desc(n))


# 기기 유형별으로 인원수 세기 ----------------------------------------------------------
product_session_master_custom %>%
  filter(CLAC3_NM == '여성트렌치코트') %>%
  count(DVC_CTG_NM)


# SNS 데이터 그래프 그리기 ---------------------------------------------------------
twitter_trench$Date[1:183]
twitter <- twitter_trench[1:183,-1]
colnames(facebook_trench) <- c("Date","Frequency")
twitter$Date <- as.Date(twitter$Date)
facebook_trench$Date <- as.Date(facebook_trench$Date)
sns_data <- left_join(twitter,facebook_trench, by = "Date")
colnames(sns_data) <- c("Date", "Twitter", "Facebook")
sns_data[is.na(sns_data)] <- 0


plot_ly(x = sns_data$Date, mode = "lines") %>%
  add_trace(y = sns_data$Twitter, name = "Twitter") %>%
  add_trace(y = sns_data$Facebook, name = "Facebook", color = I('blue')) %>%
  add_trace(y = cafe_trench$Cafe, name = "Cafe") %>%
  layout(title = "SNS Search Trend")