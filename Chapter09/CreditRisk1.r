library(CreditMetrics)
set.seed(1)

RatingClasses <- c("AAA", "AA", "A", "BBB", "BB", "B", "CCC", "D")
TransitionMatrix <- matrix(c(90.710,	8.340,	0.710,	0.075,	0.095,	0.025,	0.022,	0.023,
                             0.710,	90.550,	7.810,	0.720,	0.060,	0.120,	0.020,	0.010,
                             0.092,	2.220,	91.250,	5.420,	0.720,	0.230,	0.011,	0.057,
                             0.020,	0.420,	5.890,	85.880,	5.290,	1.190,	1.140,	0.170,
                             0.036,	0.124,	0.670,	7.730,	80.590,	8.790,	1.010,	1.050,
                             0.011,	0.119,	0.230,	0.440,	6.510,	83.440,	4.060,	5.190,
                             0.220,	0.000,	0.230,	1.330,	2.360,	11.210,	64.830,	19.820,
                             0, 0, 0, 0, 0, 0, 0, 100
)/100, 8, 8, dimnames = list(RatingClasses, RatingClasses), byrow = TRUE)
TransitionMatrix

library(markovchain)

MCModel <- new("markovchain", transitionMatrix = TransitionMatrix, states=RatingClasses, byrow = TRUE, name="MarkovChainModel")
MCModel

MCModel@states

transitionProbability(MCModel,"AAA","AA")

#CREDIT SPREAD

LGD <- 0.40

CreditRiskSpread<-cm.cs(TransitionMatrix, LGD)
CreditRiskSpread


# reference value
Rating <- c("B", "BB", "CCC")
EAD <- c(4000, 10000, 500000)
Rindex <- 0.02

RefValue<-cm.ref(TransitionMatrix, LGD, EAD, Rindex, Rating)

RefValue$constVal
RefValue$constPV

absorbingStates(MCModel)