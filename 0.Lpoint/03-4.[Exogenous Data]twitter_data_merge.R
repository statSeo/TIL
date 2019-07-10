

head(main_search_kwd_index_df_roper)

main_search_kwd_index_df_roper$main_search_kwd_index -> dd

# 차분하는게 맞나
plot(diff(dd,1),type = "l")

# decompose해서 쓰는게 맞나
x.msts <- msts(x,seasonal.periods=c(7,365.25))

daily <- msts(dd, seasonal.periods=c(7,365.25)) 

weekly <- msts(dd, seasonal=365.25/7)

comp <- decompose(weekly)

comp$seasonal

plot(decompose(weekly))


fit <- tbats(daily)
fc <- forecast(fit)
plot(fc)


## auto.arima

auto.arima(dd) 

plot(forecast(arima(dd, order = c(0,1,2))))


# twitter 데이터 가공

cardigan1<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/cardigan1.csv")
cardigan2<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/cardigan2.csv")
cardigan3<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/cardigan3.csv")
cardigan1<-cardigan1[,-1]
cardigan2<-cardigan2[,-1]
cardigan3<-cardigan3[,-1]
cardigan<-rbind.data.frame(cardigan1[1:174,],cardigan2[1:92,] ,cardigan3)
write.csv(cardigan,"C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/cardigan.csv")


trench_coat1<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/trench_coat1.csv")
trench_coat2<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/trench_coat2.csv")
trench_coat3<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/trench_coat3.csv")
trench_coat1<-trench_coat1[,-1]
trench_coat2<-trench_coat2[,-1]
trench_coat3<-trench_coat3[,-1]
trench_coat<-rbind.data.frame(trench_coat1,trench_coat2,trench_coat3)
write.csv(trench_coat,"C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/trench_coat.csv")


roper1<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/roper1.csv")
roper2<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/roper2.csv")
roper3<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/roper3.csv")
roper1<-roper1[,-1]
roper2<-roper2[,-1]
roper3<-roper3[,-1]
roper<-rbind.data.frame(roper1,roper2,roper3)
write.csv(roper,"C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/roper.csv")


slipon1<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slipon1.csv")
slipon2<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slipon2.csv")
slipon3<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slipon3.csv")
slipon1<-slipon1[,-1]
slipon2<-slipon2[,-1]
slipon3<-slipon3[,-1]
slipon<-rbind.data.frame(slipon1,slipon2,slipon3)
write.csv(slipon,"C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slipon.csv")


slingback1<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slingback1.csv")
slingback2<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slingback2.csv")
slingback3<-read.csv("C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slingback3.csv")
slingback1<-slingback1[,-1]
slingback2<-slingback2[,-1]
slingback3<-slingback3[,-1]
slingback<-rbind.data.frame(slingback1,slingback2,slingback3)
write.csv(slingback,"C:/Users/Jiwan/Dropbox/01.Lpoint/01.Data/twitter_data/slingback.csv")



plot(cardigan$Frequency,type="l")
plot(trench_coat$Frequency,type="l")
plot(roper$Frequency,type="l")
plot(slipon$Frequency,type="l")
plot(slingback$Frequency,type="l")
