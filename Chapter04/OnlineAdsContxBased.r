library(contextual)
horizon <- 500
simulations <- 1000
ProbClickContx <- matrix(c(0.1, 0.3, 0.7, 0.8, 0.4, 0.1),
                     nrow = 2, ncol = 3, byrow = TRUE)

bandit <- ContextualBinaryBandit$new(weights = ProbClickContx)

policy <- EpsilonGreedyPolicy$new(epsilon = 0.1)

agent <- Agent$new(policy,bandit)

simulator <- Simulator$new(agent, horizon, simulations, do_parallel = FALSE)

history <- simulator$run()

plot(history, type = "arms", legend_position = "bottomright")


