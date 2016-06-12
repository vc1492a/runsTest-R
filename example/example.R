# import the data
library(runstest)
data(example)

# a simple linear regression
linreg <- lm(H ~ P, data=example) 
summary(linreg)

# is autocorrelation present? check with Durbin-Watson and Runs Test
# with Durbin-Watson
d <- dwt(linreg)
d
# A Durbin-Watston test statistic of 2 indicates no autocorrelation is present in the model. 
# Since we observe a value of 0.62, we can conclude that the model exhibits autocorrelation 
# or that the model is misspecified (i.e. we are missing a variable). 

# with the runs test

runsTest(linreg)
# The Runs Test checks a randomness hypothesis for a two-valued data sequence.
# A "run" of a sequence is a maximal non-empty segment of the sequence consisting of adjacent equal elements.
# If the number of runs is significantly higher or lower than expected, the hypothesis of statistical 
# independence of the elements may be rejected. The result shows that autocorrelation is likely. 

# a plot of the residuals also shows that autocorrelation is likely
library(ggplot2)
indexResidPlot <- function(model) {
  p1<-ggplot(model, aes(c(1:25), .resid)) + geom_point()
  p1<-p1+stat_smooth(method="loess") + geom_hline(yintercept=0, col="red", linetype="dashed")
  p1<-p1+xlab("Index") + ylab("Residuals")
  p1<-p1+ggtitle("Index vs Residuals Plot") + theme_bw()
  
  return(list(rvfPlot=p1))
}

print(indexResidPlot(linreg))