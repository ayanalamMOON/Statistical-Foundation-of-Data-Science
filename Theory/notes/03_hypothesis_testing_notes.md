# Hypothesis Testing - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Hypothesis testing is a systematic method for making decisions about population parameters based on sample data. It provides a framework for scientific inquiry and evidence-based decision making.

## 1. Fundamental Concepts

### The Logic of Hypothesis Testing
1. **Make an assumption** about the population (null hypothesis)
2. **Collect sample data**
3. **Calculate the probability** of observing such data if the assumption is true
4. **Make a decision** based on this probability

### Null and Alternative Hypotheses

#### Null Hypothesis (H₀)
- **"No effect" or "no difference"** hypothesis
- **Status quo**: What we assume to be true
- **Always contains equality**: =, ≤, or ≥
- **Examples**:
  - H₀: μ = 50 (population mean equals 50)
  - H₀: μ₁ = μ₂ (two population means are equal)

#### Alternative Hypothesis (H₁ or Hₐ)
- **What we're trying to prove**
- **Contains inequality**: ≠, <, or >
- **Types**:
  - Two-tailed: H₁: μ ≠ 50
  - Left-tailed: H₁: μ < 50
  - Right-tailed: H₁: μ > 50

### Type I and Type II Errors

| Reality → | H₀ True | H₀ False |
|-----------|---------|----------|
| **Reject H₀** | Type I Error (α) | Correct Decision (Power) |
| **Fail to Reject H₀** | Correct Decision | Type II Error (β) |

#### Type I Error (α)
- **False positive**: Rejecting true H₀
- **Significance level**: Usually set at 0.05 or 0.01
- **Controlled by researcher**: Choose α before testing

#### Type II Error (β)
- **False negative**: Failing to reject false H₀
- **Power = 1 - β**: Probability of correctly rejecting false H₀
- **Influenced by**: Effect size, sample size, significance level

## 2. The Hypothesis Testing Process

### Step-by-Step Procedure
1. **State hypotheses**: H₀ and H₁
2. **Choose significance level**: α (typically 0.05)
3. **Select test statistic**: Based on data type and assumptions
4. **Calculate test statistic**: From sample data
5. **Determine p-value**: Probability of observed result under H₀
6. **Make decision**: Reject H₀ if p-value < α
7. **Draw conclusion**: In context of the problem

### Critical Value vs. P-Value Approach

#### Critical Value Approach
- **Pre-determine rejection region**: Based on α
- **Compare test statistic**: To critical value
- **Decision**: Reject if test statistic in rejection region

#### P-Value Approach
- **Calculate exact probability**: Of observed result under H₀
- **Compare to significance level**: p-value vs. α
- **More informative**: Shows strength of evidence

## 3. One-Sample Tests

### One-Sample t-Test
**Purpose**: Test if sample mean differs from hypothesized population mean

**Assumptions**:
- Random sampling
- Normal distribution (or large sample)
- Independent observations

**Test Statistic**: t = (x̄ - μ₀)/(s/√n)
**Degrees of freedom**: n - 1

**Example Applications**:
- Testing if new drug reduces fever below 100°F
- Checking if manufacturing process meets specifications
- Evaluating if training improves test scores beyond baseline

### When to Use
- **Population standard deviation unknown** (most common case)
- **Small to moderate sample sizes**
- **Normal distribution assumption** reasonable

## 4. Two-Sample Tests

### Independent Samples t-Test

#### Equal Variances (Pooled t-Test)
**Assumptions**:
- Independent random samples
- Normal distributions
- Equal population variances (σ₁² = σ₂²)

**Pooled Standard Deviation**:
s_p = √[((n₁-1)s₁² + (n₂-1)s₂²)/(n₁+n₂-2)]

**Test Statistic**: t = (x̄₁ - x̄₂)/(s_p√(1/n₁ + 1/n₂))

#### Unequal Variances (Welch's t-Test)
**When to use**: Variances significantly different
**Advantage**: More robust, doesn't assume equal variances
**Disadvantage**: More complex degrees of freedom calculation

### Paired t-Test
**Purpose**: Compare means when observations are paired

**Examples**:
- Before/after measurements on same subjects
- Matched pairs in experiments
- Repeated measurements

**Key Insight**: Analyzes the differences, not the original values
**Test Statistic**: t = d̄/(s_d/√n)

## 5. Tests for Categorical Data

### Chi-Square Test of Independence
**Purpose**: Test if two categorical variables are independent

**Null Hypothesis**: Variables are independent
**Alternative**: Variables are associated

**Expected Frequency**: E_ij = (Row total × Column total)/Grand total

**Test Statistic**: χ² = Σ[(O_ij - E_ij)²/E_ij]

**Requirements**:
- Expected frequencies ≥ 5 in at least 80% of cells
- No expected frequency < 1
- Independent observations

### Chi-Square Goodness-of-Fit
**Purpose**: Test if data follows specified distribution

**Applications**:
- Testing if die is fair
- Checking if data follows normal distribution
- Validating theoretical models

## 6. Practical Considerations

### Sample Size and Power
**Factors Affecting Power**:
1. **Effect size**: Larger effects easier to detect
2. **Sample size**: Larger samples increase power
3. **Significance level**: Lower α decreases power
4. **Population variability**: Lower σ increases power

**Power Analysis**:
- **Prospective**: Determine sample size needed
- **Retrospective**: Calculate power of completed study

### Multiple Testing Problem
**Issue**: Multiple tests increase chance of Type I error
**Solutions**:
- Bonferroni correction: α_new = α/k
- False Discovery Rate (FDR) control
- Family-wise error rate control

### Effect Size vs. Statistical Significance
**Statistical Significance**: p-value < α
**Practical Significance**: Effect size large enough to matter

**Common Effect Size Measures**:
- Cohen's d: Standardized mean difference
- R²: Proportion of variance explained
- Correlation coefficient

## 7. Assumptions and Robustness

### Normality Assumption
**Assessment Methods**:
- Q-Q plots
- Shapiro-Wilk test
- Kolmogorov-Smirnov test

**Robustness**: t-tests relatively robust to moderate departures

### Independence Assumption
**Critical**: Violation can seriously affect results
**Common Violations**:
- Clustered data
- Time series data
- Spatial correlation

### Equal Variance Assumption
**Testing**: F-test, Levene's test
**Alternatives**: Welch's t-test, bootstrap methods

## 8. Interpretation and Communication

### P-Value Interpretation
**What p-value means**:
- Probability of observing data as extreme or more extreme
- Assuming null hypothesis is true
- NOT the probability that H₀ is true

**Common Misinterpretations**:
- P(H₀|data) ≠ p-value
- p-value ≠ probability of replication
- Statistical significance ≠ practical importance

### Confidence Intervals
**Relationship to hypothesis testing**:
- If CI doesn't contain H₀ value, reject H₀
- Provides range of plausible values
- More informative than just p-value

### Reporting Results
**Essential Elements**:
1. Test statistic value
2. Degrees of freedom
3. P-value
4. Effect size
5. Confidence interval
6. Practical interpretation

## 9. Common Mistakes and Pitfalls

### Statistical Mistakes
1. **Using wrong test**: Not checking assumptions
2. **Multiple comparisons**: Not adjusting α
3. **Data dredging**: Testing many hypotheses post-hoc
4. **Confusing correlation with causation**

### Interpretation Mistakes
1. **"Accepting" null hypothesis**: Should "fail to reject"
2. **Over-interpreting p-values**: 0.049 vs. 0.051 not meaningful difference
3. **Ignoring effect size**: Focus only on significance
4. **Generalizing beyond population**: Sample limitations

## 10. Advanced Topics

### Non-Parametric Tests
**When to use**: Assumptions violated or ordinal data

**Common Tests**:
- Mann-Whitney U: Alternative to two-sample t-test
- Wilcoxon signed-rank: Alternative to paired t-test
- Kruskal-Wallis: Alternative to one-way ANOVA

### Bootstrap Methods
**Advantage**: Distribution-free approach
**Process**: Resample with replacement
**Applications**: Confidence intervals, hypothesis tests

### Bayesian Approach
**Philosophy**: Update beliefs with data
**Advantages**: Direct probability statements
**Output**: Posterior distributions, credible intervals

## 11. Real-World Applications

### Medical Research
- Clinical trials: Drug efficacy testing
- Diagnostic tests: Sensitivity and specificity
- Epidemiology: Risk factor identification

### Business and Economics
- A/B testing: Website conversion rates
- Quality control: Process monitoring
- Market research: Customer preferences

### Social Sciences
- Education: Teaching method effectiveness
- Psychology: Behavior intervention studies
- Sociology: Social program evaluation

---

## Study Tips

1. **Understand the logic** before memorizing formulas
2. **Practice assumption checking** with real data
3. **Focus on interpretation** not just calculation
4. **Learn to communicate results** to non-statisticians
5. **Consider practical significance** alongside statistical significance
6. **Understand when NOT to use** each test
7. **Practice with different scenarios** to build intuition

---

## Quick Reference Guide

### Choosing a Test
| Data Type | One Sample | Two Independent | Two Paired |
|-----------|------------|-----------------|------------|
| **Continuous** | One-sample t | Two-sample t | Paired t |
| **Categorical** | Chi-square GOF | Chi-square independence | McNemar's test |
| **Ordinal** | Sign test | Mann-Whitney U | Wilcoxon signed-rank |

### Common Critical Values
- **Two-tailed, α = 0.05**:
  - Z: ±1.96
  - t (df=10): ±2.228
  - t (df=30): ±2.042

---

*These notes provide the conceptual framework for understanding the hypothesis testing formulas and implementations in the reference guide.*
