library("neuralnet")
library(MASS)

set.seed(5)
InputData = Boston
InputData = subset(InputData, select = -c(12) )

str(InputData)
summary(InputData)

MaxData <- apply(InputData, 2, max)
MinData <- apply(InputData, 2, min)
DataScaled <- scale(InputData,center = MinData, scale = MaxData - MinData)
summary(DataScaled)
boxplot(DataScaled)

IndexData = sample(1:nrow(InputData),round(0.70*nrow(InputData)))
TrainData <- as.data.frame(DataScaled[IndexData,])
TestData <- as.data.frame(DataScaled[-IndexData,])
n = names(InputData)
f = as.formula(paste("medv ~", 
                     paste(n[!n %in% "medv"], 
                           collapse = " + ")))

NetDataModel = neuralnet(f,data=TrainData,hidden=10,linear.output=T)

summary(NetDataModel)
plot(NetDataModel)

PredNetTest <- compute(NetDataModel,TestData[,1:12])
PredNetTestStart <- PredNetTest$net.result*(max(InputData$medv)-
                                                         min(InputData$medv))+min(InputData$medv)
TestStart <- as.data.frame((TestData$medv)*(max(InputData$medv)-
                                                min(InputData$medv))+min(InputData$medv))
MSENetData <- sum((TestStart -
                     PredNetTestStart)^2)/nrow(TestStart)
RegressionModel <- lm(medv~., data=InputData)
summary(RegressionModel)
TestDataComp <- InputData[-IndexData,]
PredictLm <- predict(RegressionModel,TestDataComp)
MSERegrData <- sum((PredictLm - TestDataComp$medv)^2)/nrow(TestDataComp)

cat("MSE for Neural Network Model =",MSENetData,"\n")
cat("MSE for Regression Model =",MSERegrData,"\n")