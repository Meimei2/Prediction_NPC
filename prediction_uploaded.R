##Using the random forest prediction model to predict subtype of Nasopharyngeal carcinoma
##File needed:1.TPM matrix with sample in columns and gene symbols in rows just like example.txt in provided data diretory;
##  2.path to the provided data directory;
##  3.install "mlbench" & "caret" R package previously.
##Usage:Rscript prediction.R matrix path/to/data
args=commandArgs(T)

args[1] <- "/disk/meimei/project/neoantigen/5.Public/Zhangli/data/example.txt"
args[2] <- "/disk/meimei/project/neoantigen/5.Public/Zhangli/data"

#install.packages("mlbench")
#install.packages("caret")
library(mlbench)
library(caret)
##laod the prediction model
print("1.loading necessary data...")
print("Loading model...")
load(file = paste0(args[2], "/rf_model.Rdata"))

##load the signature genes
#load the differential expressed genes
print("Loading signature genes...")
geneused <- read.table(file = paste0(args[2],"/geneused.txt"), sep = "\t", header= T, stringsAsFactors = F)

#load the TPM matrix
print("Loading tumor matrix...")
rawtpm <- read.table(file = args[1], sep = "\t",
                     header = T, row.names = 1, stringsAsFactors = F)

dim(rawtpm)
class(rawtpm)
rawtpm <- as.matrix(rawtpm)
rawtpm <- t(rawtpm)
rawtpm[1:5,1:5]

mytumor <- rawtpm[,na.omit(match(geneused$geneused, colnames(rawtpm)))]
dim(mytumor)
mytumor[1:5,1:5]

#prediction
print("2.Predicting...")
myClasses <- predict(myFit, newdata = rawtpm,type = 'prob')

head(myClasses)

prediction <- c()
for(i in c(1:nrow(myClasses))){
  #i=2
  if(max(myClasses[i,]) > 0.4){
    tmp <- names(which.max(myClasses[i,]))
  #print(max(myClasses[i,]))
  }else{
    tmp <- "NA"
  }
  prediction <- c(prediction, tmp)
}
prediction

myClasses$prediction <- prediction
head(myClasses)

#save the results
print("Saving results...")
write.table(myClasses, file = "prediction_results.txt", sep = "\t", quote = F)


