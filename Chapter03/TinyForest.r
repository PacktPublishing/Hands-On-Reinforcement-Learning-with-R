library(MDPtoolbox)

data = mdp_example_forest()

print(data$P[,,1])
print(data$P[,,2])

print(data$R[,1])
print(data$R[,2])

mdp_check(data$P, data$R)


solver=mdp_policy_iteration(P=data$P, R=data$R, discount = 0.95)

print(solver$V)
print(solver$policy)
print(solver$iter)
print(solver$time)