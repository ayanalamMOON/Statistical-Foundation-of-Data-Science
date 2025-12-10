# Viva Questions for Practical Exam Problem 2
**Student**: Md Ayan Alam (GF202342645) | **Course**: Statistical Foundation of Data Science

---

## Category 1: Conceptual Understanding

### Q1: Why did you choose a two-tailed test instead of a one-tailed test?

**Answer**: I chose a two-tailed test because the problem asks whether the mean **differs** from 50g, not specifically whether it's greater or less than 50g. A two-tailed test examines both possibilities:
- H₀: μ = 50 (mean equals 50g)
- H₁: μ ≠ 50 (mean is different from 50g, either higher or lower)

If the question asked "is the mean **greater** than 50g?", I would use a one-tailed test (right-tailed). If it asked "is the mean **less** than 50g?", I would use a left-tailed test.

**Real-world context**: In quality control, we care about deviations in **both directions** because:
- Overweight packages → waste material, higher costs
- Underweight packages → customer complaints, regulatory violations

---

### Q2: What is the meaning of α = 0.05 in this context?

**Answer**: α = 0.05 is the **significance level** or **Type I error rate**, which means:

1. **Probability of false rejection**: There's a 5% chance we'll conclude the mean differs from 50g when it actually doesn't (rejecting a true H₀)

2. **Confidence level**: We're 95% confident in our decision (1 - α = 0.95)

3. **Critical region**: We reject H₀ if our test statistic falls in the most extreme 5% of the distribution (2.5% in each tail for two-tailed test)

**Trade-off consideration**:
- Lower α (e.g., 0.01) → Harder to reject H₀ → Fewer false alarms but may miss real differences
- Higher α (e.g., 0.10) → Easier to reject H₀ → More sensitive but more false alarms

In quality control, α = 0.05 balances these concerns appropriately.

---

### Q3: What is a p-value and how do you interpret p = 0.3173?

**Answer**: The p-value is the **probability of observing our data (or more extreme) if H₀ is true**.

**For p = 0.3173**:
- There's a 31.73% chance of getting a sample mean as far or farther from 50g as we observed (x̄ = 50.5g), purely by random sampling, if the true population mean is actually 50g

**Interpretation**:
- Since p = 0.3173 > α = 0.05, we **fail to reject H₀**
- This is **NOT** strong evidence against the null hypothesis
- We cannot conclude the population mean differs from 50g

**Common misconception**: p-value ≠ "probability H₀ is true"
- Correct: Probability of data given H₀
- Incorrect: Probability of H₀ given data (that would be Bayesian posterior probability)

---

### Q4: Explain the difference between "fail to reject H₀" and "accept H₀"

**Answer**: This is a critical distinction in hypothesis testing:

**"Fail to reject H₀"** (what we say):
- Insufficient evidence to conclude the mean differs from 50g
- Doesn't prove H₀ is true, just that we don't have enough evidence against it
- Leaves open the possibility that a larger sample might find a difference

**"Accept H₀"** (what we DON'T say):
- Implies we've proven H₀ is true
- Statistically incorrect because absence of evidence ≠ evidence of absence
- Would require Bayesian methods with priors to formally "accept"

**Analogy**: In a criminal trial:
- "Not guilty" ≠ "innocent"
- "Not guilty" = insufficient evidence to convict
- Similarly: "Fail to reject H₀" = insufficient evidence to conclude difference exists

**Our conclusion**: The data don't provide strong evidence that the mean weight differs from 50g, but we cannot definitively say it equals 50g.

---

## Category 2: Statistical Calculations

### Q5: Walk through the calculation of the sample standard deviation. Why do we use n-1 instead of n?

**Answer**:

**Calculation steps**:
```
1. Sample mean: x̄ = 404/8 = 50.5
2. Deviations: (xᵢ - x̄) = [1.5, -1.5, 0.5, -2.5, 2.5, -3.5, -0.5, 3.5]
3. Squared deviations: [2.25, 2.25, 0.25, 6.25, 6.25, 12.25, 0.25, 12.25]
4. Sum of squared deviations: Σ(xᵢ - x̄)² = 42.0
5. Variance: s² = 42.0/(8-1) = 42.0/7 = 6.0
6. Standard deviation: s = √6.0 = 2.449
```

**Why n-1 (Bessel's correction)**:
1. **Degrees of freedom**: We used one parameter (x̄) from the data to calculate deviations, so we only have n-1 "independent" pieces of information

2. **Bias correction**: Using n would systematically **underestimate** the population variance σ² because:
   - Sample deviations are calculated from x̄ (which is closer to sample points than μ)
   - Dividing by n-1 inflates the estimate to correct this bias
   - Makes s² an **unbiased estimator** of σ²

3. **Mathematical proof**: E[s²] = σ² only when using n-1

**Practical impact**: For n=8, using n vs n-1:
- With n: s² = 42/8 = 5.25
- With n-1: s² = 42/7 = 6.0
- Difference matters more for small samples!

---

### Q6: How did you calculate the t-statistic? What does t = 0.577 mean?

**Answer**:

**Formula and calculation**:
```
t = (x̄ - μ₀) / (s / √n)
t = (50.5 - 50) / (2.449 / √8)
t = 0.5 / (2.449 / 2.828)
t = 0.5 / 0.866
t = 0.577
```

**Components**:
- **Numerator (0.5)**: How far our sample mean is from the hypothesized mean
- **Denominator (0.866)**: Standard error (SE) = uncertainty in our estimate of the mean
- **t-statistic**: Signal-to-noise ratio = (observed difference) / (sampling variability)

**Interpretation of t = 0.577**:
1. Our sample mean is only 0.577 standard errors away from the hypothesized mean
2. This is a **small deviation** - well within random sampling variation
3. For comparison, |t| > 2 would be more unusual and potentially significant

**Distribution**: Under H₀, this t-statistic follows a t-distribution with df = 7

**Geometric interpretation**: If we repeated this sampling many times when μ = 50, we'd frequently see sample means this far (or farther) from 50 just by chance.

---

### Q7: What are degrees of freedom and why is df = 7 for this test?

**Answer**:

**Definition**: Degrees of freedom (df) = number of independent pieces of information available to estimate a parameter

**For one-sample t-test**: df = n - 1

**Why n - 1?**
1. We have n = 8 observations
2. We used these 8 observations to calculate x̄
3. Once we know x̄ and 7 of the observations, the 8th is **determined** (not free to vary)
4. Therefore: df = 8 - 1 = 7

**Example of constraint**:
```
If x̄ = 50.5 and we know values [52, 49, 51, 48, 53, 47, 50],
then the 8th value MUST be 54 because:
Σxᵢ = n × x̄ = 8 × 50.5 = 404
Sum of first 7 = 350
Last value = 404 - 350 = 54 (no freedom of choice!)
```

**Impact on test**:
- Lower df → wider t-distribution → higher critical values
- df = 7: t-critical = ±2.365
- df = 30: t-critical = ±2.042
- df = ∞: t-critical = ±1.96 (approaches z-distribution)

**Why it matters**: With small samples (low df), we need **stronger evidence** (larger |t|) to reject H₀ because we're less certain about the population variance.

---

## Category 3: Test Assumptions and Alternatives

### Q8: What assumptions does the one-sample t-test require? Did you check them?

**Answer**:

**Required assumptions**:

1. **Random sampling**: Each observation independently drawn from the population
   - **Check**: Assumed for quality control sample (should verify in practice)
   - **Violation impact**: Non-representative sample → biased conclusions

2. **Normality**: Population is normally distributed (or n ≥ 30 by CLT)
   - **Check performed**: Shapiro-Wilk test
     - W = 0.9589, p = 0.7959
     - p > 0.05 → No evidence against normality
   - **Visual check**: Q-Q plot shows points near diagonal line
   - **Violation impact**: For n=8, departures from normality affect p-value accuracy

3. **Continuous data**: Measurement variable (not categorical)
   - **Check**: Weight in grams is continuous ✓

4. **No extreme outliers**: Can distort mean and SD
   - **Check performed**: No values beyond mean ± 3SD
   - **Range**: [47, 54] is reasonable for 50g target

**Verification in notebook**:
```python
# Shapiro-Wilk normality test
stat, p_value = stats.shapiro(weights)
# Result: p = 0.7959 > 0.05 → Normality assumption satisfied
```

**Robustness**: t-test is relatively robust to mild normality violations when:
- Sample size ≥ 20-30 (we have n=8, so normality matters more)
- Data roughly symmetric (our data: skewness = 0.216, nearly symmetric)

---

### Q9: What would you do if the normality assumption was violated?

**Answer**:

**Step 1: Assess severity**
```python
# Check with multiple methods
shapiro_p = stats.shapiro(data)[1]  # Formal test
skewness = stats.skew(data)          # Symmetry
kurtosis = stats.kurtosis(data)      # Tail heaviness
# Visual: Q-Q plot, histogram
```

**Step 2: Choose alternative based on severity**

**Option A: Non-parametric test (recommended for severe violations)**
- **Wilcoxon signed-rank test**: Non-parametric alternative
  ```python
  from scipy.stats import wilcoxon
  # Test if median differs from 50
  stat, p_value = wilcoxon(weights - 50)
  ```
- **Advantages**:
  - No normality assumption
  - Robust to outliers
  - Tests median instead of mean
- **Disadvantages**:
  - Less powerful than t-test if data actually normal
  - Tests different hypothesis (median vs mean)

**Option B: Data transformation (for moderate violations)**
```python
# Log transformation (for right skew)
log_weights = np.log(weights)
# Square root (for mild right skew)
sqrt_weights = np.sqrt(weights)
# Box-Cox (finds optimal transformation)
from scipy.stats import boxcox
transformed, lambda_param = boxcox(weights)
```
- Re-test normality on transformed data
- Perform t-test on transformed scale
- Back-transform results for interpretation

**Option C: Bootstrapping**
```python
from scipy.stats import bootstrap
# Generate confidence interval via resampling
result = bootstrap((weights,), np.mean, n_resamples=10000)
# Check if 50 falls in CI
```

**Decision tree**:
1. Mild violation + n ≥ 30 → Proceed with t-test (CLT applies)
2. Moderate violation + small n → Try transformation
3. Severe violation or outliers → Use Wilcoxon test
4. Uncertain → Report both parametric and non-parametric results

**For our data**: Normality holds (p=0.796), so t-test is appropriate.

---

### Q10: What is the difference between Type I and Type II errors in this context?

**Answer**:

**Type I Error (α = 0.05)**:
- **Definition**: Reject H₀ when it's actually true (false positive)
- **In our context**: Conclude the mean weight differs from 50g when it actually doesn't
- **Consequences**:
  - Unnecessary machine recalibration
  - Wasted resources investigating non-existent problem
  - Production shutdown for false alarm
- **Controlled by**: Significance level α = 0.05 (5% chance)
- **Example**: True mean is exactly 50g, but random sample gives x̄ = 53.2g → we incorrectly reject H₀

**Type II Error (β, unknown)**:
- **Definition**: Fail to reject H₀ when it's actually false (false negative)
- **In our context**: Conclude no difference from 50g when there actually is one
- **Consequences**:
  - Miss real quality control issue
  - Continue producing off-spec products
  - Potential customer complaints or regulatory violations
- **Probability**: β (not directly controlled, depends on effect size and sample size)
- **Example**: True mean is 52g, but random sample gives x̄ = 50.3g → we fail to detect the problem

**Relationship**:
```
Power = 1 - β = Probability of correctly rejecting false H₀
```

**Trade-off**:
- Decreasing α (stricter) → Increases β (less power)
- Increasing sample size → Decreases both α and β
- Larger true effect → Decreases β (easier to detect)

**In our test**:
- Set α = 0.05 (Type I error rate)
- β unknown (would need to specify alternative hypothesis)
- With n=8 and α=0.05, power is modest for small effects

**Quality control perspective**:
- Type I error: "Fixing" a machine that isn't broken (costly)
- Type II error: Letting a broken machine run (dangerous)
- Balance depends on costs: If Type II consequences are severe (e.g., medical devices), use higher α

---

## Category 4: Practical Application

### Q11: The sample mean is 50.5g. Why isn't this conclusive evidence that the population mean differs from 50g?

**Answer**:

**Key concept**: Sample statistics vary due to **sampling variability**

**1. Natural sampling variation**:
- Even if true μ = 50g exactly, different samples will give different x̄ values
- With n=8 and s=2.449, the standard error = 2.449/√8 = 0.866
- So sample means typically vary by about ±0.866g around the true mean
- Observing x̄ = 50.5g (only 0.5g different) is well within this expected variation

**2. Sampling distribution**:
```
If we took 1000 samples of n=8 when μ=50:
• 68% would have 49.1 < x̄ < 50.9 (within 1 SE)
• 95% would have 48.3 < x̄ < 51.7 (within 2 SE)
• Our x̄=50.5 falls in the "common" region
```

**3. Statistical vs practical significance**:
- **Observed difference**: 50.5 - 50 = 0.5g
- **Effect size (Cohen's d)**: 0.5/2.449 = 0.204 (small effect)
- Even if statistically significant, 0.5g may not matter practically

**4. Small sample size (n=8)**:
- High uncertainty in our estimate
- 95% CI for μ: [48.46, 52.54] is very wide
- True mean could plausibly be anywhere from 48.5g to 52.5g
- 50g is well within this range

**5. The hypothesis test confirms**:
- t = 0.577 (small, not in rejection region)
- p = 0.3173 (high probability of seeing this by chance)
- Conclusion: 0.5g difference is easily explained by random sampling

**Analogy**:
- Flipping a fair coin 8 times and getting 5 heads (62.5%)
- Does this prove the coin is biased toward heads?
- No! With only 8 flips, getting 5 heads is very plausible (p=0.36)
- Similarly, with only 8 weights, getting x̄=50.5 when μ=50 is very plausible

**Bottom line**: The 0.5g difference is within the expected "noise" of random sampling. We'd need either:
- A larger difference with n=8, OR
- The same difference with much larger n
...to have convincing evidence of a real population difference.

---

### Q12: How would your conclusion change if the sample size was n=80 instead of n=8, with the same mean and standard deviation?

**Answer**:

**Recalculation with n=80**:
```
Given: x̄ = 50.5, s = 2.449, μ₀ = 50, n = 80 (instead of 8)

Standard Error = s/√n = 2.449/√80 = 2.449/8.944 = 0.274

t = (x̄ - μ₀) / SE = (50.5 - 50) / 0.274 = 0.5 / 0.274 = 1.825

df = 80 - 1 = 79
```

**Critical value and p-value**:
```
Two-tailed test, α = 0.05, df = 79:
t_critical = ±1.990

p-value ≈ 0.072 (from t-distribution)
```

**Comparison**:

| Aspect                    | n=8             | n=80             | Change        |
| ------------------------- | --------------- | ---------------- | ------------- |
| Standard Error            | 0.866           | 0.274            | ↓ 68%         |
| t-statistic               | 0.577           | 1.825            | ↑ 216%        |
| p-value                   | 0.317           | 0.072            | ↓ 77%         |
| Decision (α=0.05)         | Fail to reject  | Fail to reject   | Same          |
| Closeness to significance | Far (p >> 0.05) | Close (p ≈ 0.05) | More evidence |

**Key insights**:

1. **Smaller standard error**: SE drops from 0.866 to 0.274
   - More precise estimate of the population mean
   - Tighter confidence interval

2. **Larger t-statistic**: t increases from 0.577 to 1.825
   - Same observed difference (0.5g) becomes more "unusual"
   - Closer to rejection region (t_crit = 1.990)

3. **Lower p-value**: p drops from 0.317 to 0.072
   - Getting closer to α = 0.05 threshold
   - More evidence against H₀, but still not quite significant

4. **Still fail to reject**: p = 0.072 > 0.05
   - But now it's a "marginal" result
   - If α were 0.10, we'd reject H₀

**Practical implications**:
- With n=80, the 0.5g difference is **detectable but not conclusive** at α=0.05
- Suggests there might be a small real effect that n=8 couldn't detect
- Quality control decision: Might warrant further investigation with even larger sample

**Statistical principle demonstrated**:
- Same effect size becomes more statistically significant with larger n
- "Significant" depends on both effect size AND sample size
- This is why large studies can find "significant" but trivially small effects

**What if we wanted to detect this 0.5g difference reliably?**
- Power analysis: To detect 0.5g difference with 80% power at α=0.05
- Required n ≈ 190 observations
- Shows that n=8 is severely underpowered for this small effect

---

### Q13: Calculate and interpret a 95% confidence interval for the population mean.

**Answer**:

**Calculation**:
```
Formula: x̄ ± t_(α/2, df) × (s/√n)

Given:
• x̄ = 50.5
• s = 2.449
• n = 8
• df = 7
• α = 0.05 → α/2 = 0.025
• t_(0.025, 7) = 2.365 (from t-table)
• SE = s/√n = 2.449/√8 = 0.866

Margin of Error = t × SE = 2.365 × 0.866 = 2.048

95% CI = 50.5 ± 2.048
       = [48.45, 52.55]
```

**Interpretation**:

**1. Correct interpretation (frequentist)**:
"If we repeated this sampling process many times and constructed a 95% CI each time, approximately 95% of those intervals would contain the true population mean μ."

**2. Practical interpretation for this sample**:
"We are 95% confident that the true mean weight of packaged items lies between 48.45g and 52.55g."

**3. In quality control context**:
- Target weight: μ₀ = 50g
- Our CI: [48.45, 52.55]
- **Observation**: 50g is well within our confidence interval
- **Implication**: The data are consistent with μ = 50g
- **Action**: No evidence to conclude the machine needs adjustment

**4. Connection to hypothesis test**:
```
Equivalence rule for two-tailed test:
• If 95% CI contains μ₀ → Fail to reject H₀ at α = 0.05 ✓
• If 95% CI excludes μ₀ → Reject H₀ at α = 0.05

Our case: 50 ∈ [48.45, 52.55] → Fail to reject H₀
Matches our p-value conclusion (p = 0.317 > 0.05)
```

**5. Width of interval (4.10g)**:
- Relatively wide due to small sample size (n=8)
- High uncertainty in population mean estimate
- If we need more precision → increase sample size

**What if we wanted narrower CI?**
```
Target width: ±1g (margin of error = 1g)
Required: 1 = 2.365 × (2.449/√n)
Solve for n: n = (2.365 × 2.449/1)² ≈ 34 observations

To get margin of error ±0.5g: n ≈ 133 observations
```

**Common misconceptions to avoid**:
- ❌ "95% probability that μ is in [48.45, 52.55]" (μ is fixed, not random)
- ❌ "95% of data falls in this interval" (that's a prediction interval, not confidence interval)
- ✓ "95% confident that this interval captures the true μ" (correct)

**Visual interpretation**: If we plotted 20 different 95% CIs from 20 samples, we'd expect about 19 (95%) to contain the true μ, and 1 (5%) to miss it by chance.

---

### Q14: What is the power of this test, and why does it matter?

**Answer**:

**Definition**:
Power = 1 - β = Probability of correctly rejecting H₀ when it's false

**For our test**, power depends on:
1. **Sample size**: n = 8 (small → lower power)
2. **Significance level**: α = 0.05 (standard)
3. **Effect size**: How far true μ is from 50g (unknown in practice)
4. **Variability**: s = 2.449g (higher s → lower power)

**Power calculation for specific alternative**:
Let's calculate power if the true mean were μ = 52g (2g above target):

```python
from statsmodels.stats.power import ttest_power

# Parameters
effect_size = (52 - 50) / 2.449  # Cohen's d = 0.817 (large effect)
n = 8
alpha = 0.05

# Calculate power
power = ttest_power(effect_size, n, alpha, alternative='two-sided')
# Power ≈ 0.47 (47%)
```

**Interpretation of 47% power**:
- If the true mean is actually 52g (2g difference from target)
- With our sample size n=8
- We only have a 47% chance of detecting this difference at α=0.05
- **53% chance of Type II error** (missing a real problem!)

**Power for different effect sizes**:

| True μ | Effect Size (Cohen's d) | Power      |
| ------ | ----------------------- | ---------- |
| 50.5g  | 0.204 (small)           | 0.08 (8%)  |
| 51g    | 0.408 (medium)          | 0.18 (18%) |
| 52g    | 0.817 (large)           | 0.47 (47%) |
| 53g    | 1.225 (very large)      | 0.75 (75%) |

**Why power matters**:

1. **Quality control reliability**:
   - Low power = high risk of missing real quality issues
   - With n=8, we'd miss even a 2g deviation 53% of the time!
   - Could lead to shipping defective products

2. **Sample size planning**:
   - Standard target: 80% power (20% Type II error rate)
   - To detect 1g difference with 80% power:
     ```python
     from statsmodels.stats.power import tt_solve_power
     n_required = tt_solve_power(effect_size=1/2.449,
                                  alpha=0.05,
                                  power=0.80,
                                  alternative='two-sided')
     # n ≈ 61 observations needed
     ```

3. **Study interpretation**:
   - Our non-significant result (p=0.317) doesn't mean "no difference exists"
   - With low power, absence of evidence ≠ evidence of absence
   - Could be: (a) no difference, OR (b) difference exists but sample too small

**Increasing power**:
- ↑ Sample size (most effective): n=8 → n=60 dramatically improves power
- ↓ Variability: Better measurement precision → lower s → higher power
- ↑ Effect size: Only controllable in experimental design (not applicable here)
- ↑ Alpha: α=0.05 → α=0.10 increases power but more Type I errors

**Recommendation for quality control**:
- Current n=8 is insufficient for reliable detection
- Minimum sample size: n ≈ 30 for moderate effects
- Optimal: n ≥ 60 for good power (80%+) to detect 1g differences
- Consider sequential sampling or control charts for ongoing monitoring

---

## Category 5: Interpretation and Communication

### Q15: How would you explain your findings to a non-technical quality control manager?

**Answer**:

**Executive summary approach**:

---

**To**: Quality Control Manager
**Re**: Weight Testing Results for Machine Calibration
**Date**: December 9, 2025

**Question**: Does our packaging machine need recalibration? Target weight is 50g.

**Short Answer**: **No recalibration needed** based on current data.

**What We Found**:
- Tested 8 randomly selected packages
- Average weight: 50.5g (only 0.5g above target)
- All packages ranged from 47g to 54g (reasonable variation)
- Statistical test shows this 0.5g difference is likely due to normal measurement variation, not a calibration problem

**Statistical Confidence**:
- Our analysis has 95% confidence that the true average weight is somewhere between 48.5g and 52.5g
- Since our target of 50g falls comfortably in this range, there's no strong evidence the machine is off-target
- Probability this result happened by pure chance: 32% (quite likely)

**What This Means**:
✓ **No immediate action required** on machine calibration
✓ Observed variation is within normal operating range
✓ Continue standard quality monitoring procedures

**Important Caveats**:
⚠️ **Small sample size** (only 8 packages):
   - Cannot rule out small problems (e.g., 1g drift)
   - Larger sample would give more definitive answer

⚠️ **Recommendation**:
   - Continue monitoring with larger monthly samples (30-50 packages)
   - Consider implementing control charts for ongoing tracking
   - Retest if customer complaints increase

**Analogy**:
Think of it like checking your body temperature. If 8 readings average 98.9°F (target: 98.6°F), that 0.3° difference doesn't mean you have a fever—it's within normal day-to-day variation. Same principle here with weight measurements.

---

**Visual aid to include**:
```
[Show box plot with reference line at 50g]
[Show confidence interval diagram]
```

**Follow-up questions anticipated**:
1. *"Should we keep testing?"* → Yes, larger sample for confirmation
2. *"What if we see drift over time?"* → Control charts will catch trends
3. *"How many packages to test monthly?"* → Recommend minimum 30

---

**Key communication principles used**:
1. **Lead with conclusion**: Answer the business question first
2. **Avoid jargon**: "Confidence interval" explained in plain terms
3. **Use visuals**: Box plots are intuitive
4. **Provide context**: Explain what statistical significance means practically
5. **Action-oriented**: Clear recommendations (continue monitoring vs recalibrate)
6. **Acknowledge limitations**: Small sample size caveat
7. **Analogy**: Body temperature comparison makes concept relatable

**What to avoid**:
- ❌ "The p-value of 0.3173 exceeds the alpha level of 0.05..."
- ❌ "We fail to reject the null hypothesis..."
- ❌ Technical formulas and calculations
- ❌ Focusing on test mechanics instead of business implications

**Follow-up materials to provide**:
- One-page visual summary
- Trend chart if historical data available
- Recommendation for sample size increase
- Threshold guidelines for when to recalibrate (e.g., if future x̄ > 52g or < 48g)

---

### Q16: What recommendations would you make based on these results?

**Answer**:

**Immediate Recommendations** (Based on Current Test):

**1. No Machine Recalibration Required**
- ✅ Current evidence: Mean weight of 50.5g is statistically consistent with 50g target
- ✅ All weights within reasonable tolerance (47-54g)
- ✅ Action: Continue normal production operations

**2. Acknowledge Test Limitations**
- ⚠️ Sample size (n=8) provides low statistical power
- ⚠️ Cannot confidently detect differences smaller than ~2g
- ⚠️ Result is "absence of evidence," not "evidence of absence"

**Strategic Recommendations** (Process Improvement):

**3. Implement Larger Routine Sampling**
```
Current: n=8 packages tested
Recommended: n=30-50 per shift or daily batch

Benefits:
• Power to detect 1g deviations: 8% → 80%
• Narrower confidence intervals: ±2.0g → ±0.7g
• More reliable quality decisions
• Earlier detection of calibration drift

Cost-benefit:
• Testing time: +15 minutes per shift
• Prevents costly recalls or customer complaints
• Industry standard for quality control
```

**4. Establish Statistical Process Control (SPC)**
```
Implement control charts (X-bar and R charts):

X-bar Chart:
• Plot daily mean weights
• Control limits: 50 ± 3×(s/√n)
• Signal rules:
  - 1 point beyond control limits → investigate immediately
  - 2 of 3 consecutive points beyond 2σ → warning
  - 8 consecutive points on one side of center → trend alert

R Chart:
• Monitor variability (range)
• Detect changes in measurement precision
• Identify when s increases (less consistent production)
```

**5. Define Action Thresholds**
```
Create decision tree for future tests:

IF mean weight > 52g OR mean weight < 48g
  → STOP production, recalibrate immediately

ELSE IF 51g < mean < 52g OR 48g < mean < 49g
  → WARNING: Schedule calibration check within 24 hours
  → Increase sampling frequency

ELSE IF 49g ≤ mean ≤ 51g
  → CONTINUE normal operations
  → Maintain standard monitoring
```

**6. Root Cause Analysis Preparation**
Even though no issue detected now, prepare for future:
```
If recalibration becomes necessary, investigate:
• Machine wear patterns (bearings, dispensing mechanisms)
• Environmental factors (temperature, humidity affecting density)
• Raw material variation (different batches)
• Operator technique differences (shift-to-shift variation)
• Measurement instrument calibration (scale accuracy)
```

**7. Cost-Benefit Considerations**
```
Type I Error (False alarm - recalibrate when not needed):
• Cost: 2 hours downtime + technician ($500)
• Current risk: 5% (α = 0.05)

Type II Error (Miss real problem):
• Cost: Regulatory fine ($10,000) OR customer complaints (reputation)
• Current risk: ~50% for small deviations (low power)

Recommendation:
• Accept current α = 0.05 (Type I risk)
• Reduce Type II risk by increasing sample size
• Cost of testing 50 vs 8 packages: minimal (~$20/day)
• ROI: Prevents one $10k fine per year → 180x return
```

**8. Documentation and Training**
```
Immediate actions:
☐ Document this baseline test in quality records
☐ Train operators on acceptable weight ranges [47-54g]
☐ Create visual reference card for sampling procedure
☐ Establish monthly statistical review meetings
☐ Archive data for trend analysis (detect gradual drift)
```

**9. Alternative Testing Approaches**
For ongoing monitoring, consider:
```
Option A: Sequential Probability Ratio Test (SPRT)
• Test continuously, stop when decision reached
• More efficient than fixed n
• Reduces average sample size by 30-50%

Option B: Acceptance Sampling Plans
• AQL (Acceptable Quality Level) based approach
• E.g., accept batch if ≤2 out of 50 packages are outside [48, 52]g
• Industry standard (ISO 2859)

Option C: Automated In-Line Weighing
• Weigh every package automatically
• Real-time alerts for out-of-spec items
• Capital investment: ~$15,000, payback: 2 years
```

**10. Reporting Schedule**
```
Weekly: Update control charts, flag any trends
Monthly: Statistical summary report to management
Quarterly: Comprehensive review with recommendations
Annually: Compare to regulatory standards and benchmarks
```

**Summary of Priorities**:
1. **Short-term** (This Week): Continue production, no recalibration
2. **Medium-term** (This Month): Implement larger sample sizes (n=30-50)
3. **Long-term** (This Quarter): Deploy statistical process control charts
4. **Strategic** (This Year): Consider automated weighing system

**Key Success Metrics**:
- Reduce quality escapes (defective products reaching customers) by 80%
- Decrease false alarm rate (unnecessary recalibrations) by 50%
- Improve process capability index (Cpk) from current to >1.33
- Achieve Six Sigma quality level (3.4 defects per million)

---

## Category 6: Advanced Statistical Concepts

### Q17: What is the relationship between confidence intervals and hypothesis tests?

**Answer**:

**Fundamental Equivalence**:

For a two-tailed test at significance level α:
- **95% CI** corresponds to **α = 0.05** test
- **99% CI** corresponds to **α = 0.01** test
- **90% CI** corresponds to **α = 0.10** test

**Decision Rule**:
```
If μ₀ is INSIDE the (1-α)×100% CI → Fail to reject H₀ at level α
If μ₀ is OUTSIDE the (1-α)×100% CI → Reject H₀ at level α
```

**Our Example**:
```
95% CI: [48.45, 52.55]
H₀: μ = 50

Since 50 ∈ [48.45, 52.55]:
→ Fail to reject H₀ at α = 0.05 ✓

This matches our hypothesis test result (p = 0.317 > 0.05)
```

**Mathematical Derivation**:
```
Confidence Interval:
x̄ ± t_(α/2, df) × SE

Hypothesis Test:
Reject H₀ if |t_obs| > t_(α/2, df)

Where t_obs = (x̄ - μ₀) / SE

Equivalence:
Reject H₀ ⟺ μ₀ is outside CI

Proof:
|x̄ - μ₀| > t_(α/2, df) × SE
⟺ μ₀ < x̄ - t_(α/2, df) × SE  OR  μ₀ > x̄ + t_(α/2, df) × SE
⟺ μ₀ is outside [x̄ - t×SE, x̄ + t×SE]
⟺ μ₀ is outside the confidence interval
```

**Why Both Approaches Exist**:

**Hypothesis Test Advantages**:
1. Gives explicit p-value (strength of evidence)
2. Directly answers "Is there a difference?" question
3. Controls Type I error rate precisely
4. Standard in scientific reporting

**Confidence Interval Advantages**:
1. Shows **plausible range** of parameter values
2. Gives effect size information (width = precision)
3. Shows **practical significance**, not just statistical
4. Can test multiple hypotheses simultaneously
   - From [48.45, 52.55], we know:
     - μ = 50? ✓ Plausible
     - μ = 48? ✓ Plausible
     - μ = 53? ✓ Plausible
     - μ = 55? ✗ Outside CI, implausible

**Complementary Information**:
```
Example Scenario:

Hypothesis Test:
H₀: μ = 50 vs H₁: μ ≠ 50
Result: p = 0.317 → Fail to reject
Tells us: "No significant difference from 50"

95% CI: [48.45, 52.55]
Tells us ADDITIONALLY:
• True mean could reasonably be anywhere in this range
• Difference from 50 could be as much as ±2.5g
• Uncertainty is high due to small sample (wide interval)
• Effect size is small (interval centered near 50)
```

**Extension to One-Tailed Tests**:
```
One-tailed test at α = 0.05 corresponds to:
• 90% CI (not 95%!)
• Because confidence level = 1 - 2α for two-tailed
                          = 1 - α for one-tailed

Example:
H₀: μ ≤ 50 vs H₁: μ > 50 (right-tailed, α=0.05)
Reject if μ₀ < lower bound of 90% CI

90% CI for our data:
x̄ - t_(0.10, 7) × SE = 50.5 - 1.895×0.866 = 48.86
→ Reject H₀ if 50 < 48.86 (false)
→ Fail to reject (matches p-value approach)
```

**Practical Workflow**:
```
Recommended approach: Report BOTH

1. State hypothesis test result:
   "t(7) = 0.577, p = 0.317, fail to reject H₀"

2. Provide confidence interval:
   "95% CI: [48.45, 52.55]"

3. Interpret together:
   "The data do not provide strong evidence that the mean
    differs from 50g (p = 0.317). The true mean could
    plausibly range from 48.5g to 52.5g, consistent with
    the target of 50g."
```

**Common Pitfall**:
```
❌ "Since 50 is in the CI, we accept H₀"
✓ "Since 50 is in the CI, we fail to reject H₀"

The CI contains many values—we don't "accept" all of them!
CI shows plausibility, not proof.
```

**Visualizing the Relationship**:
```
        Hypothesis Test               Confidence Interval
              |                              |
         p-value (0.317)           CI: [48.45, 52.55]
              |                              |
    p > 0.05 → FTR H₀            50 ∈ CI → FTR H₀
              |                              |
              └──────────────────────────────┘
                   Same Conclusion
```

---

### Q18: Explain what Cohen's d effect size means and why we report it.

**Answer**:

**Definition**:
Cohen's d is a **standardized measure of effect size** that quantifies the magnitude of difference between two means in units of standard deviation.

**Formula**:
```
Cohen's d = (x̄ - μ₀) / s
          = (50.5 - 50) / 2.449
          = 0.5 / 2.449
          = 0.204
```

**Interpretation Guidelines** (Cohen's conventions):
```
|d| < 0.2    → Negligible/Trivial effect
|d| = 0.2    → Small effect
|d| = 0.5    → Medium effect
|d| = 0.8    → Large effect
|d| > 1.2    → Very large effect

Our result: d = 0.204 → Small effect (borderline negligible)
```

**What d = 0.204 Means Practically**:

1. **Standard deviation units**:
   - Sample mean is 0.204 standard deviations above the hypothesized mean
   - In other words, 20.4% of one SD
   - Small magnitude in "typical variation" terms

2. **Overlap of distributions**:
   - If we imagine two populations (one at μ=50, one at μ=50.5)
   - With same SD = 2.449
   - Cohen's d = 0.204 means ~92% overlap between distributions
   - Very similar distributions with minor shift

3. **Percentile interpretation**:
   - If someone at the mean of the "50.5g distribution"
   - They'd be at approximately the 58th percentile of the "50g distribution"
   - Barely above average in the reference population

**Why We Report Effect Size**:

**Problem 1: P-values don't tell magnitude**
```
Scenario A: n=8, x̄=50.5, s=2.449
→ p = 0.317 (not significant)
→ d = 0.204 (small effect)

Scenario B: n=800, x̄=50.5, s=2.449
→ p = 0.005 (highly significant!)
→ d = 0.204 (same small effect)

Same effect size, different statistical significance!
p-value conflates effect size with sample size.
Cohen's d isolates the effect magnitude.
```

**Problem 2: Statistical vs Practical Significance**
```
Large sample can make tiny effects "significant":

Example: n=10,000, x̄=50.05, μ₀=50, s=2.449
→ p < 0.001 (statistically significant)
→ d = 0.05/2.449 = 0.02 (trivially small)

Decision: Statistically significant but practically meaningless
         Don't recalibrate for 0.05g difference

Effect size prevents overreaction to "significant" but tiny effects.
```

**Problem 3: Cross-study comparisons**
```
Study 1: Weight difference of 0.5g (our study)
         s₁ = 2.449 → d₁ = 0.204

Study 2: Different manufacturing process
         Weight difference of 0.5g
         s₂ = 1.0 → d₂ = 0.5

Same absolute difference (0.5g), but:
• Study 1: Small effect (high variability context)
• Study 2: Medium effect (low variability context)

Cohen's d enables fair comparison across different contexts.
```

**Quality Control Application**:

**Effect Size Thresholds for Action**:
```
Cohen's d    Recommendation
-----------  ----------------------------------------
< 0.2        No action; within normal variation
0.2 - 0.5    Monitor closely; schedule inspection
0.5 - 0.8    Plan recalibration within 1 week
> 0.8        Immediate recalibration required
```

**Our Case (d = 0.204)**:
- Just barely crosses into "small effect" territory
- Quality decision: Continue monitoring
- If d were 0.5 (1.22g difference), we'd schedule calibration
- If d were 0.8 (2g difference), we'd recalibrate immediately

**Relationship to Power Analysis**:
```
Power depends on effect size:

For our test (n=8, α=0.05):
• d = 0.2 (our observed) → Power ≈ 8%
• d = 0.5 → Power ≈ 18%
• d = 0.8 → Power ≈ 47%

This shows why we failed to reject:
Even if true effect is d=0.2, we'd only detect it 8% of the time!
```

**Limitations of Cohen's d**:

1. **Context-dependent**:
   - d = 0.2 might be huge in pharmaceutical dosing
   - d = 0.2 might be trivial in industrial processes
   - Use domain expertise, not just Cohen's conventions

2. **Assumes normality**:
   - Based on standard deviation metric
   - For skewed data, may not accurately reflect practical importance

3. **Sample size affects precision**:
   - With n=8, our d estimate is imprecise
   - 95% CI for d: approximately [-0.50, 0.90]
   - True effect could be anywhere in this range

**Reporting Best Practice**:
```
Complete statistical report includes:

1. Descriptive statistics: x̄ = 50.5, s = 2.449
2. Hypothesis test: t(7) = 0.577, p = 0.317
3. Effect size: Cohen's d = 0.204 (small)
4. Confidence interval: 95% CI [48.45, 52.55]
5. Interpretation: "The sample mean is 0.5g above target,
                    representing a small effect (d=0.204).
                    This difference is not statistically
                    significant (p=0.317) and appears to be
                    within normal operational variation."
```

**Visual Representation**:
```
[Include overlapping normal curves diagram]

Curve 1: μ=50, σ=2.449 (null hypothesis)
Curve 2: μ=50.5, σ=2.449 (observed sample)

Distance between peaks = 0.5g = 0.204 SD
High overlap → small effect
```

---

### Q19: What assumptions would need to change if this were a paired t-test instead?

**Answer**:

**One-Sample vs Paired t-test Comparison**:

**Current Setup (One-Sample t-test)**:
- **Data structure**: Single sample of n=8 independent weights
- **Research question**: Does the population mean differ from a fixed value (50g)?
- **H₀**: μ = μ₀ = 50
- **Test statistic**: t = (x̄ - μ₀) / (s/√n)

**Paired t-test Alternative**:
- **Data structure**: TWO related samples of n=8 pairs
- **Research question**: Is there a difference between two related measurements?
- **H₀**: μ_difference = 0 (or μ₁ = μ₂)
- **Test statistic**: t = (d̄ - 0) / (s_d/√n)

**Key Conceptual Difference**:

**One-sample t-test**:
```
Sample: [52, 49, 51, 48, 53, 47, 50, 54]
Compare to: Fixed standard (50g)
```

**Paired t-test** (if applicable):
```
Before calibration: [52, 49, 51, 48, 53, 47, 50, 54]
After calibration:  [51, 48, 50, 47, 52, 46, 49, 53]
Differences (D):    [ 1,  1,  1,  1,  1,  1,  1,  1]

Analyze the DIFFERENCES, not the original values
```

**When to Use Paired t-test in Quality Control**:

**Scenario 1: Before-After Machine Adjustment**
```
Research question: Does recalibration change the mean weight?

Data collection:
• Measure same 8 production slots BEFORE calibration
• Measure same 8 production slots AFTER calibration
• Pair by slot number (controls for slot-specific variation)

Advantage: Removes between-slot variability
Paired differences isolate the calibration effect
```

**Scenario 2: Two Measurement Methods**
```
Research question: Does new scale agree with reference scale?

Data collection:
• Weigh same 8 packages on reference scale
• Weigh SAME 8 packages on new scale
• Pair by package ID

H₀: μ_new - μ_reference = 0 (no systematic bias)
```

**Scenario 3: Multiple Machines**
```
Research question: Do two machines produce same average weight?

Data collection:
• Produce 8 batches of packages
• For each batch, measure output from Machine A and Machine B
• Pair by batch (controls for raw material variation)
```

**Assumptions Comparison**:

| Assumption       | One-Sample t-test             | Paired t-test                                |
| ---------------- | ----------------------------- | -------------------------------------------- |
| **Independence** | Observations independent      | **PAIRS are related, but pairs independent** |
| **Normality**    | Data (X) normally distributed | **DIFFERENCES (D) normally distributed**     |
| **Scale**        | Continuous measurement        | Continuous measurement                       |
| **Matching**     | Not applicable                | **Pairs must be meaningfully matched**       |

**Critical Assumption Change: Independence Structure**

**One-sample t-test**:
```
Independence assumption:
• Each weight measurement is independent
• Weight of package 1 doesn't affect weight of package 2
• Random sampling ensures this
```

**Paired t-test**:
```
Independence assumption is MODIFIED:
• Within-pair dependence is EXPECTED (that's the point!)
• Between-pair independence is REQUIRED
• Violates standard independence if pairs aren't properly formed

Example violation:
Pairing "8 packages from Monday" with "8 packages from Tuesday"
→ Temporal correlation may exist across days
→ Breaks between-pair independence assumption
```

**How Pairing Affects Calculations**:

**One-Sample t-test** (our current analysis):
```
Test statistic: t = (50.5 - 50) / (2.449/√8) = 0.577
df = 7
Uses variability of original observations (s = 2.449)
```

**Paired t-test** (hypothetical):
```
Suppose we had before-after data:
Before: [52, 49, 51, 48, 53, 47, 50, 54]
After:  [51, 48, 50, 47, 52, 46, 49, 53]
Differences (D): [1, 1, 1, 1, 1, 1, 1, 1]

d̄ = 1.0 (mean difference)
s_d = 0 (SD of differences—perfect consistency!)

Test statistic: t = (1.0 - 0) / (0/√8) → Undefined!

With more realistic variation:
Differences: [1.2, 0.8, 1.1, 0.9, 1.3, 0.7, 1.0, 1.4]
d̄ = 1.05
s_d = 0.245

t = 1.05 / (0.245/√8) = 1.05 / 0.087 = 12.1
df = 7
p < 0.001 (highly significant!)
```

**Power Advantage of Pairing**:

**Why pairing increases power**:
```
One-sample test uses total variability: s = 2.449
Paired test uses within-pair variability: s_d = 0.245

Reduction in variability → Larger t-statistic → More power

Example:
One-sample: SE = 2.449/√8 = 0.866
Paired: SE = 0.245/√8 = 0.087

Same difference (1g) yields:
One-sample: t = 1.0/0.866 = 1.15 (not significant)
Paired: t = 1.0/0.087 = 11.5 (highly significant)
```

**When Pairing Backfires**:

**Scenario**: Weak correlation between pairs
```
If before-after measurements are weakly correlated:
• Paired test loses df (n-1 instead of 2n-1 for independent samples)
• Loss of df can outweigh variance reduction
• Independent samples t-test may be more powerful

Rule of thumb:
Use paired test if within-pair correlation r > 0.5
Use independent samples if r < 0.5
```

**Checking Normality Assumption**:

**One-sample t-test**:
```python
# Check normality of original data
shapiro_stat, p_value = stats.shapiro(weights)
```

**Paired t-test**:
```python
# Check normality of DIFFERENCES
differences = before - after
shapiro_stat, p_value = stats.shapiro(differences)
# Note: differences may be normal even if original data aren't!
```

**Implementation in Python**:

**One-sample t-test** (current):
```python
from scipy.stats import ttest_1samp
t_stat, p_value = ttest_1samp(weights, popmean=50)
```

**Paired t-test** (alternative):
```python
from scipy.stats import ttest_rel
# If we had before and after measurements:
t_stat, p_value = ttest_rel(before, after)

# Equivalent to one-sample test on differences:
differences = before - after
t_stat, p_value = ttest_1samp(differences, popmean=0)
```

**Decision Tree for Test Selection**:
```
START: Two groups of measurements

├─ Are measurements on SAME subjects/items?
│  ├─ YES → Paired t-test
│  │        (controls for individual differences)
│  │
│  └─ NO → Independent samples t-test
│           (groups are unrelated)
│
└─ Only ONE group to compare to standard?
   → One-sample t-test (our current scenario)
```

**Summary Table**:

| Aspect           | One-Sample t-test (Current)  | Paired t-test (Alternative)       |
| ---------------- | ---------------------------- | --------------------------------- |
| **Data**         | Single sample vs fixed value | Two related samples               |
| **Question**     | "Does μ = μ₀?"               | "Does μ_diff = 0?"                |
| **Variability**  | Uses s of original data      | Uses s_d of differences           |
| **Power**        | Lower (more variability)     | Higher (controls pairing factors) |
| **df**           | n - 1                        | n - 1 (same!)                     |
| **Independence** | Between all observations     | Between pairs only                |
| **Normality**    | Of original data             | Of DIFFERENCES                    |

**For Our Quality Control Problem**:
- Current one-sample t-test is **correct** choice
- Paired test would apply if we were comparing:
  - Before vs after recalibration
  - Different measurement devices
  - Multiple production machines
- Since we're only comparing to a target value (50g), one-sample is appropriate

---

### Q20: How would you design a follow-up study to confirm these findings?

**Answer**:

**Comprehensive Follow-up Study Design**:

---

### **STUDY DESIGN OVERVIEW**

**Primary Objective**: Confirm whether the packaging machine produces items with mean weight equal to 50g target

**Secondary Objectives**:
1. Estimate mean weight with higher precision
2. Assess process capability (variability control)
3. Detect any temporal trends or systematic biases
4. Validate initial test assumptions

**Current Study Limitations to Address**:
- Small sample size (n=8) → Low statistical power
- Single time point → Cannot detect trends
- No process capability metrics → Unknown variability control
- Assumption checks underpowered → Need larger sample for validation

---

### **PHASE 1: POWER ANALYSIS & SAMPLE SIZE DETERMINATION**

**Goal**: Determine required sample size for adequate power

**Parameters**:
```
Minimum detectable effect: δ = 1g (practically important deviation)
Effect size: d = δ/σ = 1/2.449 = 0.408 (medium effect)
Significance level: α = 0.05 (two-tailed)
Desired power: 1 - β = 0.80 (80% chance of detecting δ=1g if it exists)
```

**Sample Size Calculation**:
```python
from statsmodels.stats.power import tt_solve_power

n_required = tt_solve_power(
    effect_size=0.408,
    alpha=0.05,
    power=0.80,
    alternative='two-sided'
)
# Result: n ≈ 48 observations

# Round up to practical value: n = 50
```

**Justification**:
- n=50 provides 80% power to detect 1g deviation
- Allows robust normality testing (Central Limit Theorem fully applies)
- Enables more precise confidence interval (±0.5g instead of ±2g)

---

### **PHASE 2: SAMPLING STRATEGY**

**Stratified Random Sampling Approach**:

**Temporal Stratification** (Control for time-based variation):
```
Sample across different times to capture variability:

• 5 production shifts × 10 packages per shift = 50 total
• Shifts sampled:
  - Monday morning
  - Tuesday afternoon
  - Wednesday night
  - Thursday morning
  - Friday afternoon

Rationale:
- Detects shift-to-shift variation
- Identifies machine warm-up effects
- Captures operator differences
- Represents full weekly production cycle
```

**Spatial Stratification** (Control for machine position effects):
```
If multiple production lines:
• Sample from 5 different machines × 10 packages each
• Or 10 positions on conveyor belt × 5 packages each

Rationale:
- Identifies machine-specific biases
- Detects position-dependent effects
- Ensures representative coverage
```

**Sampling Procedure**:
```
For each stratum:
1. Randomly select 10 time points within shift
2. At each time point, select package using random number generator
3. Record metadata: timestamp, machine ID, operator, batch number
4. Weigh using calibrated scale (±0.01g precision)
5. Document environmental conditions (temperature, humidity)
```

---

### **PHASE 3: DATA COLLECTION PROTOCOL**

**Measurement Standardization**:
```
Equipment:
• Use SAME calibrated scale for all measurements
• Calibration certificate valid within 6 months
• Precision: ±0.01g
• Zero balance before each measurement

Procedure:
1. Remove package from production line
2. Allow 30 seconds to stabilize temperature
3. Place on scale center
4. Record weight when reading stabilizes (±0.01g for 3 seconds)
5. Repeat measurement (measure twice, average if diff > 0.05g)
6. Return package to production or quality hold area

Environmental controls:
• Temperature: 20±2°C
• Humidity: 50±10%
• Scale on vibration-dampened surface
```

**Data Recording**:
```python
# Structured data format (CSV)
Columns:
- package_id (unique identifier)
- timestamp (YYYY-MM-DD HH:MM:SS)
- shift (Morning/Afternoon/Night)
- machine_id (A, B, C, ...)
- operator_id (anonymized)
- batch_number (raw material batch)
- weight_measurement_1 (grams)
- weight_measurement_2 (grams)
- weight_final (average or validated measurement)
- temperature_celsius
- humidity_percent
- notes (any unusual observations)
```

---

### **PHASE 4: STATISTICAL ANALYSIS PLAN**

**Primary Analysis (Confirmatory)**:
```
1. One-Sample t-test (same as original):
   H₀: μ = 50 vs H₁: μ ≠ 50
   α = 0.05, two-tailed

2. Equivalence Testing (additional):
   H₀: |μ - 50| ≥ 1 vs H₁: |μ - 50| < 1
   TOST (Two One-Sided Tests) procedure
   Demonstrates weight is "close enough" to 50g

3. 95% Confidence Interval:
   Expected precision: ±0.5g (vs current ±2g)
```

**Secondary Analyses**:
```
1. Process Capability Assessment:
   Calculate Cp, Cpk indices

   If specification limits are 50±3g:
   USL = 53, LSL = 47

   Cp = (USL - LSL) / (6σ)
      = 6 / (6 × s)
      Target: Cp ≥ 1.33 (capable process)

   Cpk = min[(USL - μ̂// filepath: c:\Users\ayana\Projects\Stats&AI\Statistical Foundation of Data Science\Practical_exam\Viva_Questions_Problem_2.md

# Viva Questions for Practical Exam Problem 2
**Student**: Md Ayan Alam (GF202342645) | **Course**: Statistical Foundation of Data Science

---

## Category 1: Conceptual Understanding

### Q1: Why did you choose a two-tailed test instead of a one-tailed test?

**Answer**: I chose a two-tailed test because the problem asks whether the mean **differs** from 50g, not specifically whether it's greater or less than 50g. A two-tailed test examines both possibilities:
- H₀: μ = 50 (mean equals 50g)
- H₁: μ ≠ 50 (mean is different from 50g, either higher or lower)

If the question asked "is the mean **greater** than 50g?", I would use a one-tailed test (right-tailed). If it asked "is the mean **less** than 50g?", I would use a left-tailed test.

**Real-world context**: In quality control, we care about deviations in **both directions** because:
- Overweight packages → waste material, higher costs
- Underweight packages → customer complaints, regulatory violations

---

### Q2: What is the meaning of α = 0.05 in this context?

**Answer**: α = 0.05 is the **significance level** or **Type I error rate**, which means:

1. **Probability of false rejection**: There's a 5% chance we'll conclude the mean differs from 50g when it actually doesn't (rejecting a true H₀)

2. **Confidence level**: We're 95% confident in our decision (1 - α = 0.95)

3. **Critical region**: We reject H₀ if our test statistic falls in the most extreme 5% of the distribution (2.5% in each tail for two-tailed test)

**Trade-off consideration**:
- Lower α (e.g., 0.01) → Harder to reject H₀ → Fewer false alarms but may miss real differences
- Higher α (e.g., 0.10) → Easier to reject H₀ → More sensitive but more false alarms

In quality control, α = 0.05 balances these concerns appropriately.

---

### Q3: What is a p-value and how do you interpret p = 0.3173?

**Answer**: The p-value is the **probability of observing our data (or more extreme) if H₀ is true**.

**For p = 0.3173**:
- There's a 31.73% chance of getting a sample mean as far or farther from 50g as we observed (x̄ = 50.5g), purely by random sampling, if the true population mean is actually 50g

**Interpretation**:
- Since p = 0.3173 > α = 0.05, we **fail to reject H₀**
- This is **NOT** strong evidence against the null hypothesis
- We cannot conclude the population mean differs from 50g

**Common misconception**: p-value ≠ "probability H₀ is true"
- Correct: Probability of data given H₀
- Incorrect: Probability of H₀ given data (that would be Bayesian posterior probability)

---

### Q4: Explain the difference between "fail to reject H₀" and "accept H₀"

**Answer**: This is a critical distinction in hypothesis testing:

**"Fail to reject H₀"** (what we say):
- Insufficient evidence to conclude the mean differs from 50g
- Doesn't prove H₀ is true, just that we don't have enough evidence against it
- Leaves open the possibility that a larger sample might find a difference

**"Accept H₀"** (what we DON'T say):
- Implies we've proven H₀ is true
- Statistically incorrect because absence of evidence ≠ evidence of absence
- Would require Bayesian methods with priors to formally "accept"

**Analogy**: In a criminal trial:
- "Not guilty" ≠ "innocent"
- "Not guilty" = insufficient evidence to convict
- Similarly: "Fail to reject H₀" = insufficient evidence to conclude difference exists

**Our conclusion**: The data don't provide strong evidence that the mean weight differs from 50g, but we cannot definitively say it equals 50g.

---

## Category 2: Statistical Calculations

### Q5: Walk through the calculation of the sample standard deviation. Why do we use n-1 instead of n?

**Answer**:

**Calculation steps**:
```
1. Sample mean: x̄ = 404/8 = 50.5
2. Deviations: (xᵢ - x̄) = [1.5, -1.5, 0.5, -2.5, 2.5, -3.5, -0.5, 3.5]
3. Squared deviations: [2.25, 2.25, 0.25, 6.25, 6.25, 12.25, 0.25, 12.25]
4. Sum of squared deviations: Σ(xᵢ - x̄)² = 42.0
5. Variance: s² = 42.0/(8-1) = 42.0/7 = 6.0
6. Standard deviation: s = √6.0 = 2.449
```

**Why n-1 (Bessel's correction)**:
1. **Degrees of freedom**: We used one parameter (x̄) from the data to calculate deviations, so we only have n-1 "independent" pieces of information

2. **Bias correction**: Using n would systematically **underestimate** the population variance σ² because:
   - Sample deviations are calculated from x̄ (which is closer to sample points than μ)
   - Dividing by n-1 inflates the estimate to correct this bias
   - Makes s² an **unbiased estimator** of σ²

3. **Mathematical proof**: E[s²] = σ² only when using n-1

**Practical impact**: For n=8, using n vs n-1:
- With n: s² = 42/8 = 5.25
- With n-1: s² = 42/7 = 6.0
- Difference matters more for small samples!

---

### Q6: How did you calculate the t-statistic? What does t = 0.577 mean?

**Answer**:

**Formula and calculation**:
```
t = (x̄ - μ₀) / (s / √n)
t = (50.5 - 50) / (2.449 / √8)
t = 0.5 / (2.449 / 2.828)
t = 0.5 / 0.866
t = 0.577
```

**Components**:
- **Numerator (0.5)**: How far our sample mean is from the hypothesized mean
- **Denominator (0.866)**: Standard error (SE) = uncertainty in our estimate of the mean
- **t-statistic**: Signal-to-noise ratio = (observed difference) / (sampling variability)

**Interpretation of t = 0.577**:
1. Our sample mean is only 0.577 standard errors away from the hypothesized mean
2. This is a **small deviation** - well within random sampling variation
3. For comparison, |t| > 2 would be more unusual and potentially significant

**Distribution**: Under H₀, this t-statistic follows a t-distribution with df = 7

**Geometric interpretation**: If we repeated this sampling many times when μ = 50, we'd frequently see sample means this far (or farther) from 50 just by chance.

---

### Q7: What are degrees of freedom and why is df = 7 for this test?

**Answer**:

**Definition**: Degrees of freedom (df) = number of independent pieces of information available to estimate a parameter

**For one-sample t-test**: df = n - 1

**Why n - 1?**
1. We have n = 8 observations
2. We used these 8 observations to calculate x̄
3. Once we know x̄ and 7 of the observations, the 8th is **determined** (not free to vary)
4. Therefore: df = 8 - 1 = 7

**Example of constraint**:
```
If x̄ = 50.5 and we know values [52, 49, 51, 48, 53, 47, 50],
then the 8th value MUST be 54 because:
Σxᵢ = n × x̄ = 8 × 50.5 = 404
Sum of first 7 = 350
Last value = 404 - 350 = 54 (no freedom of choice!)
```

**Impact on test**:
- Lower df → wider t-distribution → higher critical values
- df = 7: t-critical = ±2.365
- df = 30: t-critical = ±2.042
- df = ∞: t-critical = ±1.96 (approaches z-distribution)

**Why it matters**: With small samples (low df), we need **stronger evidence** (larger |t|) to reject H₀ because we're less certain about the population variance.

---

## Category 3: Test Assumptions and Alternatives

### Q8: What assumptions does the one-sample t-test require? Did you check them?

**Answer**:

**Required assumptions**:

1. **Random sampling**: Each observation independently drawn from the population
   - **Check**: Assumed for quality control sample (should verify in practice)
   - **Violation impact**: Non-representative sample → biased conclusions

2. **Normality**: Population is normally distributed (or n ≥ 30 by CLT)
   - **Check performed**: Shapiro-Wilk test
     - W = 0.9589, p = 0.7959
     - p > 0.05 → No evidence against normality
   - **Visual check**: Q-Q plot shows points near diagonal line
   - **Violation impact**: For n=8, departures from normality affect p-value accuracy

3. **Continuous data**: Measurement variable (not categorical)
   - **Check**: Weight in grams is continuous ✓

4. **No extreme outliers**: Can distort mean and SD
   - **Check performed**: No values beyond mean ± 3SD
   - **Range**: [47, 54] is reasonable for 50g target

**Verification in notebook**:
```python
# Shapiro-Wilk normality test
stat, p_value = stats.shapiro(weights)
# Result: p = 0.7959 > 0.05 → Normality assumption satisfied
```

**Robustness**: t-test is relatively robust to mild normality violations when:
- Sample size ≥ 20-30 (we have n=8, so normality matters more)
- Data roughly symmetric (our data: skewness = 0.216, nearly symmetric)

---

### Q9: What would you do if the normality assumption was violated?

**Answer**:

**Step 1: Assess severity**
```python
# Check with multiple methods
shapiro_p = stats.shapiro(data)[1]  # Formal test
skewness = stats.skew(data)          # Symmetry
kurtosis = stats.kurtosis(data)      # Tail heaviness
# Visual: Q-Q plot, histogram
```

**Step 2: Choose alternative based on severity**

**Option A: Non-parametric test (recommended for severe violations)**
- **Wilcoxon signed-rank test**: Non-parametric alternative
  ```python
  from scipy.stats import wilcoxon
  # Test if median differs from 50
  stat, p_value = wilcoxon(weights - 50)
  ```
- **Advantages**:
  - No normality assumption
  - Robust to outliers
  - Tests median instead of mean
- **Disadvantages**:
  - Less powerful than t-test if data actually normal
  - Tests different hypothesis (median vs mean)

**Option B: Data transformation (for moderate violations)**
```python
# Log transformation (for right skew)
log_weights = np.log(weights)
# Square root (for mild right skew)
sqrt_weights = np.sqrt(weights)
# Box-Cox (finds optimal transformation)
from scipy.stats import boxcox
transformed, lambda_param = boxcox(weights)
```
- Re-test normality on transformed data
- Perform t-test on transformed scale
- Back-transform results for interpretation

**Option C: Bootstrapping**
```python
from scipy.stats import bootstrap
# Generate confidence interval via resampling
result = bootstrap((weights,), np.mean, n_resamples=10000)
# Check if 50 falls in CI
```

**Decision tree**:
1. Mild violation + n ≥ 30 → Proceed with t-test (CLT applies)
2. Moderate violation + small n → Try transformation
3. Severe violation or outliers → Use Wilcoxon test
4. Uncertain → Report both parametric and non-parametric results

**For our data**: Normality holds (p=0.796), so t-test is appropriate.

---

### Q10: What is the difference between Type I and Type II errors in this context?

**Answer**:

**Type I Error (α = 0.05)**:
- **Definition**: Reject H₀ when it's actually true (false positive)
- **In our context**: Conclude the mean weight differs from 50g when it actually doesn't
- **Consequences**:
  - Unnecessary machine recalibration
  - Wasted resources investigating non-existent problem
  - Production shutdown for false alarm
- **Controlled by**: Significance level α = 0.05 (5% chance)
- **Example**: True mean is exactly 50g, but random sample gives x̄ = 53.2g → we incorrectly reject H₀

**Type II Error (β, unknown)**:
- **Definition**: Fail to reject H₀ when it's actually false (false negative)
- **In our context**: Conclude no difference from 50g when there actually is one
- **Consequences**:
  - Miss real quality control issue
  - Continue producing off-spec products
  - Potential customer complaints or regulatory violations
- **Probability**: β (not directly controlled, depends on effect size and sample size)
- **Example**: True mean is 52g, but random sample gives x̄ = 50.3g → we fail to detect the problem

**Relationship**:
```
Power = 1 - β = Probability of correctly rejecting false H₀
```

**Trade-off**:
- Decreasing α (stricter) → Increases β (less power)
- Increasing sample size → Decreases both α and β
- Larger true effect → Decreases β (easier to detect)

**In our test**:
- Set α = 0.05 (Type I error rate)
- β unknown (would need to specify alternative hypothesis)
- With n=8 and α=0.05, power is modest for small effects

**Quality control perspective**:
- Type I error: "Fixing" a machine that isn't broken (costly)
- Type II error: Letting a broken machine run (dangerous)
- Balance depends on costs: If Type II consequences are severe (e.g., medical devices), use higher α

---

## Category 4: Practical Application

### Q11: The sample mean is 50.5g. Why isn't this conclusive evidence that the population mean differs from 50g?

**Answer**:

**Key concept**: Sample statistics vary due to **sampling variability**

**1. Natural sampling variation**:
- Even if true μ = 50g exactly, different samples will give different x̄ values
- With n=8 and s=2.449, the standard error = 2.449/√8 = 0.866
- So sample means typically vary by about ±0.866g around the true mean
- Observing x̄ = 50.5g (only 0.5g different) is well within this expected variation

**2. Sampling distribution**:
```
If we took 1000 samples of n=8 when μ=50:
• 68% would have 49.1 < x̄ < 50.9 (within 1 SE)
• 95% would have 48.3 < x̄ < 51.7 (within 2 SE)
• Our x̄=50.5 falls in the "common" region
```

**3. Statistical vs practical significance**:
- **Observed difference**: 50.5 - 50 = 0.5g
- **Effect size (Cohen's d)**: 0.5/2.449 = 0.204 (small effect)
- Even if statistically significant, 0.5g may not matter practically

**4. Small sample size (n=8)**:
- High uncertainty in our estimate
- 95% CI for μ: [48.46, 52.54] is very wide
- True mean could plausibly be anywhere from 48.5g to 52.5g
- 50g is well within this range

**5. The hypothesis test confirms**:
- t = 0.577 (small, not in rejection region)
- p = 0.3173 (high probability of seeing this by chance)
- Conclusion: 0.5g difference is easily explained by random sampling

**Analogy**:
- Flipping a fair coin 8 times and getting 5 heads (62.5%)
- Does this prove the coin is biased toward heads?
- No! With only 8 flips, getting 5 heads is very plausible (p=0.36)
- Similarly, with only 8 weights, getting x̄=50.5 when μ=50 is very plausible

**Bottom line**: The 0.5g difference is within the expected "noise" of random sampling. We'd need either:
- A larger difference with n=8, OR
- The same difference with much larger n
...to have convincing evidence of a real population difference.

---

### Q12: How would your conclusion change if the sample size was n=80 instead of n=8, with the same mean and standard deviation?

**Answer**:

**Recalculation with n=80**:
```
Given: x̄ = 50.5, s = 2.449, μ₀ = 50, n = 80 (instead of 8)

Standard Error = s/√n = 2.449/√80 = 2.449/8.944 = 0.274

t = (x̄ - μ₀) / SE = (50.5 - 50) / 0.274 = 0.5 / 0.274 = 1.825

df = 80 - 1 = 79
```

**Critical value and p-value**:
```
Two-tailed test, α = 0.05, df = 79:
t_critical = ±1.990

p-value ≈ 0.072 (from t-distribution)
```

**Comparison**:

| Aspect                    | n=8             | n=80             | Change        |
| ------------------------- | --------------- | ---------------- | ------------- |
| Standard Error            | 0.866           | 0.274            | ↓ 68%         |
| t-statistic               | 0.577           | 1.825            | ↑ 216%        |
| p-value                   | 0.317           | 0.072            | ↓ 77%         |
| Decision (α=0.05)         | Fail to reject  | Fail to reject   | Same          |
| Closeness to significance | Far (p >> 0.05) | Close (p ≈ 0.05) | More evidence |

**Key insights**:

1. **Smaller standard error**: SE drops from 0.866 to 0.274
   - More precise estimate of the population mean
   - Tighter confidence interval

2. **Larger t-statistic**: t increases from 0.577 to 1.825
   - Same observed difference (0.5g) becomes more "unusual"
   - Closer to rejection region (t_crit = 1.990)

3. **Lower p-value**: p drops from 0.317 to 0.072
   - Getting closer to α = 0.05 threshold
   - More evidence against H₀, but still not quite significant

4. **Still fail to reject**: p = 0.072 > 0.05
   - But now it's a "marginal" result
   - If α were 0.10, we'd reject H₀

**Practical implications**:
- With n=80, the 0.5g difference is **detectable but not conclusive** at α=0.05
- Suggests there might be a small real effect that n=8 couldn't detect
- Quality control decision: Might warrant further investigation with even larger sample

**Statistical principle demonstrated**:
- Same effect size becomes more statistically significant with larger n
- "Significant" depends on both effect size AND sample size
- This is why large studies can find "significant" but trivially small effects

**What if we wanted to detect this 0.5g difference reliably?**
- Power analysis: To detect 0.5g difference with 80% power at α=0.05
- Required n ≈ 190 observations
- Shows that n=8 is severely underpowered for this small effect

---

### Q13: Calculate and interpret a 95% confidence interval for the population mean.

**Answer**:

**Calculation**:
```
Formula: x̄ ± t_(α/2, df) × (s/√n)

Given:
• x̄ = 50.5
• s = 2.449
• n = 8
• df = 7
• α = 0.05 → α/2 = 0.025
• t_(0.025, 7) = 2.365 (from t-table)
• SE = s/√n = 2.449/√8 = 0.866

Margin of Error = t × SE = 2.365 × 0.866 = 2.048

95% CI = 50.5 ± 2.048
       = [48.45, 52.55]
```

**Interpretation**:

**1. Correct interpretation (frequentist)**:
"If we repeated this sampling process many times and constructed a 95% CI each time, approximately 95% of those intervals would contain the true population mean μ."

**2. Practical interpretation for this sample**:
"We are 95% confident that the true mean weight of packaged items lies between 48.45g and 52.55g."

**3. In quality control context**:
- Target weight: μ₀ = 50g
- Our CI: [48.45, 52.55]
- **Observation**: 50g is well within our confidence interval
- **Implication**: The data are consistent with μ = 50g
- **Action**: No evidence to conclude the machine needs adjustment

**4. Connection to hypothesis test**:
```
Equivalence rule for two-tailed test:
• If 95% CI contains μ₀ → Fail to reject H₀ at α = 0.05 ✓
• If 95% CI excludes μ₀ → Reject H₀ at α = 0.05

Our case: 50 ∈ [48.45, 52.55] → Fail to reject H₀
Matches our p-value conclusion (p = 0.317 > 0.05)
```

**5. Width of interval (4.10g)**:
- Relatively wide due to small sample size (n=8)
- High uncertainty in population mean estimate
- If we need more precision → increase sample size

**What if we wanted narrower CI?**
```
Target width: ±1g (margin of error = 1g)
Required: 1 = 2.365 × (2.449/√n)
Solve for n: n = (2.365 × 2.449/1)² ≈ 34 observations

To get margin of error ±0.5g: n ≈ 133 observations
```

**Common misconceptions to avoid**:
- ❌ "95% probability that μ is in [48.45, 52.55]" (μ is fixed, not random)
- ❌ "95% of data falls in this interval" (that's a prediction interval, not confidence interval)
- ✓ "95% confident that this interval captures the true μ" (correct)

**Visual interpretation**: If we plotted 20 different 95% CIs from 20 samples, we'd expect about 19 (95%) to contain the true μ, and 1 (5%) to miss it by chance.

---

### Q14: What is the power of this test, and why does it matter?

**Answer**:

**Definition**:
Power = 1 - β = Probability of correctly rejecting H₀ when it's false

**For our test**, power depends on:
1. **Sample size**: n = 8 (small → lower power)
2. **Significance level**: α = 0.05 (standard)
3. **Effect size**: How far true μ is from 50g (unknown in practice)
4. **Variability**: s = 2.449g (higher s → lower power)

**Power calculation for specific alternative**:
Let's calculate power if the true mean were μ = 52g (2g above target):

```python
from statsmodels.stats.power import ttest_power

# Parameters
effect_size = (52 - 50) / 2.449  # Cohen's d = 0.817 (large effect)
n = 8
alpha = 0.05

# Calculate power
power = ttest_power(effect_size, n, alpha, alternative='two-sided')
# Power ≈ 0.47 (47%)
```

**Interpretation of 47% power**:
- If the true mean is actually 52g (2g difference from target)
- With our sample size n=8
- We only have a 47% chance of detecting this difference at α=0.05
- **53% chance of Type II error** (missing a real problem!)

**Power for different effect sizes**:

| True μ | Effect Size (Cohen's d) | Power      |
| ------ | ----------------------- | ---------- |
| 50.5g  | 0.204 (small)           | 0.08 (8%)  |
| 51g    | 0.408 (medium)          | 0.18 (18%) |
| 52g    | 0.817 (large)           | 0.47 (47%) |
| 53g    | 1.225 (very large)      | 0.75 (75%) |

**Why power matters**:

1. **Quality control reliability**:
   - Low power = high risk of missing real quality issues
   - With n=8, we'd miss even a 2g deviation 53% of the time!
   - Could lead to shipping defective products

2. **Sample size planning**:
   - Standard target: 80% power (20% Type II error rate)
   - To detect 1g difference with 80% power:
     ```python
     from statsmodels.stats.power import tt_solve_power
     n_required = tt_solve_power(effect_size=1/2.449,
                                  alpha=0.05,
                                  power=0.80,
                                  alternative='two-sided')
     # n ≈ 61 observations needed
     ```

3. **Study interpretation**:
   - Our non-significant result (p=0.317) doesn't mean "no difference exists"
   - With low power, absence of evidence ≠ evidence of absence
   - Could be: (a) no difference, OR (b) difference exists but sample too small

**Increasing power**:
- ↑ Sample size (most effective): n=8 → n=60 dramatically improves power
- ↓ Variability: Better measurement precision → lower s → higher power
- ↑ Effect size: Only controllable in experimental design (not applicable here)
- ↑ Alpha: α=0.05 → α=0.10 increases power but more Type I errors

**Recommendation for quality control**:
- Current n=8 is insufficient for reliable detection
- Minimum sample size: n ≈ 30 for moderate effects
- Optimal: n ≥ 60 for good power (80%+) to detect 1g differences
- Consider sequential sampling or control charts for ongoing monitoring

---

## Category 5: Interpretation and Communication

### Q15: How would you explain your findings to a non-technical quality control manager?

**Answer**:

**Executive summary approach**:

---

**To**: Quality Control Manager
**Re**: Weight Testing Results for Machine Calibration
**Date**: December 9, 2025

**Question**: Does our packaging machine need recalibration? Target weight is 50g.

**Short Answer**: **No recalibration needed** based on current data.

**What We Found**:
- Tested 8 randomly selected packages
- Average weight: 50.5g (only 0.5g above target)
- All packages ranged from 47g to 54g (reasonable variation)
- Statistical test shows this 0.5g difference is likely due to normal measurement variation, not a calibration problem

**Statistical Confidence**:
- Our analysis has 95% confidence that the true average weight is somewhere between 48.5g and 52.5g
- Since our target of 50g falls comfortably in this range, there's no strong evidence the machine is off-target
- Probability this result happened by pure chance: 32% (quite likely)

**What This Means**:
✓ **No immediate action required** on machine calibration
✓ Observed variation is within normal operating range
✓ Continue standard quality monitoring procedures

**Important Caveats**:
⚠️ **Small sample size** (only 8 packages):
   - Cannot rule out small problems (e.g., 1g drift)
   - Larger sample would give more definitive answer

⚠️ **Recommendation**:
   - Continue monitoring with larger monthly samples (30-50 packages)
   - Consider implementing control charts for ongoing tracking
   - Retest if customer complaints increase

**Analogy**:
Think of it like checking your body temperature. If 8 readings average 98.9°F (target: 98.6°F), that 0.3° difference doesn't mean you have a fever—it's within normal day
