# Supervised learning and regression

Data Analysis and Tax Compliance · Human Centered Artificial Intelligence · University of Milan · Silvia Salini · 2026/2027.

Open `index.html` for the block hub. Each numbered e-tivity is an independent HTML file with embedded CSS, JavaScript and widget data; no internet is needed for the activity itself. Resource links require the accompanying folders. Written responses remain in browser storage when available, with text export; they are never submitted automatically.

## Contents

| Path | Content |
|---|---|
| 01-supervised-learning.html | 10 sections, 8 formative questions, model-complexity exploration |
| 02-linear-regression.html | 11 sections, 8 formative questions, OLS, influence and interaction explorers |
| 03-logistic-regression.html | 11 sections, 7 formative questions, probability and threshold explorers |
| slides/ | Three PDF decks: 23, 39 and 31 slides |
| tex/ | Editable Beamer sources, vector figures and PDF copies |
| R/ | Six teaching labs, shared helpers and run-all script |
| data/ | Six CSV datasets, dictionary and reference calculations |

## R instructions

1. Extract the complete block or the labs zip. Keep `R/`, `data/` and `supervised.Rproj` together.
2. Open `supervised.Rproj` in RStudio. If using R without RStudio, set the working directory to this folder.
3. Run `source("R/01_ols_by_hand.R")` for the first lab, or `source("R/run_all.R")` for all labs.
4. From a terminal, `Rscript R/run_all.R` also works. An absolute path to that script is supported.
5. Outputs are written to `results/`. The run-all script records `sessionInfo()`.

Core labs use the standard R packages distributed with R. The optional tree lab requires `rpart`; if it is absent, that lab is skipped with a message. Install it yourself with `install.packages("rpart")` to run the extension. No code installs packages automatically.

The CSVs have fixed train/validation/test labels. Outcomes in test rows are excluded from fitting and selection. Lab 4 uses the original train+validation rows as a development set for five-fold cross-validation. Each lab is a separate teaching exercise: do not use repeated test results across labs to select a final deployment model.

## Reproducibility and checks

Worked OLS quantities, logistic estimates, polynomial fits and classification counts were independently recalculated. The actual JavaScript passed numerical and DOM interaction checks, and all PDF slides were visually inspected. A full browser rendering test could not run in the preparation environment. A native R executable was unavailable in the preparation environment, so the scripts have not been executed in R here. Run the supplied workflow in R/RStudio before class to inspect the generated outputs on your installation.

## Overleaf

Upload `HCAI_Supervised_Overleaf_2026.zip`, or the contents of `tex/`, as a project. Choose `supervised_learning.tex`, `linear_regression.tex` or `logistic_regression.tex` as the main document and compile with pdfLaTeX. `pdf/` contains the matching compiled PDFs; those copies must be refreshed after later edits.

The activity content is intentionally fuller than a compact review: explanations, worked calculations, interactive explorations, feedback, written reflection and a final submission task are included. R sessions remain separate.
