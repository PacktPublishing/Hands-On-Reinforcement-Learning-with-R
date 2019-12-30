# Recursion
FibRec <- function(n) {
  if (n<=2) 
    return(1)
  
  return (FibRec(n-1)+FibRec(n-2))
}

StartTime <- Sys.time()
paste("20th Fibonacci number is: ",FibRec(20))
EndTime <- Sys.time()

paste("Computational time using Recursion is: ",EndTime - StartTime)
