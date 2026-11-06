# HCAI / Silvia Salini
# PART B: bivariate analysis of BES education indicators. Base R only.
# Open HCAI_R_Lab.Rproj. The prepared data have one row per region.
stopifnot(file.exists("data/bes_education.csv"))
dir.create("results", showWarnings = FALSE)
bes <- read.csv("data/bes_education.csv", stringsAsFactors = FALSE)
bes$area <- factor(bes$area,
  levels = c("North-West", "North-East", "Centre", "South-Islands"))
stopifnot(nrow(bes) == 20, !anyDuplicated(bes$region), !anyNA(bes))
print(head(bes))
print(table(bes$area))

# These are 20 observed regions, not an iid random sample of 20 individuals.
# Descriptions apply to the supplied regions and year. Tests below illustrate
# model-based inference conditional on assumptions, including independent errors.
# Spatial dependence, aggregation and confounding limit interpretation.
# The prepared file retains Trentino-Alto Adige and excludes its two constituent
# autonomous provinces, which would otherwise duplicate territory.

# 1. Two categorical variables: area and a threshold on early leaving.
# Threshold chosen for the teaching example before inspecting test results.
bes$dropout <- factor(ifelse(bes$early_leaving_pct > 15, "Above 15%", "At most 15%"),
                       levels = c("At most 15%", "Above 15%"))
tab <- table(Area = bes$area, Early_leaving = bes$dropout)
print(tab)
print(round(100 * prop.table(tab, margin = 1), 1)) # conditional on area
print(round(100 * prop.table(tab, margin = 2), 1)) # conditional on dropout group
# The expected-count limitation is displayed explicitly below.
chi <- suppressWarnings(chisq.test(tab, correct = FALSE))
print(round(chi$expected, 2))
cat("Cells with expected counts below 5:", sum(chi$expected < 5), "of", length(tab), "\n")
V <- sqrt(as.numeric(chi$statistic) /
            (sum(tab) * min(nrow(tab) - 1, ncol(tab) - 1)))
cat("Descriptive chi-square:", as.numeric(chi$statistic), " Cramer's V:", V, "\n")
# Sparse expected counts make the chi-square asymptotic p-value unreliable here.
# Fisher's exact test is conditional on the margins under its sampling model.
# It addresses sparse counts, not spatial dependence or selection.
exact <- fisher.test(tab)
print(exact)

# 2. Quantitative outcome across two groups: NEET percentages by dropout group.
print(aggregate(neet_pct ~ dropout, data = bes,
                FUN = function(x) c(n = length(x), mean = mean(x), SD = sd(x))))
welch <- t.test(neet_pct ~ dropout, data = bes)
print(welch)
# The estimate and interval use group 1 minus group 2 in the factor order above.
# Effects are in percentage POINTS, since the outcome is a percentage.

# 3. Quantitative outcome across four areas: one-way ANOVA.
print(aggregate(neet_pct ~ area, data = bes,
                FUN = function(x) c(n = length(x), mean = mean(x), SD = sd(x))))
fit_anova <- aov(neet_pct ~ area, data = bes)
anova_table <- summary(fit_anova)[[1]]
print(anova_table)
eta2 <- anova_table[1, "Sum Sq"] / sum(anova_table[, "Sum Sq"])
cat("Eta-squared:", eta2, "\n")
# A significant global test would concern at least one mean difference.
# It would not identify every pair or establish a geographical cause.
# Optional unequal-variance comparison:
print(oneway.test(neet_pct ~ area, data = bes, var.equal = FALSE))

pdf("results/group_comparisons.pdf", width = 11, height = 4.7, pointsize = 14)
par(mfrow = c(1, 2), mar = c(6, 4, 3, 1))
boxplot(neet_pct ~ dropout, data = bes, col = "#dce8e1", outline = FALSE,
        xlab = "", ylab = "NEET (%)", main = "Two dropout groups")
stripchart(neet_pct ~ dropout, data = bes, vertical = TRUE, method = "stack",
           add = TRUE, pch = 16, col = "#155f46")
boxplot(neet_pct ~ area, data = bes, col = "#dce8e1", outline = FALSE,
        las = 2, xlab = "", ylab = "NEET (%)", main = "Four geographical areas")
stripchart(neet_pct ~ area, data = bes, vertical = TRUE, method = "stack",
           add = TRUE, pch = 16, col = "#155f46")
dev.off()

# 4. Two quantitative variables: culture and tertiary education.
selected <- c("tertiary_pct", "cultural_pct", "reading_pct", "library_pct")
print(round(cor(bes[selected]), 3))
correlation <- cor(bes$cultural_pct, bes$tertiary_pct)
cat("Pearson r (culture, tertiary education):", correlation, "\n")

# Optional bridge to supervised learning: a simple fitted line.
fit_line <- lm(tertiary_pct ~ cultural_pct, data = bes)
print(summary(fit_line))
# A one-percentage-point difference in cultural participation is associated
# with slope percentage points in tertiary education in this fitted line.
# This is an observational regional association, not a causal effect or
# evidence of predictive accuracy on new cases.

pdf("results/correlation.pdf", width = 11, height = 4.7, pointsize = 15)
par(mar = c(4.5, 4.5, 2.5, 1))
plot(tertiary_pct ~ cultural_pct, data = bes, pch = 19, col = "#155f46",
     xlab = "Cultural participation (%)", ylab = "Tertiary education, age 30-34 (%)",
     main = "Each point represents one region")
abline(fit_line, col = "#ad501f", lwd = 2)
legend("topleft", paste("Pearson r =", round(correlation, 3)), bty = "n")
dev.off()

# 5. Save a compact numerical reference for the class discussion.
reference <- data.frame(
  quantity = c("regions", "chi_square", "Cramers_V", "Fisher_p",
               "Welch_t", "Welch_df", "Welch_p", "Welch_CI_low", "Welch_CI_high",
               "ANOVA_F", "ANOVA_p", "eta_squared", "Pearson_r", "slope", "R_squared"),
  value = c(nrow(bes), unname(chi$statistic), V, exact$p.value,
            unname(welch$statistic), unname(welch$parameter), welch$p.value,
            welch$conf.int[1:2], anova_table[1, "F value"],
            anova_table[1, "Pr(>F)"], eta2, correlation,
            unname(coef(fit_line)[2]), summary(fit_line)$r.squared))
write.csv(reference, "results/bivariate_summary.csv", row.names = FALSE)
write.csv(as.data.frame.matrix(tab), "results/contingency_counts.csv")

# Discuss:
# A. Why is an unqualified chi-square p-value a poor choice for this table?
# B. What information is lost by thresholding early leaving at 15%?
# C. What changes when the unit is a region rather than a person?
# D. What would we need before claiming causality or predictive performance?
