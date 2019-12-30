library(keras)

MnistData <- dataset_mnist()

str(MnistData)

Xtrain <- MnistData$train$x
Ytrain <- MnistData$train$y
Xtest <- MnistData$test$x
Ytest <- MnistData$test$y

table(Ytrain)
table(Ytest)

hist(Ytrain)
hist(Ytest)

dim(Xtrain)
dim(Xtest)

Xtrain <- array_reshape(Xtrain, c(nrow(Xtrain), 784))
Xtest <- array_reshape(Xtest, c(nrow(Xtest), 784))

dim(Xtrain)
dim(Xtest)

Xtrain <- Xtrain / 255
Xtest <- Xtest / 255


Ytrain <- to_categorical(Ytrain, 10)
Ytest <- to_categorical(Ytest, 10)


KerasMLPModel <- keras_model_sequential()
KerasMLPModel %>% 
  layer_dense(units = 256, activation = 'relu', input_shape = c(784)) %>% 
  layer_dropout(rate = 0.45) %>% 
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = 'softmax')

summary(KerasMLPModel)

KerasMLPModel %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  metrics = c('accuracy')
)


BatchSize <- 128
NumEpochs <- 50


ModelHistory <- KerasMLPModel %>% fit(
  Xtrain, Ytrain,
  batch_size = BatchSize,
  epochs = NumEpochs,
  verbose = 1,
  validation_split = 0.3
)

plot(ModelHistory)

ScoreValues <- KerasMLPModel %>% evaluate(
  Xtrain, Ytrain,
  verbose = 0
)

cat('Test loss:', ScoreValues[[1]], '\n')
cat('Test accuracy:', ScoreValues[[2]], '\n')