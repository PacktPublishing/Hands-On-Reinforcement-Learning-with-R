HIT <- 1 
STICK <- 2
BJCard <- function()
  return(sample(10,1))

StateInput <- function () {
  return ( c(sample(10, 1), sample(10, 1), 0))
}
StepFunc <- function (s, a) {
  if(s[3]==1)
    return(list(s, 0))
  
  NewState <- s
  BJReward <- 0
  
  if(a==1) { 
    NewState[2] <- s[2] + BJCard() 
    if (NewState[2]>21 || NewState[2]<1) { 
      NewState[3] <- 1
      BJReward <- -1
    }
  } 
  else { 
    NewState[3] <- 1
    DealerWork <- FALSE
    DealerSum <- s[1]
    while(!DealerWork) { 
      DealerSum <- DealerSum + BJCard()
      if (DealerSum>21) { 
        DealerWork <- TRUE
        BJReward <- 1
      } else if (DealerSum >= 17) { 
        DealerWork <- TRUE
        if(DealerSum==s[2])
          BJReward <- 0
        else 
          BJReward <- 2*as.integer(DealerSum<s[2])-1
      }
    }
  }
  return(list(NewState, BJReward))
}


ActionsEpsValGreedy <- function(s, QFunc, EpsVal) {
  if(runif(1)<EpsVal)
    return(sample(1:2, 1))
  else
    return(which.max(QFunc[s[1],s[2],])) 
}

library("foreach")

MontecarloFunc <- function(NumEpisode){
  QFunc <- array(0, dim=c(10, 21, 2))
  N <- array(0, c(10,21,2))
  N0=100
  
  policy <- function(s) {
    ActionsEpsValGreedy(s, QFunc, N0/(sum(N[s[1], s[2],])+N0))
  }
  
  foreach(i=1:NumEpisode) %do% {
    s <- StateInput()
    SumReturns <- 0
    N.episode <- array(0, c(10,21,2))
    
    while(s[3]==0) {
      a <- policy(s)
      N.episode[s[1], s[2], a] <- N.episode[s[1], s[2], a] + 1
      StateReward <- StepFunc(s, a)
      s <- StateReward[[1]]
      SumReturns <- SumReturns + StateReward[[2]]
    }
    IndexValue <- which(N.episode!=0)
    N[IndexValue] <- (N[IndexValue]+N.episode[IndexValue])
    QFunc[IndexValue] <- QFunc[IndexValue] + (SumReturns- QFunc[IndexValue]) / N[IndexValue]
  }
  return(list(QFunc=QFunc, N=N))
}

MCModel <- MontecarloFunc(NumEpisode=100000)

StateValueFunc <- apply(MCModel$QFunc, MARGIN=c(1,2), FUN=max)
persp(StateValueFunc, x=1:10, y=1:21, theta=50, phi=35, d=1.9, expand=0.3, border=NULL, ticktype="detailed",
      shade=0.6, xlab="Dealer exposed card", ylab="Player sum", zlab="Value", nticks=10)