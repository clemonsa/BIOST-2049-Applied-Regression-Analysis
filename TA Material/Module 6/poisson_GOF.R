poisson_GOF <- function(x, type = c("deviance","pearson")){
  if(missing(type)){
    type <- "deviance" # default arg 'type = "deviance"'
  }
  stopifnot("glm" %in% class(x), # input must be of class 'glm'
            class(type) == "character", # type arg must be 'character'
            type == "deviance" | type == "pearson")
  
  if(type == "deviance"){
    # Deviance based likelihood ratio test: $\chi^2_D$ 
    cat("Goodness-of-fit chi2 = ", x$deviance,
        paste0("\nProb > chi2(",x$df.residual,") = "), pchisq(x$deviance, df=x$df.residual, lower.tail = F))
  }
  if(type == "pearson"){
    # Pearson goodness of fit: $\chi^2_P$
    y <- as.character(x$formula[2]) # outcome variable
    y_j <- x$y
    e_ep_j <- predict(x, type = "response")
    cat("Goodness-of-fit chi2 = ", sum((y_j - e_ep_j)^2/e_ep_j),
        paste0("\nProb > chi2(",x$df.residual,") = "),
        pchisq(sum((y_j - e_ep_j)^2/e_ep_j), df=x$df.residual, lower.tail = F))
  }
}