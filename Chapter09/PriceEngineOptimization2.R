library(bandit) 

set.seed(1)


UsersContacted1 <- c(10000, 9580, 10011, 10007)
Purchases1 <- c(571, 579, 563, 312)
Prices <- c(299, 306, 312, 335)

PostDistr1Month = sim_post(Purchases1,UsersContacted1, ndraws = 10000)

ProbWinner1 <- prob_winner(PostDistr1Month)
names(ProbWinner1) <- Prices

ProbWinner1

UsersContacted2 <- c(12350, 12001, 11950, 12500)
Purchases2 <- c(621, 625, 601, 520)

PostDistr2Month = sim_post(Purchases2,UsersContacted2, ndraws = 1000000)
ProbWinner2 <- prob_winner(PostDistr2Month)
names(ProbWinner2) <- Prices

ProbWinner2

UsersContacted3 <- c(14864, 14990, 14762, 10073)
Purchases3 <- c(803, 825, 791, 141)

PostDistr3Month <- sim_post(Purchases3,UsersContacted3, ndraws = 1000000)
ProbWinner3 <- prob_winner(PostDistr3Month)
names(ProbWinner3) <- Prices
ProbWinner3

significance_analysis(Purchases3,UsersContacted3)

ValueRemaining <- value_remaining(Purchases3,UsersContacted3)
PotentialValue <- quantile(ValueRemaining, 0.95)
PotentialValue
