#install.packages("flexclust")
library(flexclust)

healthy <- read.csv("healthy.csv",header = FALSE)
dim(healthy)
healthy.matrix <- as.matrix(healthy)
dim(healthy.matrix)
str(healthy.matrix)

image(healthy.matrix,axes = FALSE , col = grey(seq(0,1,length = 256)))

healthy.vector <-  as.vector(healthy.matrix)
str(healthy.vector)

# Need to comment out this since matrix size is huge 
#distance <- dist(healthy.vector,method = "euclidian")

k <- 5
set.seed(1)

KMC <- kmeans(healthy.vector,centers = k , iter.max = 1000)

str(KMC)

healthyClusters <- KMC$cluster
dim(healthyClusters) <- c(nrow(healthy.matrix),ncol(healthy.matrix))
image(healthyClusters,axes = FALSE, col = rainbow(k))


#----------
  

tumor <- read.csv("tumor.csv",header = FALSE)

tumor.matrix <- as.matrix(tumor)
tumor.vector <- as.vector(tumor.matrix)

KMC.kcca <- as.kcca(KMC,healthy.vector)
tumor.clusters <- predict(KMC.kcca,newdata = tumor.vector)
dim(tumor.clusters)  <-   as.matrix(c(nrow(tumor.matrix), ncol(tumor.matrix)))
image(tumor.clusters,axes = FALSE, col = rainbow(k) )

