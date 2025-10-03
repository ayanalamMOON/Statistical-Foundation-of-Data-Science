# Statistical Foundation of Data Science

[![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange.svg)](https://jupyter.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)]()

## Student Information

| Field | Details |
|-------|---------|
| **Name** | Md Ayan Alam |
| **Roll Number** | GF202342645 |
| **Course** | Statistical Foundation of Data Science |
| **Institution** | Shoolini University of Biotechnology and Management Sciences |
| **Academic Year** | 2025 |

## Repository Overview

This repository contains comprehensive implementations and solutions for statistical analysis, data science methodologies, and computational mathematics assignments. Each assignment demonstrates practical applications of statistical concepts, data manipulation techniques, and advanced analytical methods using Python ecosystem.

## Repository Structure

```
Statistical-Foundation-of-Data-Science/
├── README.md                           # This file
├── requirements.txt                    # Python dependencies
├── .gitignore                         # Git ignore rules
├── LICENSE                            # Repository license
├── .venv/                             # Virtual environment (in root)
│
├── Practical Assignments/             # Hands-on coding assignments
│   ├── Assignment 1/                  # First assignment - Statistical Analysis
│   │   ├── stats_analysis.ipynb      # Statistical Analysis & Array Operations
│   │   ├── Assignment_1.ipynb         # Complete assignment notebook
│   │   ├── Assignment_1.pdf           # PDF export of assignment
│   │   ├── generate_data.py           # Synthetic data generation
│   │   ├── synthetic_data.csv         # Generated dataset
│   │   ├── age_bin_statistics.csv     # Processed statistics
│   │   └── Problems.txt               # Assignment specifications
│   │
│   ├── Assignment 2/                  # Second assignment - Teacher Rating Analysis
│   │   ├── Assignment_2.ipynb         # Complete analysis notebook
│   │   ├── Assignment_2.pdf           # PDF export of assignment
│   │   ├── generate_rating_data.py    # Teacher rating data generator
│   │   ├── teacher_ratings.csv        # Generated teacher dataset (500 records)
│   │   └── Assignment_2_files/        # Supporting files and assets
│   │
│   └── [Future assignments will be added here]
│
├── Project/                           # Major course projects
│   └── [Future project implementations]
│
├── Lecture Assignments/               # Lecture-based theoretical assignments
│   └── Assignment 1/                  # First lecture assignment
│       ├── Statistical+FDS+-+Assignment+1.pdf
│       ├── Statistical+FDS+-+Assignment+1.txt
│       └── Screenshot 2025-09-18 225722.png
│
├── Theory/                            # Theoretical foundations
│   ├── notes/                         # Course notes
│   │   ├── 00_study_guide.md
│   │   ├── 01_descriptive_statistics_notes.md
│   │   ├── 01_descriptive_statistics_interactive.ipynb
│   │   ├── 02_probability_distributions_notes.md
│   │   ├── 02_probability_distributions_interactive.ipynb
│   │   ├── 03_hypothesis_testing_notes.md
│   │   ├── 03_hypothesis_testing_interactive.ipynb
│   │   ├── 04_regression_analysis_notes.md
│   │   ├── 05_linear_algebra_notes.md
│   │   ├── 06_bayesian_statistics_notes.md
│   │   └── README.md
│   ├── formulas/                      # Statistical formulas
│   │   └── statistical_formulas_reference.ipynb
│   └── references/                    # Academic references
│
├── Data/                              # Datasets and data sources
│   ├── raw/                           # Original datasets
│   ├── processed/                     # Cleaned datasets
│   └── external/                      # External data sources
│
├── Utils/                             # Utility functions
│   ├── statistical_functions.py      # Custom statistical methods
│   ├── visualization_helpers.py      # Plotting utilities
│   └── data_preprocessing.py         # Data cleaning functions
│
└── Reports/                           # Analysis reports
    ├── assignment_reports/            # Individual assignment reports
    └── project_reports/              # Comprehensive project reports
```

## Assignment Catalog

### Completed Assignments

#### Assignment 1: Statistical Analysis and Array Operations
- **File**: `Practical Assignments/Assignment 1/stats_analysis.ipynb`
- **Status**: Completed
- **Completion Date**: September 16, 2025
- **Topics Covered**:
  - Statistical measures (mean, median, weighted mean)
  - Data standardization and outlier detection
  - Age-based demographic binning
  - NumPy array operations and linear algebra
- **Key Technologies**: Pandas, NumPy, Matplotlib, Seaborn, SciPy
- **Deliverables**:
  - Jupyter notebook with complete analysis
  - Generated synthetic dataset
  - Age bin statistics export
  - Comprehensive visualizations

**Technical Achievements**:
- Robust NaN handling without data loss
- Z-score standardization with outlier detection
- Tidy data principles implementation
- Advanced linear algebra operations
- Professional visualization standards

#### Assignment 2: Teacher Rating Data Analysis
- **File**: `Practical Assignments/Assignment 2/Assignment_2.ipynb`
- **Status**: Completed
- **Completion Date**: October 3, 2025
- **Topics Covered**:
  - Data type identification (Cross-sectional vs Time Series)
  - Comprehensive descriptive statistics computation
  - Distribution analysis and normality testing
  - Gender-based comparative analysis
  - Chi-square test of independence
  - Effect size calculations (Cohen's d, Cramér's V)
- **Key Technologies**: Pandas, NumPy, Matplotlib, Seaborn, SciPy
- **Deliverables**:
  - Jupyter notebook with 6 complete questions
  - PDF export for submission
  - Synthetic teacher rating dataset (500 teachers, 12 variables)
  - Multiple statistical visualizations (histograms, box plots, Q-Q plots, violin plots)

**Technical Achievements**:
- Generated realistic synthetic dataset with correlations
- Performed statistical hypothesis testing (t-tests, chi-square)
- Created publication-quality multi-panel visualizations
- Implemented normality tests (Shapiro-Wilk, D'Agostino)
- Calculated effect sizes for practical significance
- Cross-tabulation and contingency table analysis
- Professional markdown documentation with interpretations

---

## Technical Requirements

### Core Dependencies
```python
# Data Science Stack
pandas >= 2.3.0
numpy >= 2.3.0
scipy >= 1.16.0
scikit-learn >= 1.7.0
statsmodels >= 0.14.0

# Visualization
matplotlib >= 3.10.0
seaborn >= 0.13.0
plotly >= 6.0.0

# Jupyter Environment
jupyter >= 1.1.0
ipykernel >= 6.30.0
jupyterlab >= 4.4.0

# Statistical Computing
sympy >= 1.14.0
numba >= 0.61.0

# Development Tools
black >= 25.0.0
flake8 >= 7.0.0
pytest >= 8.0.0
```

### Development Environment Setup

1. **Clone Repository**
   ```bash
   git clone https://github.com/ayanalamMOON/Statistical-Foundation-of-Data-Science.git
   cd Statistical-Foundation-of-Data-Science
   ```

2. **Create Virtual Environment**
   ```bash
   python -m venv .venv
   source .venv/Scripts/activate  # Windows
   # source .venv/bin/activate    # Linux/Mac
   ```

3. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Launch Jupyter Lab**
   ```bash
   jupyter lab
   ```

## Progress Tracking

### Assignment Completion Matrix

| Assignment | Start Date | Due Date | Status | Grade | Notes |
|------------|------------|----------|---------|-------|-------|
| Assignment 1: Statistical Analysis & Array Ops | Sep 13, 2025 | Sep 16, 2025 | ✅ Completed | - | Comprehensive implementation |
| Assignment 2: Teacher Rating Data Analysis | Sep 23, 2025 | Oct 10, 2025 | ✅ Completed | - | 6 questions with full statistical analysis |

### Skills Development Roadmap

```mermaid
graph TD
    A[Statistical Foundations] --> B[Descriptive Statistics]
    A --> C[Inferential Statistics]
    B --> D[Data Visualization]
    C --> E[Hypothesis Testing]
    D --> F[Exploratory Data Analysis]
    E --> G[Regression Modeling]
    F --> H[Time Series Analysis]
    G --> I[Machine Learning]
    H --> J[Advanced Analytics]
    I --> K[Deep Learning Applications]
    J --> K
```

## Learning Objectives

### Core Competencies
- **Statistical Theory**: Master fundamental and advanced statistical concepts
- **Data Manipulation**: Proficient use of pandas and NumPy for data operations
- **Visualization**: Create publication-quality statistical visualizations
- **Hypothesis Testing**: Apply appropriate statistical tests for various scenarios
- **Modeling**: Develop and validate statistical and machine learning models
- **Programming**: Write clean, efficient, and well-documented Python code

### Advanced Skills
- **Bayesian Methods**: Implement Bayesian statistical approaches
- **Time Series**: Analyze and forecast time-dependent data
- **Multivariate Analysis**: Handle complex multi-dimensional datasets
- **Computational Statistics**: Use simulation and resampling methods
- **Statistical Software**: Proficiency in R, Python, and specialized packages

## Code Quality Standards

### Formatting
This repository uses **Black** code formatter for consistent Python code style:
```bash
# Format Python files
black "path/to/file.py"

# Format Jupyter notebooks
black "path/to/notebook.ipynb"

# Check formatting without changes
black --check "path/to/file.py"
```

### Best Practices
- All code follows PEP 8 style guidelines
- Comprehensive docstrings for functions and classes
- Type hints for function parameters and returns
- Unit tests for utility functions
- Git commits follow conventional commit format

## Resources and References

### Textbooks
- "Introduction to Statistical Learning" by James, Witten, Hastie, Tibshirani
- "The Elements of Statistical Learning" by Hastie, Tibshirani, Friedman
- "Bayesian Data Analysis" by Gelman, Carlin, Stern, Rubin
- "Time Series Analysis and Its Applications" by Shumway, Stoffer

### Online Resources
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)
- [Statistical Learning Course (Stanford)](https://www.statlearning.com/)
- [Scipy Stats Documentation](https://docs.scipy.org/doc/scipy/reference/stats.html)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

### Academic Papers
- References will be added as assignments progress
- Citation format: APA Style

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) file for details.

## Contributing

This is an academic repository for coursework. While external contributions are not expected, feedback and suggestions are welcome through issues.

## Contact

**Md Ayan Alam**
Roll Number: GF202342645
Email: [mdalam@shooliniuniversity.com]
GitHub: [@ayanalamMOON](https://github.com/ayanalamMOON)

---

## Recent Updates

### October 3, 2025
- ✅ Completed Assignment 2: Teacher Rating Data Analysis
- ✅ Added comprehensive statistical hypothesis testing
- ✅ Generated PDF exports for both assignments
- ✅ Implemented code formatting with Black
- ✅ Enhanced repository with description and 19 topics for discoverability
- ✅ Updated README with complete repository structure

### September 16, 2025
- ✅ Completed Assignment 1: Statistical Analysis and Array Operations
- ✅ Set up initial repository structure
- ✅ Created comprehensive theory notes and interactive notebooks
- ✅ Established development environment with virtual environment

---

*Last Updated: October 3, 2025*
*Repository maintained for academic purposes*
