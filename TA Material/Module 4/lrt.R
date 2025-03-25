lrt <- function(reduced, full){ # important to provide reduced model in correct argument
  calc <- stats::anova(reduced, full)
  LR_chi <- calc$Deviance[2] # Test Statistic
  DF <- calc$Df[2] # degree of freedom
  
  pval <- round(stats::pchisq(q = LR_chi, df = DF, lower.tail = F), digits = 4)
  
  cat(paste0("chi2(", DF,")=",signif(LR_chi, digits = 4),
             "\nProb > chi2 = ", pval))
  
  # result <- list(LR_chi, DF, pval)
  # names(result) <- c("LR chi2", "df", "Prob > chi2")
  # return(result)
}