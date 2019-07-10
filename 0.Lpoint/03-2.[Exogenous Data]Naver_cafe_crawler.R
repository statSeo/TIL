# library(stringr)
# library(rvest)
# library(RSelenium)

#urlSearch <- "https://section.cafe.naver.com/cafe-home/search/articles?query=스마트바겐%20가디건#%7B%22query%22%3A%22스마트바겐%20가디건%22%2C%22page%22%3A1%2C%22sortBy%22%3A0%2C%22period%22%3A%5B%222018.04.01%22%2C%222018.09.30%22%5D%2C%22menuType%22%3A%5B0%5D%2C%22searchBy%22%3A0%2C%22duplicate%22%3Afalse%2C%22includeAll%22%3A%22%22%2C%22exclude%22%3A%22%22%2C%22include%22%3A%22%22%2C%22exact%22%3A%22%22%2C%22filterMode%22%3Atrue%7D"
#urlSearch <- "https://section.cafe.naver.com/cafe-home/search/articles?query=딜공%20가디건#%7B%22query%22%3A%22딜공%20가디건%22%2C%22page%22%3A25%2C%22sortBy%22%3A0%2C%22period%22%3A%5B%222018.04.01%22%2C%222018.09.30%22%5D%2C%22menuType%22%3A%5B0%5D%2C%22searchBy%22%3A0%2C%22duplicate%22%3Afalse%2C%22includeAll%22%3A%22%22%2C%22exclude%22%3A%22%22%2C%22include%22%3A%22%22%2C%22exact%22%3A%22%22%2C%22filterMode%22%3Atrue%7D"
urlSearch <- "https://section.cafe.naver.com/cafe-home/search/articles?query=딜공%20원피스#%7B%22query%22%3A%22딜공%20원피스%22%2C%22page%22%3A1%2C%22sortBy%22%3A0%2C%22period%22%3A%5B%222018.04.01%22%2C%222018.09.30%22%5D%2C%22menuType%22%3A%5B0%5D%2C%22searchBy%22%3A0%2C%22duplicate%22%3Afalse%2C%22includeAll%22%3A%22%22%2C%22exclude%22%3A%22%22%2C%22include%22%3A%22%22%2C%22exact%22%3A%22%22%2C%22filterMode%22%3Atrue%7D"


stringProcess <- function(cafeSearchData){
  cafeSearchData <- gsub("\\\n","",cafeSearchData) 
  cafeSearchData <- gsub("\\\t","",cafeSearchData) 
  cafeSearchData <- substring(cafeSearchData,0,(nchar(cafeSearchData)-1))
  cafeSearchData <- gsub("\\.","-",cafeSearchData) 
  cafeSearchData[grep("시간",cafeSearchData)] <- "2019-01-04"
  cafeSearchData <- as.Date(cafeSearchData)
  return(cafeSearchData)
}

ch=wdman::chrome(port=4567L) #크롬드라이버를 포트 4567번에 배정
remDr=remoteDriver(port=4567L, browserName='chrome') #remort설정

remDr$open() #크롬 Open
remDr$navigate(urlSearch) #설정 URL로 이동

frontPage <- remDr$getPageSource() #페이지 전체 소스 가져오기
cafeSearchData <- read_html(frontPage[[1]]) %>% html_nodes('.tit_sub.txt_block') %>%  html_text() %>% trimws()
cafeResult <- stringProcess(cafeSearchData)

flag <- TRUE
checkNum <- 7

for (i in 2:11) {
  if(i==8){
    while (flag) {
      webElem <- remDr$findElements(using = 'xpath',value = paste0('//*[@id="content_srch"]/div[3]/div[2]/button[',i,']')) #버튼 element 찾기
      remDr$mouseMoveToLocation(webElement = webElem[[1]]) #해당 버튼으로 포인터 이동
      remDr$click() #버튼 클릭
      Sys.sleep(0.5) #잠시 동작 멈춤
      
      frontPage <- remDr$getPageSource() #페이지 전체 소스 가져오기
      cafeSearchData <- read_html(frontPage[[1]]) %>% html_nodes('.tit_sub.txt_block') %>%  html_text() %>% trimws()
      cafeSearchData <- stringProcess(cafeSearchData)
      cafeResult <- append(cafeResult, cafeSearchData)
      
      pageNum <- read_html(frontPage[[1]]) %>% html_nodes(xpath='//*[@id="content_srch"]/div[3]/div[2]/button[8]') %>%  html_text() %>% as.numeric()
      if(is.na(pageNum)){
        flag <- FALSE
      }
      checkNum <- pageNum
    }
  }else{
    webElem <- remDr$findElements(using = 'xpath',value = paste0('//*[@id="content_srch"]/div[3]/div[2]/button[',i,']')) #버튼 element 찾기
    remDr$mouseMoveToLocation(webElement = webElem[[1]]) #해당 버튼으로 포인터 이동
    remDr$click() #버튼 클릭
    Sys.sleep(0.5) #잠시 동작 멈춤
    
    frontPage <- remDr$getPageSource() #페이지 전체 소스 가져오기
    cafeSearchData <- read_html(frontPage[[1]]) %>% html_nodes('.tit_sub.txt_block') %>%  html_text() %>% trimws()
    cafeSearchData <- stringProcess(cafeSearchData)
    cafeResult <- append(cafeResult, cafeSearchData)
  }
}

remDr$close()

resultTable <- table(cafeResult)
resultDf <- data.frame(resultTable)
# a <- as.data.frame(as.Date("2018-04-01") + 0:182)
# colnames(a) <- "Date"
# 
# 
colnames(resultDf) <- c("Date","Freq")
resultDf$Date <- as.Date(resultDf$Date)
resultDf <- left_join(a, resultDf, by = "Date")

# 결측값에 0을 넣는다.
resultDf[is.na(resultDf)] <- 0
#resultDf_smartbargain <- resultDf
#  resultDf_dealgong <- resultDf
# resultDf <- left_join(resultDf_smartbargain, resultDf_dealgong, by = "Date")
# resultDf %>%
#   group_by(Date) %>%
#  mutate(Freq = Freq.x + Freq.y) %>%
#  select(Date, Freq)-> resultDf_sum
# 
# save(resultDf_sum, file = "result_onepiece.RData")
