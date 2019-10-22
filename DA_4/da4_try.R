dataset = read.csv('bike.csv')

library(caret)
library(caTools)
library(e1071)
dataset$Member.type = factor(dataset$Member.type, levels = c('Casual', 'Member'), labels = c(0, 1))
dataset$Bike.number = as.numeric(dataset$Bike.number)
split_data = sample.split(dataset, SplitRatio = 7/10)
train_set = subset(dataset, split_data == TRUE)
test_set = subset(dataset, split_data == FALSE)
train_set = train_set[, c(1, 8, 9)]
test_set = test_set[, c(1, 8, 9)]
classifier = naiveBayes(x = train_set[-3], y = train_set$Member.type)
predicted_data = predict(classifier, test_set[-3])

cf = confusionMatrix(predicted_data, test_set$Member.type)
cf