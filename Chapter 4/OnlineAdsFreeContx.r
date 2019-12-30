library(contextual)
horizon <- 500
simulations <- 1000
ProbClick <- c(0.1, 0.3, 0.7)

bandit <- BasicBernoulliBandit$new(weights = ProbClick)

policy <- EpsilonFirstPolicy$new(time_steps = 100)

agent <- Agent$new(policy, bandit)


simulator <- Simulator$new(agent, horizon, simulations, do_parallel = FALSE)

history <- simulator$run()

plot(history, type = "average", regret = FALSE, lwd = 2, legend_position = "bottomright")

plot(history, type = "cumulative", regret = FALSE, rate = TRUE, lwd = 2)

plot(history, type = "arms")



