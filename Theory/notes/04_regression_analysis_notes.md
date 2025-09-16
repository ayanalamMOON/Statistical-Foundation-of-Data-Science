# Regression Analysis - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Regression analysis is a statistical method for modeling relationships between variables. It allows us to predict outcomes, understand relationships, and make inferences about how changes in one variable affect another.

## 1. Simple Linear Regression

### Conceptual Foundation
**Goal**: Model the relationship between two variables using a straight line
**Equation**: Y = β₀ + β₁X + ε

**Components**:
- **Y**: Dependent variable (response, outcome)
- **X**: Independent variable (predictor, explanatory)
- **β₀**: Y-intercept (value of Y when X = 0)
- **β₁**: Slope (change in Y for unit change in X)
- **ε**: Error term (random variation)

### The Method of Least Squares
**Principle**: Minimize the sum of squared residuals
**Why squared?**:
- Eliminates negative values
- Penalizes large errors more
- Mathematically tractable

**Ordinary Least Squares (OLS) Estimates**:
- β̂₁ = Σ(xᵢ - x̄)(yᵢ - ȳ) / Σ(xᵢ - x̄)²
- β̂₀ = ȳ - β̂₁x̄

### Key Assumptions (LINE)
1. **Linearity**: Relationship is linear
2. **Independence**: Observations are independent
3. **Normality**: Errors are normally distributed
4. **Equal variance**: Homoscedasticity (constant error variance)

### Interpretation Guidelines
**Slope (β₁)**:
- For every 1-unit increase in X, Y increases by β₁ units (on average)
- Sign indicates direction of relationship
- Magnitude indicates strength

**Intercept (β₀)**:
- Expected value of Y when X = 0
- May not be meaningful if X = 0 is outside data range
- Used for prediction equation

## 2. Correlation vs. Regression

### Correlation Coefficient (r)
**Purpose**: Measures strength and direction of linear relationship
**Range**: -1 ≤ r ≤ 1
**Interpretation**:
- r = 1: Perfect positive linear relationship
- r = 0: No linear relationship
- r = -1: Perfect negative linear relationship

**Guidelines for Interpretation**:
- |r| > 0.7: Strong relationship
- 0.3 < |r| < 0.7: Moderate relationship
- |r| < 0.3: Weak relationship

### Key Differences
| Aspect | Correlation | Regression |
|--------|-------------|------------|
| **Purpose** | Measure association | Model relationship |
| **Variables** | Symmetric (X,Y) | Asymmetric (X→Y) |
| **Units** | Unitless | Y units per X unit |
| **Prediction** | No | Yes |

### Relationship Between r and R²
- R² = r² (in simple linear regression)
- R² represents proportion of variance explained
- r preserves sign information

## 3. Coefficient of Determination (R²)

### Interpretation
**Definition**: Proportion of total variation in Y explained by X
**Range**: 0 ≤ R² ≤ 1
**Formula**: R² = SSR/SST = 1 - SSE/SST

**Decomposition of Variance**:
- **SST** (Total): Σ(yᵢ - ȳ)² = total variation in Y
- **SSR** (Regression): Σ(ŷᵢ - ȳ)² = variation explained by model
- **SSE** (Error): Σ(yᵢ - ŷᵢ)² = unexplained variation

### Common Misconceptions
1. **Higher R² always better**: Not necessarily - may indicate overfitting
2. **R² determines causation**: Correlation ≠ causation
3. **R² measures model accuracy**: It measures explanatory power, not predictive accuracy

## 4. Multiple Linear Regression

### Model Extension
**Equation**: Y = β₀ + β₁X₁ + β₂X₂ + ... + βₚXₚ + ε

**Matrix Notation**:
- **Y** = n×1 response vector
- **X** = n×(p+1) design matrix
- **β** = (p+1)×1 parameter vector
- **ε** = n×1 error vector

**Solution**: β̂ = (X'X)⁻¹X'Y

### Interpretation of Coefficients
**Partial regression coefficients**:
- βⱼ represents change in Y for 1-unit change in Xⱼ
- **Holding all other variables constant**
- Accounts for confounding variables

### Adjusted R²
**Purpose**: Adjusts for number of predictors
**Formula**: R²ₐdⱼ = 1 - [(1-R²)(n-1)/(n-p-1)]
**Why needed**: R² always increases with more variables

## 5. Assumptions and Diagnostics

### Checking Linearity
**Methods**:
- Scatterplots of Y vs. each X
- Residual plots vs. fitted values
- Component-plus-residual plots

**Solutions for Non-linearity**:
- Transform variables (log, square root)
- Add polynomial terms
- Use non-linear regression

### Checking Independence
**Common Violations**:
- Time series data (autocorrelation)
- Clustered data
- Spatial correlation

**Diagnostics**:
- Durbin-Watson test
- ACF plots of residuals
- Design-based solutions

### Checking Normality
**Methods**:
- Q-Q plots of residuals
- Shapiro-Wilk test
- Histogram of residuals

**Robustness**: Regression is relatively robust to normality violations

### Checking Homoscedasticity
**Symptoms of Heteroscedasticity**:
- Fan-shaped residual plots
- Larger variance for larger fitted values

**Tests**:
- Breusch-Pagan test
- White test

**Solutions**:
- Transform response variable
- Weighted least squares
- Robust standard errors

## 6. Outliers and Influential Points

### Types of Unusual Observations
1. **Outliers**: Unusual Y values (large residuals)
2. **High leverage points**: Unusual X values
3. **Influential points**: Large impact on fitted line

### Diagnostic Measures
**Leverage**: hᵢᵢ = diagonal elements of hat matrix
**Cook's Distance**: Measures overall influence
**DFBETAS**: Influence on individual coefficients

**Rules of Thumb**:
- Leverage > 2(p+1)/n: High leverage
- Cook's D > 4/n: Influential
- |DFBETAS| > 2/√n: Influential for coefficient

### Handling Strategies
1. **Investigate**: Check for data entry errors
2. **Transform**: May reduce influence
3. **Remove**: Only if clearly erroneous
4. **Robust methods**: Less sensitive to outliers

## 7. Variable Selection

### Why Variable Selection?
- **Overfitting**: Too many variables relative to sample size
- **Multicollinearity**: Highly correlated predictors
- **Interpretability**: Simpler models easier to understand
- **Prediction**: Remove noise variables

### Selection Methods
**Forward Selection**:
- Start with no variables
- Add variables that improve model

**Backward Elimination**:
- Start with all variables
- Remove non-significant variables

**Stepwise Selection**:
- Combination of forward and backward
- Can add or remove at each step

### Information Criteria
**AIC (Akaike Information Criterion)**:
- AIC = n·ln(SSE/n) + 2p
- Lower is better
- Balances fit and complexity

**BIC (Bayesian Information Criterion)**:
- BIC = n·ln(SSE/n) + p·ln(n)
- More conservative than AIC
- Stronger penalty for complexity

## 8. Multicollinearity

### Definition and Problems
**Multicollinearity**: High correlation among predictors

**Problems**:
- Unstable coefficient estimates
- Large standard errors
- Difficulty interpreting individual effects
- Poor prediction for new data

### Detection
**Correlation Matrix**: Look for high correlations (|r| > 0.8)
**Variance Inflation Factor (VIF)**:
- VIF = 1/(1-R²ⱼ) where R²ⱼ is R² from regressing Xⱼ on other X's
- VIF > 10 indicates problematic multicollinearity

### Solutions
1. **Remove variables**: Drop redundant predictors
2. **Principal Components**: Use PC regression
3. **Ridge regression**: Shrinkage method
4. **Center variables**: Helps with polynomial terms

## 9. Model Validation

### Training vs. Testing
**Training Set**: Used to fit model
**Test Set**: Used to evaluate performance
**Validation Set**: Used for model selection

**Cross-Validation**:
- k-fold CV: Divide data into k groups
- Leave-one-out CV: Special case where k = n
- Provides more robust performance estimate

### Performance Metrics
**For Continuous Outcomes**:
- **RMSE**: Root Mean Square Error
- **MAE**: Mean Absolute Error
- **R²**: Coefficient of determination

**Prediction Intervals**: Account for uncertainty in prediction

## 10. Advanced Topics

### Categorical Predictors
**Dummy Variables**: 0/1 coding for categories
**Reference Category**: Omitted category (intercept)
**Interpretation**: Difference from reference category

**Example**: Gender (Male = 0, Female = 1)
- Coefficient represents average difference between females and males

### Interaction Effects
**Model**: Y = β₀ + β₁X₁ + β₂X₂ + β₃X₁X₂ + ε
**Interpretation**: Effect of X₁ depends on level of X₂
**Centering**: Often helpful to center variables before creating interactions

### Polynomial Regression
**Model**: Y = β₀ + β₁X + β₂X² + ... + βₚXᵖ + ε
**Cautions**:
- High degree polynomials can overfit
- Extrapolation can be problematic
- Multicollinearity among polynomial terms

## 11. Practical Applications

### Predictive Modeling
**Goal**: Accurate predictions for new observations
**Focus**: Minimize prediction error
**Methods**: Cross-validation, regularization

### Explanatory Modeling
**Goal**: Understand relationships between variables
**Focus**: Interpret coefficients
**Methods**: Hypothesis testing, confidence intervals

### Causal Inference
**Goal**: Estimate causal effects
**Challenges**: Confounding variables
**Methods**: Randomized experiments, instrumental variables

## 12. Common Pitfalls

### Statistical Pitfalls
1. **Extrapolation**: Predicting outside data range
2. **Assuming causation**: Correlation ≠ causation
3. **Ignoring assumptions**: Can invalidate results
4. **Overfitting**: Too complex for sample size

### Interpretation Pitfalls
1. **Confusing correlation with causation**
2. **Ignoring confidence intervals**
3. **Over-interpreting R²**
4. **Treating observational studies as experiments**

## 13. Software Implementation

### R Implementation
```r
# Simple linear regression
model <- lm(y ~ x, data = mydata)
summary(model)

# Multiple regression
model <- lm(y ~ x1 + x2 + x3, data = mydata)
```

### Python Implementation
```python
# Using statsmodels
import statsmodels.api as sm
X = sm.add_constant(X)  # Add intercept
model = sm.OLS(y, X).fit()

# Using scikit-learn
from sklearn.linear_model import LinearRegression
model = LinearRegression().fit(X, y)
```

---

## Study Tips

1. **Understand assumptions** before applying methods
2. **Always plot your data** before and after modeling
3. **Focus on interpretation** not just fitting
4. **Practice with real datasets** to build intuition
5. **Learn diagnostic techniques** for assumption checking
6. **Understand difference** between prediction and explanation
7. **Don't forget the context** - statistical significance vs. practical importance

---

## Key Formulas Summary

### Simple Linear Regression
- **Slope**: β̂₁ = Σ(x-x̄)(y-ȳ) / Σ(x-x̄)²
- **Intercept**: β̂₀ = ȳ - β̂₁x̄
- **R²**: r² = [Σ(x-x̄)(y-ȳ)]² / [Σ(x-x̄)²Σ(y-ȳ)²]

### Multiple Linear Regression
- **Matrix form**: β̂ = (X'X)⁻¹X'Y
- **Adjusted R²**: 1 - [(1-R²)(n-1)/(n-p-1)]

---

*These notes provide the conceptual foundation for understanding regression analysis formulas and their practical applications.*
