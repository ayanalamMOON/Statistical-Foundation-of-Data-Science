# Copilot Instructions for Statistical Foundation of Data Science

**Student**: Md Ayan Alam (GF202342645) | **Course**: Statistical Foundation of Data Science | **Institution**: Shoolini University

## Project Architecture

This is an **academic coursework repository** for statistical analysis and data science assignments, organized into four major components:

1. **Practical Assignments/** - Hands-on coding exercises with synthetic datasets (Jupyter notebooks)
2. **Theory/** - Study notes, interactive notebooks, and formula references
3. **Utils/** - Reusable statistical and visualization functions
4. **PDF_Merger/** - Standalone GUI utility (independent subproject)

### Data Flow Pattern
Assignments follow a consistent workflow:
```
generate_*_data.py → synthetic_*.csv → Assignment_*.ipynb → Assignment_*.pdf
```
Example: `generate_rating_data.py` creates `teacher_ratings.csv` used across Assignments 2-6.

## Critical Development Workflows

### Virtual Environment (Required)
```bash
# Activate before ANY Python work
source .venv/Scripts/activate  # Windows Git Bash
.venv\Scripts\activate.bat     # Windows CMD
```
All dependencies installed in `.venv/` at repository root.

**Dependency Versions** (from `requirements.txt`):
- pandas>=2.3.0, numpy>=2.3.0, scipy>=1.16.0
- matplotlib>=3.10.0, seaborn>=0.13.0
- jupyter>=1.1.0, jupyterlab>=4.4.0
- statsmodels>=0.14.0, scikit-learn>=1.7.0
- black>=25.0.0 (formatter)

### Code Formatting (Pre-submission Standard)
```bash
# Format Python files and notebooks before committing
./format_code.sh "Practical Assignments/Assignment 4"
./format_code.sh --install-jupyter  # First time setup for .ipynb support
```
Uses **Black** formatter. Excludes `.venv`, `__pycache__`, `.ipynb_checkpoints`.

### Assignment Development Cycle
1. Read `Assignment_N.txt` for specifications
2. **Check for existing datasets first**:
   - Assignments 2-6 reuse `teacher_ratings.csv` from Assignment 2
   - Only run `generate_*_data.py` if dataset doesn't exist or needs regeneration
   - Verify dataset matches expected columns/structure before proceeding
3. Complete analysis in `Assignment_N.ipynb` with section headers matching questions
4. Export to PDF: Jupyter → File → Save and Export Notebook As → PDF
5. Format code: `./format_code.sh "Practical Assignments/Assignment N"`

### Testing
No formal test suite exists. Validation happens through:
- Notebook cell execution (outputs shown inline)
- Visual inspection of plots
- Statistical test results interpretation

## Project-Specific Conventions

### Notebook Structure (Strictly Followed)
Every assignment notebook includes:
```python
# Cell 1: Markdown header with student info table
| Field | Details |
| **Name** | Md Ayan Alam |
| **Roll Number** | GF202342645 |

# Cell 2: Assignment overview and learning objectives
# Cell 3+: Import all libraries at once (pandas, numpy, scipy, matplotlib, seaborn)
# Remaining cells: One problem per section with descriptive headers
```

### NaN Handling Pattern (Critical)
**Always filter NaN before statistical calculations** to avoid misleading results:
```python
# CORRECT pattern used throughout
clean_data = df["column"].dropna()
mean_value = clean_data.mean()

# For weighted means with two columns:
valid_mask = values.notna() & weights.notna()
weighted_mean = (values[valid_mask] * weights[valid_mask]).sum() / weights[valid_mask].sum()
```

### Synthetic Data Generation Requirements
All `generate_*_data.py` scripts must:
- Set `np.random.seed(42)` for reproducibility
- Include realistic correlations between variables (see `generate_rating_data.py` for pattern)
- Generate 500 records by default
- Introduce ~1-2% missing values strategically
- Document dataset type (cross-sectional vs time series) in docstring
- Print descriptive statistics when run as main

### Statistical Analysis Standards
1. **Always check assumptions** before parametric tests:
   - Normality: Shapiro-Wilk test + Q-Q plots
   - Homogeneity of variance: Levene's test
   - Report assumption violations explicitly

2. **Report effect sizes** with hypothesis tests:
   - Cohen's d for t-tests
   - Cramér's V for chi-square tests
   - Rank-biserial correlation for Mann-Whitney U

3. **Use formal statistical notation** in markdown:
   - χ²(df) = value, p = 0.xxx (not "chi square = ...")
   - t(df) = value, p = 0.xxx, d = value
   - See Assignment 4 as reference implementation

### Visualization Standards
**Multi-panel layouts preferred** for comprehensive analysis:
```python
fig, axes = plt.subplots(2, 2, figsize=(14, 10))
# Use GridSpec for complex layouts (see Assignment 4)
```

**Required elements**:
- Title, axis labels with units
- Legends for multiple groups
- Statistical reference lines (mean, median, ±1 SD)
- Grid enabled with `alpha=0.3`
- No top/right spines: `sns.despine()`

**Color palette**: Use seaborn "husl" palette for consistency

### Professional Presentation Rule
**No emojis in final assignment notebooks** (enforced since Assignment 4). Use professional markdown formatting only.

## Utility Module Usage

### Statistical Functions (`Utils/statistical_functions.py`)
Key reusable functions (import before using):
- `weighted_mean(values, weights)` - Handles NaN automatically
- `detect_outliers_zscore(data, threshold=3.0)` - Returns mask and z-scores
- `detect_outliers_iqr(data, multiplier=1.5)` - Returns mask and quartile info
- `comprehensive_summary_stats(data)` - Returns dict with 15+ statistics
- `binning_analysis(df, bin_column, target_columns, bins, labels)` - Aggregated stats per bin

### Visualization Helpers (`Utils/visualization_helpers.py`)
Provides styled plotting functions (partially implemented). Check source before using.

## Key Files and Their Purpose

| File | Purpose | When to Reference |
|------|---------|-------------------|
| `README.md` | Complete project documentation | Understanding overall structure, completed assignments |
| `requirements.txt` | Production dependencies | Setting up environment, checking versions |
| `format_code.sh` | Code formatting script | Before committing code |
| `Theory/notes/00_study_guide.md` | Learning roadmap | Understanding statistical concepts for assignments |
| `Utils/statistical_functions.py` | Reusable analysis functions | Implementing statistical calculations |
| Assignment N `*.txt` files | Specifications | Understanding problem requirements |

## Common Pitfalls to Avoid

1. **Don't calculate statistics on data with NaN** - Always filter first
2. **Don't assume normal distributions** - Test assumptions before parametric tests
3. **Don't ignore effect sizes** - Report alongside p-values for practical significance
4. **Don't mix Windows/Unix paths** - Repository uses Windows paths with forward slashes in code
5. **Don't commit large CSV files** - `.gitignore` excludes them, use `!age_bin_statistics.csv` pattern for exceptions
6. **Don't modify Utils/ without testing** - Used across multiple assignments

## LaTeX Integration (Optional)

VS Code configured for LaTeX compilation (`.vscode/settings.json`):
- Uses `pdflatex` with auto-build on save
- See `Lecture Assignments/Assignment 1/` for `.tex` workflow example

### LaTeX Assignment Format - CRITICAL RULE

**SOLUTION SECTIONS MUST CONTAIN ONLY MATHEMATICAL CONTENT - NO NARRATIVE TEXT**

This is the **Assignment 2 format standard** that MUST be followed for all LaTeX assignments:

#### ✅ ALLOWED in `\begin{solution}...\end{solution}`:
- Mathematical formulas and equations
- Calculations with numbered steps (STEP 1, STEP 2, etc.)
- Step-by-step derivations showing each algebraic manipulation
- Numerical tables and matrices
- Final results in boxes
- Theorem statements (formal mathematical statements only)
- Proof derivations (mathematical steps only)
- Brief labels like "STEP 1:", "Case 1:", "For cluster i:"

**Calculation Requirements:**
- **Show ALL intermediate steps** - no jumps in algebra or arithmetic
- **One operation per line** - make each transformation explicit
- **Keep it concise** - write only what is mathematically necessary
- **No excessive explanations** - let the mathematics speak for itself

**Example of CORRECT calculation format:**
```latex
\begin{align*}
f(x) &= (x-2)^2 + 3     \quad \text{(given)} \\
    &= x^2 - 4x + 4 + 3 \quad \text{(expand)} \\
    &= x^2 - 4x + 7     \quad \text{(simplify)}
\end{align*}
```

**Example of INCORRECT (too much narrative):**
```latex
First, we need to understand that expanding the square will give us three terms.
Let me show you why this works: when we expand (x-2)^2, we're essentially...
[excessive explanation continues]
```

#### ❌ FORBIDDEN in `\begin{solution}...\end{solution}`:
- "Goal:", "Key insight:", "Motivation:", "Intuition:" sections
- "Why...", "How...", "What..." explanatory questions
- "Wait, this doesn't work..." or "Let me recalculate..." thinking-aloud text
- "Hmm,", "Actually,", "Note that" commentary
- Bullet-point explanations of concepts
- "Interpretation:" sections with prose
- "Claim:", "Proof sketch:" with narrative proofs
- Parenthetical comments like "(no change needed)", "(this makes sense because...)"
- ASCII visualizations or diagrams
- "Accepting this standard result for brevity" disclaimers
- Any sentence that explains WHY or HOW something works conceptually

#### ✅ WHERE NARRATIVE BELONGS:
All explanatory text, intuitions, interpretations, and conceptual discussions go in `\begin{explanation}...\end{explanation}` sections ONLY.

### Explanation Section Format - CRITICAL RULE

**EXPLANATION SECTIONS MUST BE WRITTEN AS PROFESSIONAL TEACHING CONTENT - NO INNER MONOLOGUE**

Explanation sections should read like a **textbook or lecture notes**, not like someone thinking aloud or working through problems.

#### ✅ ALLOWED in `\begin{explanation}...\end{explanation}`:
- Clear conceptual explanations in declarative sentences
- "Why this matters" and "How it works" discussions
- Step-by-step reasoning presented as teaching material
- Examples with pedagogical purpose
- Comparisons and contrasts between methods
- Intuitive interpretations of mathematical results
- Real-world applications and implications
- Common pitfalls and how to avoid them
- Key insights presented as established facts

**Tone Requirements:**
- **Authoritative and confident** - present information as a teacher would
- **Direct and clear** - use simple, declarative statements
- **Professional** - academic but accessible language
- **Organized** - logical flow with clear structure

**Example of CORRECT explanation format:**
```latex
\begin{explanation}
\textbf{Why normalization is essential:}

In KNN algorithms, features with larger scales dominate distance calculations.
Consider a dataset where age ranges from 20-80 (range: 60) and income ranges
from \$20,000-\$200,000 (range: 180,000). Without normalization, income
differences are weighted 3,000× more than age differences.

Normalization ensures all features contribute proportionally to the distance metric.
\end{explanation}
```

#### ❌ FORBIDDEN in `\begin{explanation}...\end{explanation}`:
- "Wait, let me reconsider..." or "Hmm, this seems wrong..."
- "Actually, I made a mistake..." or "Let me recalculate..."
- "Oh, I see now..." or "Ah, that makes sense..."
- "Let me try a different approach..." or "Maybe I should..."
- "I think..." or "I believe..." (use definitive statements)
- "This is confusing, but..." or "I'm not sure, but..."
- Self-corrections mid-explanation ("No wait, that's not right...")
- Questioning tone: "Why does this work? Well, uh..."
- Stream-of-consciousness writing
- Debugging commentary or trial-and-error narration
- Apologetic language: "Sorry for the confusion..."
- Uncertainty markers: "probably", "maybe", "might be"

**Example of INCORRECT (inner monologue):**
```latex
\begin{explanation}
Hmm, let me think about why normalization matters here. Well, first I should
consider... wait, actually that's not quite right. Let me reconsider. Oh, I see
now - it's because the scales are different! Actually, let me recalculate to make
sure. Yeah, that seems to work better.
\end{explanation}
```

#### Quality Standards for Explanations:
1. **Write in present tense** - "This algorithm works by..." not "This worked by..."
2. **Use active voice** - "We normalize features to..." not "Features are normalized..."
3. **Be definitive** - "This happens because..." not "This might happen because..."
4. **Structure logically** - use subheadings, numbered lists, clear paragraphs
5. **Teach, don't discover** - present insights as conclusions, not as realizations
6. **No self-reference** - avoid "I", "my calculation", "my approach"
7. **No metacommentary** - don't comment on the writing process itself

**STRICT ENFORCEMENT POLICY FOR EXPLANATIONS**:
- **Before submitting**: Remove ALL inner monologue and thinking-aloud text
- **Rewrite uncertainties**: Convert "I think X" to "X occurs because..."
- **Remove corrections**: If you made an error, just write the correct version
- **Professional tone only**: Write as if for publication in academic materials
- **No stream-of-consciousness**: Every sentence should be deliberate and polished

**Reference Implementation**: See `Lecture Assignments/Assignment 2/Assignment2_Solutions.tex` for correct format.

**Recent Violation Example (Problem 7, Assignment 3)**:
- ❌ Had "Goal:", "Key insight:", "Wait, this doesn't work cleanly", "Why logarithmic?" in solution sections
- ✅ Fixed by removing ALL narrative, keeping only: algorithm steps, probability calculations, tables, theorem statements, mathematical derivations

**STRICT ENFORCEMENT POLICY**:
- **Before submitting ANY LaTeX solution**: Verify solution sections contain ZERO narrative text
- **If ANY forbidden pattern detected**: IMMEDIATELY rewrite to pure mathematics
- **No exceptions**: This rule applies to ALL problems in ALL LaTeX assignments
- **Automated check**: Search solution sections for forbidden keywords before compilation
- **Quality standard**: Solution = mathematics only, Explanation = narrative only

This is non-negotiable for maintaining academic formatting standards.

## Theory Notes Reference Guide

Use these notes strategically during assignment work:

| When You Need... | Reference This File |
|------------------|-------------------|
| Overall problem-solving approach | `Theory/notes/00_study_guide.md` |
| Mean/median/mode selection, variance interpretation | `Theory/notes/01_descriptive_statistics_notes.md` |
| Distribution selection, normality testing | `Theory/notes/02_probability_distributions_notes.md` |
| Hypothesis test selection, assumption checking | `Theory/notes/03_hypothesis_testing_notes.md` |
| Regression concepts, coefficient interpretation | `Theory/notes/04_regression_analysis_notes.md` |
| Matrix operations, PCA foundations | `Theory/notes/05_linear_algebra_notes.md` |
| Bayesian approach alternatives | `Theory/notes/06_bayesian_statistics_notes.md` |
| Formula implementations in Python | `Theory/formulas/statistical_formulas_reference.ipynb` |

**Quick lookup pattern**: If stuck on "which test to use?" → check `03_hypothesis_testing_notes.md` decision trees. If confused about "what does this statistic mean?" → check corresponding descriptive/probability notes.

## AI Agent Guidelines

When assisting with this codebase:
1. **Check assignment .txt file first** for exact requirements before coding
2. **Follow existing notebook structure** - match section headers to questions
3. **Use Utils/ functions where applicable** - don't reimplement existing utilities
4. **Check for existing datasets** - Assignments 2-6 share `teacher_ratings.csv`, don't regenerate unnecessarily
5. **Always validate statistical assumptions** - include assumption checks in analysis
6. **Format output for PDF export** - avoid markdown features that break in PDF
7. **Test notebooks by running all cells** - ensure reproducibility from clean state
8. **Reference Theory/notes/** using the guide above for statistical concept explanations

## Dataset Reuse Pattern (Critical)

**Key Rule**: Most assignments share the same dataset to enable cross-assignment comparisons.

### Dataset Mapping
- **Assignments 2-6**: ALL use `teacher_ratings.csv` (500 records, 12 variables)
  - Generated once by `Assignment 2/generate_rating_data.py`
  - Includes: teacher_id, gender, age, beauty, tenured, experience_years, students, eval_score, difficulty, course_type, department, teaching_format
  - Intentional missing values: ~2% in beauty, ~1% in eval_score
- **Assignment 1**: Uses `synthetic_data.csv` (age demographics)

**Before starting any assignment 2-6**:
1. Check if `Practical Assignments/Assignment 2/teacher_ratings.csv` exists
2. If missing, run `generate_rating_data.py` from Assignment 2 folder
3. Load the same dataset for subsequent assignments - DO NOT regenerate

### Why This Matters
Assignments build on each other:
- Assignment 2: Basic descriptive stats on dataset
- Assignment 3: Filtered analysis and segmentation
- Assignment 4: Hypothesis testing on categorical/continuous variables
- Assignments 5-6: Advanced statistical techniques on same data

Regenerating the dataset breaks reproducibility across assignments.

## Import Pattern (Standardized)

All assignment notebooks follow this exact import structure:
```python
# Standard imports in every assignment notebook
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from scipy.stats import [specific_tests_needed]  # e.g., ttest_ind, chi2_contingency
import warnings
warnings.filterwarnings('ignore')

# Set visualization defaults
sns.set_style("whitegrid")
plt.rcParams['figure.dpi'] = 100
```

Additional imports added as needed:
- `from scipy.stats import shapiro, levene` - assumption testing
- `from statsmodels.stats.proportion import proportion_confint` - confidence intervals
- `from scipy.stats import gaussian_kde` - kernel density estimation
- `from scipy.stats import mannwhitneyu` - non-parametric tests

## Git Workflow Specifics

### What's Tracked vs Ignored
**Tracked** (committed to git):
- All `.ipynb` notebook files with outputs
- Generated `.pdf` exports of assignments
- Small reference CSVs: `age_bin_statistics.csv`
- Assignment specification `.txt` files
- Theory notes and formulas

**Ignored** (`.gitignore`):
- Large CSV files (most `*.csv` files)
- Virtual environment (`.venv/`)
- Jupyter checkpoints (`.ipynb_checkpoints/`)
- LaTeX aux files (`*.aux`, `*.log`, `*.toc`)
- Typst compiler binaries (`typst-x86_64-pc-windows-msvc/`)

**Exception Pattern**: Use `!filename.csv` in `.gitignore` to force-track specific CSVs

### Assignment Submission Checklist
1. Complete notebook with all cells executed
2. Export to PDF (File → Save and Export Notebook As → PDF)
3. Format code: `./format_code.sh "Practical Assignments/Assignment N"`
4. Verify PDF renders correctly (no broken markdown/LaTeX)
5. Commit notebook + PDF (CSV datasets not committed unless exception)

## Environment-Specific Commands

This is a **Windows-based** repository with Git Bash as default shell.

### Path Conventions
- **In Code**: Use forward slashes: `pd.read_csv("Practical Assignments/Assignment 2/teacher_ratings.csv")`
- **In Shell**: Windows paths work: `cd "c:/Users/ayana/Projects/Stats&AI/Statistical Foundation of Data Science"`
- **Virtual Environment**: `.venv/` located at repository root (not per-assignment)

### Activation Commands
```bash
# Git Bash (primary shell)
source .venv/Scripts/activate

# Windows CMD (alternative)
.venv\Scripts\activate.bat

# PowerShell (alternative)
.venv\Scripts\Activate.ps1
```

## Statistical Rigor Requirements

### Assumption Validation Workflow
For any parametric test, **ALWAYS** check and report:
```python
# Example pattern from Assignment 4
# 1. Normality check
stat, p_normality = shapiro(data)
print(f"Shapiro-Wilk: W={stat:.4f}, p={p_normality:.4f}")

# 2. Homogeneity of variance (for group comparisons)
stat, p_levene = levene(group1, group2)
print(f"Levene's test: F={stat:.4f}, p={p_levene:.4f}")

# 3. Proceed with appropriate test
if p_normality > 0.05 and p_levene > 0.05:
    # Use parametric test (t-test)
    stat, p_value = ttest_ind(group1, group2)
else:
    # Use non-parametric alternative (Mann-Whitney U)
    stat, p_value = mannwhitneyu(group1, group2)
```

### Reporting Standards (Academic Format)
- **Statistical notation**: χ²(1, N=500) = 4.23, p = .040, V = 0.092
  - NOT "chi-square = 4.23, p-value = 0.04"
- **Effect sizes mandatory**: Always report Cohen's d, Cramér's V, or rank-biserial
- **Interpretation required**: Don't just report numbers, explain practical significance
- **Visual + Statistical**: Pair every hypothesis test with appropriate visualization

---

*Last Updated: November 22, 2025 | Generated for GitHub Copilot, Cursor, Windsurf, Cline agents*
