library(contextual)
horizon <- 500
simulations <- 1000
ProbClick <- c(0.1, 0.3, 0.7)

bandit <- BasicBernoulliBandit$new(weights = ProbClick)

policy <- EpsilonGreedyPolicy$new(epsilon = 0.1)

agent <- Agent$new(policy,bandit)

simulator <- Simulator$new(agent, horizon, simulations, do_parallel = FALSE)

history <- simulator$run()


plot(history, type = "average", regret = TRUE, lwd = 2, legend_position = "topright")

plot(history, type = "cumulative", regret = TRUE, rate = TRUE, lwd = 2,legend_position = "topright")

plot(history, type = "arms", legend_position = "topright")