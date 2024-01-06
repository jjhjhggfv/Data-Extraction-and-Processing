# Load the dataset
data=read.csv("car_evaluation.csv")
print(data)

str(data)
summary(data)

# Replace missing values with appropriate methods, e.g., mean, median
data[data == "?"] <- NA
data <- na.omit(data)
print(data)

#Renaming Columns
  Give meaningful names to the columns.
```R
colnames(data) <- c("buying", "maint", "doors", "persons", "lug_boot", "safety", "class")
print(data)

#Dealing with Categorical Data
data$buying <- as.factor(data$buying)
data$maint <- as.factor(data$maint)
data$doors <- as.factor(data$doors)
data$persons <- as.factor(data$persons)
data$lug_boot <- as.factor(data$lug_boot)
data$safety <- as.factor(data$safety)
data$class <- as.factor(data$class)
print(data)

#Data Visualisation

#Bar Plot 
library(ggplot2)
ggplot(data, aes(x = class)) +
  geom_bar() +
  labs(title = "Car Class Distribution")

#Boxplot
ggplot(data, aes(x = class, y = buying)) +
  geom_boxplot() +
  labs(title = "Buying Attribute Box Plot by Class")


#Scatterplot
ggplot(data, aes(x = buying, y = safety)) +
  geom_point() +
  labs(title = "Scatter Plot: Buying vs. Safety")


#Pie Chart
library(plotly)

plot_ly(data, labels = ~doors, type = 'pie', ids = ~doors) %>%
  layout(title = "Doors Attribute Pie Chart")

#Data Transformation

#Normalization/Standardization
# Using the 'scale' function
data[,1:6]=lapply(data[,1:6],as.numeric)
data[, 1:6] <- scale(data[, 1:6])
print(data)


#Feature Engineering
# Example: Combine 'doors' and 'persons' to create a new feature
data$doors_persons <- paste(data$doors, data$persons, sep = "_")
print(data)


#Binning or Discretization

# Assuming 'buying' is a categorical column in your dataset
frequency_table <- table(data$buying)
print(frequency_table)
print(data)

#Aggregation
# Calculate the mean 'maint' cost for each 'buying' category
aggregate(data$maint, by = list(buying = data$buying), FUN = mean)
print(data)

#Dropping Unnecessary Columns
# Example: Remove the 'buying' and 'maint' columns
data=data[, c("buying", "maint")]
print(data)


#Data Reduction
#PCA
# Check and convert columns to numeric
data[, 1:6] <- sapply(data[, 1:6], as.numeric)

# Check for missing values and impute if necessary
data[is.na(data)] <- 0  # You can choose a different imputation method if needed

# Perform PCA on the numeric features
pca_result <- prcomp(data[, 1:6], scale. = TRUE)

# Summary of PCA results
summary(pca_result)

# Extract the principal components
pcs <- pca_result$x
print(data)

# You can choose to keep a certain number of principal components based on the explained variance
# For example, keeping the first two components
selected_pcs <- pcs[, 1:2]