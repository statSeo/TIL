
library(arules)
library(munsell)
library(arulesViz)
###########################################################################

#####################################
# 세션기준 장바구니
#####################################

#########################################
# 분석시작 

rules <- apriori(trans_multibuy_session, parameter = list(supp = 0.00001, conf = 0.01))
# rules <- apriori(trans_clnt, parameter = list(supp = 0.00003, conf = 0.2))
rules


### visualize rules as a scatter plot (with jitter to reduce occlusion)
plot(rules, control=list(jitter=2))

### select and inspect rules with highest lift
rules_high_lift <- head(sort(rules, by="lift"), 30)
inspect(rules_high_lift)


# subset of association rules : subset()
# rule_interest <- subset(rules, items %in% c("여성스웨터", "doc_4ac"))
# inspect(rule_interest)

# subset with left-hand side item : subset(lhs %in% "item")
# rule_interest_lhs <- subset(Epub_rule_2, lhs %in% c("doc_72f", "doc_4ac"))
# inspect(rule_interest_lhs)

rule_interest_ca <- subset(rules, rhs %in% c("여성가디건") & lift > 2 ) ; inspect(rule_interest_ca[1:30])
rule_interest_tr <- subset(rules, rhs %in% c("여성트렌치코트")) ; inspect(sort(rule_interest_tr, by="lift"))
rule_interest_sb <- subset(rules, rhs %in% c("여성슬링백")) ; inspect(sort(rule_interest_sb, by="lift"))
rule_interest_so <- subset(rules, rhs %in% c("여성슬립온")) ; inspect(sort(rule_interest_so, by="lift"))
rule_interest_ro <- subset(rules, rhs %in% c("여성로퍼")) ; inspect(sort(rule_interest_ro, by="lift"))

###########
# Visualize
###########

## 
plot(rule_interest, method="graph", control=list(type="itemsets"))
plot(rule_interest_ca[1:19], method="graph", control=list(type="itemsets"))
plot(rule_interest_ca, method="graph", control=list(type="items"))


###########
# weight 
###########

asso_ca <- as(rule_interest_ca, "data.frame")
asso_tr <- as(rule_interest_tr, "data.frame")
asso_sb <- as(rule_interest_sb, "data.frame")
asso_so <- as(rule_interest_so, "data.frame")
asso_ro <- as(rule_interest_ro, "data.frame")

asso_ca[1:19,] -> asso_ca
asso_ro[1:9,] -> asso_ro

# 중괄호안에 들어간애 뽑기
gsub("[\\{\\}]", "", regmatches(asso_ca$rules, regexpr("\\{.*?\\}", asso_ca$rules))) -> asso_ca$rules
gsub("[\\{\\}]", "", regmatches(asso_tr$rules, regexpr("\\{.*?\\}", asso_tr$rules))) -> asso_tr$rules
gsub("[\\{\\}]", "", regmatches(asso_sb$rules, regexpr("\\{.*?\\}", asso_sb$rules))) -> asso_sb$rules
gsub("[\\{\\}]", "", regmatches(asso_so$rules, regexpr("\\{.*?\\}", asso_so$rules))) -> asso_so$rules
gsub("[\\{\\}]", "", regmatches(asso_ro$rules, regexpr("\\{.*?\\}", asso_ro$rules))) -> asso_ro$rules

asso_ca<-asso_ca[,c(1,3)]
asso_tr<-asso_tr[,c(1,3)]
asso_sb<-asso_sb[,c(1,3)]
asso_so<-asso_so[,c(1,3)]
asso_ro<-asso_ro[,c(1,3)]


##########################
# daily 상품군 구매 table
##########################
library(tidyverse)

main_search_kwd_index_df$SESS_DT -> mydates

daily_buy_table %>%
  mutate_all(funs(replace(., is.na(.), 0))) -> daily_buy_table

############## indirect_buy_idx_cardigan
tmp <- c()
for(i in 1:nrow(asso_ca)){
  category_idx <- asso_ca[i,1] == daily_buy_table$x
  category_val <- as.numeric(as.vector(t(daily_buy_table[category_idx,]))[-1]) * asso_ca[i,2]
  tmp <- rbind(tmp,category_val)
}
rownames(tmp) <- asso_ca$rules
indirect_buy_val <- apply(tmp,2,sum)
indirect_buy_idx_cardigan <- data.frame(mydates,indirect_buy_val)

############## indirect_buy_idx_trenchcoat
tmp <- c()
for(i in 1:nrow(asso_tr)){
  category_idx <- asso_tr[i,1] == daily_buy_table$x
  category_val <- as.numeric(as.vector(t(daily_buy_table[category_idx,]))[-1]) * asso_tr[i,2]
  tmp <- rbind(tmp,category_val)
}
rownames(tmp) <- asso_tr$rules
indirect_buy_val <- apply(tmp,2,sum)
indirect_buy_idx_trenchcoat <- data.frame(mydates,indirect_buy_val)

##############  indirect_buy_idx_slingback
tmp <- c()
for(i in 1:nrow(asso_sb)){
  category_idx <- asso_sb[i,1] == daily_buy_table$x
  category_val <- as.numeric(as.vector(t(daily_buy_table[category_idx,]))[-1]) * asso_sb[i,2]
  tmp <- rbind(tmp,category_val)
}
rownames(tmp) <- asso_sb$rules
indirect_buy_val <- apply(tmp,2,sum)
indirect_buy_idx_slingback <- data.frame(mydates,indirect_buy_val)

##############  indirect_buy_idx_slipon
tmp <- c()
for(i in 1:nrow(asso_so)){
  category_idx <- asso_so[i,1] == daily_buy_table$x
  category_val <- as.numeric(as.vector(t(daily_buy_table[category_idx,]))[-1]) * asso_so[i,2]
  tmp <- rbind(tmp,category_val)
}
rownames(tmp) <- asso_so$rules
indirect_buy_val <- apply(tmp,2,sum)
indirect_buy_idx_slipon <- data.frame(mydates,indirect_buy_val)


############## indirect_buy_idx_roper
tmp <- c()
for(i in 1:nrow(asso_ro)){
  category_idx <- asso_ro[i,1] == daily_buy_table$x
  category_val <- as.numeric(as.vector(t(daily_buy_table[category_idx,]))[-1]) * asso_ro[i,2]
  tmp <- rbind(tmp,category_val)
}
rownames(tmp) <- asso_ro$rules
indirect_buy_val <- apply(tmp,2,sum)
indirect_buy_idx_roper <- data.frame(mydates,indirect_buy_val)

par(mfrow=c(1,3))
plot(indirect_buy_idx_cardigan$indirect_buy_val,type="l")
plot(indirect_buy_idx_trenchcoat$indirect_buy_val,type="l")
plot(indirect_buy_idx_slingback$indirect_buy_val,type="l")
plot(indirect_buy_idx_slipon$indirect_buy_val,type="l")
plot(indirect_buy_idx_roper$indirect_buy_val,type="l")












tmp

daily_buy_table[,2][asso_ca[1,1] == daily_buy_table$x]

colnames(daily_buy_table)
daily_buy_table$x

head(cvr)
str(cvr)



indirect_buy_idx_cadi <-  


###############################################


