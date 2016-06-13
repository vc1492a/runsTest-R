# Copyright (c) 2016, Valentino Constantinou <vc@valentino.io>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#' runsTest
#' 
#' @description Examines model residuals for the presence of autocorrelation.
#'
#' @param model A linear regression model specified using base R lm.
#'
#' @return Prints the number of expected runs, number of actual runs, and whether autocorrelation is likely.
#' @export
#'
#' @examples
#' data(example)
#' linreg <- lm(H ~ P, data=example) 
#' runsTest(linreg)
#' 
runsTest <- function(model, plot) {
  n1 = sum(resid(model) > 0) # number of positive residuals
  n2 = sum(resid(model) < 0) # number of negative residuals
  u = ((2*n1*n2) / (n1+n2)) + 1 # expected number of runs
  print("expected runs")
  print(u)
  o2 = ((2*n1*n2)*(2*n1*n2-n1-n2)) / (((n1+n2)^2) * (n1+n2-1)) # variance of the expected runs
  o = sqrt(o2) # standard deviation of the expected runs
  resids = sign(resid(model)) # save the signs of residuals as a vector of values
  runs = 1 # at least one run in any vector of residuals
  for (i in 2:length(resids)) { # for every i compare with i - 1
    if (resids[i] > 0 && resids[i-1] < 0) {
      runs = runs + 1
    } 
    if (resids[i] < 0 && resids[i-1] > 0) {
      runs = runs + 1
    }
  }
  print("actual runs")
  print(runs)
  diff = u - runs
  if (abs(diff) > abs(2*o)) { # if the difference is twice the standard deviation
    print("autocorrelation is likely")
  }
  else {
    print("autocorrelation is not likely")
  }
  if (missing(plot)) {
    print('To plot, use plot=TRUE')
  }
  else {
    residlength = length(resid(model))
    p1 <- ggplot2::ggplot(model, ggplot2::aes(c(1:residlength), .resid)) + ggplot2::geom_point()
    p1 <- p1 + ggplot2::stat_smooth(method="loess") + ggplot2::geom_hline(yintercept=0, col="red", linetype="dashed")
    p1 <- p1 + ggplot2::xlab("Index") + ggplot2::ylab("Residuals")
    p1 <- p1 + ggplot2::ggtitle("Index vs Residuals Plot") + ggplot2::theme_bw()
    print(p1)
  }
}