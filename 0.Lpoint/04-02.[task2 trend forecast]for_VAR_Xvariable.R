
# load("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/01.Input_Data/cardigan_final.RData")

#
Long_hld　<-　rep(0,183)
Sht_hld　<-　rep(0,183) 

new_Long_hld <- rep(0,14)
new_Sht_hld <- rep(0,14)

Long_hld[c(34:36,174:178)] <- 1
Sht_hld[c(37,52,67,74,137,179)] <- 1
new_Sht_hld[c(3,9)] <- 1

#
spline_week <- rep(1:(183 %/% 7 + 1), each = 7, time = 1)[1:183] + 14
new_week <- rep(41:43, each = 7, time = 1)[2:15]
new_poly <- poly(c(spline_week,new_week),5)[184:length(c(spline_week,new_week)),] 

### 
cbind(cardigan_final[,7],Long_hld,Sht_hld,poly(c(spline_week,new_week),5)[1:183,])-> forxt
save(forxt,file = "forxt.RData")

fornewxt <- cbind(temperature,new_Long_hld,new_Sht_hld,new_poly)
fornewxt　<- fornewxt[,-1] 
save(fornewxt,file = "fornewxt.RData")

# getwd()
# dim(forxt)
# dim(fornewxt)


