# Practical Assignment 8: Decision Trees

## Quick Start Guide

### Prerequisites
- Python 3.7+
- Jupyter Notebook / JupyterLab
- Required packages: pandas, numpy, matplotlib, seaborn, scikit-learn

### Installation
```bash
# Install required packages
pip install pandas numpy matplotlib seaborn scikit-learn scipy

# Optional: For better tree visualization
pip install graphviz
```

### Running the Notebook

1. **Navigate to the directory:**
   ```bash
   cd "c:\Users\ayana\Projects\Stats&AI\Statistical Foundation of Data Science\Practical Assignments\Practical_8"
   ```

2. **Launch Jupyter:**
   ```bash
   jupyter notebook Practical_8.ipynb
   ```

3. **Execute all cells:**
   - Click "Kernel" → "Restart & Run All"
   - Or run cells sequentially from top to bottom

### Dataset

The notebook includes automatic dataset downloading. The script will:
1. Try downloading from Hugging Face Datasets
2. Fall back to GitHub if needed
3. Fall back to Kaggle mirror if needed

If automatic download fails, you can manually download `diabetes.csv` from:
https://www.kaggle.com/datasets/uciml/pima-indians-diabetes-database

## Notebook Contents

### Theoretical Sections (Sec 1-2)
- Decision Tree fundamentals
- Entropy and Information Gain
- Gini Index
- Mathematical foundations with worked examples

### Practical Implementation (Sec 3-9)
- Dataset loading and EDA
- Feature selection and data splitting
- Model building and evaluation
- **Tree visualization**
- **Root node analysis with manual calculations** ⭐

### Analysis & Conclusions (Sec 10-11)
- Feature importance analysis
- Comprehensive conclusions and insights

## Key Features

✓ **70 total cells** (32 markdown + 38 code)
✓ **Textbook-quality explanations** with LaTeX equations
✓ **Manual calculations** for Entropy & Gini Index
✓ **Complete root node justification**
✓ **Professional visualizations**
✓ **All assignment requirements met**

## Expected Runtime

- First run (with downloads): ~2-3 minutes
- Subsequent runs: ~1-2 minutes

## Outputs

The notebook generates:
- Statistical summaries
- Multiple visualizations (histograms, heatmaps, tree diagrams, ROC curves)
- Manual calculation results
- Performance metrics
- Comprehensive analysis

## Troubleshooting

**Dataset Download Issues:**
- Check internet connection
- Install `datasets` package: `pip install datasets`
- Manually download diabetes.csv if needed

**Visualization Issues:**
- Tree visualization uses matplotlib (always works)
- Graphviz is optional for enhanced visualizations

**Missing Packages:**
```bash
pip install --upgrade pandas numpy matplotlib seaborn scikit-learn scipy
```

## Assignment Requirements Checklist

- [x] Build Decision Tree classifier with Scikit-learn
- [x] Download Pima Indian Diabetes dataset from Kaggle
- [x] Feature selection (dependent vs independent variables)
- [x] Split the data
- [x] Build decision tree
- [x] Visualization - pictorial representation
- [x] Find Entropy
- [x] Find Information Gain
- [x] Find Gini Index
- [x] Support why you chose the specific root node

## Files in This Directory

- `Practical_8.ipynb` - Main notebook (87 KB)
- `download_dataset.py` - Dataset download script
- `diabetes.csv` - Pima Indians Diabetes dataset
- `README.md` - This file
- `notebook_builder.py` - Helper script
- `build_section_*.py` - Notebook construction scripts

## Contact & Support

For questions about the implementation, refer to:
- Inline code comments in the notebook
- Theory sections for mathematical explanations
- Conclusions section for summary

## Credits

- **Dataset**: Pima Indians Diabetes Database (UCI ML Repository / Kaggle)
- **Libraries**: Scikit-learn, Pandas, NumPy, Matplotlib, Seaborn
- **Assignment**: Statistical Foundation of Data Sciences course

---

**Last Updated**: November 2025
**Version**: 1.0
**Status**: Complete and Ready for Submission
