library(TraMineR)
library(cluster)
library(dbscan)
library(clusterCrit)
library(ClusterR)
cafeData <- read.csv(file = "User_Sequence_Data.csv", header = TRUE)
#Print first 3 obsercations
head(cafeData,3)
#Dimension of data set (Im using 2000 observations here)
dim(cafeData)
#Create labels for the sequence object
cafeData.seq.labels <- c("BookShelf", "PS4", "Counter", "Side1", "Side2", "Business", "Corner")
#create a sequence object, the sequence appears from 2-31st column
cafeData.seq <- seqdef(cafeData, var = 2:31, labels = cafeData.seq.labels)
coffeecc <- seqsubm(cafeData.seq, method = "TRATE")


TrueLabels = as.integer(cafeData$Behaviour) #Extract the ground truth labels as integers

#Compute Optimal Matching, Lowest common prefix, Lowest Common Subsequence distance matrix
coffee.OM <- seqdist(cafeData.seq, method = "OM", sm = coffeecc)
coffee.LCP <- seqdist(cafeData.seq, method = "LCP")
coffee.LCS <- seqdist(cafeData.seq, method = "LCS")

clusterward <- agnes(coffee.OM, diss = TRUE, method = "ward")
cluster6.OM <- cutree(clusterward, k = 8) #cluster membership
cluster6.OM <- factor(cluster6.OM, labels = c("Behavior 1", "Behavior 2", "Behavior 3","Behavior 4","Behavior 5","Behavior 6", "Behavior 7"))
table(cluster6.OM)
write.table(cluster6.OM, file = "OM_Results_native.csv", sep = ",", col.names = NA)

seqfplot(cafeData.seq, group = cluster6.OM, pbarw = T) #Visualize which sequences created clusters
seqmtplot(cafeData.seq, group = cluster6.OM)
intCriteria(coffee.OM,as.integer(cluster6.OM),c("Silhouette","Calinski_Harabasz","Dunn"))
external_validation(TrueLabels, cluster6.OM, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.OM, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.OM, method = "adjusted_rand_index", summary_stats = FALSE)


#https://cran.r-project.org/web/packages/clusterCrit/vignettes/clusterCrit.pdf

clusterward.LCP <- agnes(coffee.LCP, diss = TRUE, method = "ward")
cluster6.LCP <- cutree(clusterward.LCP, k = 8) #cluster membership
cluster6.LCP <- factor(cluster6.LCP, labels = c("Behavior 1", "Behavior 2", "Behavior 3","Behavior 4","Behavior 5","Behavior 6", "Behavior 7"))
table(cluster6.LCP)
write.table(cluster6.LCP, file = "LCP_Results_native.csv", sep = ",", col.names = NA)
intCriteria(coffee.LCP,as.integer(cluster6.LCP),c("Silhouette","Calinski_Harabasz","Dunn"))
external_validation(TrueLabels, cluster6.LCP, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.LCP, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.LCP, method = "adjusted_rand_index", summary_stats = FALSE)

clusterward.LCS <- agnes(coffee.LCS, diss = TRUE, method = "ward")
cluster6.LCS <- cutree(clusterward.LCS, k = 8) #cluster membership
cluster6.LCS <- factor(cluster6.LCS, labels = c("Behavior 1", "Behavior 2", "Behavior 3","Behavior 4","Behavior 5","Behavior 6", "Behavior 7"))
tbleLCS <- table(cluster6.LCS)
write.table(cluster6.LCS, file = "LCS_Results_native.csv", sep = ",", col.names = NA)
intCriteria(coffee.LCS,as.integer(cluster6.LCS),c("Silhouette","Calinski_Harabasz","Dunn"))

external_validation(TrueLabels, cluster6.LCS, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.LCS, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, cluster6.LCS, method = "adjusted_rand_index", summary_stats = FALSE)


###########    K MEDOID    #######


K_Med.OM <- pam(coffee.OM, 8, diss = TRUE)
summary(K_Med.OM)
clusplot(coffee.OM,K_Med.OM$clustering, diss = TRUE, shade = TRUE)
write.table(K_Med.OM$clustering, file = "OM_Results_KMed.csv", sep = ",", col.names = NA)
intCriteria(coffee.OM,K_Med.OM$clustering,c("Silhouette","Calinski_Harabasz","Dunn"))

external_validation(TrueLabels, K_Med.OM$clustering, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.OM$clustering, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.OM$clustering, method = "adjusted_rand_index", summary_stats = FALSE)


K_Med.LCP <- pam(coffee.LCP, 8, diss = TRUE)
summary(K_Med.LCP)
#plot(K_Med.LCP)
clusplot(coffee.LCP,K_Med.LCP$clustering, diss = TRUE, shade = TRUE)
write.table(K_Med.LCP$clustering, file = "LCP_Results_KMed.csv", sep = ",", col.names = NA)
intCriteria(coffee.LCP,K_Med.LCP$clustering,c("Silhouette","Calinski_Harabasz","Dunn"))

external_validation(TrueLabels, K_Med.LCP$clustering, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.LCP$clustering, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.LCP$clustering, method = "adjusted_rand_index", summary_stats = FALSE)

K_Med.LCS <- pam(coffee.LCS, 8, diss = TRUE)
summary(K_Med.LCS)
#plot(K_Med.LCS)
clusplot(coffee.LCS,K_Med.LCS$clustering, diss = TRUE, shade = TRUE)
intCriteria(coffee.LCS,K_Med.LCS$clustering,c("Silhouette","Calinski_Harabasz","Dunn"))
write.table(K_Med.LCS$clustering, file = "LCS_Results_KMed.csv", sep = ",", col.names = NA)

external_validation(TrueLabels, K_Med.LCS$clustering, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.LCS$clustering, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, K_Med.LCS$clustering, method = "adjusted_rand_index", summary_stats = FALSE)


########      DB SCAN    #############




#plot(coffee.OM, col=DB$cluster)
dbscan::kNNdistplot(coffee.OM, k =  15)
abline(h = 240, lty = 2)
db.OM<-dbscan(coffee.OM, MinPts = 15,eps= 240 )
intCriteria(coffee.OM,as.integer(db.OM$cluster),c("Silhouette","Calinski_Harabasz","Dunn"))
write.table(db.OM$cluster, file = "OM_Results_DB.csv", sep = ",", col.names = NA)

external_validation(TrueLabels, db.OM$cluster, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, db.OM$cluster, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, db.OM$cluster, method = "adjusted_rand_index", summary_stats = FALSE)

dbscan::kNNdistplot(coffee.LCP, k =  15)
abline(h = 89, lty = 2)
db.LCP<-dbscan(coffee.LCP, MinPts = 15,eps= 89 )
write.table(db.LCP$cluster, file = "LCP_Results_DB.csv", sep = ",", col.names = NA)
intCriteria(coffee.LCP,as.integer(db.LCP$cluster),c("Silhouette","Calinski_Harabasz","Dunn"))
external_validation(TrueLabels, db.LCP$cluster, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, db.LCP$cluster, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, db.LCP$cluster, method = "adjusted_rand_index", summary_stats = FALSE)


dbscan::kNNdistplot(coffee.LCS, k =  15)
abline(h = 250, lty = 2)
db.LCS<-dbscan(coffee.LCS, MinPts = 15,eps= 250 )
intCriteria(coffee.LCS,as.integer(db.LCS$cluster),c("Silhouette","Calinski_Harabasz","Dunn"))

external_validation(TrueLabels, db.LCS$cluster, method = "purity", summary_stats = FALSE)
external_validation(TrueLabels, db.LCS$cluster, method = "entropy", summary_stats = FALSE)
external_validation(TrueLabels, db.LCS$cluster, method = "adjusted_rand_index", summary_stats = FALSE)

write.table(db.LCS$cluster, file = "LCS_Results_DB.csv", sep = ",", col.names = NA)

