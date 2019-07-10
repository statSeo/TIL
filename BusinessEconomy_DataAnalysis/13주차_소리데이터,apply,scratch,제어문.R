## 14. 소리데이터 이해와 만들기.pdf

library(seewave)
data(package="seewave")
# 음성데이터의 형태.
data(tico)
tico
class(tico)
plot(tico@left)
listen(tico)
# 진폭은 소리의 크기
v.sound <- 0.2*sin(2*pi*220*seq(0,1, length.out = 8000))
v.sound_02 <- 0.5*sin(2*pi*220*seq(0,1, length.out = 8000))
v.sound_05 <- sin(2*pi*220*seq(0,1, length.out = 8000))
plot(v.sound[1:100], type="l")
plot(v.sound_02[1:100], type="l")
plot(v.sound_05[1:100], type="l")
# 주파수는 소리의 높낮이
sound_220 <- sin(2*pi*220*seq(0,1, length.out = 8000))
sound_440 <- sin(2*pi*440*seq(0,1, length.out = 8000))
sound_660 <- sin(2*pi*660*seq(0,1, length.out = 8000))
plot(sound_220[1:100], type="l")
plot(sound_440[1:100], type="l")
plot(sound_660[1:100], type="l")
# 진폭이 다른 소리 데이터 듣기
library(audio)
play(v.sound, f=22100)
play(v.sound_02, f=22100)
play(v.sound_05, f=22100)
# 주파수가 다른 소리 데이터 듣기
listen(sound_220, f=22100)
listen(sound_440, f=22100)
listen(sound_660, f=22100)
# 도레미파솔라시도
duration01 <- 1
tempo <- 120
sample_rate <- 44100
C4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 261.63 * 2 * pi)
D4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 293.67 * 2 * pi)
E4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 329.63 * 2 * pi)
F4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 349.23 * 2 * pi)
G4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 392.00 * 2 * pi)
A4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 440.00 * 2 * pi)
B4 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 493.88 * 2 * pi)
C5 <- sin(seq(0, duration01 / tempo * 60, 1 / sample_rate) * 523.25 * 2 * pi)
play(C4) ; play(D4) ; play(E4); play(F4); play(G4); play(A4) ;play(B4);play(C5)


## 14.1 Muse Score 사용하기.pdf
# ~


## 15. apply+lapply+sapply+mapply+ifelse+함수.pdf
# apply : matrix를 행 or 열 지정하여 계산
x <- cbind(x1= 7, x2 = c(7:1, 2:5))
x
class(x)
apply(x, 2, sum) # 열에 대하여 더하기 / sum(x[,1])
apply(x, 1, sum) # 행에 대하여 더하기 / sum(x[1,])
# lapply : list를 list로 계산 /  sapply : list를 vector로 계산
x_list <- list(x1= 7:1, x2 = c(7:1, 2:5))
x_list
lapply(x_list, sum) # sum(x_list[[1]])
lapply(x_list, mean)
sapply(x_list, mean)
# mapply : list의 각 원소들에 대한 계산
s1 <- list(a = c(1:3), b = c(11:13))
s2 <- list(c = c(21:23), d = c(31:33))
mapply(sum, s1$a, s1$b, s2$c, s2$d)
# ifelse
x <- 1:10
y <- ifelse(x> 5, "morethan5", "lessthan5")
cbind(x, y)
# 시험과 관련된 예제.
library(tidyverse)
trees
trees02 <- trees %>%
  mutate(Volume2 = ifelse(Volume > 50, "large",
                          ifelse(Volume > 30, "middle", "large")))
trees02


## 16. scratch+R제어문.pdf
#스크래치 -> 엔트리 (그래픽 환경을 통한 교육용 프로그래밍 언어 by Python)
# for while while+break repeat 로 1~5 출력하기 
x <- 1:5
for (i in x) {
  if (i == 3){
    next
  }
  print(i)
}
x <- 1
repeat {
  print(x)
  x = x+1
  if (x == 6){
    break
  }
}
x <- 1
while(T){
  print(x)
  x = x+1
  if (x == 6){
    break
  }
}
x <- 1
while(x<6){
  print(x)
  x = x+1
}

## 1.Easy 통계분석by_commander.pdf
# install.packages("Rcmdr", dependencies=TRUE )
library(Rcmdr)

## 2.Easy 기계학습.pdf
library(rattle)
rattle()

data("iris")
head(iris)

data("weather")
head(weather)
