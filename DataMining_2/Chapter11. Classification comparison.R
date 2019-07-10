
library(ggplot2)
library(rpart)
library(rpart.plot)
library(gmodels)
library(e1071)
library(gridExtra)
data(iris)
summary(iris)
temp = as.data.frame(scale(iris[,1:4]))
temp$Species = iris$Species
summary(temp)

g1 = ggplot(temp,aes(x =Sepal.Length,y = Sepal.Width,color = Species)) + geom_point() + ggtitle("Sepal.Width vs Sepal.Length")
g2 = ggplot(temp,aes(x =Petal.Length,y = Petal.Width,color = Species)) + geom_point() + ggtitle("Petal.Width vs Petal.Length")
g3 = ggplot(temp,aes(x =Petal.Length,y = Sepal.Length,color = Species)) + geom_point() + ggtitle("Sepal.Length vs Petal.Length")
g4 = ggplot(temp,aes(x =Petal.Width,y = Sepal.Width,color = Species)) + geom_point()  + ggtitle("Sepal.Width vs Petal.Width")
grid.arrange(g1,g2,g3,g4,nrow = 2)

dim(iris)
smp_size =  100
set.seed(123)
train_ind = sample(seq_len(nrow(temp)), size = smp_size)
train = temp[train_ind, ]
test = temp[-train_ind, ]

## tree
model.tree = tree(Species ~ . ,data =train)
cv.treemethod =cv.tree(model.tree ,FUN=prune.misclass ) ## Fun can be deviance 
prune.carseats=prune.misclass(model.tree,best=3  )
preds.rpart = predict(prune.carseats,newdata = test,type = "class")
plot(prune.carseats)
text(prune.carseats)
CrossTable(test$Species,  preds.rpart, chisq = F,prop.r = F,prop.c = F,prop.t = F,prop.chisq = F)
paste0(((14+16+16)/nrow(test))*100,"%")

##KNN
library(class)
cl = train$Species
set.seed(1234)
preds.knn = knn(train[,1:4],test[,1:4],cl,k=3)
CrossTable(preds.knn,test$Species,chisq = F,prop.r = F,prop.c = F,prop.t = F,prop.chisq = F)
paste0( ((14+17+15)/nrow(test))*100 ,"%")

## svm 
model.svm = svm(Species ~ . ,data = train)
preds.svm = predict(model.svm,newdata = test)
CrossTable(preds.svm,test$Species,chisq = F,prop.r = F,prop.c = F,prop.t = F,prop.chisq = F)
paste0( ((14+16+15)/nrow(test))*100 ,"%")
plot(model.svm, data=train,Petal.Width ~ Petal.Length)

