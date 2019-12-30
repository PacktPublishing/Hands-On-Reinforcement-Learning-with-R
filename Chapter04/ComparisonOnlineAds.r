library(contextual)
horizon <- 500
simulations <- 1000
ProbClick <- c(0.8, 0.3, 0.1)
bandit <- BasicBernoulliBandit$new(weights = ProbClick)

agents <- list(Agent$new(OraclePolicy$new(), bandit),
               Agent$new(UCB1Policy$new(), bandit),
               Agent$new(ThompsonSamplingPolicy$new(1.0, 1.0), bandit),
               Agent$new(EpsilonGreedyPolicy$new(0.1), bandit),
               Agent$new(SoftmaxPolicy$new(tau = 0.1),bandit),
               Agent$new(Exp3Policy$new(0.1), bandit))

simulation <- Simulator$new(agents, horizon, simulations)
history <- simulation$run()

plot(history, type = "cumulative", regret = FALSE)