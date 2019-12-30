#C:\PythonScript\gym-http-api
#python gym_http_server.py

library(gym)

remote_base <- "http://127.0.0.1:5000"
client <- create_GymClient(remote_base)
print(client)

# Create environment
env_id <- "FrozenLake-v0"
instance_id <- env_create(client, env_id)
print(instance_id)

# List all environments
all_envs <- env_list_all(client)
print(all_envs)

# Set up agent
action_space_info <- env_action_space_info(client, instance_id)
print(action_space_info)

observation_space_info <- env_observation_space_info(client, instance_id)
print(observation_space_info)

action_size = action_space_info$n
state_size = observation_space_info$n

Qtable <- matrix(data = 0, nrow = state_size, ncol = action_size)

print(Qtable)


alpha = .80
gamma = .95
NumEpisodes = 200

RewardsList = list()
IndxList = 1
NumGoal=0
for (i in 1:NumEpisodes) {
  cat("######Episode ", i, " ######", "\n")
  state = env_reset(client, instance_id)
  SumReward = 0
  j = 0
  while (j < 99){
    j=j+1
    action = which.max(Qtable[state+1,] + runif(4,0, 1)*(1./(i+1)))
    action = action - 1
    
    Results<- env_step(client, instance_id, action, render = TRUE)
    NewState<-Results$observation
    ActualReward<-Results$reward
    
    Qtable[state+1, action+1] = (1 - alpha) * Qtable[state+1, action+1] + alpha * (ActualReward + gamma * max(Qtable[NewState+1,]))
    SumReward = SumReward + ActualReward
    state = NewState
    
    if (Results[["done"]]) {
      print("#####STEP######")
      print(j)
      cat("State achieved", NewState+1, "\n")
      cat("Reward", ActualReward, "\n")
      
      if (state==15) {
        NumGoal=NumGoal+1
        
      }
      break
    }
  }
  
  RewardsList[IndxList]<-SumReward
  IndxList = IndxList +1
}
cat("Numbers of goal achieved ", NumGoal, "\n")

print ("Score: ")
print(do.call(sum,RewardsList)/NumEpisodes)

print ("Final Q-Table Values")
print (Qtable)


for (episode in 1:5) {
  print("****************EPISODE**********************")
  print(episode)
  state = env_reset(client, instance_id)
  
  for (step in 1:100) { 
    TotRew = 0
    # Take the action (index) that have the maximum expected future reward given that state
    action = which.max(Qtable[state+1,])
    action = action - 1
    
    Results<- env_step(client, instance_id, action, render = TRUE)
    Newstate<-Results$observation
    reward<-Results$reward
    TotRew <- TotRew + reward
    
    
    if (Results[["done"]]) { 
      cat("Number of steps", step, "\n")
      print(TotRew)
      cat("STATO", Newstate, "\n")
      break
      
    }
    state = Newstate
    
  }
}
