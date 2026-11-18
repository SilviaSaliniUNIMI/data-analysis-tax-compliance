# Run from the supervised folder, or: Rscript /path/to/supervised/R/run_all.R
args <- commandArgs(trailingOnly=FALSE)
script <- sub("^--file=", "", args[grepl("^--file=",args)])
if(length(script)) setwd(dirname(dirname(normalizePath(script[1]))))
if (!file.exists("data/study_hours.csv")) stop("Open supervised.Rproj first.")
for (file in c("01_ols_by_hand.R","02_multiple_diagnostics.R","03_logistic_regression.R",
              "04_validation_and_cv.R","05_tax_compliance_case.R","06_trees_optional.R")) {
 cat("\n--- ",file," ---\n",sep="")
 source(file.path("R",file),local=new.env(parent=globalenv()))
}
writeLines(capture.output(sessionInfo()),"results/sessionInfo.txt")
cat("Finished. Outputs are in results/.\n")
