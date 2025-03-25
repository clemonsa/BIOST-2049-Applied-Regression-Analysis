log_summary <- function(x, robust = FALSE, irr = FALSE){
  stopifnot("glm" %in% class(x), # input must be of class 'glm'
            is.logical(robust)) # robust argument must be logical
  
  waldChi2 <- function(x){
    # Get the coefficients of the non-intercept parameters 
    b <- matrix(coef(x)[2:length(coef(x))])
    # Get the covariance matrix of terms in b
    V <- vcov(x)[2:nrow(vcov(x)),2:nrow(vcov(x))]
    # Create the R matrix for the 3 linear hypothesis
    R <- matrix(0, nrow = nrow(b), ncol = nrow(b))
    # Only the diagonal in R needs to be filled in
    diag(R) <- 1
    # Create a vector of values Rb = r
    r <- 0
    # Calculate Wald statistics
    chi2 <- as.numeric(t((R%*%b - r)) %*% (solve(R %*% V %*% t(R))) %*% (R%*%b - r))
    
    return(chi2)
  }
  
  preds <- unlist(strsplit(as.character(x$formula[3]), # extract predictors used
                           split = "[[:space:]]\\+[[:space:]]"))
  LL <- stats::logLik(x) # log likelihood
  y <- as.character(x$formula[2]) # outcome variable
  tStat <- if(robust == FALSE){
    with(x, null.deviance - deviance) # LR chi-square test statistic
  }
  else(
    waldChi2(x) # Wald chi-square test statistic
  )
  McF <- signif(1 - stats::logLik(x)/stats::logLik(glm(as.formula(paste(y, "1", sep = "~")), # McFadden's Pseudo R^2
                                                       family = poisson(link = "log"), data = x$data)), digits = 4)
  AIC <- stats::AIC(x) # Akaike information criterion
  BIC <- stats::BIC(x) # Bayesian Information Criterion
  pval <- round(with(x, stats::pchisq(tStat, # p-value of model
                                      df.null - df.residual, lower.tail = FALSE)), digits = 4)
  Disp_P <- sum(residuals(x, type = "pearson")^2) / x$df.residual # Pearson Dispersion
  
  mod_stats <- merge(summary(x)$coefficients, confint.default(x),
                     by = "row.names", sort = FALSE) # model stats
  
  if(robust == TRUE){
    rse <- sqrt(diag(sandwich::vcovHC(x, type="HC0"))) # Robust Standard Error
    
    mod_stats <- subset(mod_stats,
                        select = -3) # drop 'Std. Error'
    
    # robust statistics
    mod_stats$`z value` <- round(coef(x) / rse, digits = 2)
    mod_stats$`Pr(>|z|)` <-  round(2 * stats::pnorm(abs(stats::coef(x)/rse), lower.tail=FALSE), 
                                   digits = 3)
    mod_stats$`2.5 %` <- stats::coef(x) - stats::qnorm(0.975, lower.tail = T) * rse
    mod_stats$`97.5 %` <- stats::coef(x) + stats::qnorm(0.975, lower.tail = T) * rse
    mod_stats$`Robust Std. Error` <- rse # add 'Robust Std. Error'
    mod_stats <- mod_stats[,c(1:2, ncol(mod_stats),3:(ncol(mod_stats)-1))] # reorder columns
  }
  
  if(irr == TRUE){
    mod_stats$Estimate <- exp(mod_stats$Estimate)
    mod_stats$`2.5 %` <- exp(mod_stats$`2.5 %`)
    mod_stats$`97.5 %` <- exp(mod_stats$`97.5 %`)
    # mod_stats$`Robust Std. Error` <- msm::deltamethod(list(~ exp(x1), ~ exp(x2), ~ exp(x3), ~ exp(x4)), coef(x),
    #                                sandwich::vcovHC(x, type="HC0"))
    
    names(mod_stats) <- c("Row.names", "IRR", "Delta Std. Error",
                          "z value", "Pr(>|z|)", "2.5 %", "97.5 %")
  }
  
  tbl <- data.frame(nrow = length(preds), ncol = 5) # data.frame
  
  output <- list(LL, y, tStat, McF, AIC, BIC, pval, Disp_P, tbl) # list of diagnostics
  names(output) <- c("log likelihood", "outcome", "chi2", "Pseudo R^2",
                     "AIC", "BIC", "Prob > chi2","(1/df) Pearson","results") # names for list
  
  output$results <- mod_stats
  
  return(output)
}

# To Do
## Fix Robust Std. Error using Delta Method when arg 'irr = TRUE'
## Fix Pseudo R^2 when using Poisson Regression model w/ offset