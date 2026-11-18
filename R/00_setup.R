# Shared helpers. Open supervised.Rproj before sourcing individual labs.
if (!file.exists("data/study_hours.csv")) {
  stop("Open supervised.Rproj, or set the working directory to the supervised folder.")
}
dir.create("results", showWarnings = FALSE)
options(stringsAsFactors = FALSE, digits = 5)
read_course <- function(name) read.csv(file.path("data", name))
rmse <- function(y, p) sqrt(mean((y - p)^2))
mae <- function(y, p) mean(abs(y - p))
logloss <- function(y, p) {
  p <- pmin(pmax(p, 1e-15), 1 - 1e-15)
  -mean(y * log(p) + (1 - y) * log1p(-p))
}
auc_rank <- function(y, p) {
  n1 <- sum(y == 1); n0 <- sum(y == 0)
  if (n1 == 0 || n0 == 0) return(NA_real_)
  (sum(rank(p, ties.method = "average")[y == 1]) - n1 * (n1 + 1)/2)/(n1*n0)
}
class_metrics <- function(y, p, threshold = .5, cost_fp = 1, cost_fn = 4) {
  stopifnot(all(y %in% c(0,1)), all(is.finite(p)), all(p >= 0 & p <= 1))
  positive <- p >= threshold
  tp <- sum(positive & y == 1); fp <- sum(positive & y == 0)
  fn <- sum(!positive & y == 1); tn <- sum(!positive & y == 0)
  div <- function(a,b) if (b == 0) NA_real_ else a/b
  data.frame(threshold, TP=tp, FP=fp, FN=fn, TN=tn,
    accuracy=(tp+tn)/length(y), recall=div(tp,tp+fn),
    specificity=div(tn,tn+fp), precision=div(tp,tp+fp),
    F1=div(2*tp,2*tp+fp+fn), cost=cost_fp*fp+cost_fn*fn,
    Brier=mean((y-p)^2), log_loss=logloss(y,p), AUC=auc_rank(y,p))
}
threshold_search <- function(y, p, cost_fp = 1, cost_fn = 4) {
  # Includes the all-negative rule; deterministic tie-break: smallest threshold.
  grid <- sort(unique(c(0, p, 1)))
  out <- do.call(rbind, lapply(grid, function(z) class_metrics(y,p,z,cost_fp,cost_fn)))
  out[order(out$cost, out$threshold), ]
}
plot_roc <- function(y,p, main="ROC curve") {
  grid <- c(Inf, sort(unique(p), decreasing=TRUE), -Inf)
  pts <- sapply(grid, function(z) {
    c(FPR=sum(p >= z & y == 0)/sum(y == 0), TPR=sum(p >= z & y == 1)/sum(y == 1))
  })
  plot(pts[1,], pts[2,], type="l", xlim=c(0,1), ylim=c(0,1),
    xlab="False-positive rate", ylab="Recall", col="#A34010", lwd=2, main=main)
  abline(0,1,lty=2,col="grey")
}
calibration_table <- function(y,p) {
  # Fixed probability intervals; show the number of observations in every bin.
  bin <- cut(p, breaks=seq(0,1,.2), include.lowest=TRUE)
  out <- lapply(levels(bin), function(b) {
    keep <- bin == b
    data.frame(bin=b,n=sum(keep),mean_probability=if(any(keep)) mean(p[keep]) else NA_real_,
      observed_rate=if(any(keep)) mean(y[keep]) else NA_real_)
  })
  do.call(rbind,out)
}
