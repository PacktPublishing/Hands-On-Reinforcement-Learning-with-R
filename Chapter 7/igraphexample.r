library(igraph)

Graph1 <- graph(edges=c(1,2, 2,3, 3, 1, 4,2), n=4, directed=F)

class(Graph1) 

Graph1

plot(Graph1)

WeightsGraph1<- c(4,1,1,1)

E(Graph1)$weight <- WeightsGraph1

ShortDistance<- shortest_paths(Graph1, 1,4)
ShortDistance

d1<-mean_distance(Graph1)
d1