lroc <- function(response, predictor, ...){
  roc_result <- pROC::roc(response, predictor, ...)
  
  se <- function(x, ...) sqrt(stats::var(x, ...)/length(x))
  
  cat("number of observations = ",
      length(c(roc_result$cases, roc_result$controls)),
      "\narea under ROC curve = ", signif(roc_result$auc, digits = 4),
      "\n95% C.I. = ", pROC::ci(roc_result, method = "delong")[-2])
  
  pROC::plot.roc(roc_result, print.auc = T, show.thres = T)
}

## Requires the pROC package

## See help(roc, "pROC") to understand how to use