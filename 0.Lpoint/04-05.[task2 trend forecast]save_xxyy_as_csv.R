

setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint")

category_target = "roper"
# "cardigan","trenchcoat","slipon","slingback","roper"

rm(xx,yy)


# xxyy --------------------------------------------------------------------
loading_location <- paste0("./01.Data/03.XXYY/xxyy_", category_target,".RData")
load(file = loading_location)
colnames(xx)[11:19] <- 6:14

write.csv(xx, file = paste0("./01.Data/03.XXYY/xx_", category_target,".csv"))
write.csv(yy, file = paste0("./01.Data/03.XXYY/yy_", category_target,".csv"))



# new_x -------------------------------------------------------------------
loading_location <- paste0("./01.Data/02.For_New_X/new/new_x_", category_target,".RData")
load(file = loading_location)
new_x
colnames(new_x)[11:19] <- 6:14

write.csv(new_x, file = paste0("./01.Data/02.For_New_X/new/new_x_", category_target,".csv"))

