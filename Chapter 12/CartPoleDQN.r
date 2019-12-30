library(rlR)
CPEnv = makeGymEnv("CartPole-v0")
CPEnv

CPEnv$step(1)

CPAgent = initAgent("AgentDQN", CPEnv)
str(CPAgent)

CPAgent$learn(500L)  

CPAgent$plotPerf(F)

