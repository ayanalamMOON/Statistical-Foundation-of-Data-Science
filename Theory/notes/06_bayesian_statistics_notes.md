# Bayesian Statistics - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Bayesian statistics provides a framework for updating beliefs about parameters based on observed data. Unlike frequentist statistics, it treats parameters as random variables and incorporates prior knowledge into the analysis.

## 1. Fundamental Philosophy

### Frequentist vs. Bayesian Perspectives

#### Frequentist Approach
- **Parameters**: Fixed but unknown constants
- **Data**: Random variables
- **Probability**: Long-run frequency interpretation
- **Inference**: Based on sampling distributions

#### Bayesian Approach
- **Parameters**: Random variables with distributions
- **Data**: Observed (fixed once collected)
- **Probability**: Degree of belief interpretation
- **Inference**: Updates beliefs with data

### The Bayesian Learning Process
1. **Start with prior beliefs** about parameters
2. **Collect data** (evidence)
3. **Update beliefs** using Bayes' theorem
4. **Result**: Posterior distribution of parameters

## 2. Bayes' Theorem

### Basic Form
**P(A|B) = P(B|A) × P(A) / P(B)**

### Statistical Form
**π(θ|x) = f(x|θ) × π(θ) / f(x)**

**Components**:
- **π(θ|x)**: Posterior distribution
- **f(x|θ)**: Likelihood function
- **π(θ)**: Prior distribution
- **f(x)**: Marginal likelihood (evidence)

### Proportional Form
**π(θ|x) ∝ f(x|θ) × π(θ)**
- Marginal likelihood is constant for parameter inference
- Often easier to work with proportional relationships

## 3. Prior Distributions

### Types of Priors

#### Informative Priors
- **Based on previous knowledge** or expert opinion
- **Strong influence** on posterior (especially with small data)
- **Examples**: Historical data, scientific literature

#### Non-informative (Vague) Priors
- **Minimal influence** on analysis
- **Let data speak** for themselves
- **Examples**: Uniform distributions, very wide normal distributions

#### Conjugate Priors
- **Mathematical convenience**: Prior and posterior have same form
- **Analytical solutions**: Closed-form posterior distributions
- **Examples**: Beta-Binomial, Normal-Normal

### Choosing Priors
**Considerations**:
1. **Available information**: What do we know beforehand?
2. **Sensitivity analysis**: How do different priors affect results?
3. **Computational tractability**: Can we compute the posterior?
4. **Scientific validity**: Does the prior make sense in context?

**Common Mistakes**:
- Using overly informative priors without justification
- Ignoring the impact of prior choice
- Choosing priors for mathematical convenience only

## 4. Likelihood Function

### Definition and Properties
**L(θ|x) = f(x|θ)**: Probability of data given parameters
**Same function as PDF**, but viewed as function of θ

**Properties**:
- Not a probability distribution in θ
- Contains all information from data about θ
- Proportional to probability of observed data

### Maximum Likelihood
**MLE**: Value of θ that maximizes L(θ|x)
**Often found by**: Setting ∂ln L(θ)/∂θ = 0
**Frequentist estimate**: Uses only likelihood, ignores prior

## 5. Posterior Distributions

### Interpretation
**Complete information** about parameter after observing data
**Probability statements**: Can make direct probability statements about parameters
**Example**: P(0.4 < θ < 0.6 | data) = 0.95

### Point Estimates from Posterior
**Posterior Mean**: E[θ|x] = ∫θπ(θ|x)dθ
**Posterior Median**: 50th percentile of posterior
**MAP (Maximum A Posteriori)**: Mode of posterior distribution

### Interval Estimates
**Credible Intervals**: Bayesian analog of confidence intervals
**Equal-tailed**: P(θ < L) = P(θ > U) = α/2
**HPD (Highest Posterior Density)**: Shortest interval containing (1-α)×100% probability

## 6. Conjugate Prior Families

### Beta-Binomial Model
**Prior**: θ ~ Beta(α, β)
**Likelihood**: X|θ ~ Binomial(n, θ)
**Posterior**: θ|x ~ Beta(α + x, β + n - x)

**Interpretation**:
- α: Prior "successes"
- β: Prior "failures"
- Posterior updates counts

**Applications**: Success rates, proportions, probabilities

### Normal-Normal Model (Known Variance)
**Prior**: μ ~ N(μ₀, σ₀²)
**Likelihood**: X|μ ~ N(μ, σ²) [σ² known]
**Posterior**: μ|x ~ N(μₙ, σₙ²)

**Posterior parameters**:
- μₙ = (σ²μ₀ + nσ₀²x̄)/(σ² + nσ₀²)
- σₙ² = σ²σ₀²/(σ² + nσ₀²)

**Interpretation**: Weighted average of prior mean and sample mean

### Gamma-Poisson Model
**Prior**: λ ~ Gamma(α, β)
**Likelihood**: X|λ ~ Poisson(λ)
**Posterior**: λ|x ~ Gamma(α + Σxᵢ, β + n)

**Applications**: Count data, rates, arrival times

## 7. Non-Conjugate Models

### When Conjugacy Doesn't Apply
- **Complex likelihood functions**
- **Non-standard prior distributions**
- **Multiple parameters with complex relationships**

### Computational Methods
**Grid Approximation**: Evaluate posterior on grid
**Rejection Sampling**: Accept/reject samples from proposal
**Importance Sampling**: Weight samples from proposal
**Markov Chain Monte Carlo (MCMC)**: Advanced sampling methods

### MCMC Methods
**Metropolis-Hastings**: General purpose sampler
**Gibbs Sampling**: For conditional conjugacy
**Hamiltonian Monte Carlo**: Uses gradient information

## 8. Model Comparison

### Marginal Likelihood
**f(x) = ∫f(x|θ)π(θ)dθ**: Probability of data under model
**Model evidence**: How well model predicts data
**Bayes Factor**: Ratio of marginal likelihoods

### Bayes Factors
**BF₁₂ = f(x|M₁)/f(x|M₂)**: Evidence for model 1 vs. model 2

**Interpretation Guidelines**:
- BF > 10: Strong evidence for model 1
- 3 < BF < 10: Moderate evidence
- 1/3 < BF < 3: Weak evidence
- BF < 1/3: Evidence against model 1

### Information Criteria
**DIC (Deviance Information Criterion)**: Bayesian AIC analog
**WAIC (Watanabe AIC)**: More general than DIC
**Leave-One-Out CV**: Cross-validation approach

## 9. Hierarchical Models

### Structure
**Multiple levels** of parameters
**Parameters have their own parameters** (hyperparameters)
**Examples**: Students within schools, patients within hospitals

### Simple Hierarchical Model
**Level 1**: yᵢⱼ|θⱼ ~ N(θⱼ, σ²)
**Level 2**: θⱼ|μ, τ² ~ N(μ, τ²)
**Level 3**: μ ~ N(μ₀, σ₀²), τ² ~ InvGamma(a, b)

### Benefits
**Borrowing strength**: Information shared across groups
**Shrinkage**: Extreme estimates pulled toward group mean
**Uncertainty quantification**: Accounts for multiple sources of variation

## 10. Decision Theory

### Loss Functions
**Quantify cost** of incorrect decisions
**Common loss functions**:
- Squared error: L(θ, δ) = (θ - δ)²
- Absolute error: L(θ, δ) = |θ - δ|
- 0-1 loss: L(θ, δ) = I(θ ≠ δ)

### Bayes Risk
**Expected loss**: R(δ) = E[L(θ, δ)|data]
**Bayes estimator**: Minimizes Bayes risk
**Optimal decisions**: Choose action with minimum expected loss

### Example: Estimation
**Squared error loss**: Bayes estimator is posterior mean
**Absolute error loss**: Bayes estimator is posterior median
**0-1 loss**: Bayes estimator is posterior mode

## 11. Practical Considerations

### Prior Sensitivity
**Robust analysis**: How much do results depend on prior?
**Sensitivity analysis**: Try different reasonable priors
**Prior predictive checks**: Do priors imply reasonable data?

### Posterior Predictive Checks
**Generate new data** from posterior predictive distribution
**Compare to observed data**: Model adequacy assessment
**Discrepancies indicate** model problems

### Computational Issues
**Convergence diagnostics**: Has MCMC converged?
**Effective sample size**: How many independent samples?
**Monte Carlo standard error**: Uncertainty in estimates

## 12. Advantages and Disadvantages

### Advantages
1. **Direct probability statements** about parameters
2. **Incorporates prior knowledge** naturally
3. **Coherent framework** for uncertainty quantification
4. **Flexible modeling** of complex problems
5. **Automatic multiplicity adjustment**

### Disadvantages
1. **Subjective prior choice**
2. **Computational complexity**
3. **Model sensitivity**
4. **Less familiar to many practitioners**
5. **Can be slow for large datasets**

## 13. Applications

### Clinical Trials
**Adaptive designs**: Modify trial based on interim results
**Historical controls**: Incorporate prior trial data
**Safety monitoring**: Continuous evidence accumulation

### Machine Learning
**Bayesian neural networks**: Uncertainty in weights
**Gaussian processes**: Flexible function modeling
**Bayesian optimization**: Efficient hyperparameter tuning

### A/B Testing
**Early stopping**: Stop when sufficient evidence
**Multiple testing**: Natural framework for multiple comparisons
**Revenue optimization**: Incorporate business costs

### Quality Control
**Process monitoring**: Update beliefs about process parameters
**Reliability analysis**: Component failure rates
**Risk assessment**: Uncertainty quantification

## 14. Software and Implementation

### R Packages
**MCMCpack**: General MCMC functions
**rstan**: Interface to Stan
**rstanarm**: Pre-compiled Bayesian models
**brms**: Bayesian regression using Stan

### Python Libraries
**PyMC3**: Probabilistic programming
**Stan (PyStan)**: Cross-platform Bayesian modeling
**Edward/TensorFlow Probability**: Deep learning integration

### Specialized Software
**BUGS/WinBUGS**: Classic Bayesian software
**JAGS**: Cross-platform BUGS implementation
**Stan**: Modern, efficient Bayesian computation

## 15. Common Misconceptions

### About Bayesian Methods
1. **"Always subjective"**: Can use weakly informative priors
2. **"Too computational"**: Simple models have analytical solutions
3. **"Always better"**: Depends on problem and prior quality
4. **"Confidence intervals same as credible intervals"**: Different interpretations

### About Priors
1. **"Priors always dominate"**: Depends on sample size and informativeness
2. **"Non-informative priors are objective"**: Still contain implicit assumptions
3. **"Conjugate priors required"**: Convenient but not necessary

## 16. Comparison with Frequentist Methods

### Philosophical Differences
| Aspect | Frequentist | Bayesian |
|--------|-------------|----------|
| **Parameters** | Fixed constants | Random variables |
| **Probability** | Long-run frequency | Degree of belief |
| **Inference** | Sampling distribution | Posterior distribution |
| **Prior info** | Ignored | Incorporated |

### Practical Differences
**Sample size**: Bayesian can work with small samples
**Multiple testing**: Natural in Bayesian framework
**Stopping rules**: Less relevant in Bayesian analysis
**Interpretation**: Direct probability statements possible

### When Each is Preferred
**Frequentist**: Regulatory settings, large samples, established procedures
**Bayesian**: Small samples, complex models, incorporating prior knowledge

---

## Study Tips

1. **Start with simple conjugate examples** before tackling complex models
2. **Understand the philosophical differences** from frequentist approach
3. **Practice prior specification** and sensitivity analysis
4. **Learn basic MCMC concepts** for computational implementation
5. **Work through real examples** to see practical benefits
6. **Understand when Bayesian methods add value** vs. frequentist approaches
7. **Practice interpreting posterior distributions** and credible intervals

---

## Key Formulas Summary

### Bayes' Theorem
- **π(θ|x) = f(x|θ)π(θ) / f(x)**
- **Posterior ∝ Likelihood × Prior**

### Common Conjugate Pairs
- **Beta-Binomial**: Beta(α,β) → Beta(α+x, β+n-x)
- **Normal-Normal**: Updates by precision weighting
- **Gamma-Poisson**: Gamma(α,β) → Gamma(α+Σx, β+n)

### Model Comparison
- **Bayes Factor**: BF = f(x|M₁)/f(x|M₂)
- **Posterior odds**: Prior odds × Bayes factor

---

*These notes provide the conceptual foundation for understanding Bayesian statistics and its applications in data science.*
