library(MDPtoolbox)

MoveUp=matrix(c(0.3, 0.7, 0, 0,
            0, 0.9, 0.1, 0,
            0, 0.1, 0.9, 0,
            0, 0, 0.7, 0.3),
          nrow=4,ncol=4,byrow=TRUE)

MoveDown=matrix(c( 1, 0, 0, 0,
               0.7, 0.2, 0.1, 0,
               0, 0.1, 0.2, 0.7,
               0, 0, 0, 1),
            nrow=4,ncol=4,byrow=TRUE)


MoveLeft=matrix(c( 0.9, 0.1, 0, 0,
               0.1, 0.9, 0, 0,
               0, 0.7, 0.2, 0.1,
               0, 0, 0.1, 0.9),
            nrow=4,ncol=4,byrow=TRUE)


MoveRight=matrix(c( 0.9, 0.1, 0, 0,
                0.1, 0.2, 0.7, 0,
                0, 0, 0.9, 0.1,
                0, 0, 0.1, 0.9),
             nrow=4,ncol=4,byrow=TRUE)


AllActions=list(up=MoveUp, down=MoveDown, left=MoveLeft, right=MoveRight)


AllRewards=matrix(c( -2, -2, -2, -2,
                  -2, -2, -2, -2,
                  -2, -2, -2, -2,
                  20, 20, 20, 20),
               nrow=4,ncol=4,byrow=TRUE)

mdp_check(AllActions, AllRewards)


GridModel=mdp_policy_iteration(P=AllActions, R=AllRewards, discount = 0.1)


GridModel$policy 
names(AllActions)[GridModel$policy] 

GridModel$V 

GridModel$iter

GridModel$time 