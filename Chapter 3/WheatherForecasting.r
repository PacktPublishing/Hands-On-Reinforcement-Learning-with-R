library(markovchain)

set.seed(1)
States <- c("Rainy","Cloudy","Sunny")
TransMat <- matrix(c(0.30,0.50,0.20,0.25,0.4,0.35,0.1,0.2,0.70),nrow = 3, byrow = TRUE,dimnames = list(States,States))

MarkovChainModel <- new("markovchain",transitionMatrix=TransMat, states=States, byrow = TRUE, name="MarkovChainModel") 
MarkovChainModel

states(MarkovChainModel)
dim(MarkovChainModel)

str(MarkovChainModel)
MarkovChainModel@transitionMatrix

library(diagram)

plot(MarkovChainModel,package="diagram")


transitionProbability(MarkovChainModel, "Sunny", "Rainy")


StartState<-c(0,0,1)

Pred3Days <- StartState * (MarkovChainModel ^ 3)
print (round(Pred3Days, 3))
Pred1Week <- StartState * (MarkovChainModel ^ 7)
print (round(Pred1Week, 3))

steadyStates(MarkovChainModel)

YearWeatherState <- rmarkovchain(n = 365, object = MarkovChainModel, t0 = "Sunny")
YearWeatherState[1:40]





