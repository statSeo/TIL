## 6. Optimization.pdf
##    opti_ex.rx.txt

#===========================================
## intro
f1 <- function(x,y) 2*(x-1)^2 + 5*(y-3)^2 + 10
# 1줄이라 중괄호 안써도
f1(1,1) # 점검

x1 <- seq(-4,4,length=100)
x2 <- seq(-4,4,length=100)
z <- outer(x1,x2,f1) # x와 y의 f1을 사용하여 outer product를 계산.
dim(z) # 100x100

# 3d 그래프 / theta로 조금 회전
persp(x1, x2, z, ticktype="detailed")
persp(x1, x2, z, ticktype="detailed", theta=20)
persp(x1, x2, z, ticktype="detailed", theta=50)

# 2d 그래프 + 색 + 등고선 
image(x1,x2,z)
contour(x1,x2,z, add=TRUE)

# optim은 두개의 변수로 인식x -> x1,x2로 변경
f1.o <- function(x) 2*(x[1]-1)^2 + 5*(x[2]-3)^2 + 10  
r <- optim(c(1,1),f1.o) # initial value가 1,1
r
# convergence = 0 : optimization 성공.

#===========================================
## LP /  page 14

# install.packages("lpSolve")
library(lpSolve)

objective.in <- c(25, 20)
const.mat <- matrix(c(20, 12, 1/15, 1/15), nrow=2, byrow=TRUE)
const.rhs <- c(1800, 8)
const.dir <- c("<=", "<=")
optimum <- lp(direction="max", objective.in, const.mat, const.dir, const.rhs)
optimum$solution; optimum$objval

#===========================================
## QP (숙제있음) / page 20

# install.packages("quadprog")
library(quadprog)
# solve.QP(Qmat, dvec, Amat, bvec, meq)


################ 이까지 17 ####################-
#===========================================
## page25 : Non-gradient based / 
# Golden Section Search : 두개의 그리드로 나눠 계쏙해서 비교 objective function이 smooth 하지 않아도 가능!
## NLP : r내장 optimize() -> smooth 하지 않아도 가능 

# differentiable function
f2 <- function(x)(print(x) - 1/3)^2
xmin <- optimize(f2, interval = c(0, 1), tol = 0.0001)

# non-differentiable function(ex.절대값이 들어간 함수)
f3 <- function(x) return(abs(x-2) + 2*abs(x-1))
xmin <- optimize(f3, interval = c(0, 3), tol = 0.0001)

#===========================================
## Himmelblau's function (아래에서 쓸거.) /  benchmark optimization algorithms 용도

fn <- function(para){ # Vector of the parameters
  matrix.A <- matrix(para, ncol=2)
  x <- matrix.A[,1]
  y <- matrix.A[,2]
  f.x <- (x^2+y-11)^2+(x+y^2-7)^2
  return(f.x)
}
par <- c(1,1)

xy <- as.matrix(expand.grid(seq(-5,5,length = 101), seq(-5,5,length = 101)))
colnames(xy) <- c("x", "y")
df <- data.frame(fnxy = fn(xy), xy)

library(lattice)
wireframe(fnxy ~ x*y, data = df, shade = TRUE, drape=FALSE,
          scales = list(arrows = FALSE),
          screen = list(z=-240, x=-70, y=0))

#===========================================
## Comparison

# install.packages("optimx")

library(optimx)


optimx(par, fn, method = "Nelder-Mead") #  Nelder-Mead :Golden Section Search의 다차원 버전. p=1 -> n =2 // p=a -> n=a+1 : 제일 큰 값없애서 새로추가하고 반복. // smooth 필요x
optimx(par, fn, method = "CG") # Gradient descent
optimx(par, fn, method = "BFGS")# Newton methods / 한번미분0 , 두분미분>0 / 2차도함수존재할때
#ㅇ--
optimx(par, fn, method = c("Nelder-Mead", "CG", "BFGS", "spg", "nlm"))


optimx(par, fn, method = c("BFGS", "Nelder-Mead"), control = list(trace = 6, follow.on=TRUE, maximize=FALSE))

#===========================================
## OLS Example

# Sample data
n <- 100
x1 <- rnorm(n)
x2 <- rnorm(n)
y <- 1 + x1 + x2 + rnorm(n)
X <- cbind( rep(1,n), x1, x2 )

# Regression
r <- lm(y ~ x1 + x2)

# Optimization
library(quadprog)
s <- solve.QP( t(X) %*% X, t(y) %*% X, matrix(nr=3,nc=0), numeric(), 0 )

# Comparison
coef(r)
## (Intercept) x1 x2
## 1.0645272 1.0802060 0.9807713
s$solution # Identical
## [1] 1.0645272 1.0802060 0.9807713

# Median Example