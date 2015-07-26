require(plyr) #Load up PLYR Library

##############SETUP DIRECTORYS AND FILES##############
uci_hard_dir <- "UCI\ HAR\ Dataset" 
LoadFeatureFile <- paste(uci_hard_dir, "/features.txt", sep = "") # load in features file to R
ActivityLabelsFile <- paste(uci_hard_dir, "/activity_labels.txt", sep = "") # Load in activity labels into R
xTrainFile <- paste(uci_hard_dir, "/train/X_train.txt", sep = "")
yTrainFile <- paste(uci_hard_dir, "/train/y_train.txt", sep = "")
SubjectTrainFile <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "")
xTestFile <- paste(uci_hard_dir, "/test/X_test.txt", sep = "")
yTestFile  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "")
SubTestFile<- paste(uci_hard_dir, "/test/subject_test.txt", sep = "")

# Now everything is located read into R varibles	
###############SETUP DATA##########################################
features <- read.table(LoadFeatureFile, colClasses = c("character"))#send features to R varible
activity_labels <- read.table(ActivityLabelsFile, col.names = c("ActivityId", "Activity")) # send activity labels to R varible
x_train <- read.table(xTrainFile)
y_train <- read.table(yTrainFile)
subject_train <- read.table(SubjectTrainFile)
x_test <- read.table(xTestFile)
y_test <- read.table(yTestFile)
subject_test <- read.table(SubTestFile)

################TRAINING SET MERGE##################
training_sensor_data <- cbind(cbind(x_train, subject_train), y_train)
test_sensor_data <- cbind(cbind(x_test, subject_test), y_test)
sensor_data <- rbind(training_sensor_data, test_sensor_data)
sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensor_data) <- sensor_labels

#################MEAN AND STD EVAL CALCULATION###############
sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]

##################CHANGE TO DESCRIPTIVE NAMES AND LABEL#################
sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]
names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE) # remove 
names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))

#################Stage 5 ###################################

# This is similar to start of code 
sensor_avg_by_act_sub = ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg_by_act_sub, file = "sensor_avg_by_act_sub.txt")
uci_hard_dir <- "UCI\ HAR\ Dataset"
LoadFeatureFile <- paste(uci_hard_dir, "/features.txt", sep = "")
ActivityLabelsFile <- paste(uci_hard_dir, "/activity_labels.txt", sep = "")
xTrainFile <- paste(uci_hard_dir, "/train/X_train.txt", sep = "")
yTrainFile <- paste(uci_hard_dir, "/train/y_train.txt", sep = "")
SubjectTrainFile <- paste(uci_hard_dir, "/train/subject_train.txt", sep = "")
xTestFile <- paste(uci_hard_dir, "/test/X_test.txt", sep = "")
yTestFile  <- paste(uci_hard_dir, "/test/y_test.txt", sep = "")
SubTestFile<- paste(uci_hard_dir, "/test/subject_test.txt", sep = "")
features <- read.table(LoadFeatureFile, colClasses = c("character"))
activity_labels <- read.table(ActivityLabelsFile, col.names = c("ActivityId", "Activity"))
x_train <- read.table(xTrainFile)
y_train <- read.table(yTrainFile)
subject_train <- read.table(SubjectTrainFile)
x_test <- read.table(xTestFile)
y_test <- read.table(yTestFile)
subject_test <- read.table(SubTestFile)

######################MERGE BOTH SETS###############################
training_sensor_data <- cbind(cbind(x_train, subject_train), y_train)
test_sensor_data <- cbind(cbind(x_test, subject_test), y_test)
sensor_data <- rbind(training_sensor_data, test_sensor_data)
sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensor_data) <- sensor_labels
sensor_data_mean_std <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]
sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "ActivityId", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]
names(sensor_data_mean_std) <- gsub('\\(|\\)',"",names(sensor_data_mean_std), perl = TRUE)
names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Acc',"Acceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Mag',"Magnitude",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.mean',".Mean",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_std))
names(sensor_data_mean_std) <- gsub('Freq$',"Frequency",names(sensor_data_mean_std))
#######################Final Output######################
sensor_avg_by_act_sub = ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg_by_act_sub, file = "sensor_avg_by_act_sub.txt,row.names=FALSE") # final output, note col.names=false requirement

