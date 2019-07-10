# regression 에선 모델을 비교하는 것은 간단하나
# classification 에선 ROC curve가 그 기준이 됨 / 분할표 생각!

install.packages("ROCR")
require('ROCR')

cls = c('P', 'P', 'N', 'P', 'P', 'P', 'N', 'N', 'P', 'N', 'P', 
        'N', 'P', 'N', 'N', 'N', 'P', 'N', 'P', 'N')
score = c(0.9, 0.8, 0.7, 0.6, 0.55, 0.54, 0.53, 0.52, 
          0.51, 0.505, 0.4, 0.39, 0.38, 0.37, 0.36, 
          0.35, 0.34, 0.33, 0.3, 0.1)


pred = prediction(score, cls)
roc = performance(pred, "tpr", "fpr")

plot(roc, lwd=2, colorize=TRUE)
lines(x=c(0, 1), y=c(0, 1), col="black", lwd=1)


auc = performance(pred, "auc")
auc = unlist(auc@y.values)
auc

acc = performance(pred, "acc")
acc 

ac.val = max(unlist(acc@y.values))
ac.val
th = unlist(acc@x.values)[unlist(acc@y.values) == ac.val]
th # cutoff value

plot(acc)
abline(v=th, col='grey', lty=2)





install.packages("ISLR")
library(ISLR)
attach(Default)
str(Default)

dim(Default)
set.seed(1234)
train=sample(1:10000,5000)
test=Default[-train,]
g=glm(default~student+income+balance,family=binomial(link=logit),subset=train)
summary(g)
score<-predict(g,newdata=Default,type="response")[-train]
cls<-Default[-train,1]

pred = prediction(score, cls)
roc = performance(pred, "tpr", "fpr")

plot(roc, lwd=2, colorize=TRUE)
lines(x=c(0, 1), y=c(0, 1), col="black", lwd=1)


auc = performance(pred, "auc")
auc = unlist(auc@y.values)
auc

acc = performance(pred, "acc")

ac.val = max(unlist(acc@y.values))
ac.val
th = unlist(acc@x.values)[unlist(acc@y.values) == ac.val]
th 

plot(acc)
abline(v=th, col='grey', lty=2)
