library(stringr)
library(rvest)
library(RSelenium)

urlSearch <- "https://facebook.com/"


ch=wdman::chrome(port=4567L) #크롬드라이버를 포트 4567번에 배정
remDr=remoteDriver(port=4567L, browserName='chrome') #remort설정

remDr$open() #크롬 Open
remDr$navigate(urlSearch) #설정 URL로 이동

id <- remDr$findElement(using = 'css',  "#email")
id$sendKeysToElement(list("email_id")) #email facebook ID 기입

password <- remDr$findElement(using = 'css',  "#pass")
password$sendKeysToElement(list("password")) #password 기입


login <- remDr$findElement(using = 'css',"[class='uiButton uiButtonConfirm']")
login$clickElement()
Sys.sleep(2)

text <- remDr$findElement(using = 'css',  "[class = '_1frb']")
text$clickElement()
text$sendKeysToElement(list("슬립온","\uE007"))
Sys.sleep(2)
#trt <- remDr$findElement(using = 'css', '#u_ps_fetchstream_3_0_f > a:nth-child(6)')
#trt$clickElement()

webElem <- remDr$findElement("css", "body")

for(i in 1:15) {
  webElem$sendKeysToElement(list(key = "end"))
  Sys.sleep(2)
}

frontPage <- remDr$getPageSource() #페이지 전체 소스 가져오기

slingback6 <- read_html(frontPage[[1]]) %>% html_nodes('.timestampContent') %>%  html_text() %>% trimws()

# quantile ----------------------------------------------------------------

slingback1
slingback2
slingback3
slingback4
slingback5
slingback6

facebook_slingback <- c(slingback1,slingback2,slingback3,slingback4,slingback5,slingback6)
write.csv(facebook_slingback, file = "facebook_slingback.csv", fileEncoding = "CP949")
facebook_slingback <- facebook_slingback[-163,]
facebook_slingback <- as.data.frame(table(facebook_slingback))
save(facebook_slingback, file = "facebook_slingback.RData")


facebook_slipon <- c(slipon1, slipon2, slipon3, slipon4, slipon5, slipon6)
write.csv(facebook_slipon, file = "facebook_slipon.csv", fileEncoding = "CP949")
facebook_slipon <- facebook_slipon[,-1]
save(facebook_slipon, file = "facebook_slipon.RData")



facebook_roper <- c(roper1,roper2,roper3,roper4,roper5,roper6)
write.csv(facebook_roper, file = "facebook_roper.csv", fileEncoding = "CP949")
facebook_roper <- facebook_roper[,-1]
save(facebook_roper, file = "facebook_roper.RData")

facebook_trench <- c(trench1, trench2, trench3, trench4, trench5, trench6)
write.csv(facebook_trench, file = "facebook_trench.csv", fileEncoding = "CP949")

facebook_trench <- facebook_trench[-150,]
facebook_trench <- as.data.frame(table(facebook_trench))
save(facebook_trench, file = "facebook_trench.RData")

facebook_cardigan <- facebook_cardigan[-168:-171,]
save(facebook_cardigan, file = "facebook_cardigan.RData")
facebook_cardigan <- c(cafeSearchData_1, cafeSearchData_2, cafeSearchData_3 ,cafeSearchData_4 ,cafeSearchData_5, cafeSearchData_6, cafeSearchData_7)
rm(facebook_cardigan)
facebook_cardigan <- data.frame(facebook_cardigan)
facebook_cardigan3 <- as.data.frame(table(facebook_cardigan2))
