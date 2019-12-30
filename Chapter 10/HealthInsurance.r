library(markovchain)

age<-seq(from = 30,  to = 50, by=1)
ProbA2U<-seq(0.0006,0.0060,length.out = 21)
ProbA2D<-seq(0.0005,0.0020,length.out = 21)
ProbA2A<-1-(ProbA2U+ProbA2D)
ProbU2A<-seq(0,0,length.out = 21)
ProbU2D<-seq(0.1219,0.1879,length.out = 21)
ProbU2U<-1-(ProbU2A+ProbU2D)
ProbD2A<-seq(0,0,length.out = 21)
ProbD2U<-seq(0,0,length.out = 21)
ProbD2D<-1-(ProbD2A+ProbD2U)
DecrementsTable<- data.frame(age,ProbA2A,ProbA2U,ProbA2D,ProbU2A,ProbU2U,ProbU2D,ProbD2A,ProbD2U,ProbD2D)

str(DecrementsTable)
summary(DecrementsTable)
head(DecrementsTable)

WorkesStates<-c("Active","Unable","Dead")

TransMatrix35<-matrix(as.numeric(DecrementsTable[DecrementsTable$age==35,2:10]),nrow = 3,ncol = 3, byrow = TRUE,
                      dimnames = list(WorkesStates, WorkesStates))

MCModel35<-new("markovchain", transitionMatrix = TransMatrix35, states = WorkesStates, name="MCModel35")

MCModel35

states(MCModel35)
dim(MCModel35)
str(MCModel35)
MCModel35@transitionMatrix
absorbingStates(MCModel35)

set.seed(5)

WorkerStatePred35<- rmarkovchain(n = 1000, object = MCModel35, t0 ="Active")
table(WorkerStatePred35)

TransMatrix50<-matrix(as.numeric(DecrementsTable[DecrementsTable$age==50,2:10]),nrow = 3,ncol = 3, byrow = TRUE,
                      dimnames = list(WorkesStates, WorkesStates))
MCModel50<-new("markovchain", transitionMatrix = TransMatrix50, states = WorkesStates, name="MCModel50")

WorkerStatePred50<- rmarkovchain(n = 1000, object = MCModel50, t0 ="Active")
table(WorkerStatePred50)

MCModelsList=list()
j=1
for(i in 30:50){
  TransMatrix<-matrix(as.numeric(DecrementsTable[DecrementsTable$age==i,2:10]),nrow = 3,ncol = 3, byrow = TRUE,
                           dimnames = list(WorkesStates, WorkesStates))
  
  MCModelsList[[j]]<-new("markovchain", transitionMatrix = TransMatrix, states = WorkesStates)
  j=j+1
}

MCList30to50<-new("markovchainList", markovchains = MCModelsList,name="MCList30to50")
  
StatesSequence<-rmarkovchain(n=10000, object=MCList30to50,t0="Active")
str(StatesSequence)
StatesOccurences<-table(StatesSequence$value)
ExpectedUnableOccurence<-StatesOccurences[3]/nrow(StatesSequence)
ExpectedUnableOccurence


