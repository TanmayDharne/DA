dataset = read.csv('iris.csv')
str(dataset)
lapply(dataset, class)
ncol(dataset)
summary(dataset)

mean(dataset$Sepal.Length)
max(dataset$Sepal.Length)
min(dataset$Sepal.Length)
sd(dataset$Sepal.Length)
var(dataset$Sepal.Length)
range(dataset$Sepal.Length)
sum(dataset$Sepal.Length)
quantile(dataset$Sepal.Length, 0.1)
quantile(dataset$Sepal.Length, c(0.1, 0.2, 0.3, 0.4, 0.5))

hist(dataset$Sepal.Length, border = "red", xlab = "Sepal Length", main = "Sepal Length Histogram")
hist(as.numeric(dataset$Species))

boxplot(dataset$Sepal.Length)
boxplot(dataset)$out