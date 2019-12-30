v <- c(18,9,12,25)
w <- c(5,2,4,6)
W <- 10

Tabweights<-c(0,w)
TabValues<-c(0,v)
n<-length(w)
TabMatrix<-matrix(NA,nrow =n+1,ncol = W+1)

TabMatrix[,]<-0

for (j in 2:W+1){
  for (i in 2:n+1){
      if (Tabweights[i] > j) {
        TabMatrix[i,j] = TabMatrix[i-1,j]
      }  
      else
      {
        TabMatrix[i,j]<-max(TabMatrix[i-1,j], TabValues[i] + TabMatrix[i-1,j-Tabweights[i]])
      }
  }
}

cat("The best value is",TabMatrix[i,j])

i = n+1 
w = W+1
ItemSelected = c()
while(i>1 & w>0)
  { 
  if(TabMatrix[i,w]!=TabMatrix[i-1,w])
    {
    ItemSelected<-c(ItemSelected,(i)-1)
    w = w - Tabweights[i]
    i = i - 1
   }
  else
  { 
    i = i - 1
  }
}

cat("The items selected are",ItemSelected)
