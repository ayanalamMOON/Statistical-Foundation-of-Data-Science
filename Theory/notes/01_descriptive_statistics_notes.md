# Descriptive Statistics - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Descriptive statistics provide tools to summarize and describe the main features of a dataset. They help us understand the basic characteristics of data without making inferences about a larger population.

## 1. Measures of Central Tendency

### Arithmetic Mean
- **Purpose**: Represents the "typical" value in a dataset
- **Best used when**: Data is normally distributed without extreme outliers
- **Limitations**: Sensitive to outliers and skewed distributions
- **Example**: Average test score in a class

**Key Insights:**
- Sample mean (x̄) estimates population mean (μ)
- Unbiased estimator of population parameter
- Forms the basis for many other statistical measures

### Weighted Mean
- **Purpose**: When observations have different levels of importance
- **Applications**:
  - GPA calculations (credit hours as weights)
  - Portfolio returns (investment amounts as weights)
  - Survey data (population representation weights)

### Median
- **Purpose**: Middle value that divides data into two equal halves
- **Advantages**:
  - Robust to outliers
  - Better for skewed distributions
  - Always exists for ordered data
- **Disadvantages**:
  - Doesn't use all data points
  - Less efficient than mean for normal distributions

### Mode
- **Purpose**: Most frequently occurring value
- **Types**:
  - Unimodal: One mode
  - Bimodal: Two modes
  - Multimodal: Multiple modes
- **Applications**: Categorical data, identifying peaks in distributions

## 2. Measures of Dispersion

### Variance and Standard Deviation
- **Variance (σ²)**: Average squared deviation from mean
- **Standard Deviation (σ)**: Square root of variance
- **Why square deviations?**
  - Eliminates negative values
  - Gives more weight to larger deviations
  - Mathematical properties (differentiable)

**Population vs Sample:**
- Population: Divide by N (all data available)
- Sample: Divide by n-1 (Bessel's correction for unbiased estimation)

### Range
- **Simplest measure**: Max - Min
- **Limitations**: Only uses two data points, sensitive to outliers
- **Useful for**: Quick assessment, quality control

### Interquartile Range (IQR)
- **Definition**: Q3 - Q1 (75th percentile - 25th percentile)
- **Advantages**: Robust to outliers, focuses on middle 50% of data
- **Applications**: Box plots, outlier detection

### Coefficient of Variation (CV)
- **Purpose**: Relative measure of variability
- **Formula**: CV = (σ/μ) × 100%
- **Use cases**: Comparing variability across different units or scales

## 3. Shape and Distribution Characteristics

### Skewness
- **Right-skewed (positive)**: Tail extends to the right, mean > median
- **Left-skewed (negative)**: Tail extends to the left, mean < median
- **Symmetric**: Mean ≈ median ≈ mode

### Kurtosis
- **Measures**: "Tailedness" of distribution
- **Mesokurtic**: Normal distribution (kurtosis = 3)
- **Leptokurtic**: Heavy tails (kurtosis > 3)
- **Platykurtic**: Light tails (kurtosis < 3)

## 4. Practical Applications

### Data Exploration Strategy
1. **Start with central tendency**: Understand typical values
2. **Examine dispersion**: Assess data variability
3. **Check distribution shape**: Identify skewness and outliers
4. **Compare measures**: Mean vs median reveals distribution characteristics

### Choosing the Right Measure
| Situation | Best Measure | Reason |
|-----------|--------------|---------|
| Normal distribution | Mean | Most efficient estimator |
| Skewed distribution | Median | Robust to skewness |
| Categorical data | Mode | Only applicable measure |
| Outliers present | Median, IQR | Robust to extreme values |
| Comparing variability | CV | Accounts for scale differences |

## 5. Common Misconceptions

1. **"Mean is always best"**: Not true for skewed or outlier-heavy data
2. **"Larger standard deviation means worse"**: Depends on context and scale
3. **"Range tells the whole story"**: Ignores distribution of middle values
4. **"Sample size doesn't matter"**: Larger samples provide more reliable estimates

## 6. Real-World Examples

### Income Data
- **Mean income**: Often higher than median due to high earners
- **Median income**: Better represents typical household
- **Mode**: Most common income bracket

### Test Scores
- **Mean**: Overall class performance
- **Standard deviation**: Score consistency
- **Range**: Spread between highest and lowest performers

### Quality Control
- **Mean**: Process center
- **Standard deviation**: Process consistency
- **CV**: Relative process variability

## 7. Key Takeaways

1. **No single statistic tells the complete story** - use multiple measures
2. **Consider data distribution** before choosing summary statistics
3. **Context matters** - what's appropriate depends on the application
4. **Visual exploration** often reveals insights not captured by numbers alone
5. **Robust measures** (median, IQR) are safer with unknown data quality

---

## Study Tips

1. **Practice with real datasets** to understand when to use each measure
2. **Create visualizations** alongside calculations to build intuition
3. **Compare different measures** on the same dataset to see their relationships
4. **Understand the assumptions** behind each statistical measure
5. **Learn to communicate results** to non-technical audiences

---

*These notes complement the formulas and implementations in the statistical_formulas_reference.ipynb notebook.*
