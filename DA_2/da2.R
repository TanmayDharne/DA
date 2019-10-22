dataset = read.csv('dia.csv')
str(dataset)
summary(dataset)
lapply(dataset, class)

library(e1071)
library(caTools)
library(caret)
dataset$Outcome = factor(dataset$Outcome, levels = c(0, 1), labels = c(0, 1))
split_set = sample.split(dataset, SplitRatio = 2/3)
train_set = subset(dataset, split_set == TRUE)
test_set = subset(dataset, split_set == FALSE)
classifier = naiveBayes(x = train_set[-9], y = train_set$Outcome)
classifier
predicted_data = predict(classifier, newdata = test_set[-9])
predicted_data

cf = confusionMatrix(predicted_data, test_set$Outcome)

