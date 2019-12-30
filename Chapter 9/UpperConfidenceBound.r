dataset = read.csv('ETFs.csv')

str(dataset)

summary(dataset)

boxplot(dataset)

DataSel<- as.data.frame(matrix(0, nrow = 150, ncol = 6),col.names = Names)
rowmax = apply(dataset, 1, max)
for (i in 1:150){
  for (j in 1:6){
    if (dataset[i,j] == rowmax[i]) 
      DataSel[i,j] <- 1
  }
}

NumObs = 150
NumArms = 6
ETFSelected = integer()
NumSelections = integer(NumArms)
RewSum = integer(NumArms)
TotRew = 0
for (n in 1:NumObs){
  ETF = 0
  MaxUpBound = 0
  for (i in 1:NumArms){
    if(NumSelections[i]> 0 ){
      AverageReward = RewSum[i]/NumSelections[i]
      DeltaI  = sqrt(3/2 * log(n)/NumSelections[i])
      UpBound = AverageReward + DeltaI 
    } else{
      UpBound  = 1e400
    }
    if(UpBound > MaxUpBound){
      MaxUpBound = UpBound
      ETF = i
    }
  }
  ETFSelected = append(ETFSelected, ETF)
  NumSelections[ETF] = NumSelections[ETF] + 1
  reward = DataSel[n, ETF]
  RewSum[ETF] = RewSum[ETF] + reward
  TotRew = TotRew + reward
}

hist(ETFSelected,
     col = 'blue',
     main = 'Histogram of ETFs selections',
     xlab = 'ETFs',
     ylab = 'Number of times each ETF was selected')