# Data Analysis and Tax Compliance / HCAI
# Silvia Salini, University of Milan. October 2026.
# Synthetic teaching data: these records describe no real firms.
# Download filings_synthetic.csv and this script into the same folder.
# Set that folder as the working directory, or select the CSV when prompted.
# Uses only base R and the standard stats/graphics packages.

path <- "filings_synthetic.csv"
if (!file.exists(path)) path <- file.choose()
d <- read.csv(path, na.strings = c("", "NA"), stringsAsFactors = FALSE)
stopifnot(nrow(d) == 24, !anyDuplicated(d$firm_id))
str(d)
colSums(is.na(d))

# Measurement and frequencies
table(d$sector)
prop.table(table(d$sector))
prop.table(table(d$filing_channel))
known <- !is.na(d$filing_delay_days)
c(known = sum(known), missing = sum(!known))
late <- sum(d$filing_delay_days[known] > 0)
c(late_among_known = late / sum(known),
  full_set_lower_bound = late / nrow(d),
  full_set_upper_bound = (late + sum(!known)) / nrow(d))
mean(d$filing_delay_days, na.rm = TRUE)

# Location and dispersion; turnover is in thousand EUR
x <- d$turnover_kEUR
n <- length(x)
qs <- quantile(x, c(.25, .5, .75), type = 7)
print(qs)
mode_x <- function(x) {
  counts <- table(x)
  names(counts)[counts == max(counts)]
}
mode_x(x)  # R's mode() describes storage/type, not the statistical mode
c(mean = mean(x), median = median(x),
  range = diff(range(x)), IQR = IQR(x, type = 7),
  variance_n = mean((x - mean(x))^2),
  sample_variance = var(x), sample_sd = sd(x),
  mean_absolute_deviation = mean(abs(x - mean(x))),
  CV = sd(x) / mean(x))

# Graphs with labels and units
barplot(table(d$sector), ylab = "Number of firms", col = "#00766b",
        main = "Sector: 24 synthetic firms")
hist(x, breaks = seq(0, 300, by = 25), right = FALSE,
     include.lowest = TRUE, xlab = "Turnover (thousand EUR)",
     ylab = "Number of firms", main = "Turnover distribution",
     col = "#00766b", border = "white", freq = TRUE)
# For unequal bins use density heights. Areas sum to 1 here.
hist(x, breaks = c(0, 50, 100, 200, 400), right = FALSE,
     include.lowest = TRUE, freq = FALSE,
     xlab = "Turnover (thousand EUR)", ylab = "Relative frequency density",
     main = "Unequal-width bins", col = "#123452", border = "white")

# Boxplot using the same type-7 quartiles as the e-tivity.
# Base R boxplot() can use different hinges for small samples.
q1 <- unname(qs[1]); q3 <- unname(qs[3])
iqr <- q3 - q1
fences <- c(q1 - 1.5 * iqr, q3 + 1.5 * iqr)
inside <- x >= fences[1] & x <= fences[2]
print(fences)
print(d[!inside, c("firm_id", "turnover_kEUR")])
box_stats <- list(stats = matrix(c(min(x[inside]), q1, median(x), q3,
                                   max(x[inside])), ncol = 1),
                  n = n, conf = matrix(c(NA_real_, NA_real_), nrow = 2),
                  out = x[!inside], group = rep(1, sum(!inside)),
                  names = "Turnover")
bxp(box_stats, horizontal = TRUE, outline = TRUE,
    xlab = "Turnover (thousand EUR)", main = "Type-7 quartiles",
    boxfill = "#d9ece6")

# Sensitivity comparison is informative; it does not justify deleting a value.
rbind(all = c(mean = mean(x), median = median(x), sd = sd(x)),
      without_largest = c(mean = mean(x[x < max(x)]),
                          median = median(x[x < max(x)]),
                          sd = sd(x[x < max(x)])))

# Heterogeneity: fixed set of K = 3 possible sectors
p <- as.numeric(prop.table(table(factor(d$sector,
    levels = c("Commerce", "Services", "Manufacturing")))))
K <- length(p)
G <- 1 - sum(p^2)
H <- -sum(p[p > 0] * log(p[p > 0])) # natural logarithms, nats
c(Gini_Simpson = G, Shannon_nats = H, normalised_H = H / log(K))

# Standardisation using the same complete observations and sample SD
stopifnot(sd(x) > 0)
z <- as.numeric(scale(x))
print(data.frame(firm_id = d$firm_id, turnover_kEUR = x, z = z))
c(mean_z = mean(z), sd_z = sd(z))

# Audit selection: these outcomes describe audited firms only
a <- subset(d, audited == 1)
stopifnot(all(!is.na(a$discrepancy_found)),
          all(is.na(d$discrepancy_found[d$audited == 0])))
c(audited_n = nrow(a), discrepancies = sum(a$discrepancy_found),
  proportion_among_audited = mean(a$discrepancy_found))

# Reference values (allow floating-point rounding)
stopifnot(abs(mean(x) - 56.75) < 1e-8,
          abs(sd(x) - 57.7327049200997) < 1e-8,
          abs(IQR(x, type = 7) - 34) < 1e-8,
          abs(G - 0.611111111111111) < 1e-8,
          abs(H - 1.01140426470735) < 1e-8)
