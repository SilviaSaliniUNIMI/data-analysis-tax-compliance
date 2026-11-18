# Lab 5: fictional late-filing records; this is not a fraud detector.
source("R/00_setup.R")
d <- read_course("filing_synthetic.csv")
tr <- subset(d,split=="train");va <- subset(d,split=="validation");te <- subset(d,split=="test")
# All predictors are defined as available before the filing deadline.
# digital_channel is reserved for an illustrative performance comparison.
fit <- glm(late_filing~previous_late+complexity+support_used,data=tr,family=binomial())
print(summary(fit))
pv <- predict(fit,va,type="response")
cut <- threshold_search(va$late_filing,pv,cost_fp=1,cost_fn=4)$threshold[1]
pt <- predict(fit,te,type="response")
print(class_metrics(te$late_filing,pt,cut))
by_channel <- do.call(rbind,lapply(c(0,1),function(g) {
 keep <- te$digital_channel==g
 cbind(channel=g,n=sum(keep),positives=sum(te$late_filing[keep]),
   class_metrics(te$late_filing[keep],pt[keep],cut))
}))
print(by_channel);write.csv(by_channel,"results/05_channel_metrics.csv",row.names=FALSE)
# Questions: is late filing the target of interest? Which errors matter?
# What if outcomes were observed only for selected audited cases?
# Is a probability a justification for an automatic adverse decision? Explain.
# Group comparisons here are exploratory and uncertain, not proof of fairness.
# No personal data, real tax records, legal classifications, or policy effects are used.
