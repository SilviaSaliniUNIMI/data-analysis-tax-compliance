# Lab 1: five observations, OLS, inference and prediction intervals.
source("R/00_setup.R")
d <- read_course("study_hours.csv")
x <- d$hours; y <- d$score
b1 <- sum((x-mean(x))*(y-mean(y))) / sum((x-mean(x))^2)
b0 <- mean(y)-b1*mean(x)
fit <- lm(score ~ hours, data=d)
stopifnot(isTRUE(all.equal(unname(coef(fit)),c(b0,b1))))
print(c(intercept=b0,slope=b1))
d$fitted <- fitted(fit); d$residual <- resid(fit)
print(d)
SSE <- sum(resid(fit)^2); SST <- sum((y-mean(y))^2)
print(c(SSE=SSE,SST=SST,R2=1-SSE/SST,SER=sqrt(SSE/(nrow(d)-2))))
print(summary(fit)); print(confint(fit)); print(anova(fit))
# Exact t/F intervals require the classical independent Normal, constant-variance model.
# Five fictional observations illustrate arithmetic, not reliable empirical evidence.
new <- data.frame(hours=c(4,5,8))
print(predict(fit,new,interval="confidence"))
print(predict(fit,new,interval="prediction"))
# 8 hours lies beyond the observed 2--6 hour range: discuss extrapolation.
pdf("results/01_ols.pdf",width=8,height=5)
plot(x,y,pch=19,col="#A34010",xlab="Study hours",ylab="Score")
abline(fit,col="#123452",lwd=2)
segments(x,y,x,fitted(fit),lty=2)
dev.off()
write.csv(d,"results/01_residuals.csv",row.names=FALSE)
# Questions: why do residuals sum to zero? Why is a prediction interval wider?
