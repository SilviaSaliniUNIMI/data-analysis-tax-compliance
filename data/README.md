# Dataset dictionary

All datasets in this block are fictional teaching examples. No real students, households, taxpayers or delivery customers are represented. Values are not empirical estimates about a population. Files use comma separators and a decimal point. There are no missing values.

## study_hours.csv (5 rows)

- `student`: anonymous fictional label A--E.
- `hours`: study hours; values 2, 3, 4, 5, 6.
- `score`: exam points; values 50, 55, 60, 63, 72.

This fixed small example illustrates OLS arithmetic and model-based inference. It is not a reliable empirical sample. No training/test split is claimed for it.

## homes_synthetic.csv (180 rows)

- `id`: record identifier, excluded from model predictors.
- `area_m2`: floor area in square metres, 40--140.
- `renovated`: 0 = no, 1 = yes.
- `centre`: 0 = outside the centre, 1 = centre.
- `price_k_eur`: fictional price in thousands of euros.
- `split`: train (108), validation (36), test (36).

Simulation: price = 35 + 2.7*area + 24*renovated + 32*centre + 0.22*area*centre + Normal(0,18^2), rounded to two decimals. This is a pedagogical relationship, not a housing-market estimate.

## deliveries_synthetic.csv (500 rows)

- `id`: identifier; excluded from predictors.
- `distance_km`: planned distance, measured before dispatch, from 1 to 25 km.
- `peak`: 0/1 indicator for peak-time dispatch.
- `late`: target, 1 = arrival after the promised deadline, 0 = otherwise.
- `split`: train (300), validation (100), test (100).

Simulation: late is Bernoulli with p = logistic(-3 + 0.18*distance_km + 0.9*peak). The fitted training coefficients are approximately (-3.43149, 0.210064, 0.946306), not identical to the simulation coefficients.

## filing_synthetic.csv (600 rows)

- `id`: identifier; excluded from predictors.
- `previous_late`: number of previous late filings, 0--4.
- `complexity`: illustrative ordinal score 1--5; the core model treats successive steps as equally spaced.
- `support_used`: 0/1, whether support was used before the filing deadline.
- `digital_channel`: 0/1, reserved for illustrative group evaluation rather than model fitting.
- `late_filing`: target; 1 = late, 0 = timely. This is not a fraud label.
- `split`: train (360), validation (120), test (120).

Simulation: p = logistic(-3.8 + 0.65*previous_late + 0.42*complexity - 0.65*support_used), with a Bernoulli outcome for every row. All predictors are defined as available before the outcome. The support coefficient in the simulation is not empirical evidence for any real policy effect. Channel is generated independently. The exercise discusses how selective outcome observation would change the problem.

## threshold_example.csv (12 rows)

- `case`: fictional case number.
- `observed`: fixed event label, 0 or 1; six of each.
- `probability`: fixed teaching score, not estimated from the delivery model.

Positive classification uses probability >= threshold. These rows illustrate the confusion matrix, ROC and error costs; they are not a claimed test sample for a trained model.

## complexity_example.csv (60 rows)

- `x`: fictional continuous predictor, between -3 and 3.
- `y`: 2 + 0.8*x - 0.7*x^2 + Normal(0,1.1^2).
- `split`: train (40), validation (20), assigned with a fixed interleaved pattern after sorting x.

Degrees 1, 2 and 9 are fitted on training rows. There is no test sample in this small demonstration and no final generalisation claim.

## Generation and numerical references

The larger datasets were generated once using NumPy's default_rng seed 20261118 and stored here as fixed CSVs. The fixed CSV bytes are the source of truth for R, e-tivity and slide calculations. R does not regenerate them from a different random-number generator. `reference_results.json` stores the worked OLS quantities, complexity errors, threshold counts and an independent logistic coefficient calculation.
