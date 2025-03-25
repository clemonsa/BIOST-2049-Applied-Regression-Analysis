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