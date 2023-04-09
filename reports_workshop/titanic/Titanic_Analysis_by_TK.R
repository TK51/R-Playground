# Titanic Analysis
# by Taras K.
# 03/18/2023
# The original inspirational source is by Hilla Behar

# In this analysis the following questions were asked:
  
# - What is the relationship the features and a passenger’s chance of survival.
# - Prediction of survival for the entire ship.

Setting the environment
# The following packages are to be used for the current analysis

library(tidyverse)
library(ggplot2)
library(dplyr)
library(GGally)
library(rpart)  # decision tree model package
library(rpart.plot)  # decision tree visualization package
library(ggcorrplot)  # to understand the correlation matrix
library(randomForest)  # planting the trees needs some methodology...:)

getwd()
setwd("./reports_workshop/titanic")

list.files(path = "../input")
# Ioad the data
test <- read.csv('./test.csv',stringsAsFactors = FALSE)
train <- read.csv('./train.csv', stringsAsFactors = FALSE)
dim(test)  # check the test data frame dimenstions
dim(train) # check the train data frame dimenstions
# merging both datasets into a consolidated one
full <- bind_rows(train,test) # rbind doesn't work due to differt number of columns in train and test
dim(full)  # check the resulted data frame dimenstions
str(full)  # check the resulted data frame structure
# checking the missing data
paste("Here is missing value check:")  # that's added for some internal explanations
colSums(is.na(full))  # showing aggregated "n/a" values within each column
colSums(full == "")  # showing empty cells aggreaated values within each column

# cross-checking the empty records for Embarked
filter(full, full$Embarked == "")

# getting the digits of missing values
paste("= N/A in full dataset:")  # that's added for some internal explanations
table(is.na(full))  # showing aggregated "n/a" values within each column
Cleaning & transforming the data
# change the empty strings in Embarked to the first choice "C"
full$Embarked[full$Embarked == ""] = "C"
# see how many features can be transformed to factors
apply(full, 2, function(x) length(unique(x)))
# move the attributes Survived, Pclass, Sex, Embarked to be factors
cols <- as.factor(c("Survived", "Pclass", "Sex", "Embarked"))
for (i in cols){
  full[, i] <- as.factor(full[, i])
}

# Now let's look on the structure of the full data set
str(full)
# move the attributes Survived, Pclass, Sex, Embarked to be factors within train data set
cols <- as.factor(c("Survived", "Pclass", "Sex", "Embarked"))
for (i in cols){
  train[, i] <- as.factor(train[, i])
}

# Now let's look on the structure of the train data set
str(train)
Analyse the cleaned data
The data has been loaded & cleaned a little bit so far. Now, it’s time to look at the relationships between the different attributes within set.

# check the correlations within factored attributes, so to see if there's something useful
full_fctrs <- full[, c("Survived", "Pclass", "Sex", "Embarked")]
train_fctrs <- train[, c("Survived", "Pclass", "Sex", "Embarked")]

dim(full_fctrs)  # check if the re-shaping went well resulted in 4 columns only
dim(train_fctrs)
str(train_fctrs)
str(full_fctrs)
# visualizing the numbers available so to get the general picture of the case
ggplot(data = train_fctrs, aes(x = Survived, fill = Sex)) + geom_bar() +
  scale_y_continuous(limits = c(0, 600)) +              # making visual limits
  scale_fill_manual(values = c("#c979a0", "#79C9A2")) + # color code for sex categories
  labs(title = "Survived by Sex",                       # setting labels
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Survived", y = "Persons \n") +           # placing extra-line for better readability
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
# side-by-side comparison to make things more understandable - Survived by Sex
ggplot(data = train_fctrs, aes(x = Survived, fill = Sex)) + geom_bar(position = "dodge") + 
  scale_y_continuous(limits = c(0, 600)) +                # making visual limits
  scale_fill_manual(values = c("#c979a0", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Sex",                         # setting labels
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Survived", y = "Persons \n") + 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))

ggplot(data = train_fctrs, aes(x = Pclass, fill = Survived)) + geom_bar() +
  scale_y_continuous(limits = c(0, 600)) +                # making visual limits
  scale_fill_manual(values = c("#c979a0", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Class", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Class", y = "Persons \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
# side-by-side comparison to make things more understandable - Survived by Class
ggplot(data = train_fctrs, aes(x = Pclass, fill = Survived)) + geom_bar(position = "dodge") +
  scale_y_continuous(limits = c(0, 400)) +
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Class", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Class", y = "Persons \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
# create a train-limited dataset, so the data from train is only considered in calculations

LT = dim(train)[1]
MT = dim(test)[1]  # [1] stands for number of rows, [2] stands for number of columns within the data frame
LT  # train dataset limited - gives number of rows to be used for certain purposes, like limited calculations
MT  # test dataset limited - ...
## check the relationship between Sex and Survival:
ggplot(data = full[1:LT,],aes(x = Sex,fill = Survived)) + geom_bar() + # [1:LT] = look into train data, without N/As in test
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Sex", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Survived", y = "Persons \n")
# Survival as a function of Embarked:
ggplot(data = full[1:LT,], aes(x = Embarked, fill = Survived)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived Proportions by Embarked", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Embarked", y = "Frequency \n")
# get the numbers of Survived within Embarked classes, =1 - survived, =0 - didn't survive
t<-table(full[1:LT,]$Embarked,full[1:LT,]$Survived)
t
addmargins(table(full[1:LT,]$Embarked,full[1:LT,]$Survived))
# get the percentage of Survived within Embarked classes, =1 - survived, =0 - didn't survive
t<-table(full[1:LT,]$Embarked,full[1:LT,]$Survived)
for (i in 1:dim(t)[1]){
  t[i,]<-t[i,]/sum(t[i,])*100
}
t
# It looks like chances for survival were higher for those Embarked in 'C' (55% compared to 33% and 38%, row-wise).
# But it is a bit skewed, if to compare the number of victims and produce column-wise ratio calculations
# Survival as a function of Pclass:
ggplot(data = full[1:LT,],aes(x=Pclass,fill=Survived)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived Proportions by Passenger Class", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Pclass", y = "Frequency \n")
# It looks like you have a better chance to survive if you were in lower ticket class.
# check the of Embarked versus Pclass:
ggplot(data = full[1:LT,],aes(x=Embarked,fill=Survived))+geom_bar(position="fill")+facet_wrap(~Pclass) +
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived Proportions by Passenger Class vs Embarked Type", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Embarked", y = "Frequency \n")
# Now it's not so clear that there is a correlation between Embarked and Survival. 

# Survivial as a function of SibSp
ggplot(data = full[1:LT,],aes(x=SibSp,fill=Survived))+geom_bar()+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by SibSp", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n SibSp", y = "Persons \n")
# Survivial as a function of Parch
ggplot(data = full[1:LT,],aes(x=Parch,fill=Survived))+geom_bar()+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Parch", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Parch", y = "Persons \n")
# the dynamics of both attributes - SibSp and Parch - seem to be quite similar
# check the attribute of family size.

full$FamilySize <- full$SibSp + full$Parch +1;
full1<-full[1:LT,]
ggplot(data = full1[!is.na(full[1:LT,]$FamilySize),],aes(x=FamilySize,fill=Survived))+geom_histogram(binwidth =1,position="fill")+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Family Size Survival Specifics", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Family Members", y = "Frequency \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
# That shows that families with a family size bigger or equal to 2 but less than 6 have a more than 50% to survive, 
# in contrast to families with 1 member or more than 5 members.
# Survival as a function of age:

ggplot(data = full1[!(is.na(full[1:LT,]$Age)),],aes(x=Age,fill=Survived))+geom_histogram(binwidth =3)+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Age", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Age", y = "Persons \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
ggplot(data = full1[!is.na(full[1:LT,]$Age),],aes(x=Age,fill=Survived))+geom_histogram(binwidth = 3,position="fill")+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) + 
  labs(title = "Proportion of Survived by Age", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Age", y = "Frequency \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
# Children (under 15) and old people (80+) had a better chance to survive.
# check the correlation of Fare versus Survivial
ggplot(data = full[1:LT,],aes(x=Fare,fill=Survived))+geom_histogram(binwidth =20, position="fill")+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Fare", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Fare", y = "Persons \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
full$Fare[is.na(full$Fare)] <- mean(full$Fare,na.rm=T)
sum(is.na(full$Fare))
# seems like bigger fare gave better chance to survive
# check the missing values for Age
sum(is.na(full$Age))

# There are a lot of missing values in the Age attribute, put the mean instead of the missing values
full$Age[is.na(full$Age)] <- mean(full$Age,na.rm=T)
sum(is.na(full$Age))
# check the influence of a certain title of a passenger on the survival fact

full$Title <- gsub('(.*, )|(\\..*)', '', full$Name)
full$Title[full$Title == 'Mlle']<- 'Miss' 
full$Title[full$Title == 'Ms']<- 'Miss'
full$Title[full$Title == 'Mme']<- 'Mrs' 
full$Title[full$Title == 'Lady']<- 'Miss'
full$Title[full$Title == 'Dona']<- 'Miss'
officer<- c('Capt','Col','Don','Dr','Jonkheer','Major','Rev','Sir','the Countess')
full$Title[full$Title %in% officer]<-'Officer'

# convert Title into a factor
full$Title<- as.factor(full$Title)

# visualize the percentage of Survived vs Title
ggplot(data = full[1:LT,],aes(x=Title,fill=Survived))+geom_bar(position="fill")+
  scale_fill_manual(values = c("#a79da1", "#79C9A2")) +   # color code for sex categories
  labs(title = "Survived by Title", 
       subtitle = "The Titanic Case",
       caption = "Data from the Titanic dataset", 
       x = "\n Title", y = "Percentage \n")+ 
  theme(axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, hjust = 0.5, face = "bold"))
Prediction
At this time point, let's predict the chance of survival as a function of the other attributes. Let's keep just the correlated features: Pclass, Sex, Age, SibSp, Parch, Title and Fare.

The train dataset will be divided the train set into two sets: training set (train1) and test set (train2) to be able to estimate the error of the prediction.

# The train set with the important features 
train_im<- full[1:LT,c("Survived","Pclass","Sex","Age","Fare","SibSp","Parch","Title")]
ind<-sample(1:dim(train_im)[1],500) # Sample of 500 out of 891
train1<-train_im[ind,] # The train set of the model
train2<-train_im[-ind,] # The test set of the model
# run a logistic regression
model <- glm(Survived ~.,family=binomial(link='logit'),data=train1)
summary(model)
# It results as attributes SibSp, Parch and Fare are not statisticaly significant. 
# Let's look at the prediction of this model on the test set (train2):
pred.train <- predict(model,train2)
pred.train <- ifelse(pred.train > 0.5,1,0)

# Mean of the true prediction 
mean(pred.train==train2$Survived)
# make a summary table of the prediction model
t1<-table(pred.train,train2$Survived)
t1
# Presicion and recall of the model
presicion<- t1[1,1]/(sum(t1[1,]))
recall<- t1[1,1]/(sum(t1[,1]))
# get the precision and recall parameters
presicion
recall
# F1 score
F1<- 2*presicion*recall/(presicion+recall)
F1
# F1 score on the initial test resulted at 0.879. That's pretty good
# Let's run it on the test set:

test_im<-full[LT+1:1309,c("Pclass","Sex","Age","SibSp","Parch","Fare","Title")]

#  make at the prediction of this model on the test set:
pred.test <- predict(model,test_im)[1:418]
pred.test <- ifelse(pred.test > 0.5,1,0)

# put result into a data frame
res<- data.frame(test$PassengerId,pred.test)
names(res)<-c("PassengerId","Survived")

# put the prediction result into a .csv file
write.csv(res,file="prediction.csv",row.names = F)
Building a tree...
# plant a tree and visualize it
model_dt<- rpart(Survived ~.,data=train1, method="class")
rpart.plot(model_dt)
# make the prediction on the model
pred.train.dt <- predict(model_dt,train2,type = "class")
mean(pred.train.dt==train2$Survived)
t2<-table(pred.train.dt,train2$Survived)

presicion_dt<- t2[1,1]/(sum(t2[1,]))
recall_dt<- t2[1,1]/(sum(t2[,1]))

# get the precision and recall
presicion_dt
recall_dt
# get the F1 score
F1_dt<- 2*presicion_dt*recall_dt/(presicion_dt+recall_dt)
F1_dt
# run this model on the test set:
pred.test.dt <- predict(model_dt,test_im,type="class")[1:418]
res_dt<- data.frame(test$PassengerId,pred.test.dt)
names(res_dt)<-c("PassengerId","Survived")
write.csv(res_dt,file="prediction_dt.csv",row.names = F)
# make prediction on survival using a random forest
model_rf<-randomForest(Survived~.,data=train1)
# Let's look at the error
plot(model_rf)
# make the prediction on the model
pred.train.rf <- predict(model_rf,train2)
mean(pred.train.rf==train2$Survived)
t1<-table(pred.train.rf,train2$Survived)
presicion<- t1[1,1]/(sum(t1[1,]))
recall<- t1[1,1]/(sum(t1[,1]))
presicion
recall
F1<- 2*presicion*recall/(presicion+recall)
F1
# Let's run this model on the test set:
pred.test.rf <- predict(model_rf,test_im)[1:418]
res_rf<- data.frame(test$PassengerId,pred.test.rf)
names(res_rf)<-c("PassengerId","Survived")
write.csv(res_rf,file="submission_rf.csv",row.names = F)
Conclusion
The mean of the right predictions:
  
  decision tree method: 0.77837
random forest method: 0.77990
logistic regression model: 0.7488
