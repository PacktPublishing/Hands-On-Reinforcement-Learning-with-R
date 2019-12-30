# Recursion with Memoization

RecTable <- c(1, 1, rep(NA, 100))
FibMem <- function(x) {
  if(!is.na(RecTable[x])) return(RecTable[x])
  ans <- FibMem(x-2) + FibMem(x-1)
  RecTable[x] <<- ans
  ans
}

StartTime <- Sys.time()
paste("20th Fibonacci number is: ",FibMem(20))
EndTime <- Sys.time()

paste("Computational time using Memoization is: ",EndTime - StartTime)
