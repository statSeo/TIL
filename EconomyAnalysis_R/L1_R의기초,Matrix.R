
## 사실상 계산기?
# Matlab , R (s-plus)
# GAUSS 과거에 주로

## 특정 연구에 사용
# Eviews -> 시계열 주로
# Stata -> Panel데이터 분석시 주로


### ML_intro_R part

y <- 5
y

# R은 객체지향적 언어이기 때문에 <- 사용 
# =은 수식에 주로 활용

?sqrt

xx <- -9:9
plot(xx, sqrt(abs(xx)),  col = "red")
lines(spline(xx, sqrt(abs(xx)), n=101), col = "pink")

x <- 1:5 ;x ### 정수로 증가하는 시쿼스(벡터)
x <- seq(1,5,length=5) ;x ### the same thing
x <- seq(0,10,length=101) ;x ### 0.0, 0.1, ..., 10.0
?seq #by:사이간격 / length:시쿼스 길이,등분
x <- 1:5
x[1] <- 17 ;x

x[1] <- 1
x[3:5] <- 0
print(x)

w <- x[-3] ### everything except the third element of x
print(w)
## ex.회귀분석을 부스트래핑 할 때 10만개의 α,β 추정량 중 [-1]하면 β추정량만 보여줌

y <- c(1,5,2,4,7)
y
y[2]
y[-3]
y[c(1,4,5)]
sum(y); mean(y)

i <- (1:3)
z <- c(9,10,11)
y[i] <- z
print(y)

y <- y^2
print(y)

z <- 1:10
z <- log(z) ;z
z <- exp(z) ;z

x <- 1:10
x == 3
x < 5
x <= 5

sort(y)
rank(y)



## 2 Matrices and Lists

junk <- c(1, 2, 3, 4, 5, 0.5, 2, 6, 0, 1, 1, 0)
junk
dim(junk) # 아직 벡터or 행렬의 형태가 아니나 편의상 벡터라 부르는 것 일 뿐
length(junk)
?dim

# 벡터 -> 행렬 -> 3차원?
# c -> matrix -> array


m <- matrix(junk,ncol=3) #default는 1열 부터 채우는 것/ byrow=T옵션으로 변경
print(m)
dim(m)
dim(m)[1]
dim(m)[2]#행의 갯수
nrow(m) ### number of rows
ncol(m) ### number of columns

x <- 1:20
A <- matrix(x,4,5) ### Change vector x
A

mm <- m[1:2,1:3] ;mm
mm <- m[1:2,] ;mm # 전부를 보여줘라 결과는 같음

y <- m[,1] ### y is column 1 of m
y
x <- m[2,] ### x is row 2 of m
x
z <- m[1,2]
z

vv <- c(10,11,12,13)
m[,3] <- vv
m

t(m) ### take the transpose

x1 <- c(1,2,3)
x2 <- c(4,5,6)
x3 <- c(7,8,9)
x <- cbind(x1,x2,x3)
rbind(x1,x2,x3)


new <- matrix( 1:9, 3 , 3)
print(new)
hello <- z + new
print(hello)
m[1,3]
subm <- m[2:3, 2:4]
m[1,]
m[2,3] <- 7
m[,c(2,3)]
m[-2,]

# 큰 행렬의 계산을 쉽게,빠르게 해주는 apply / loof보다
apply(x,1,sum) ### apply the sum function to the rows of A
apply(x,2,sum) ### apply the sum function to the columns of A

x<-rnorm(500)
hist(x)
# ?rnorm : d-distribution() 밀도함수/ p-percent 누적분포함수 /q-quantile 분위수 / r-random 난수
A <- matrix(x,4,5)
B <- matrix(rnorm(30),5,6) 
C <- 1:6
dim(A)
dim(B)
dim(C)
dim(t(C))

B * C ### element끼리 element-matrix , vector-matrix 과는 다름
A %*% B ### 행렬의 곱
A %*% t(B)
B %*% C 
B %*% t(C)
B %*% t(t(C))

A <- matrix(x,4,4)
t(A) ### transpose of A
solve(A) ### inverse of A / Ax=c / x=A-1c (x가 싱귤러메트릭스가 아닐시)
det(A) ### determinant of A
# 회귀분석에서 β=(X'X)-1*X'Y 구할때 X'X 이 싱귤러메트릭스면(디터미넌트가0) 역행렬을 못구하므로 다중공선성의 문제가 있는 것.  
