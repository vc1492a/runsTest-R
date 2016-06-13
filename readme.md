## runstest: a test for autocorrelation in residuals

An implementation of the runs test (Wald-Wolfowitz test) in R. Accepts a linear regression model as input and tests whether autocorrelation is present in the residuals, which is useful for time series models. The result of the test displays the expected runs, the actual number of runs, and whether autocorrelation is likely. To use, do something along the lines of the following: 

```r
library(runstest)
data(example)
linreg <- lm(H ~ P, data=example) 
runsTest(linreg)
# to show an index vs. residuals plot, use:
runsTest(linreg, plot=TRUE)
```

You must specify the function and a linear model first prior to applying the function. See *example/example.R* for more detailed information and instructions.  

### why this package is different
Previous R packages, such as *tseries* or *randtests* test for randomness by examining single vectors of data, first requiring users to extract the residuals from a model and then conduct the runs test. This package aims to remove that step, allowing the user to pass in fitted models directly without the need to first extract the residuals. 

### installation
Make sure you install R's *devtools* and have the necessary dependencies (different between OS X and Windows) prior to using *runstest*. Then, type the following into the R console:

```r
devtools::install_github("vc1492a/runstest-R")
```

### coming soon

I am working towards publishing this package on CRAN for easy downloading and updating. 