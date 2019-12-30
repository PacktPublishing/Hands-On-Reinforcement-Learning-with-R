W = 10
WeightArray = c(5,2,4,6)
ValueArray = c(18,9,12,25)
DataKnap<-data.frame(WeightArray,ValueArray)

BestValue = 0     
ItemsSelected = c()
TempWeights<-c()
TempValues<-c()

for(i in 1:4){
  CombWeights<-as.data.frame(combn(DataKnap[,1], i))
  CombValues<-as.data.frame(combn(DataKnap[,2], i))
  SumWeights<-colSums(CombWeights)
  SumValue<-colSums(CombValues)
  TempWeights<-which(SumWeights<=W)
    if(length(TempWeights) != 0){ 
      TempValues<-SumValue[TempWeights]
      BestValue<-max(TempValues)
      Index<-which((TempValues)==BestValue)
      MaxIndex<-TempWeights[Index]
      MaxVW<-CombWeights[, MaxIndex]
      j=1
      while (j<=i){
        ItemsSelected[j]<-which(DataKnap[,1]==MaxVW[j])
        j=j+1
      }
    }
  }
list(value=round(BestValue),elements=ItemsSelected)