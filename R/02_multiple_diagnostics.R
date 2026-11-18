# Lab 2: multiple regression, dummy variables, interactions and diagnostics.
source("R/00_setup.R")
d <- read_course("homes_synthetic.csv")
# 0 is the reference category, 1 the comparison category.
d$renovated <- factor(d$renovated,levels=c(0,1),labels=c("No","Yes"))
d$centre <- factor(d$centre,levels=c(0,1),labels=c("Outside","Centre"))
train <- subset(d,split == "train")
fit_add <- lm(price_k_eur ~ area_m2 + renovated + centre, data=train)
fit_int <- lm(price_k_eur ~ area_m2 * centre + renovated, data=train)
print(summary(fit_add)); print(summary(fit_int)); print(confint(fit_int))
# The nested F comparison is an inferential comparison under classical assumptions.
print(anova(fit_add,fit_int))
new <- data.frame(area_m2=c(80,80),renovated=factor(c("No","No"),levels=levels(d$renovated)),
                  centre=factor(c("Outside","Centre"),levels=levels(d$centre)))
print(predict(fit_int,new,interval="prediction"))
pdf("results/02_diagnostics.pdf",width=9,height=8)
par(mfrow=c(2,2)); plot(fit_int); dev.off()
influence <- data.frame(id=train$id,residual=resid(fit_int),
  studentized=rstudent(fit_int),leverage=hatvalues(fit_int),Cook=cooks.distance(fit_int))
print(head(influence[order(influence$Cook,decreasing=TRUE),],5))
write.csv(influence,"results/02_influence.csv",row.names=FALSE)
# HC3 standard errors: no optional packages. This changes uncertainty, not coefficients.
X <- model.matrix(fit_int); bread <- solve(crossprod(X))
u <- resid(fit_int)/(1-hatvalues(fit_int))
V_HC3 <- bread %*% crossprod(X, X*as.numeric(u^2)) %*% bread
print(data.frame(estimate=coef(fit_int),SE_classical=coef(summary(fit_int))[,2],
  SE_HC3=sqrt(diag(V_HC3))))
# Large-sample Normal intervals; not exact small-sample robust t inference.
print(cbind(lower=coef(fit_int)-qnorm(.975)*sqrt(diag(V_HC3)),
            upper=coef(fit_int)+qnorm(.975)*sqrt(diag(V_HC3))))
# A log response changes interpretation. Exp(prediction) is not generally E(Y|X).
fit_log <- lm(log(price_k_eur) ~ log(area_m2) + renovated + centre,data=train)
print(summary(fit_log))
log_hat <- predict(fit_log,new)
smearing <- mean(exp(resid(fit_log))) # estimated using training residuals only
print(data.frame(exp_log_fit=exp(log_hat),smearing_mean=exp(log_hat)*smearing))
# Smearing assumes a suitable multiplicative-error model; a constant factor can fail
# when the distribution of log errors depends on predictors.
# Task: interpret the centre gap at 60 and 100 m2; do not infer causality.
