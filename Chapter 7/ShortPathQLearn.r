N <- 1000
gamma <- 0.9
alpha <- 1
FinalState <- 6

RMatrix <- matrix(c(-1,50,1,-1,-1,-1,
                      -1,-1,-1,1,50,-1,
                      -1,-1,-1,1,-1,-1,
                      -1,-1,-1,-1,-1,100,
                      -1,-1,-1,50,-1,-1,
                      -1,-1,-1,-1,-1,100),nrow=6,byrow = TRUE)

print(RMatrix)

QMatrix <- matrix(rep(0,length(RMatrix)), nrow=nrow(RMatrix))

for (i in 1:N) {
  
  CurrentState <- sample(1:nrow(RMatrix), 1)
  
 repeat {
    
    AllNS <- which(RMatrix[CurrentState,] > -1)
    if (length(AllNS)==1)
      NextState <- AllNS
    else
      NextState <- sample(AllNS,1)
    
    QMatrix[CurrentState,NextState] <- QMatrix[CurrentState,NextState] + alpha*(RMatrix[CurrentState,NextState] + gamma*max(QMatrix[NextState, which(RMatrix[NextState,] > -1)]) - QMatrix[CurrentState,NextState])
    
    if (NextState == FinalState) break
    CurrentState <- NextState
  }
}

print(QMatrix)

RowMaxPos<-apply(QMatrix, 1, which.max)
ShPath <- list(1)
i=1
while (i!=6) {
 IndRow<- RowMaxPos[i]
 ShPath<-append(ShPath,IndRow)
 i= RowMaxPos[i]
}

print(ShPath)

