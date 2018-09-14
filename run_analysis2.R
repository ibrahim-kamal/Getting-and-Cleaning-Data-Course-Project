library(reshape2)
library(data.table)
library(dplyr)
# read train data
train_data <- fread('UCI HAR Dataset/train/X_train.txt')
# read test data
test_data <- fread('UCI HAR Dataset/test/X_test.txt')
# read train data label 
Ytrain_data <- fread('UCI HAR Dataset/train/y_train.txt')
# read test data label
Ytest_data <- fread('UCI HAR Dataset/test/y_test.txt')
# name label column in train data label 
colnames(Ytrain_data) <- "id_label"
# name label column in test data label
colnames(Ytest_data)  <- "id_label"
# make train data and test data by add label id 
train <- cbind(Ytrain_data,train_data)
test <- cbind(Ytest_data,test_data)
# add train data and test data in one variable
all_data <- rbind(train,test)
# read columns name
features <- fread('UCI HAR Dataset/features.txt')$V2
# add "id_label" to columns name to add this name to variable that called {all_data}
colname <- c("id_label",features)
colnames(all_data) <- colname
# print mean and sd to features 
print (sapply(all_data, mean))
print (sapply(all_data, sd))
# get label names and put all of one by id_label 
label_name <-fread('UCI HAR Dataset/activity_labels.txt')
names(label_name) <- c('id',"label_name")
labellist <- sapply(all_data$id_label, function(x){label_name[x,"label_name"]$label_name})
last_data <- cbind(all_data,labellist)
# write all info to file that name tidyData.txt
fwrite(last_data,"tidyData.txt")