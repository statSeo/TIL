# 제작한 데이터 합치기
##구성 : 직접 검색, 간접 검색, 직접 구매, 간접 구매, 네이버, 커뮤니티통합, 날씨
# 직접 구매량
# 여성 슬링백

category_target = "cardigan"


library(tidyverse)
setwd("E:/Dropbox/2017/06.job_recruitment/01.Lpoint/01.Data")


load("date.idx.for.matchn.fnl.output.RData")
load("search1_product_master_sesDT.RData")
load("search2_kwd_table.RData")



direct_search_slingback <- main_search_kwd_index_df_slingback
indirect_search_slingback <- slingback.cvr
indirect_buy_slingback <- indirect_buy_idx_slingback
direct_buy_slingback
twitter_slingback <- twitter_slingback[0:183,]; tail(twitter_slingback)
#twitter_slipon <- twitter_slipon[,-1]
colnames(twitter_slingback) <- c("SESS_DT", "Twitter")
cafe_slingback <- resultDf_sum
colnames(cafe_slingback) <- c("SESS_DT", "Cafe")
weather
# 통합
slingback_table <- left_join(direct_search_slingback, indirect_search_slingback, by = "SESS_DT")
slingback_table <- left_join(slingback_table, direct_buy_slingback, by = "SESS_DT")
colnames(indirect_buy_slingback) <- c("SESS_DT", "indirect_buy")
slingback_table <- left_join(slingback_table, indirect_buy_slingback, by = "SESS_DT")
slingback_table <- left_join(slingback_table, naver_slingbacks, by = "SESS_DT")
colnames(twitter_slingback) <- c("SESS_DT", "Twitter")
slingback_table <- left_join(slingback_table, twitter_slingback, by = "SESS_DT")
colnames(cafe_slingback) <- c("SESS_DT", "Cafe")
slingback_table <- left_join(slingback_table, cafe_slingback, by = "SESS_DT")
slingback_table <- slingback_table[,-7:-8]


# pca를 통한 커뮤니티 사이트 정보량 통합
twitter_cafe <- left_join(twitter_slingback, cafe_slingback, by = "SESS_DT")
twitter_cafe <- twitter_cafe[0:183,]
community_pca <- prcomp(twitter_cafe[,-1], scale = F)
print(community_pca)
pc1 <- community_pca$rotation[,1]
twitter_cafe_matrix <-twitter_cafe[,-1]
twitter_cafe_matrix <- -(as.matrix(twitter_cafe_matrix) %*% pc1)
slingback_table <- cbind.data.frame(slingback_table, twitter_cafe_matrix)
colnames(slingback_table) <- c("SESS_DT", "direct_search", "indirect_search", "direct_buy", "indirect_buy", "Naver","Community_pc")
slingback_table <- left_join(slingback_table, weather, by = "SESS_DT")
slingback_final <- slingback_table
save(slingback_final, file = "slingback_final.RData")