
library(arules)
library(munsell)
library(arulesViz)
?transactions
###########################################################################

left_join(product,master  ,by="PD_C") -> product_master
# names(product_master)
product_master %>%
  select(CLNT_ID,SESS_ID,CLAC3_NM) -> gg
# gg$CLAC3_NM <- as.character(gg$CLAC3_NM)

## 2개이상의 상품을 구매한 session만 뽑자
gg %>%
  count(CLNT_ID,SESS_ID) %>%
  filter( n >= 2) -> multi_buy_sess_df # 1,129,144 개의 세션
# multi_buy_sess_df$CLNT_ID -> multi_buy_clnt
# multi_buy_sess_df$SESS_ID -> multi_buy_sess
# length(multi_buy_sess) -> lang_multi_buy_sess

# 그 사람들이 어떤 상품군을 구매 했는지 join 
left_join(multi_buy_sess_df,gg,by=c("CLNT_ID","SESS_ID")) -> gg1
# 동일한 상품군 구매는 제외
unique(gg1) -> gg1
gg1[,-3] -> gg2
# 두개를 합해서 key변수 만들고
gg2 %>%
  unite(CLNT_SESS_ID, CLNT_ID, SESS_ID) -> gg3
head(gg3)
dim(gg3) # 2138824
gg3 %>% 
  filter(!is.na(CLAC3_NM)) -> gg3 # 2138789

# data <- c()
# for (i in 1:nrow(gg3) ){#nrow(gg3)
#   data <- paste( data, "\n",
#     CLNT_SESS_ID_basket[i],CLAC3_NM_basket[i] )
# }
# cat(data)

# sep = " "
# gg4 <- gg3
# gg4$CLAC3_NM <- as.character(gg4$CLAC3_NM)

# 
apply(gg3,1, paste,sep = " ",collapse=" ") -> gg3_paste_row
paste(gg3_paste_row,collapse ="\n") -> data
# cat(data)
write(data, file = "trans_multibuy_session")
## read
trans_multibuy_session <- read.transactions("trans_multibuy_session", format = "single", cols = c(1,2))
inspect(trans_multibuy_session[1:10])
unlink("trans_multibuy_session")

# save(trans_multibuy_session,file = "trans_multibuy_session.Rdata")

trans_multibuy_session
# 1129150개의 장바구니 
# 908 개의 아이템

# support : 둘이 실제로 같이 거래된 확률

# confidence: A의 거래중 A,B가 동시에 거래될 확률
# : A상품 산 사람이 B상품 살 확률

# lift : 실제 같이 거래된 확률 / 서로 독립적이면 거래될확률 (상호관계)



### mine association rules
1129150 * 0.000005
rules <- apriori(trans_multibuy_session, parameter = list(supp = 0.000009, conf = 0.2))
rules

### visualize rules as a scatter plot (with jitter to reduce occlusion)
plot(rules, control=list(jitter=2))

### select and inspect rules with highest lift
rules_high_lift <- head(sort(rules, by="lift"), 10)
inspect(rules_high_lift)
# 

### plot selected rules as graph
plot(rules_high_lift, method="graph", control=list(type="items"))

rule_interest <- subset(rules, rhs %in% c("여성가디건")) ; inspect(rule_interest)
rule_interest <- subset(rules, items %in% c("여성트렌치코트")) ; inspect(rule_interest)
rule_interest <- subset(rules, rhs %in% c("여성슬링백")) ; inspect(rule_interest)
rule_interest <- subset(rules, rhs %in% c("여성슬립온")) ; inspect(rule_interest)
rule_interest <- subset(rules, rhs %in% c("여성로퍼")) ; inspect(rule_interest)

