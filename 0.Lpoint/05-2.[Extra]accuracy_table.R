library(dplyr)

# accuracy dataframe 합치기 --------------------------------------------------
accuracy_all <- rbind.data.frame(accuracy_GARCH, accuracy_ARMAX, accuracy_ANN, accuracy_Ensemble)

accuracy_all %>%
  arrange(category_target) -> accuracy_all2

write.csv(accuracy_all2, file = "accuracy_all.csv", fileEncoding = "CP949")
