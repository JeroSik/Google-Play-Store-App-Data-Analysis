#######################################################
#             INITIAL FILE READ AND SETUP             #
#######################################################
# Install ggplot and ggplot2 and their dependencies
library(ggplot2)
# Set working directory as default directory
setwd("~")

# Remove 'tbl_df', 'tbl', and removes missing values
str(googlePlay)
googlePlay <-as.data.frame(googlePlay)
str(googlePlay)
googlePS <- googlePlay[complete.cases(googlePlay),]
View(googlePS)

# Save cleaned data set
write.table(googlePS, file="googlePS", row.names=FALSE, sep=",")

#######################################################
#                 Analysis Question 1                 #
#######################################################
# Side by side boxplot of data
ggplot(data = googlePlay, aes(x = Category, y = Rating)) +
  geom_boxplot() +
  stat_boxplot(geom = "errorbar") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3) +
  ggtitle("Side by Side Boxplots of Rating Between Categories")

# Histogram of data
xbar <- tapply(googlePlay$Rating, googlePlay$Category, mean)
s <- tapply(googlePlay$Rating, googlePlay$Category, sd)
googlePlay$normal.density <- apply(googlePlay, 1, function(x){
  dnorm(as.numeric(x["Rating"]),
        xbar[x["Category"]], s[x["Category"]])})
ggplot(googlePlay, aes(x = Rating)) +
  geom_histogram(aes(y = ..density..), 
                 # bins = sqrt(nrow(bike)) + 2,
                 bins = 20,
                 fill = "grey", col = "black") +
  facet_grid(Category ~ .) +
  geom_density(col = "red", lwd = 1) +
  geom_line(aes(y = normal.density), col = "blue", lwd = 1) +
  ggtitle("Histograms of Rating Between Categories")

# QQ Plot of data
googlePlay$intercept <- apply(googlePlay, 1, function(x){xbar[x["Category"]]})
googlePlay$slope <- apply(googlePlay, 1, function(x){s[x["Category"]]})
ggplot(googlePlay, aes(sample = Rating)) +
  stat_qq() +
  facet_grid(Category ~ .) +
  geom_abline(data = googlePlay, aes(intercept = intercept, slope = slope)) +
  ggtitle("QQ Plots of Rating Between Categories")

# Table containing the sample size, mean, and standard deviation for each category
tapply(googlePlay$Rating, googlePlay$Category, length)
tapply(googlePlay$Rating, googlePlay$Category, mean)
tapply(googlePlay$Rating, googlePlay$Category, sd)

# ANOVA significance test
fit <- aov(Rating ~ Category, data = googlePlay)
summary(fit)
TukeyHSD(fit, conf.level = 0.95)

#######################################################
#                 Analysis Question 2                 #
#######################################################
# Side by side boxplot of data
ggplot(data = googlePlay, aes(x = Content.Rating, y = Rating)) +
  geom_boxplot() +
  stat_boxplot(geom = "errorbar") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3) +
  ggtitle("Side by Side Boxplots of Rating Among Restricted and Non-Restricted")

# Histogram of data
xbar <- tapply(googlePlay$Rating, googlePlay$Content.Rating, mean)
s <- tapply(googlePlay$Rating, googlePlay$Content.Rating, sd)
googlePlay$normal.density <- apply(googlePlay, 1, function(x){
  dnorm(as.numeric(x["Rating"]),
        xbar[x["Content Rating"]], s[x["Content Rating"]])})
ggplot(googlePlay, aes(x = Rating)) +
  geom_histogram(aes(y = ..density..), 
                 # bins = sqrt(nrow(bike)) + 2,
                 bins = 20,
                 fill = "grey", col = "black") +
  facet_grid(Content.Rating ~ .) +
  geom_density(col = "red", lwd = 1) +
  geom_line(aes(y = normal.density), col = "blue", lwd = 1) +
  ggtitle("Histograms of Rating Among Restricted and Non-Restricted")

# QQ Plot of data
googlePlay$intercept <- apply(googlePlay, 1, function(x){xbar[x["Content Rating"]]})
googlePlay$slope <- apply(googlePlay, 1, function(x){s[x["Content Rating"]]})
ggplot(googlePlay, aes(sample = Rating)) +
  stat_qq() +
  facet_grid(Content.Rating ~ .) +
  geom_abline(data = googlePlay, aes(intercept = intercept, slope = slope)) +
  ggtitle("QQ Plots of Rating Among Restricted and Non-Restricted")

# t-Test
t.test(googlePlay$Rating ~ googlePlay$Content.Rating, mu = 0, conf.level = 0.95,
       paired = FALSE, alternative = "two.sided", var.equal = FALSE)

#######################################################
#                 Analysis Question 3                 #
#######################################################
# Side by side boxplot of data
ggplot(data = googlePlay, aes(x = Type, y = Rating)) +
  geom_boxplot() +
  stat_boxplot(geom = "errorbar") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3) +
  ggtitle("Side by Side Boxplots of Rating Among Free and Paid")

# Histogram of data
xbar <- tapply(googlePlay$Rating, googlePlay$Type, mean)
s <- tapply(googlePlay$Rating, googlePlay$Type, sd)
googlePlay$normal.density <- apply(googlePlay, 1, function(x){
  dnorm(as.numeric(x["Rating"]),
        xbar[x["Type"]], s[x["Type"]])})
ggplot(googlePlay, aes(x = Rating)) +
  geom_histogram(aes(y = ..density..), 
                 # bins = sqrt(nrow(bike)) + 2,
                 bins = 20,
                 fill = "grey", col = "black") +
  facet_grid(Type ~ .) +
  geom_density(col = "red", lwd = 1) +
  geom_line(aes(y = normal.density), col = "blue", lwd = 1) +
  ggtitle("Histograms of Rating Among Free and Paid")

# QQ Plot of data
googlePlay$intercept <- apply(googlePlay, 1, function(x){xbar[x["Type"]]})
googlePlay$slope <- apply(googlePlay, 1, function(x){s[x["Type"]]})
ggplot(googlePlay, aes(sample = Rating)) +
  stat_qq() +
  facet_grid(Type ~ .) +
  geom_abline(data = googlePlay, aes(intercept = intercept, slope = slope)) +
  ggtitle("QQ Plots of Rating Among Free and Paid")

# t-Test
t.test(googlePlay$Rating ~ googlePlay$Type, mu = 0, conf.level = 0.95,
       paired = FALSE, alternative = "two.sided", var.equal = FALSE)