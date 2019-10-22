bike=read.csv('bike.csv')

library(caTools)
library(e1071)
bike$Member.type=factor(bike$Member.type,levels = c('Member','Casual'),labels = c(1,0))
bike$Bike.number=as.numeric(bike$Bike.number)
set.seed(100)
split=sample.split(bike,SplitRatio=7/10)
train=subset(bike,split==TRUE)
test=subset(bike,split==FALSE)
train=train[,c(1,8,9)]
test=test[,c(1,8,9)]
classifier=naiveBayes(x=train[-3],y=train$Member.type)
a=predict(classifier,test[-3])

library(caret)
cf=confusionMatrix(a,test$Member.type)
cf