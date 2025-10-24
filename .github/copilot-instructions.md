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

---

*Last Updated: October 24, 2025 | Generated for GitHub Copilot, Cursor, Windsurf, Cline agents*
