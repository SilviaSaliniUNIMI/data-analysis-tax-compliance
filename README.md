# Data Analysis and Tax Compliance · HCAI

Interactive teaching activities by Silvia Salini, University of Milan.

Course: **Data Analysis and Tax Compliance**. Degree: **Human Centered Artificial Intelligence**. Orange backgrounds identify this course’s activities.

Suggested repository name: **data-analysis-tax-compliance**.

## Create and publish the repository

1. Sign in to GitHub as `SilviaSaliniUNIMI` and choose **New repository**.
2. Name it `data-analysis-tax-compliance`. Suggested description: `Data Analysis and Tax Compliance – HCAI, University of Milan. Interactive learning activities and teaching materials by Silvia Salini.`
3. Choose Public if you want the same public course access as the IPLE site. Create the repository. You can leave the README option unticked because a README is included here.
4. Extract this ZIP on your computer. Choose **uploading an existing file** (or **Add file > Upload files**), then drag the CONTENTS of the extracted folder into GitHub, preserving `assets`, `data`, `downloads` and `overleaf` as folders. `index.html` must be at the root. Do not upload the ZIP itself as the website.
5. Commit the files to `main`.
6. Open **Settings > Pages**. Under Source choose **Deploy from a branch**, then `main` and `/(root)`. Save.
7. After deployment completes, open the site shown by GitHub Pages. With the account and name above, the expected address is `https://silviasaliniunimi.github.io/data-analysis-tax-compliance/`.

The repository has not been created or published by this package. The existing IPLE repository is unaffected. If this repository name already exists, inspect its contents before uploading.

Official GitHub instructions: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site

## Contents

- `index.html`: course homepage and six-activity route.
- `01-history.html`: a dedicated eight-section activity on fiscal records, Petty, tax assessment and payment, with two interactive comparisons, eight questions, a reflection and answer export.
- `02-descriptive.html`: 10 sections, interactive numerical examples, a full-data task, 14 self-check questions and explanatory feedback.
- `assets/`: local CSS, JavaScript and synthetic data. No third-party JavaScript, fonts or analytics.
- `data/`: the downloadable CSV and data dictionary.
- `downloads/`: lecture PDFs and the R script.
- `overleaf/`: editable Beamer project, also supplied as a separate uploadable ZIP.

Activities 3–6 (inference, bivariate analysis, supervised learning and unsupervised learning) are planned and explicitly marked as not yet available. There are no broken placeholder links.

## Work locally

Extract the entire ZIP and open `index.html` in a browser. Both activities, their calculations and quizzes work offline. Opening the historical primary sources and external further reading requires internet access. PDFs and scripts remain relative links within the folder tree.

Optional local server: `python3 -m http.server 8000`, then open http://localhost:8000 .

Answers and section checkboxes are saved in the current browser when browser storage is available. Students can export a plain-text file. No response is sent automatically to the instructor. This is formative practice, not a protected examination system; the client-side answer key is visible in the source.

## Teaching notes

- First module meeting: 14 October 2026, 14:30–16:30, room 424.
- Return: 4 November 2026, 14:30–16:30, room 424.
- Suggested study targets: history by 21 October and description by 3 November. These are not formal assessment deadlines.
- History reflection: 250–350 words. Descriptive report: 150–250 words, with one small table or graph.
- History workload: around 60–90 minutes. Description: around 2–2.5 hours, split across sessions.
- Keep instructor notes or sensitive/student data outside a public repository. The included data are entirely synthetic.
- Review the retained ARIEL link and announce the current assessment and submission arrangements through the official course channel.

## Sources and adaptation

The history activity is specific to this course. Sources: ONS on ancient censuses; The National Archives on Domesday; Petty (1662), chapter VII; Graunt (1662), Wellcome Collection; Gioia/Gioja (1826), Filosofia della statistica. Direct links appear in the activity and slides. The IPLE historical pathway is optional broader reading; its assessment practice does not define this course’s assessment.

The district exercise is synthetic: 100 households in each district; property values 800 and 200; a required total of 200; assessments 160 and 40 under the proportional rule; payments 120 and 36; payment ratios 75%, 90%, and 78% combined. It is separate from the 24-firm dataset.

The first block reworks the supplied HCAI introduction and descriptive-statistics slides. The previous inference deck is reserved for a later block. Corrections include the meaning of a positive z-score, the distinction between descriptive and sample variance, entropy bounds and the distinction between Gini–Simpson and income inequality.

Quantile convention: https://stat.ethz.ch/R-manual/R-devel/library/stats/html/quantile.html . All numerical examples use explicit units and denominators.

© Silvia Salini. All rights reserved.

## Validation

Both PDFs compile with pdfLaTeX without overfull boxes and have been visually inspected. Numerical results and the main JavaScript interactions (navigation, export, simulators, quiz and reset) were checked using a simulated DOM. A real browser was unavailable, so browser layout and download behaviour still need a final check after publication. The R script was reviewed but not executed in R in this environment.

## Revision — 14 October 2026

Orange activity backgrounds; exact course and degree names; a dedicated history-to-tax-compliance pathway; matching Beamer material and a weighted payment-ratio example in the descriptive review.

## Integration of the supplied activities

The descriptive review now condenses the supplied graphs, location and heterogeneity activities, adds an explicit variance calculation and retains an optional Monty Hall bridge. See `SOURCE_MAP.md` for content coverage. The 2026/2027 class-survey QR is included in the introduction. The replacement ARIEL URL is still needed; the supplied old deck contains course ID 3315.
