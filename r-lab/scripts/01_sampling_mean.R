# HCAI / Silvia Salini
# PART A: sampling distributions. Base R only.
# Open HCAI_R_Lab.Rproj, then run sections or source this file.
# The working directory must be the extracted r-lab folder.
stopifnot(file.exists("data/redditi.csv"))
dir.create("results", showWarnings = FALSE)

# 1. Read the supplied historical teaching population.
# Codes remain labels; check.names=FALSE preserves the supplied column names.
municipalities <- read.csv("data/redditi.csv", check.names = FALSE,
                          colClasses = c(Cod = "character"))
stopifnot(!anyDuplicated(municipalities$Cod), nrow(municipalities) == 8047)
variables <- c("Rp_avg", "Rp_share")
stopifnot(all(vapply(municipalities[variables], is.numeric, logical(1))))
stopifnot(all(is.finite(as.matrix(municipalities[variables]))))
N <- nrow(municipalities)
head(municipalities)
summary(municipalities[variables])

# Rp_avg: pension income amount / pension income frequency, within a municipality.
# Rp_share: 100 * pension income amount / taxable income amount, within a municipality.
# Target: the equally weighted mean across the N municipalities IN THIS FILE.
# This is different from an aggregate amount / aggregate frequency.
mu <- colMeans(municipalities[variables])
S2 <- vapply(municipalities[variables], var, numeric(1)) # denominator N-1
weighted_pension_mean <- sum(municipalities$Rp_tot) / sum(municipalities$Rp_freq)
print(data.frame(variable = variables, population_mean = mu,
                 population_SD = sqrt(S2 * (N - 1) / N)), row.names = FALSE)
cat("Municipal mean of Rp_avg:", mu["Rp_avg"], "\n")
cat("Aggregate pension amount / frequency:", weighted_pension_mean, "\n")

# 2. One simple random sample, without replacement within a sample.
set.seed(1111)
n <- 100
selected <- sample.int(N, size = n, replace = FALSE)
one_sample <- municipalities[selected, ]
one_mean <- colMeans(one_sample[variables])
print(data.frame(variable = variables, sample_mean = one_mean,
                 population_mean = mu, sampling_error = one_mean - mu),
      row.names = FALSE)

# 3. Repeat the sampling process B times at each sample size.
# A municipality may reappear in another replicate: the full population is
# available again at the beginning of each independent sample.
# n = observations in ONE sample; B = repetitions of the entire experiment.
B <- 200
sample_sizes <- c(10, 100, 1000)
set.seed(20261111)
mean_samples <- lapply(sample_sizes, function(n) {
  replicate(B, {
    selected <- sample.int(N, size = n, replace = FALSE)
    colMeans(municipalities[selected, variables])
  })
})
names(mean_samples) <- paste0("n", sample_sizes)

# 4. Compare empirical spread with the EXACT design-based standard error.
# var() uses N-1, so SE = sqrt((1 - n/N) * S2 / n).
# Under iid sampling with replacement the finite-population correction is absent.
comparison <- do.call(rbind, lapply(seq_along(sample_sizes), function(j) {
  n <- sample_sizes[j]
  m <- mean_samples[[j]]
  data.frame(variable = variables, n = n, B = B,
             population_mean = mu,
             mean_of_means = rowMeans(m),
             empirical_bias = rowMeans(m) - mu,
             empirical_SE = apply(m, 1, sd),
             theoretical_SE = sqrt((1 - n / N) * S2 / n), row.names = NULL)
}))
print(comparison, digits = 5, row.names = FALSE)
write.csv(comparison, "results/sampling_summary.csv", row.names = FALSE)

# 5. A population histogram and three histograms of sample means.
# Common horizontal limits make the increasing concentration visible.
pdf("results/sampling_distributions.pdf", width = 10, height = 7)
par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))
xlimits <- range(municipalities$Rp_avg)
hist(municipalities$Rp_avg, breaks = 35, xlim = xlimits,
     col = "#dce8e1", border = "white", main = "Population: municipalities",
     xlab = "Municipal pension income average (EUR)")
abline(v = mu["Rp_avg"], col = "#ad501f", lwd = 2)
for (j in seq_along(sample_sizes)) {
  hist(mean_samples[[j]]["Rp_avg", ], breaks = 15, xlim = xlimits,
       col = "#155f46", border = "white",
       main = paste("Sample means: n =", sample_sizes[j]),
       xlab = "Mean across sampled municipalities (EUR)")
  abline(v = mu["Rp_avg"], col = "#ad501f", lwd = 2)
}
dev.off()

# Companion plots for the slides, using two panels at a time.
panel_data <- c(list(municipalities$Rp_avg),
                lapply(mean_samples, function(x) x["Rp_avg", ]))
panel_titles <- c("Population", paste("Means: n =", sample_sizes))
for (pair in 1:2) {
  pdf(paste0("results/sampling_pair_", pair, ".pdf"),
      width = 11, height = 4.7, pointsize = 15)
  par(mfrow = c(1, 2), mar = c(4, 4, 2.5, 1))
  for (j in (2 * pair - 1):(2 * pair)) {
    hist(panel_data[[j]], breaks = 20, xlim = xlimits,
         col = if (j == 1) "#dce8e1" else "#155f46",
         border = "white", main = panel_titles[j],
         xlab = "Pension income (EUR)")
    abline(v = mu["Rp_avg"], col = "#ad501f", lwd = 2)
  }
  dev.off()
}

# 6. Plot both sample means: each point represents a whole sample.
pdf("results/two_sample_means.pdf", width = 11, height = 4.7, pointsize = 15)
par(mar = c(4.5, 4.5, 2.5, 1))
all_means <- do.call(cbind, mean_samples)
plot(all_means[1, ], all_means[2, ], type = "n",
     xlab = "Sample mean of municipal pension income (EUR)",
     ylab = "Sample mean of municipal pension share (%)",
     main = "One point = one sample")
colors <- c("#b8b8b8", "#326b9a", "#155f46")
for (j in seq_along(sample_sizes)) {
  points(mean_samples[[j]][1, ], mean_samples[[j]][2, ],
         pch = 16, cex = .7, col = colors[j])
}
points(mu[1], mu[2], pch = 4, lwd = 3, cex = 1.8, col = "#ad501f")
legend("topright", legend = c(paste0("n = ", sample_sizes), "Population means"),
       col = c(colors, "#ad501f"), pch = c(16, 16, 16, 4), bty = "n")
dev.off()

# 7. Optional extension: larger samples cannot repair a restricted sampling frame.
# Deliberately sample only from the highest-income quarter of municipalities.
priority_pool <- which(municipalities$Rp_avg >=
                         quantile(municipalities$Rp_avg, .75))
set.seed(31415)
priority_means <- replicate(B, mean(municipalities$Rp_avg[
  sample(priority_pool, size = 100, replace = FALSE)]))
print(data.frame(target_mean = mu["Rp_avg"],
                 restricted_frame_mean = mean(priority_means),
                 empirical_SE = sd(priority_means)))

# Discuss:
# A. What changes if n increases while B stays fixed?
# B. What changes if B increases while n stays fixed?
# C. Why does mean(municipalities$Rp_avg) differ from the aggregate ratio?
# D. Does a concentrated sampling distribution guarantee a valid target?
