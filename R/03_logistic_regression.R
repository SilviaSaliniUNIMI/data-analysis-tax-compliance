# Lab 3: logistic regression, validation-selected threshold, untouched test set.
source("R/00_setup.R")
d <- read_course("deliveries_synthetic.csv")
train <- subset(d,split=="train"); valid <- subset(d,split=="validation")
test <- subset(d,split=="test")
fit <- glm(late ~ distance_km + peak, data=train, family=binomial(link="logit"))
stopifnot(fit$converged)
print(summary(fit))
b <- coef(fit); se <- sqrt(diag(vcov(fit)))
# Wald intervals: asymptotic; separation and small samples require extra care.
print(data.frame(log_odds=b,odds_ratio=exp(b),OR_lower=exp(b-1.96*se),OR_upper=exp(b+1.96*se)))
new <- data.frame(distance_km=c(10,10),peak=c(0,1))
print(data.frame(new,probability=predict(fit,new,type="response")))
p_valid <- predict(fit,valid,type="response")
candidates <- threshold_search(valid$late,p_valid,cost_fp=1,cost_fn=4)
threshold <- candidates$threshold[1]
print(head(candidates,8)); cat("Chosen threshold:",threshold,"\n")
# Freeze model and threshold before examining test outcomes. Do not retune below.
p_test <- predict(fit,test,type="response")
result <- class_metrics(test$late,p_test,threshold,cost_fp=1,cost_fn=4)
print(result)
# Baseline probability comes from TRAINING prevalence, never test prevalence.
base <- rep(mean(train$late),nrow(test))
print(class_metrics(test$late,base,threshold,cost_fp=1,cost_fn=4))
print(calibration_table(test$late,p_test))
write.csv(result,"results/03_logistic_metrics.csv",row.names=FALSE)
write.csv(data.frame(id=test$id,observed=test$late,probability=p_test,predicted=as.integer(p_test>=threshold)),
 "results/03_logistic_predictions.csv",row.names=FALSE)
pdf("results/03_roc_calibration.pdf",width=8,height=5)
plot_roc(test$late,p_test)
cal <- calibration_table(test$late,p_test)
plot(cal$mean_probability,cal$observed_rate,xlim=c(0,1),ylim=c(0,1),pch=19,
 xlab="Mean predicted probability",ylab="Observed late-delivery rate")
abline(0,1,lty=2);dev.off()
# Discuss false positives, false negatives, probability calibration and sample size.
