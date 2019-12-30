library(MDPtoolbox)

P <- array(0, c(3,3,2))
P[,,1] <- matrix(c(0.2, 0.8, 0, 0.3,0,0.7,0.4,0,0.6), 3, 3, byrow=TRUE)
P[,,2] <- matrix(c(1, 0, 0, 1, 0, 0,1, 0, 0), 3, 3, byrow=TRUE)
R <- matrix(c(3, 1, 2, 2,1,3), 3, 2, byrow=TRUE)

mdp_check(P, R)

QLearnModel=mdp_Q_learning(P=P, R=R, discount = 0.95)

print(QLearnModel$Q)
print(QLearnModel$V)
print(QLearnModel$policy)
print(QLearnModel$mean_discrepancy)