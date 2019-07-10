# 1
# 2 
# 3 lift

install.packages("arules")
install.packages("arulesViz")
install.packages("munsell")
library(arules)
library(munsell)
library(arulesViz)

data("Groceries")
str(Groceries)
Groceries
inspect(Groceries)
inspect(Groceries[1:10])
?inspect
# inspect : display transaction 

### mine association rules
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))
rules

### visualize rules as a scatter plot (with jitter to reduce occlusion)
plot(rules, control=list(jitter=2))

### select and inspect rules with highest lift
rules_high_lift <- head(sort(rules, by="lift"), 3)
inspect(rules_high_lift)
# 

### plot selected rules as graph
plot(rules_high_lift, method="graph", control=list(type="items"))
