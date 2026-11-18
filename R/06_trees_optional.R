# Optional extension: compare logistic regression with a shallow classification tree.
source("R/00_setup.R")
if (!requireNamespace("rpart",quietly=TRUE)) {
  message("Optional lab skipped: install.packages('rpart') if you want to run it.")
} else {
 d <- read_course("deliveries_synthetic.csv")
 d$late_class <- factor(d$late,levels=c(0,1))
 tr <- subset(d,split=="train");va <- subset(d,split=="validation");te <- subset(d,split=="test")
 logistic <- glm(late~distance_km+peak,data=tr,family=binomial())
 cp_grid <- c(.001,.01,.03,.08)
 trees <- lapply(cp_grid,function(cp) rpart::rpart(late_class~distance_km+peak,data=tr,
  method="class",control=rpart::rpart.control(cp=cp,maxdepth=3,minsplit=25,xval=0)))
 loss <- sapply(trees,function(m) logloss(va$late,predict(m,va,type="prob")[,"1"]))
 best <- which.min(loss)
 validation <- c(logistic=logloss(va$late,predict(logistic,va,type="response")),tree=loss[best])
 print(data.frame(cp=cp_grid,validation_log_loss=loss));print(validation)
 chosen <- names(which.min(validation))
 # Select model with validation data, then report one final test evaluation.
 p <- if(chosen=="logistic") predict(logistic,te,type="response") else predict(trees[[best]],te,type="prob")[,"1"]
 print(c(model=chosen,test_log_loss=logloss(te$late,p),test_AUC=auc_rank(te$late,p)))
 pdf("results/06_tree.pdf",width=9,height=6)
 tree <- trees[[best]]
 if(nrow(tree$frame)>1) {plot(tree,uniform=TRUE,margin=.1);text(tree,use.n=TRUE,cex=.9)} else {
  plot.new();text(.5,.5,"Selected tree has no split")
 }
 dev.off()
}
