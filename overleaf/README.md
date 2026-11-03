# HCAI · Data Analysis and Tax Compliance · Block 1

Slides by Silvia Salini, University of Milan. Degree: **Human Centered Artificial Intelligence**. English teaching material, October 2026.

## Import into Overleaf

1. Create a new project using **Upload Project** and select this ZIP.
2. Select **pdfLaTeX** as the compiler.
3. Select `main.tex` as the main document for the 14 October lecture (33 slides).
4. To compile the independent review (31 slides), select `descriptive_review.tex` as the main document.

Both entry points use `theme.tex`, editable text in `sections/`, and vector PDF charts in `figures/`. No shell escape, external fonts or online resources are needed to compile. Formulas and tables remain native LaTeX. The charts are included as vector assets; their editable generation script is `figures/generate_figures.py`.

## Scope

This first block contains a revised introduction and a consolidated descriptive review. It does not reproduce every slide of the former descriptive deck. Lecture 3 (inference) will be developed in the next block. The six-activity route is shown in the introduction; only history and description are complete in this release.

Dates, times and room follow the supplied 2026 tentative timetable. Topic allocation is a proposal. The 14 October session is the first meeting of Silvia Salini's module, not the first meeting of the entire course.

The ARIEL link is retained from the original introductory deck and should be checked for the current cohort. The old survey link, old room schedule and standing office hours have not been carried forward. Assessment details should follow the official current course information.

The synthetic data have been created for teaching and describe no real tax records. Quantiles use R type 7. SD and sample variance use n−1 unless explicitly stated.

## Extend the project

For a later block, add a file under `sections/` and a new `.tex` entry point using the same theme. This keeps a single Overleaf project while allowing separate lecture PDFs.

© Silvia Salini. All rights reserved.

## Validation

Both PDFs compile with pdfLaTeX without overfull boxes and have been visually inspected. Numerical results and the main JavaScript interactions (navigation, export, simulators, quiz and reset) were checked using a simulated DOM. A real browser was unavailable, so browser layout and download behaviour still need a final check after publication. The R script was reviewed but not executed in R in this environment.

## Revision — 14 October 2026

Orange activity backgrounds; exact course and degree names; a dedicated history-to-tax-compliance pathway; matching Beamer material and a weighted payment-ratio example in the descriptive review.

## Integration of the supplied activities

The descriptive review now condenses the supplied graphs, location and heterogeneity activities, adds an explicit variance calculation and retains an optional Monty Hall bridge. See `SOURCE_MAP.md` for content coverage. The 2026/2027 class-survey QR is included in the introduction. The replacement ARIEL URL is still needed; the supplied old deck contains course ID 3315.
