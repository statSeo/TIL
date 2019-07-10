

### Loof
for(i in 1:10){
  print(i+1)
}
x <- 101:200
y <- 1:100
z <- rep(0,100) ### rep means repeat
length(x);length(y);length(z)

rep(NA,100) #사실 0은 계산이 되기 때문에 이 형식이 더 좋음
rep(1:4, 2)
rep(1:4, each = 2)       # not the same.
rep(1:4, c(2,2,2,2))     # same as second.
rep(1:4, c(2,1,2,1))

for(i in 1:100){
  z[i] <- x[i] + y[i]
}
w <- x + y
print(w-z) ### Loop is slower!



# 만약 길이를 다르게 해서 계산을 하면?
x <- x[-1]
y <- y[-1]
z <- rep(NA,100) ### rep means repeat
for(i in 1:100){
  z[i] <- x[i] + y[i]
}
z



##
for(i in 1:10){
  for(j in 1:5){
    print(i+j)
  }
}



### if statements
for(i in 1:10){
  if( i == 4)print(i)
}
for(i in 1:10){
  if( i != 4)print(i) ### != means ‘‘not equal to’’
}
for(i in 1:10){
  if( i < 4)print(i)
}
for(i in 1:10){
  if( i <= 4)print(i)
}

i <- 1
while(i < 10){ ### You can also use while loops.
  print(i)
  i <- i + 1
}



### Function
my.fun = function(x,y){
  a = mean(x)-mean(y)
  return(a)
}

my.fun

?runif
# r/unif : 유니폼분포 난수발생
x = runif(50,0,1)
y = runif(50,0,3)
hist(x)
?hist

my.fun(x,y)
# 2-sample t-test에서 활용

## 여러가지 값을 보여주게끔
my.fun = function(x,y){
  mx = mean(x)
  my = mean(y)
  d = mx-my
  return(list(meanx=mx,meany=my,difference=d))
}

x = runif(50,0,1)
y = runif(50,0,3)
my.fun(x,y)

output = my.fun(x,y)
print(output)
names(output)
output$difference
output[3]
output[[3]]

## statistics
summary(y)
aa <- summary(y)
dim(aa)
aa[1]
length(aa)
median(aa)
range(aa)
max(y)
min(y)
sqrt(var(y))




#### R Review with Some Examples

## example 1

# y를 뽑아주고 / x1,u 를 랜덤 값으로 / b0,b1 을 상수 넣어주고

b0 <- 1
b1 <- 1
x <- rnorm(200,0.7,0.1)
e <- rnorm(200,0,0.1) #평균은 무조건 0이 되어야

y<-b0+b1*x+e
plot(x,y,col="blue")

# 이제 regreesion GO
?lm
#분산이 설명변수들의 함수 : 이분산성 존재 /  WLS,GLS 사용 weight옵션

res1 <- lm(y~x)
res1
res1$coefficients
abline(res1)
#estimation : 걍해도 / test : standard error 필요
res1.s <- summary(res1) # 여기서 summary는 일반적일 통계량의 summary가 아닌 summary.lm으로 라이브러리에 attach되 있는 summary
?summary.lm
res1.s
# t값은 귀무가설이 b0=0 이기 때문에 β1hat/sd(β1)의 값
# 자유도는 198 = (n-2) / 왜냐하면 LS에서 시그마(y-β0-β1x)=0 / 시그마x(y-β0-β1x)=0 두식의 restriction이 있기 때문에 n-'2'

# M1 : yi=β0+β1x+εi
# M2 : yi=δ1x1+vi 
res2 <- lm(y~x-1) 
# or res2 <- lm(y ~ 0 + x) : 인터셉트 제거
abline(res2,col="red",lwd=2)

# 두선이 겹칠때(평행이거나?) bias가 없다?