
## https://cafe.naver.com/rstrategy

# 00 : 프로젝트관련 자료
# 1자리 : 숫자 관련
# 20~ : 데이터 수집관련 (ex. api)

# R,HTML -> API,크롤링
# CSS,Java script


### 수업계획표.hwp
# 시험용 ( 데이터구조 이해 / 데이터프레임 / 프레임 ) 다루기 중요


### 01.R,RStudio Packages 설치와 이해.pdf

# R studio : IDE / Integrated Development Environment 통합개발환경

?plot  # 해당 함수만
??plot # 관련모든 문서

# 패키지설치 1.clan에서
install.packages("ggplot2") # or 아래 packages -> install -> 입력
install.packages(c("ggplot2", "caret"))
require(ggplot2) # 패키지가 제대로 설치됬는지 true or false 값 반환
remove.packages("ggplot2")
update.packages()
library()
detach()
scales::comma #중복된 함수의 경우 특정 패키지의 함수 사용하기

# 패키지설치 2.open 소스 파일 

#Rtools를 별도로 설치
#devtools 패치지사용
#github,bioc,bitbucket 등에서 찾아서 설치


### 02. 데이터, 변수, 함수 이해하기.pdf

## page 2,3~ : 연산자 페이지 시험!
2**4
2^4  # 결과값 같음

# 문자입력하기
R       # 에러
'R';"R" # 둘중 상관x
"'a','b'" # 둘다쓰면 구분하기위해서 사용

a2 <- 2
# 2a <- 2 : 에러

c <- 'H'
d <- 'P'
c+d

# 시험에 함수를 쓸지 코드를 짤지는 선택
rep("*", 3)

for (i in 1:3) {
  print("*" )
}

## page11 : 코드를 짜고 숫자를 주고 답. 시험에!

## paste 와 paste0 의 차이 : 붙일 때 띄어쓰기여부
# paste sep옵션으로 일부러 만들 수도
## collapse 옵션 : vector(results)로 지정한 값에 사이공간은 이 옵션



# 프로젝트 시작 할때 아래 두 데이터를 활용.

### 21.Google Trend Data.pdf
# https://trends.google.co.kr/trends/?geo=KR
# 주제에 따라서 영어냐 한글이냐에 따라 다른결\
# 내 주제에 따른 어떤 값들을 비교할 것인가
# ex. 경쟁자분석, 기업전략, PEST


### 22.Naver Data Lab 사용법.pdf
# https://datalab.naver.com/
# 연령,성별로 데이터 조회 가능
# 다운로드로 데이터를 다운로드 가능
# 지역별 관심도 
# 카드소비 통계 
 