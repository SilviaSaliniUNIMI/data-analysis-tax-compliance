# Relationship to the original teaching materials

Course: Data Analysis and Tax Compliance. Degree: Human Centered Artificial Intelligence.

These Beamer decks reorganise the two original lessons; they are not a slide-for-slide conversion.

| Source | Coverage in this block |
| --- | --- |
| Original Lecture 1, 12 slides | Organisation, scientific reasoning, evidence and causality, R, study pathway. Timetable revised for 2026. Original cartoons are replaced by teaching questions and tax examples. The supplied 2026/2027 survey QR is included. |
| Original Lecture 2, slides 2–18 | Units, scales, measurement validity/reliability, datasets, frequencies. |
| Original Lecture 2, slides 19–31 | Graph selection, categories, bins and histogram density. |
| Original Lecture 2, slides 32–59 | Mode, median, mean, quantiles, boxplots, extreme values and weighted comparisons. |
| Original Lecture 2, slides 60–96 | Categorical heterogeneity, range, IQR, deviations, variance, SD. The four-value calculation is retained in a processing-time context. |
| Original Lecture 2, slides 97–110 | Z-scores, standardisation and composite-index interpretation. |
| Misleading Graphs | Baseline, order, numeric spacing, counts/rates, multiple-response pie charts, binning and unequal-width density. |
| Measures of Location | Redistribution/balance, cumulative ordinal medians, grouped interpolation, modal density, percentiles, robustness, skewness and choice of measure. |
| Heterogeneity Indices | Raw/normalised Gini–Simpson and Shannon, log bases, editable counts, classifications, rare categories and learning connection. |
| Monty Hall | Optional short probability bridge with three-case reasoning and repeated simulation. |

The consolidated activity has 10 sections and an estimated core workload of 2–2.5 hours, with a 150–250-word interpretation. Worked details can be opened as needed. The separate IPLE exam blocks, long historical biographies, films and repeated cases are not all reproduced. The dedicated fiscal-history activity remains E-tivity 1.

The new ARIEL URL was not present in the message. The address in the supplied introduction is still https://myariel.unimi.it/course/view.php?id=3315. It remains in the deck pending the intended replacement URL. The supplied PNG is the survey QR, not evidence of the ARIEL address.

## Block 2 update — 3 November 2026

### Supplied slide sources
- `DA&TC_HCAI_Salini_Lecture3-Inference.pdf` (61 pages): population/sample, estimators, repeated sampling, intervals, tests and errors. The source acknowledges Evan Schofer (2005) and Alan Agresti.
- `DA&TC_HCAI_Salini_Lecture4-5-Bivariate Analysis.zip`: Association (26 pages), ANOVA (58 pages), Correlation (16 pages). Sources acknowledge Silvia Salini and Alan Agresti; they point to Art of Stat for practice.

### Activity sources used
The live IPLE URL could not be retrieved during preparation. The following saved original activities by Silvia Salini were read and used; they are not claimed to be verified copies of the current live IPLE pages.

| Saved source | Adapted content | Destination |
| --- | --- | --- |
| B3-etivity1(1).html | Known population, samples, repeated means/proportions, effect of n | Inference §§1–4 |
| B3-etivity2(4).html | z/t intervals, degrees of freedom, coverage | Inference §§5–6 |
| B3-etivity3(1).html | Tests, alpha/beta/power, repeated experiments, p-values | Inference §§7–10 |
| B4-etivity1(1).html | Two-group t, ANOVA decomposition, F, eta², diagnostics, post-hoc | Bivariate §§5–6 |
| B4-etivity2(1).html | Conditional tables, expected counts, χ², residuals, V, sample size | Bivariate §§2–4 |
| B4-etivity3(1).html | Weighted averages, reversal, interpretation | Bivariate §8 |
| B4-etivity4(9).html | Scatterplots, covariance/r, nonlinear form, OLS, prediction | Bivariate §7 and optional §9 |

### Adaptation decisions
- English course materials; orange activity backgrounds; existing course branding retained.
- Integrated conceptual activities: 10 inference sections / 12 quiz questions; 11 bivariate sections / 14 questions. No R prerequisite.
- Business/municipal examples replaced with six explicitly separate synthetic datasets. No supplied private records or raw R workspaces are republished.
- Finite-register sampling without replacement uses the finite-population correction; its count is hypergeometric. Independent Bernoulli and normal-model examples are labelled separately.
- Corrected inferential language: fail to reject, not prove/accept; p-value conditional on the null; confidence level describes repeated coverage; consistency does not require finite-sample unbiasedness.
- Cramér’s V distinguished from V². All χ² cells, F tables and regression values recomputed from the supplied new CSVs; copied inconsistent intermediate examples are not retained.
- Two-group F = t² limited to the matching pooled equal-variance model. Welch and paired designs distinguished.
- Simpson example supports an association discussion, not a causal policy claim.
- Regression is an optional bridge to supervised learning, not a new required modelling unit within the two-hour bivariate lecture.
- Supplied `sample mean R example.zip` and `DA&TC_HCAI_Salini_Lacture 6-7-Bivariate Analysis R.zip` are reserved for separate R lessons, following the instructor’s latest instruction. No new R lesson is included in this release.

### Reference checks
- NIST e-Handbook: https://www.itl.nist.gov/div898/handbook/eda/section3/eda352.htm
- R official t-test documentation: https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html
- R official chi-squared documentation: https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html

### Validation
Both new Beamer PDFs compile with pdfLaTeX. Numerical helpers were checked against SciPy; activity navigation, quizzes, response export, calculator inputs and the principal simulation controls were exercised in a DOM harness. No installed browser engine was available for browser screenshot verification. PDF pages were rendered for visual inspection.
