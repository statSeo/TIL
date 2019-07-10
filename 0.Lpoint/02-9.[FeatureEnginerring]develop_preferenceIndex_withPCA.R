
library(tidyverse)
setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")

category_target = "slingback"
# "cardigan","trenchcoat","slipon","slingback","roper"

location <- paste0("./01.Input_Data/",category_target, "_final.RData")
load(location)

inputdata <- get(paste0(category_target, "_final"))
head(inputdata)

pcaresult <- prcomp(inputdata[,2:5])
summary(pcaresult)
pcaresult$rotation

date_list = seq(as.Date("2018-04-01"), as.Date("2018-09-30"), by=1)
pref <- data.frame(SESS_DT = date_list, pref = pcaresult$x[,1])

ggplot(pref, aes(SESS_DT, pref)) +
  geom_line()

