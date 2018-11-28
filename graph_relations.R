# Install ggplot and ggplot2 and their dependencies
library(ggplot2)
# install.packages("ggplot2")
# Set working directory as default directory
setwd("~")

# Remove 'tbl_df', 'tbl', and removes missing values
str(googleplaystore)
googleplaystore <-as.data.frame(googleplaystore)
str(googleplaystore)
googlePS <- googleplaystore[complete.cases(googleplaystore),]
View(googlePS)

# Save cleaned data set
write.table(googlePS, file="googlePS", row.names=FALSE, sep=",")

xbar <- tapply(googlePS$Rating, googlePS$Category, mean)
s <- tapply(googlePS$Rating, googlePS$Category, sd)
bike.sub$normal.density <- ifelse(bike.sub$season == "Sp",
                                  dnorm(bike.sub$count, xbar["Sp"] , s["Sp"]),
                                  dnorm(bike.sub$count, xbar["Su"], s["Su"]))
ggplot(bike.sub, aes(x = count)) +
  geom_histogram(aes(y = ..density..),
                 # bins = sqrt(length(bike.sub$count)),
                 bins = 20,
                 fill = "grey", col = "black") +
  facet_grid(season ~ .) +
  geom_density(col = "red", lwd = 1) +
  geom_line(aes(y = normal.density), col = "blue", lwd = 1) +
  ggtitle("Histograms of Bike Rentals by Spring and Summer")
