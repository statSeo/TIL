install.packages(c("KoNLP","dplyr","wordcloud","ggplot2","tm","class","stringr","rvest","tree","randomForest"))
library(KoNLP)
library(dplyr)
library(wordcloud)
library(ggplot2)
library(tm)
library(class)
library(stringr)
library(rvest)
library(tree)
library(randomForest)
useSejongDic()

setwd("C:/Users/CAU/Desktop/data")


## 데이터 불러오기 / 처리
aa <- read.csv(
  "C:/Users/CAU/Downloads/aa.csv"
  ,stringsAsFactors=FALSE
  ,fileEncoding="EUC-KR"
)

aa<-aa[-325,c(4,5,6,7)]

data2<-aa$민원내용

for(i in 1: length(data2)){
  data2_1<-data2[i]
  write.table(data2_1, paste0(i,"_data.txt"))
}

initRhino <- function(path)
{
  setwd(paste(path, "/RHINO", sep=""))
  if(!require(rJava)) {install.packages("rJava"); library(rJava)}
  .jinit()
  .jaddClassPath(paste(path, "/RHINO", sep=""))
  .jclassPath()
  RHINO <- .jnew("rhino/RHINO")
  .jcall(RHINO, returnSig = "V", "ExternInit")
  
  return(RHINO)
}

getMorph <- function(sentence, type){
  result <- .jcall(RHINO, returnSig = "S", "getMorph", sentence, type)
  Encoding(result) <- "UTF-8"
  resultVec <- unlist(strsplit(result, '\r\n'))
  return(resultVec)
}

path <- "C:/Users/CAU/Desktop/RHINO2.5.3/WORK"
RHINO <- initRhino(path)

setwd("C:/Users/CAU/Desktop/data")

nouns<-character(324)
for(i in 1:324){
  result <- readLines(paste0(i , "_data.txt"))   
  result_text <- paste(result[2:length(result)],collapse = ". ")
  text <- getMorph(result_text, "NNG")  
  text <- text[nchar(text)>=2]
  nouns[i] <- paste(text, collapse = ", ")
}


## 워드클라우드

total<-character()
for(i in 1:324){
  result <- readLines(paste0(i , "_data.txt"))   
  result_text <- paste(result[2:length(result)],collapse = ". ")
  text <- getMorph(result_text, "NNG")  
  text <- text[nchar(text)>=2]
  total <- c(text,total)
}

wordFreq <- sort(table(total), decreasing=TRUE)  #빈도 계산
pal <- brewer.pal(9, "YlGnBu")
pal <- brewer.pal(7, "Dark2")
pal <- brewer.pal(8, "Paired")

windowsFonts(malgun=windowsFont("맑은 고딕"))

set.seed(1000) 
wordcloud(words=names(wordFreq), freq=wordFreq, scale=c(10, 0.1), colors=pal, min.freq=4, random.order=F, family="malgun")

dim(wordFreq)
termFrequency<-as.matrix(wordFreq)[-c(1,50:3795),]
df <- data.frame(term=names(termFrequency), freq=termFrequency)
ggplot(df, aes(x=term, y=freq)) + geom_bar(stat="identity") +
  xlab("Terms") + ylab("Count") + coord_flip()

total_data<-as.data.frame(as.matrix(wordFreq))
word<-rownames(total_data)[1:3000]


## 데이터 처리

aa$ptext <-nouns
myCorpus_ <- Corpus(VectorSource(aa$ptext))
tdm <- TermDocumentMatrix(myCorpus_)    #, control=list( weighting=function(x) weightTfIdf(x,T))
mat.df <- as.data.frame(data.matrix(tdm))
dim(mat.df)
rownames(mat.df)
for(i in 1:3795){
  kor  <-  repair_encoding(rownames(mat.df)[i], from = 'utf-8')
  rownames(mat.df)[i] <- kor
}
rownames(mat.df)
mat.df<-t(mat.df)

mat.df2<-mat.df


mat.df2 <- mat.df[,colnames(mat.df) %in% word]
dim(mat.df2)


###### KNN Classification

set.seed(100)
train <- sample(nrow(mat.df1), ceiling(nrow(mat.df1) * .70))
test <- (1:nrow(mat.df1))[- train]

## 금융권역

mat.df1<-cbind(mat.df2, aa$금융권역)
colnames(mat.df1)[ncol(mat.df1)] <- "금융권역"

cl1 <- mat.df1[, "금융권역"]  
modeldata1 <- mat.df1[,!colnames(mat.df1) %in% "금융권역"]

# Create model: training set, test set, training set classifier
knn.pred1 <- knn(modeldata1[train, ], modeldata1[test, ], cl1[train])
# Confusion matrix
conf.mat1 <- table("Predictions" = knn.pred1, Actual = cl1[test])
conf.mat1
(accuracy <- sum(diag(conf.mat1))/length(test) * 100)



## 민원유형
mat.df1<-cbind(mat.df2,  aa$민원유형)
colnames(mat.df1)[ncol(mat.df1)] <- "민원유형"

cl1 <- mat.df1[, "민원유형"]
modeldata1 <- mat.df1[,!colnames(mat.df1) %in% "민원유형"]

# Create model: training set, test set, training set classifier
knn.pred1 <- knn(modeldata1[train, ], modeldata1[test, ], cl1[train])

# Confusion matrix
conf.mat1 <- table("Predictions" = knn.pred1, Actual = cl1[test])
conf.mat1
(accuracy <- sum(diag(conf.mat1))/length(test) * 100)


## 세부민원유형
mat.df1<-cbind(mat.df2, aa$세부민원유형)
colnames(mat.df1)[ncol(mat.df1)] <- "세부민원유형"

cl1 <- mat.df1[, "세부민원유형"]
modeldata1 <- mat.df1[,!colnames(mat.df1) %in% "세부민원유형"]

# Create model: training set, test set, training set classifier
knn.pred1 <- knn(modeldata1[train, ], modeldata1[test, ], cl1[train])

# Confusion matrix
conf.mat1 <- table("Predictions" = knn.pred1, Actual = cl1[test])
conf.mat1
(accuracy <- sum(diag(conf.mat1))/length(test) * 100)

#####  Classification Trees

# 금융권역
mat.df_1<-cbind(mat.df2, aa$금융권역)
colnames(mat.df_1)[ncol(mat.df_1)] <- "금융권역"
mat.df_1<-as.data.frame(mat.df_1)

set.seed(10)
dim(mat.df_1)
train=sample(1:nrow(mat.df_1), ceiling(324*0.7)) 
mat.df_1.test=mat.df_1[-train,]
tree_1=tree(금융권역~.,mat.df_1,subset=train)
summary(tree_1)
plot(tree_1)
text(tree_1,pretty=0)
tree_1

tree.pred=predict(tree_1,mat.df_1.test,type="class")
capital.test=mat.df_1$금융권역[-train]
(table_1<-table(tree.pred,capital.test))
sum(diag(table_1))/length(capital.test) *100 

cv1=cv.tree(tree_1,FUN=prune.misclass)
names(cv1)
cv1
par(mfrow=c(1,2))
plot(cv1$size,cv1$dev,type="b")
plot(cv1$k,cv1$dev,type="b")
prune1=prune.misclass(tree_1,best=5)
plot(prune1)
text(prune1,pretty=0)
tree.pred=predict(prune1,mat.df_1.test,type="class")
( table_1<-table(tree.pred,capital.test) )
sum(diag(table_1))/length(capital.test) *100 

# 민원유형

mat.df1<-cbind(mat.df2,  aa$민원유형)
colnames(mat.df1)[ncol(mat.df1)] <- "민원유형"

str(mat.df1)
mat.df_1<-as.data.frame(mat.df1)
tree_1<-tree(민원유형~.,data=mat.df_1)
summary(tree_1)
plot(tree_1)
text(tree_1,pretty=0)
tree_1

set.seed(10)
dim(mat.df_1)
train=sample(1:nrow(mat.df_1), ceiling(324*0.7))
mat.df_1.test=mat.df_1[-train,]
tree_1=tree(민원유형~.,mat.df_1,subset=train)

tree.pred=predict(tree_1,mat.df_1.test,type="class")
capital.test=mat.df_1$민원유형[-train]
(table_1<-table(tree.pred,capital.test))
sum(diag(table_1))/length(capital.test) *100 


#####  Random forest

# 금융권역
mat.df_1<-cbind(mat.df2, aa$금융권역)
colnames(mat.df_1)[ncol(mat.df_1)] <- "금융권역"
mat.df_1<-as.data.frame(mat.df_1)

set.seed(1)
dim(mat.df_1)
train=sample(1:nrow(mat.df_1), ceiling(324*0.7)) 
capital.test=mat.df_1$금융권역[-train]

rf=randomForest(금융권역~.,data=mat.df_1,subset=train,importance=TRUE) # 옵션 ntree=500
rf
yhat.rf = predict(rf,newdata=mat.df_1[-train,])
( table_1<-table(yhat.rf, capital.test) )
sum(diag(table_1))/length(capital.test) *100 
# importance(rf)
varImpPlot(rf)




# 민원유형

set.seed(1)
dim(mat.df_1)
train=sample(1:nrow(mat.df_1), ceiling(324*0.7)) 


mat.df_1<-cbind(mat.df2, aa$민원유형)
colnames(mat.df_1)[ncol(mat.df_1)] <- "민원유형"
mat.df_1<-as.data.frame(mat.df_1)

capital.test=mat.df_1$민원유형[-train]


rf=randomForest(민원유형~.,data=mat.df_1,subset=train,importance=TRUE) # 옵션 ntree=500
rf
yhat.rf = predict(rf,newdata=mat.df_1[-train,])
( table_1<-table(yhat.rf, capital.test) )
sum(diag(table_1))/length(capital.test) *100 
# importance(rf)
varImpPlot(rf)




