# Data Analysis and Tax Compliance
Human Centered Artificial Intelligence · Silvia Salini · University of Milan · 2026/2027

Cumulative release, 3 November 2026: four orange e-tivities and four PDF/Beamer decks.

## Open locally
Unzip the package and open `index.html`. JavaScript, CSS and datasets are local; no installation or external API is needed. Written responses and quiz results are saved in browser storage when permitted. Export responses before clearing storage or switching browser/device. Simulation runs and controls are temporary. Nothing is submitted automatically.

## GitHub Pages
1. Sign into the intended account; create a public repository named `data-analysis-tax-compliance` (or open the repository already created for this course).
2. Extract this ZIP. Upload the **contents** of the project folder: `index.html`, activity HTML files, `assets`, `data`, `downloads` and `overleaf`. Preserve subfolders. The ZIP itself is not the website.
3. Commit to `main`. When updating, replace matching files; do not nest the new release inside an extra course folder. GitHub’s web uploader may require several batches for the full package.
4. Settings → Pages → Build and deployment → Deploy from a branch → `main` → `/(root)` → Save.
5. Wait for the deployment and use the URL shown by GitHub. For the account SilviaSaliniUNIMI and this name it is `https://silviasaliniunimi.github.io/data-analysis-tax-compliance/`.
6. Open all four activities and PDF links on the published site. If Pages shows a 404, verify that `index.html` is at the selected root and inspect the deployment status.

`.nojekyll` is included. It can also be created on GitHub via Add file → Create new file if a file picker hides it. The static HTML site does not require a Jekyll build. No repository or deployment was created automatically by preparing this package.

## Teaching scope
- 14 October: introduction; independent history and descriptive review.
- 4 November, 14:30–16:30, room 424: inference.
- 6 November, 10:30–12:30, room 424: bivariate analysis.
The dates/times/room come from the supplied timetable; topic allocation follows the agreed teaching plan.
- New R lessons will be prepared separately. The earlier descriptive-review R script remains available.
- Supervised and unsupervised activities are planned, not yet included.

## Editable slides
The `overleaf` directory contains four entry points: `main.tex`, `descriptive_review.tex`, `inference.tex`, `bivariate.tex`. Use pdfLaTeX. Select the desired main document to compile that deck. Supplied figure PDFs are ready; Python figure generators are optional and are not executed by Overleaf.

See `SOURCE_MAP.md` for source coverage, adaptations and verification limits. Dataset assumptions are in `data/data_dictionary.html` (block 1) and `data/block2_dictionary.html` (block 2).
