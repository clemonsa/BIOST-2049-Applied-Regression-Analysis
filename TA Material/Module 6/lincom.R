lincom <- function(x, linfct, exp = FALSE, ...){
  stopifnot("glm" %in% class(x), # input must be of class 'glm'
            is.logical(exp))  # robust argument must be logical
  
  linComb <- multcomp::glht(x, linfct, ...)
  linSummary <- summary(linComb)
  df <- setNames(data.frame(Estimate = linSummary$test$coefficients,
             sigma = linSummary$test$sigma,
             z = linSummary$test$tstat,
             pval= linSummary$test$pvalues),
           c("Estimate", "Std. Err", "z", "P>|z|"))
  Confint <- stats::confint(linSummary)$confint[,2:3]
  Confint <- matrix(Confint, ncol = 2)
  colnames(Confint) <- c("2.5 %", "97.5 %")
  df <- cbind(df, Confint)
  
  if(exp == TRUE){
    df <- apply(df[c(1, 5:6)], 2, exp)
  }
  return(df)
}