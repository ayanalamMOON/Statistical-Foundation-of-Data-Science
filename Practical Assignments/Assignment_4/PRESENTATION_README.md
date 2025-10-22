# Assignment 4 LaTeX Beamer Presentation

## Overview

This is a professional 8-page LaTeX Beamer presentation for Assignment 4 of the Statistical Foundation of Data Science course. The presentation covers categorical and continuous variable analysis using the teacher ratings dataset.

## Contents

### Presentation Structure (8 Slides)

1. **Title Page**
   - Student information
   - Assignment details
   - Date

2. **Overview & Dataset**
   - Assignment details and focus areas
   - Dataset description
   - Variable types

3. **Question 1: Tenure & Visible Minorities**
   - Chi-square test of independence
   - Contingency tables
   - Effect size analysis

4. **Question 2: Age by Tenure Status**
   - Two-sample t-test
   - Descriptive statistics
   - Cohen's d effect size

5. **Question 3: Best Visualization for Age**
   - Histogram vs Box plot vs Density plot
   - Selection criteria
   - Justification

6. **Question 4: Bar Charts Comparison**
   - pyplot.bar() vs pyplot.barh()
   - Use cases and differences
   - Gender distribution example

7. **Question 5: Median Evaluation Score**
   - Median calculation for tenured professors
   - Descriptive statistics
   - Interpretation

8. **Summary & Conclusions**
   - Key findings from all questions
   - Statistical methods summary
   - Final results

## Features

- **Professional Theme**: Madrid theme with seahorse color scheme
- **Mathematical Formulas**: Comprehensive LaTeX math notation
- **Tables**: Well-formatted statistical tables
- **Two-Column Layout**: Balanced information presentation
- **Color Coding**: Custom colors for emphasis
- **Aspect Ratio**: 16:9 for modern displays

## Requirements

### LaTeX Packages Used

- `beamer` - Presentation framework
- `amsmath` - Mathematical formulas
- `amssymb` - Mathematical symbols
- `booktabs` - Professional tables
- `graphicx` - Graphics support
- `tikz` - Drawing diagrams
- `pgfplots` - Plotting (if needed)
- `xcolor` - Color definitions

### LaTeX Distribution

You need one of the following:
- **TeX Live** (Linux/Mac/Windows)
- **MiKTeX** (Windows)
- **MacTeX** (macOS)

## Compilation Instructions

### Method 1: Using pdflatex (Recommended)

```bash
cd "Practical Assignments/Assignment_4"
pdflatex Assignment_4_Presentation.tex
pdflatex Assignment_4_Presentation.tex  # Run twice for proper references
```

### Method 2: Using latexmk (Automated)

```bash
latexmk -pdf Assignment_4_Presentation.tex
```

### Method 3: Using VS Code with LaTeX Workshop

1. Install the "LaTeX Workshop" extension in VS Code
2. Open `Assignment_4_Presentation.tex`
3. Press `Ctrl+Alt+B` (or `Cmd+Option+B` on Mac) to build
4. Or click the "Build LaTeX project" button in the sidebar

### Method 4: Using Overleaf (Online)

1. Go to [Overleaf](https://www.overleaf.com)
2. Create a new blank project
3. Upload `Assignment_4_Presentation.tex`
4. Click "Recompile"

## Output

The compilation will generate:
- `Assignment_4_Presentation.pdf` - The final presentation (8 pages)
- Additional auxiliary files (.aux, .log, .nav, .out, .snm, .toc)

## Customization

### To Add Actual Data

Replace the placeholder values with your actual results:

1. **Question 1** (Slide 3):
   - Replace `XX.X%` with actual tenure rates
   - Update chi-square test results

2. **Question 2** (Slide 4):
   - Replace `$\bar{x}_1$`, `$\bar{x}_2$` with actual means
   - Update standard deviations
   - Add actual sample sizes

3. **Question 5** (Slide 7):
   - Replace `$n$`, `$M$`, `$\bar{x}$` with actual values
   - Update quartiles and IQR

4. **Summary** (Slide 8):
   - Update effect sizes
   - Add specific conclusions

### To Change Colors

Modify the color definitions in the preamble:

```latex
\definecolor{darkblue}{RGB}{0,51,102}
\definecolor{lightblue}{RGB}{102,178,255}
\definecolor{accent}{RGB}{255,128,0}
```

### To Change Theme

```latex
\usetheme{Madrid}      % Try: Berlin, Copenhagen, Singapore, etc.
\usecolortheme{seahorse}  % Try: dolphin, whale, beaver, etc.
```

## Presentation Tips

### Presenting the Slides

1. **Slide 1**: Introduce yourself and the assignment
2. **Slide 2**: Provide context about the dataset
3. **Slide 3-7**: Walk through each question methodically
4. **Slide 8**: Summarize key findings

### Time Management (10-minute presentation)

- Introduction: 1 minute
- Dataset overview: 1 minute
- Questions 1-5: 1.5 minutes each (7.5 minutes)
- Summary: 30 seconds

## File Structure

```
Assignment_4/
├── Assignment_4.ipynb                    # Jupyter notebook (main analysis)
├── Assignment_4.txt                      # Assignment questions
├── Assignment_4_Presentation.tex         # LaTeX Beamer presentation
├── Assignment_4_Presentation.pdf         # Compiled PDF (after build)
└── PRESENTATION_README.md                # This file
```

## Troubleshooting

### Common Issues

1. **"Package not found" error**
   - Solution: Install missing packages via your TeX distribution

2. **Compilation fails**
   - Run `pdflatex` twice (first run may show errors)
   - Check for syntax errors in modifications

3. **Fonts look different**
   - This is normal - different systems use different fonts
   - PDF will look consistent across all platforms

4. **Tables don't fit**
   - Reduce font size: `\scriptsize` or `\tiny`
   - Adjust column widths
   - Use abbreviations

### Getting Help

- LaTeX Stack Exchange: https://tex.stackexchange.com
- Beamer documentation: `texdoc beamer`
- Overleaf tutorials: https://www.overleaf.com/learn

## Version Information

- **Created**: October 19, 2025
- **LaTeX Engine**: pdfLaTeX
- **Beamer Version**: Compatible with latest
- **Page Count**: 8 slides
- **Aspect Ratio**: 16:9

## License

This presentation template is created for educational purposes as part of the Statistical Foundation of Data Science course.

## Author

**Md Ayan Alam**
Roll Number: GF202342645
Statistical Foundation of Data Science
Assignment 4

---

**Note**: Remember to fill in the actual statistical results from your analysis before presenting!
