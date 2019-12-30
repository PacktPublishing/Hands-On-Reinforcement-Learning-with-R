#TIC TAC TOE GAME
library(tictactoe)

ttt(ttt_human(name="GIUSEPPE"), ttt_random())

player1<- ttt_ai()
player2<- ttt_ai()
SimulatedGame <- ttt_simulate(player1, player2, N = 100)

str(SimulatedGame)

prop.table(table(SimulatedGame))

player3<- ttt_ai()
player4<- ttt_ai()

TrainPlayer4 <- ttt_qlearn(player4, N = 500, verbose = FALSE)

SimulatedGameQLearn <- ttt_simulate(player3, player4, N = 100)

prop.table(table(SimulatedGameQLearn))