# Lab 4: model complexity and 5-fold cross-validation for linear prediction.
source("R/00_setup.R")
d <- read_course("homes_synthetic.csv")
dev <- subset(d,split != "test"); test <- subset(d,split == "test")
# Here train+validation form an 80% DEVELOPMENT set; CV occurs entirely inside it.
# The same predefined 20% test set remains excluded from all selection.
forms <- list(area=price_k_eur~area_m2,
 additive=price_k_eur~area_m2+renovated+centre,
 interaction=price_k_eur~area_m2*centre+renovated,
 quadratic=price_k_eur~area_m2*centre+I(area_m2^2)+renovated)
set.seed(20261118)
fold <- sample(rep(1:5,length.out=nrow(dev)))
cv <- sapply(forms,function(form) {
  out <- rep(NA_real_,nrow(dev))
  for(k in 1:5) {
    fit <- lm(form,data=dev[fold!=k,])
    out[fold==k] <- predict(fit,newdata=dev[fold==k,])
  }
  rmse(dev$price_k_eur,out)
})
print(sort(cv)); selected <- names(which.min(cv))
final <- lm(forms[[selected]],data=dev)
p <- predict(final,test)
baseline <- rep(mean(dev$price_k_eur),nrow(test))
result <- data.frame(model=c(selected,"Mean baseline"),
 RMSE=c(rmse(test$price_k_eur,p),rmse(test$price_k_eur,baseline)),
 MAE=c(mae(test$price_k_eur,p),mae(test$price_k_eur,baseline)))
print(result);write.csv(result,"results/04_cv_test_metrics.csv",row.names=FALSE)
# Test R-squared can be negative; use test mean only in this evaluation denominator.
cat("Test R-squared:",1-sum((test$price_k_eur-p)^2)/sum((test$price_k_eur-mean(test$price_k_eur))^2),"\n")
# A separate small example matches the interactive complexity activity.
c <- read_course("complexity_example.csv");tr <- subset(c,split=="train");va <- subset(c,split=="validation")
for(degree in c(1,2,9)) {
  fit <- lm(y~poly(x,degree=degree,raw=TRUE),data=tr)
  print(c(degree=degree,training_RMSE=rmse(tr$y,predict(fit,tr)),
    validation_RMSE=rmse(va$y,predict(fit,va))))
}
# Scaling, imputation, feature selection and oversampling must be fitted INSIDE each
# training fold when used. This complete dataset requires no imputation or scaling.
