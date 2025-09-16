# Probability Distributions - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Probability distributions are mathematical functions that describe the likelihood of different outcomes in a random experiment. They form the foundation of statistical inference and hypothesis testing.

## 1. Normal Distribution (Gaussian Distribution)

### Key Characteristics
- **Bell-shaped curve**: Symmetric around the mean
- **Parameters**: μ (mean) and σ (standard deviation)
- **Empirical Rule (68-95-99.7)**:
  - 68% of data within 1 standard deviation
  - 95% of data within 2 standard deviations
  - 99.7% of data within 3 standard deviations

### Why is it Important?
1. **Central Limit Theorem**: Sample means approach normal distribution
2. **Natural phenomena**: Many real-world variables follow normal distribution
3. **Mathematical convenience**: Well-studied with known properties
4. **Foundation for inference**: Basis for many statistical tests

### Standard Normal Distribution
- **Z-scores**: Standardized values with μ = 0, σ = 1
- **Transformation**: Z = (X - μ)/σ
- **Applications**: Probability calculations, hypothesis testing

### Real-World Examples
- Human height and weight
- Measurement errors
- Test scores (when properly designed)
- Manufacturing tolerances

## 2. Student's t-Distribution

### When to Use
- **Small sample sizes** (typically n < 30)
- **Unknown population standard deviation**
- **Normal population assumption** still holds

### Key Features
- **Heavier tails** than normal distribution
- **Degrees of freedom (df)**: n - 1 for one-sample tests
- **Approaches normal** as df increases
- **Symmetric** around zero

### Practical Applications
- **One-sample t-test**: Testing if sample mean differs from population mean
- **Two-sample t-test**: Comparing means of two groups
- **Confidence intervals**: For population mean with unknown σ
- **Regression analysis**: Testing coefficient significance

### Degrees of Freedom Impact
- **Low df (1-5)**: Very heavy tails, wide distribution
- **Medium df (6-30)**: Moderate tail heaviness
- **High df (>30)**: Nearly identical to normal distribution

## 3. Chi-Square Distribution

### Characteristics
- **Right-skewed**: Always positive values
- **Shape depends on df**: More symmetric as df increases
- **Additive property**: Sum of independent χ² variables is χ²

### Applications
1. **Goodness-of-fit tests**: Testing if data follows expected distribution
2. **Test of independence**: Examining relationships in contingency tables
3. **Variance testing**: Testing if sample variance equals population variance
4. **Confidence intervals**: For population variance

### Degrees of Freedom
- **Goodness-of-fit**: (number of categories - 1)
- **Independence test**: (rows - 1) × (columns - 1)
- **Variance test**: n - 1

### Practical Examples
- Testing if a die is fair
- Examining relationship between gender and preference
- Quality control in manufacturing
- Medical research (treatment vs. outcome)

## 4. F-Distribution

### Purpose
- **Comparing variances** between two or more groups
- **ANOVA**: Analysis of Variance
- **Regression testing**: Overall model significance

### Parameters
- **Two degrees of freedom**: df₁ (numerator) and df₂ (denominator)
- **Always positive**: Ratio of variances
- **Right-skewed**: Shape depends on both df parameters

### Key Applications
1. **Two-sample variance test**: F = s₁²/s₂²
2. **ANOVA F-test**: Comparing multiple group means
3. **Regression F-test**: Testing overall model significance
4. **Nested model comparison**: Comparing reduced vs. full models

## 5. Understanding Distribution Relationships

### Normal Family
- **Standard Normal**: Z ~ N(0,1)
- **General Normal**: X ~ N(μ,σ²)
- **Sum of normals**: Still normal (linear combinations)

### t-Distribution Family
- **Relationship to normal**: Approaches N(0,1) as df → ∞
- **Derived from normal**: When σ unknown, use sample standard deviation

### Chi-Square Family
- **From normal**: Sum of squared standard normal variables
- **Relationship to variance**: (n-1)s²/σ² ~ χ²(n-1)

### F-Distribution Family
- **Ratio of chi-squares**: F = (χ₁²/df₁)/(χ₂²/df₂)
- **Relationship to t**: t² ~ F(1,df)

## 6. Choosing the Right Distribution

### Decision Framework

| Situation | Distribution | Key Considerations |
|-----------|--------------|-------------------|
| Large sample, known σ | Normal (Z) | n ≥ 30, σ known |
| Small sample, unknown σ | t-distribution | n < 30, σ unknown |
| Testing categorical relationships | Chi-square | Independence, goodness-of-fit |
| Comparing variances | F-distribution | ANOVA, regression |

### Sample Size Guidelines
- **n ≥ 30**: Can often use normal approximation
- **n < 30**: Consider t-distribution for means
- **Very small n**: Be cautious about distribution assumptions

## 7. Practical Considerations

### Assumption Checking
1. **Normality**: Use Q-Q plots, Shapiro-Wilk test
2. **Independence**: Consider data collection method
3. **Constant variance**: Check residual plots
4. **Sample size**: Ensure adequate power

### Common Mistakes
1. **Using normal when t is appropriate**: Underestimates uncertainty
2. **Ignoring assumptions**: Can lead to invalid conclusions
3. **Confusing parameters**: Mixing up degrees of freedom
4. **Over-relying on p-values**: Consider effect sizes too

## 8. Advanced Topics

### Non-Central Distributions
- **Non-central t**: When null hypothesis is false
- **Non-central χ²**: For power analysis
- **Non-central F**: Effect size in ANOVA

### Multivariate Extensions
- **Multivariate normal**: For correlated variables
- **Hotelling's T²**: Multivariate version of t-test
- **Wishart distribution**: Multivariate version of chi-square

## 9. Computational Aspects

### Using Software
- **R**: Built-in functions (dt, pt, qt, rt)
- **Python**: scipy.stats module
- **Critical values**: Use inverse functions
- **Simulations**: Generate random samples for understanding

### Approximations
- **Normal approximation**: When exact distributions are complex
- **Bootstrap methods**: Non-parametric alternative
- **Asymptotic results**: Large sample properties

## 10. Real-World Applications

### Quality Control
- **Control charts**: Using normal distribution
- **Process capability**: 6-sigma methodology

### Finance
- **Risk modeling**: Normal distribution assumptions
- **Value at Risk**: Tail probabilities

### Medicine
- **Clinical trials**: t-tests for treatment comparison
- **Diagnostic tests**: Chi-square for accuracy measures

### Education
- **Test scoring**: Normal distribution of abilities
- **Item analysis**: Chi-square for fairness testing

---

## Study Tips

1. **Visualize distributions** to understand shape and properties
2. **Practice with real data** to see when each distribution applies
3. **Understand the underlying assumptions** for each test
4. **Learn the relationships** between different distributions
5. **Use simulation** to build intuition about distribution behavior

---

## Key Formulas Summary

### Normal Distribution
- PDF: f(x) = (1/σ√(2π)) × e^(-½((x-μ)/σ)²)
- Z-score: Z = (X - μ)/σ

### t-Distribution
- df = n - 1 for one-sample tests
- Heavier tails than normal

### Chi-Square
- df = categories - 1 (goodness-of-fit)
- df = (r-1)(c-1) (independence)

### F-Distribution
- F = s₁²/s₂² (variance comparison)
- Two df parameters: numerator and denominator

---

*These notes provide conceptual understanding to complement the mathematical formulas in the reference guide.*
