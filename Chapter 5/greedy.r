K = 10
w = c(5,2,4,6)
v = c(18,9,12,25)
DataKnap<-data.frame(w,v)

DataKnap$rows_idx <- row(DataKnap)
DataKnap <- DataKnap[DataKnap$w < K,]
DataKnap$VWRatio <- DataKnap$v/DataKnap$w
DescOrder <- order(DataKnap$VWRatio, decreasing = TRUE)
DataKnap <- DataKnap[DescOrder,]

KnapSol <- list(value = 0)
SumWeights <- 0
i <- 1

while (i<=nrow(DataKnap) & SumWeights + DataKnap$w[i]<=K){
    SumWeights <- SumWeights + DataKnap$w[i]
    KnapSol$value <- KnapSol$value + DataKnap$v[i]
    KnapSol$elements[i] <- DataKnap$row[i]
    i <- i + 1
} 

print(KnapSol)