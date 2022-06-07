# This is the Data Science project from the students of University of Malaya
# The model below will be used to detect the level of obesity based on the input given by the users
# We would use Multinomial Logistic Regression as the model for this purpose

# The token for loading dataset will be constantly changed! Please copy the latest link from github before running the code.
url <- "https://raw.githubusercontent.com/ryoshi007/Obesetimator/main/src/obesity(cleaned).csv?token=GHSAT0AAAAAABSTADEYWCCWXT35NEHXMBOGYU7J4ZQ"
data <- read.csv(url)

# Do some data cleaning
library(dplyr)
data[1] <- NULL
data <- rename(data, "TypeOfObesity" = NObeyesdad)

# Check the structure of data
str(data)

# Convert some columns into factors
data$Gender <- as.factor(data$Gender)
data$family_history_with_overweight <- as.factor(data$family_history_with_overweight)
data$FAVC <- as.factor(data$FAVC)
data$FCVC <- as.factor(data$FCVC)
data$NCP <- as.factor(data$NCP)
data$CAEC <- as.factor(data$CAEC)
data$SMOKE <- as.factor(data$SMOKE)
data$CH2O <- as.factor(data$CH2O)
data$SCC <- as.factor(data$SCC)
data$FAF <- as.factor(data$FAF)
data$TUE <- as.factor(data$TUE)
data$CALC <- as.factor(data$CALC)
data$MTRANS <- as.factor(data$MTRANS)
data$TypeOfObesity <- as.factor(data$TypeOfObesity)
data$TypeOfObesity <- relevel(data$TypeOfObesity, ref="Insufficient_Weight")

# Check for missing values
apply(data, 2, function(x) any(is.na(x) | is.infinite(x)))

# Set ordinal level for type of obesity
data$TypeOfObesity <- as.ordered(data$TypeOfObesity)

# Summary of dataset
summary(data)

check <- filter(data, TypeOfObesity == "Obesity_Type_II")
nrow(check)

# Cross-tabulate the variables with results
xtabs(~ TypeOfObesity + Gender, data)
xtabs(~ TypeOfObesity + family_history_with_overweight, data)
xtabs(~ TypeOfObesity + FAVC, data)
xtabs(~ TypeOfObesity + CAEC, data)
xtabs(~ TypeOfObesity + SMOKE, data)
xtabs(~ TypeOfObesity + SCC, data)
xtabs(~ TypeOfObesity + CALC, data)
xtabs(~ TypeOfObesity + MTRANS, data)

# Splitting the data
library(caret)
index <- createDataPartition(data$TypeOfObesity, p = .70, list = FALSE)
train <- data[index,]
test <- data[-index,]

# Setting up the model
library(MASS)
model <- polr(TypeOfObesity~., train, Hess = TRUE)
summary(model)

# Setting up the model
library(nnet)
nnet_model <- multinom(TypeOfObesity~., train)

summary(nnet_model)
(ctable <- coef(summary(nnet_model)))
p <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2
(ctable <- cbind(ctable, "p value" = p))

# Confusion Matrix & Error for Training data
nnet_train_pred <- predict(nnet_model, train)
(nnet_tab_pred <- table(nnet_train_pred, train$TypeOfObesity))
1- sum(diag(nnet_tab_pred))/sum(nnet_tab_pred)

# Confusion Matrix & Error for Test data
nnet_test_pred <- predict(nnet_model, test)
nnet_tab_pred2 <- table(nnet_test_pred, test$TypeOfObesity)
1- sum(diag(nnet_tab_pred2))/sum(nnet_tab_pred2)

# Check prediction
check_pred <- predict(nnet_model, test[1:5,], type="prob")
print(check_pred)


# Calculate p-Value for checking confidential level of each variables and find the significant variables
z <- summary(nnet_model)$coefficients/summary(nnet_model)$standard.errors
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p

# Save the model to use it later for Shiny app
saveRDS(nnet_model, "prediction_model.rds")

# To read the model for Shiny app
model <- readRDS("prediction_model.rds")
