## 7. Legendre
# Legendre_RClass_v1.R

# 일반적인 회귀분석식에서 beta는 시간에 따라 변할수도(구조변환)
#   St = alpha + beta Ft + ut
#-> St = alpha + beta(t) Ft + ut

# 또는 다른 변수에 영향을 받아 변할수도
#-> St = alpha + beta(Spt) Ft + ut

### 데이터 : 나라별 주식시장 spot,future가격 
data <- read.csv("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/7. Legendre/Data_New.csv",header=T)
head(data)

pt <- data[3200:4700,3:4]
#pt <- data[37:1537,3:4]

pt.log <-log(pt)*100
zt <- pt.log   #log transformation

rt <- zt[2:dim(pt)[1],] - zt[1:dim(pt)[1]-1,]   
# Log return series
plot(rt[,1],type="l")


# 각각을 정의
y <- rt[,1]  # where y = spot, x = future
x <- rt[,2]
#u <- (pt[,1]-pt[,2])[2:dim(pt)[1]]   # u denote basis; basis = spot - future
u <- (pt[,1]-pt[,2])[1:1500]   # u(t-1) denote basis; basis = spot - future

y.o <- matrix(y)   # y(t)
x.o <- matrix(x)   # x(t)
u.o <- matrix(u)   # u(t-1)
z <- u.o

# 전기에`영향을 받는다 beta(Bt-1)
# t = 1,2,3,...,1000 이면 값이 너무 차이나므로
# normalize_t = 0~1로 만들어 주자.
z.norm <- (z-min(z))/(max(z)-min(z))      # normalization for basis
z.norm.in <- as.matrix(z.norm[(1:500)])   #
head(z)
head(z.norm)

# 이하 Legendre_RClass_v1.R 참고

