"""
Statistical Functions Utility Module
Author: Md Ayan Alam (GF202342645)
Description: Custom statistical methods and utility functions for data analysis
"""

import numpy as np
import pandas as pd
from scipy import stats
from typing import Union, List, Tuple, Optional
import warnings


def weighted_mean(values: Union[np.ndarray, pd.Series],
                  weights: Union[np.ndarray, pd.Series]) -> float:
    """
    Calculate weighted mean handling NaN values appropriately.

    Parameters:
    -----------
    values : array-like
        Values to calculate weighted mean for
    weights : array-like
        Weights corresponding to each value

    Returns:
    --------
    float
        Weighted mean of the values
    """
    # Convert to pandas Series for easier NaN handling
    if not isinstance(values, pd.Series):
        values = pd.Series(values)
    if not isinstance(weights, pd.Series):
        weights = pd.Series(weights)

    # Remove NaN values
    valid_mask = values.notna() & weights.notna()
    clean_values = values[valid_mask]
    clean_weights = weights[valid_mask]

    if len(clean_values) == 0:
        return np.nan

    return (clean_values * clean_weights).sum() / clean_weights.sum()


def detect_outliers_zscore(data: Union[np.ndarray, pd.Series],
                          threshold: float = 3.0) -> Tuple[np.ndarray, pd.Series]:
    """
    Detect outliers using z-score method.

    Parameters:
    -----------
    data : array-like
        Data to analyze for outliers
    threshold : float, default=3.0
        Z-score threshold for outlier detection

    Returns:
    --------
    tuple
        (outlier_mask, z_scores)
    """
    if isinstance(data, np.ndarray):
        data = pd.Series(data)

    # Calculate z-scores
    z_scores = (data - data.mean()) / data.std()

    # Identify outliers
    outlier_mask = np.abs(z_scores) > threshold

    return outlier_mask, z_scores


def detect_outliers_iqr(data: Union[np.ndarray, pd.Series],
                       multiplier: float = 1.5) -> Tuple[np.ndarray, dict]:
    """
    Detect outliers using Interquartile Range (IQR) method.

    Parameters:
    -----------
    data : array-like
        Data to analyze for outliers
    multiplier : float, default=1.5
        IQR multiplier for outlier detection

    Returns:
    --------
    tuple
        (outlier_mask, quartile_info)
    """
    if isinstance(data, np.ndarray):
        data = pd.Series(data)

    Q1 = data.quantile(0.25)
    Q3 = data.quantile(0.75)
    IQR = Q3 - Q1

    lower_bound = Q1 - multiplier * IQR
    upper_bound = Q3 + multiplier * IQR

    outlier_mask = (data < lower_bound) | (data > upper_bound)

    quartile_info = {
        'Q1': Q1,
        'Q3': Q3,
        'IQR': IQR,
        'lower_bound': lower_bound,
        'upper_bound': upper_bound
    }

    return outlier_mask, quartile_info


def comprehensive_summary_stats(data: Union[np.ndarray, pd.Series]) -> dict:
    """
    Calculate comprehensive summary statistics for a dataset.

    Parameters:
    -----------
    data : array-like
        Data to analyze

    Returns:
    --------
    dict
        Dictionary containing various statistical measures
    """
    if isinstance(data, np.ndarray):
        data = pd.Series(data)

    clean_data = data.dropna()

    if len(clean_data) == 0:
        return {'error': 'No valid data points'}

    return {
        'count': len(clean_data),
        'missing': data.isnull().sum(),
        'mean': clean_data.mean(),
        'median': clean_data.median(),
        'mode': clean_data.mode().iloc[0] if len(clean_data.mode()) > 0 else np.nan,
        'std': clean_data.std(),
        'var': clean_data.var(),
        'min': clean_data.min(),
        'max': clean_data.max(),
        'range': clean_data.max() - clean_data.min(),
        'q1': clean_data.quantile(0.25),
        'q3': clean_data.quantile(0.75),
        'iqr': clean_data.quantile(0.75) - clean_data.quantile(0.25),
        'skewness': stats.skew(clean_data),
        'kurtosis': stats.kurtosis(clean_data),
        'cv': clean_data.std() / clean_data.mean() if clean_data.mean() != 0 else np.nan
    }


def binning_analysis(data: pd.DataFrame,
                    bin_column: str,
                    target_columns: List[str],
                    bins: Union[int, List],
                    labels: Optional[List] = None) -> pd.DataFrame:
    """
    Perform binning analysis with comprehensive statistics.

    Parameters:
    -----------
    data : pd.DataFrame
        Input dataframe
    bin_column : str
        Column name to create bins for
    target_columns : list
        Columns to calculate statistics for each bin
    bins : int or list
        Bin edges or number of bins
    labels : list, optional
        Labels for the bins

    Returns:
    --------
    pd.DataFrame
        Binned analysis results
    """
    df_copy = data.copy()

    # Create bins
    df_copy['bin'] = pd.cut(df_copy[bin_column], bins=bins, labels=labels, right=False)

    # Calculate statistics for each bin
    agg_functions = {
        col: ['count', 'mean', 'median', 'std', 'min', 'max']
        for col in target_columns
    }

    result = df_copy.groupby('bin', observed=False).agg(agg_functions)

    # Flatten column names
    result.columns = ['_'.join(col).strip() for col in result.columns.values]

    return result.reset_index()


def correlation_analysis(data: pd.DataFrame,
                        method: str = 'pearson') -> Tuple[pd.DataFrame, pd.DataFrame]:
    """
    Perform comprehensive correlation analysis.

    Parameters:
    -----------
    data : pd.DataFrame
        Input dataframe
    method : str, default='pearson'
        Correlation method ('pearson', 'spearman', 'kendall')

    Returns:
    --------
    tuple
        (correlation_matrix, p_values_matrix)
    """
    # Select only numeric columns
    numeric_data = data.select_dtypes(include=[np.number])

    if method == 'pearson':
        corr_matrix = numeric_data.corr(method='pearson')
        # Calculate p-values
        n = len(numeric_data)
        p_values = np.zeros((len(numeric_data.columns), len(numeric_data.columns)))

        for i, col1 in enumerate(numeric_data.columns):
            for j, col2 in enumerate(numeric_data.columns):
                if i != j:
                    r = corr_matrix.iloc[i, j]
                    t_stat = r * np.sqrt((n - 2) / (1 - r**2))
                    p_values[i, j] = 2 * (1 - stats.t.cdf(abs(t_stat), n - 2))
                else:
                    p_values[i, j] = 0

        p_values_df = pd.DataFrame(p_values,
                                  index=numeric_data.columns,
                                  columns=numeric_data.columns)
    else:
        corr_matrix = numeric_data.corr(method=method)
        p_values_df = pd.DataFrame(np.nan,
                                  index=numeric_data.columns,
                                  columns=numeric_data.columns)
        warnings.warn(f"P-values not calculated for {method} correlation")

    return corr_matrix, p_values_df


# Example usage and testing functions
if __name__ == "__main__":
    # Test the functions with sample data
    np.random.seed(42)
    sample_data = pd.DataFrame({
        'values': np.random.normal(50, 15, 100),
        'weights': np.random.uniform(1, 5, 100),
        'age': np.random.randint(18, 65, 100)
    })

    print("Testing statistical functions...")
    print(f"Weighted mean: {weighted_mean(sample_data['values'], sample_data['weights'])}")

    outliers, z_scores = detect_outliers_zscore(sample_data['values'])
    print(f"Number of outliers (z-score): {outliers.sum()}")

    summary = comprehensive_summary_stats(sample_data['values'])
    print(f"Summary statistics: {summary}")
