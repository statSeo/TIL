library(xlsx)
library(quadprog)
data1 <- read.xlsx("C:/Users/Jiwan/NaverCloud/2018 수업자료/경제분석을 위한 R프로그래밍/PS2/data_port_PS2.xlsx",sheetIndex=1,startRow=1,stringsAsFactors=F)

str(data1)
nrow(data1)
head(data1)
data2 <- data1[,-1]

# 1. 분산,평균,합1
# 2. 분산,합1
# 3. 분산,평균,합1,구입만
# 4. 분산,합1,구입만
# 5. 모두 1/5

# Case 1
return_Q1 <- c(rep(NA,nrow(data1)-120))
ppi_Q1 <- NULL
mean_v <- rbind(mean(data2[,1]),mean(data2[,2]),mean(data2[,3]),mean(data2[,4]),mean(data2[,5]))
c <- sum(data2)/ (dim(data2)[1] * dim(data2)[2] )

Amat <- cbind(mean_v,matrix(rep(1,5),ncol = 1))
bvec <- c(c,1)

for (i in 1:(nrow(data1)-120)){
  Q1 <- solve.QP(cov(data2[i:(119+i),]), c(0,0,0,0,0),
                 Amat,bvec,0)
  ppi_Q1 <- cbind(ppi_Q1,Q1$solution)
  return_Q1[i] <- t(Q1$solution) %*% t(data2[(i+120),])
  Sharpe_Q1 <- mean(return_Q1) / (sd(return_Q1)/ length(return_Q1) )
}
plot(ts(ppi_Q1[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "case1",ylab="phi")
lines(ts(ppi_Q1[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q1[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q1[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q1[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)

Sharpe_Q1

# Case 2
return_Q2 <- c(rep(NA,nrow(data1)-120))
ppi_Q2 <- NULL
for (i in 1:(nrow(data1)-120)){
  Q2 <- solve.QP(cov(data2[i:(119+i),]), c(0,0,0,0,0),
                 matrix(rep(1,5),ncol = 1),c(1),0)
  ppi_Q2 <- cbind(ppi_Q2,Q2$solution)
  return_Q2[i] <- t(Q2$solution) %*% t(data2[(i+120),])
  Sharpe_Q2 <- mean(return_Q2) / (sd(return_Q2)/ length(return_Q2) )
}
ppi_Q2
dim(ppi_Q2)

plot(ts(ppi_Q2[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "case2",ylab="phi")
lines(ts(ppi_Q2[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q2[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q2[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q2[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
  ,col = c("black", "blue", "red", "green", "yellow"),
  lty = 1,ncol=5,cex=0.7)
       
Sharpe_Q2

# Case 3
return_Q3 <- c(rep(NA,nrow(data1)-120))
ppi_Q3 <- NULL
mean_v <- rbind(mean(data2[,1]),mean(data2[,2]),mean(data2[,3]),mean(data2[,4]),mean(data2[,5]))
c <- sum(data2)/ (dim(data2)[1] * dim(data2)[2] )

Amat <- cbind(mean_v,matrix(rep(1,5),ncol = 1), diag(5))
bvec <- c(c,1, rep(0, 5))

for (i in 1:(nrow(data1)-120)){
  Q3 <- solve.QP(cov(data2[i:(119+i),]), c(0,0,0,0,0),
                 Amat,bvec,0)
  ppi_Q3 <- cbind(ppi_Q3,Q3$solution)
  return_Q3[i] <- t(Q3$solution) %*% t(data2[(i+120),])
  Sharpe_Q3 <- mean(return_Q3) / (sd(return_Q3)/ length(return_Q3) )
}
plot(ts(ppi_Q3[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "case3",ylab="phi")
lines(ts(ppi_Q3[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q3[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q3[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q3[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)

Sharpe_Q3


# Case 4
return_Q4 <- c(rep(NA,nrow(data1)-120))
ppi_Q4 <- NULL

Amat <- cbind(matrix(rep(1,5),ncol = 1), diag(5))
bvec <- c(1, rep(0, 5))

for (i in 1:(nrow(data1)-120)){
  Q4 <- solve.QP(cov(data2[i:(119+i),]), c(0,0,0,0,0),
                 Amat,bvec,0)
  ppi_Q4 <- cbind(ppi_Q4,Q4$solution)
  return_Q4[i] <- t(Q4$solution) %*% t(data2[(i+120),])
  Sharpe_Q4 <- mean(return_Q4) / (sd(return_Q4)/ length(return_Q4) )
}

plot(ts(ppi_Q4[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "case4",ylab="phi")
lines(ts(ppi_Q4[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q4[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q4[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q4[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)

Sharpe_Q4

# Case 5
return_Q5 <- c(rep(NA,nrow(data1)-120))
for (i in 1:(nrow(data1)-120)){
  # ppi_Q5[i] <- Q5$solution
  return_Q5[i] <- t(c(rep(1/5,5))) %*% t(data2[(i+120),])
  Sharpe_Q5 <- mean(return_Q5) / (sd(return_Q5)/ length(return_Q5) )
}
Sharpe_Q5


############################################### 기말연계
library(quadprog)
library(MASS)
return_Q2 <- c(rep(NA,nrow(data1)-120))
ppi_Q2 <- NULL
sim_all_phi <- NULL
sim.n <- 10

Amat <- cbind(matrix(rep(1,5),ncol = 1), diag(5))
bvec <- c(1, rep(0, 5))

for (i in 1:(nrow(data1)-120)){
  
  sam_mean <- rbind(mean(data2[i:(119+i),1]),mean(data2[i:(119+i),2]),mean(data2[i:(119+i),3]),mean(data2[i:(119+i),4]),mean(data2[i:(119+i),5]))
  
  sam_cov <- cov(data2[i:(119+i),])
  
  for (j in 1:sim.n){
    forresample <- mvrnorm( 120 , sam_mean , sam_cov ) # 120x5
    sim.phi <- solve.QP( cov(forresample)  , c(0,0,0,0,0) ,
                         Amat , bvec , 0) 
    sim_all_phi <- cbind(sim_all_phi,sim.phi$solution) # 5x10
  }
  Q2 <- apply(sim_all_phi,1,mean)
  sim_all_phi <- NULL
  
  ppi_Q2 <- cbind(ppi_Q2,Q2)
  return_Q2[i] <- t(Q2) %*% t(data2[(i+120),])
}

Sharpe_Q2 <- mean(return_Q2) / (sd(return_Q2)/ length(return_Q2) )
Sharpe_Q2

plot(ts(ppi_Q2[1,],start=1990,frequency = 12),type = "l",ylim = c(-1,3) ,
     main = "Case2 : Resampled Portfolio",ylab="phi")
lines(ts(ppi_Q2[2,],start=1990,frequency = 12), col="blue")
lines(ts(ppi_Q2[3,],start=1990,frequency = 12), col="red")
lines(ts(ppi_Q2[4,],start=1990,frequency = 12), col="green")
lines(ts(ppi_Q2[5,],start=1990,frequency = 12), col="yellow")

legend("top",c("Cnsmr" ,"Manuf" ,"HiTec","Hlth.", "Other")
       ,col = c("black", "blue", "red", "green", "yellow"),
       lty = 1,ncol=5,cex=0.7)

