## 12. Image data 다루기. pdf

## image_read() :이미지 데이터 불러오기
# install.packages("magick")
library(magick)
# str(magick::magick_config())
# ?image_read
gh <- image_read("C:/Users/Jiwan/Desktop/still_life_with_Guitar_1922.jpg") #한글포함x
gh
class(gh)

## image_data() :이미지 데이터 보기
image_data(gh) # array형식: 레이어+가로+세로
image_data(gh)[1, 680:692, 567:577]
unique(image_data(gh)[1, 1:692, 1])
image_write(gh, "c:/Users/Jiwan/Desktop/save.jpg")

## 
image_border(gh, "blue", "20x10") #경계선
image_rotate(gh, 45) # 회전.
image_flip(gh) # 뒤집기
image_crop(gh, "300x400+50") # 자르기

## 그림 쌓기
bigdata <- image_read('https://jeroen.github.io/images/bigdata.jpg')
frink <- image_read("https://jeroen.github.io/images/frink.png")
logo <- image_read("https://jeroen.github.io/images/Rlogo.png")
img <- c(bigdata, logo, frink)
img <- image_scale(img, "300x300")
image_info(img)

image_mosaic(img)
image_flatten(img)
image_flatten(img, 'Add')

## 그림 붙이기
image_append(image_scale(img, "x200"))
image_append(image_scale(img, "100"), stack = TRUE)


## 이미지 합하기 1.
library(magick)
library(ggplot2)
frink <- image_read("https://jeroen.github.io/images/frink.png")
bigdata <- image_read('https://jeroen.github.io/images/bigdata.jpg')
# frink에 대하여 높이를 445에서 200으로 줄이고, 300도 회전한다.
frink_scale <- image_scale(image_rotate(image_background(frink, "none"), 300), "x200")
frink_scale
# bigdata에 대하여 높이를 768에서 400으로 줄이고, frink_scale의 위치를 (180, 100)에 둔다.
image_composite(image_scale(bigdata, "x400"), frink_scale, offset = "+180+100")

## 이미지 합하기 2.
logo <- image_read("https://jeroen.github.io/images/Rlogo.png")
bigdata <- image_read('https://jeroen.github.io/images/bigdata.jpg')
logo_200 <- image_scale(logo, "x200")
image_composite(image_scale(bigdata, "x400"), logo_200, offset = "+250+150")

## 이미지 + 저수준 그래프
library(magick)
str(magick::magick_config())
frink <- image_read("https://jeroen.github.io/images/frink.png")
img <- image_draw(frink)
rect(20, 20, 200, 100, border = "red", lty = "dashed", lwd = 5)
abline(h = 300, col = 'blue', lwd = '10', lty = "dotted")
text(30, 250, "Hoiven-Glaven", family = "monospace", cex = 4, srt = 90)
palette(rainbow(11, end = 0.9))
symbols(rep(200, 11), seq(0, 400, 40), circles = runif(11, 5, 35), bg = 1:11, inches = FALSE, add = TRUE)

## 이미지 기타효과주기
frink <- image_read("https://jeroen.github.io/images/frink.png")
obama <- image_read('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/800px-President_Barack_Obama.jpg')
image_charcoal(obama) %>%
  image_composite(frink) %>%
  image_annotate("CONFIDENTIAL", size = 50, color = "red", boxcolor = "pink",
                 degrees = 30, location = "+100+100") %>%
  image_rotate(30)

#=================================================================
### 13.1~3 R마크다운.pdf
#추가파일 참조
# 우측 상단에 톱니바귀 모양에서 preview를 보여줄 페이지 설정 가능.

#=================================================================
### 13.4 Report Doc_prettty doc.pdf
library(prettydoc)
# File > New File > R Markdown > From Template > Lightweight and Preety Document


#============================
# https://studio.code.org/courses