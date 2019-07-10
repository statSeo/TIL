# 판다스 인덱스와 슬라이싱의 차이처럼
df$col1    # 벡터형식
df["col1"] # 1열의 데이터프레임 형식
# 다르게 불러온다 

#####################################################################
### Getting Column of Dataframe from String
# https://stackoverflow.com/questions/39543606/r-getting-column-of-dataframe-from-string
#####################################################################

# 1 같은 결과
df$col1 
# 2 같은 결과
z <- "col1"
df[[z]]

# 바보짓
colname_datetime <- c("placed_datetime","driver_datetime","delivered_datetime")
i = 0
for (i in colname_datetime){
  i = i+1
  samp_clean[colname_datetime[i]] <- parse_date_time(samp_clean[[i]], "HMS")
}

# 답안
colname_datetime <- c("placed_datetime","driver_datetime","delivered_datetime")
for (i in colname_datetime){
  samp_clean[[i]] <- parse_date_time(samp_clean[[i]], "HMS")
}


####################################################################
######################### get과 assign #######3#####################
####################################################################
abc <- "aaa"
get(paste0("a","b","c"))

assign(paste0("a","b"),get(paste0("a","b","c")))
ab

# 예시
park<-data.frame(NA,NA,NA,NA)
j<- 0
for (i in aa){
  j <- j+1
  assign(paste0("peo_2018",i),get(paste0("peo_2018",i,"_ori"))[1:4])
  assign(paste0("peo_2018",i) , get(paste0("peo_2018",i)) %>% filter( V3 == 11215780 ) )
  print(dim(get(paste0("peo_2018",i))))
  if (j>1){
    park <- rbind( park , get(paste0("peo_2018",i)))
  }
  else {
    park <- get(paste0("peo_2018",i))
  }
}

##############################################################################
##### 큰 따옴표 안에 내용을 함수안에서 큰따옴표 없는 것처럼 활용하기 #########
#################### (tidyverse에서 string loop 만들기) ######################
##############################################################################

#https://stackoverflow.com/questions/49469982/r-using-a-string-as-an-argument-to-mutate-verb-in-dplyr
# 간단예시

library(rlang)
library(tidyverse)

input_from_shiny <- "Petal.ratio = Petal.Length/Petal.Width"
iris_mutated <- iris %>% mutate_(input_from_shiny)

iris_mutated2 <- iris %>% 
  mutate(!!parse_quosure(input_from_shiny))

lhs <- "Petal.ratio"
rhs <- "Petal.Length/Petal.Width"
iris_mutated3 <- iris %>% 
  mutate(!!lhs := !!parse_quosure(rhs))

head(iris_mutated)
head(iris_mutated2)
head(iris_mutated3)

# quo 류 : = / 같은 기호 활용하기 , 따옴표안에 넣어서 저장
# quo 안에 = 이 들어가버리면 = 왼쪽으로 제목으로 인식하지않음
# !! : tidyverse에서 따옴표애들 해체에서 사용하기기
# _가 붙은 함수들은 굳이 따옴표를 해체할 필요가 없음
# := : !!를 사용시 = 대신에 사용
# 

# 바보 짓
colname_datetime <- c("order_datetime","placed_datetime","driver_datetime","delivered_datetime")
for (i in colname_datetime) {
  samp_clean = aa %>%
    mutate(get(colname_datetime[i]) = parse_date_time(samp_clean[[i]], "HMS"))
}

# 성공 1
colname_datetime <- c("order_datetime","placed_datetime","driver_datetime","delivered_datetime")
for (i in colname_datetime) {
  q = enquo(i)
  samp_clean = aa %>%
    mutate((!! q) := parse_date_time(aa[[i]], "HMS"))
}

# 성공 2
colname_datetime <- c("order_datetime","placed_datetime","driver_datetime","delivered_datetime")
for (i in colname_datetime) {
  samp_clean = aa %>%
    mutate((!!enquo(i)) := parse_date_time(aa[[i]], "HMS"))
}

# 성공 3
colname_datetime <- c("order_datetime","placed_datetime","driver_datetime","delivered_datetime")
for (i in colname_datetime) {
  # q = enquo(i)
  samp_clean = aa %>%
    mutate((!! i) := parse_date_time(aa[[i]], "HMS"))
}
