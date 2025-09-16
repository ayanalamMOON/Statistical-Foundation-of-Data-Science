"""
Visualization Helpers Module
Author: Md Ayan Alam (GF202342645)
Description: Utility functions for creating professional statistical visualizations
"""

import matplotlib.pyplot as plt
import matplotlib.figure
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pandas as pd
import numpy as np
from typing import List, Optional, Tuple, Union, Any
import warnings


# Set default style
plt.style.use('default')
sns.set_palette("husl")


def setup_matplotlib_style():
    """Setup professional matplotlib styling."""
    plt.rcParams.update({
        'figure.figsize': (12, 8),
        'font.size': 11,
        'axes.titlesize': 14,
        'axes.labelsize': 12,
        'xtick.labelsize': 10,
        'ytick.labelsize': 10,
        'legend.fontsize': 10,
        'figure.titlesize': 16,
        'axes.grid': True,
        'grid.alpha': 0.3,
        'axes.spines.top': False,
        'axes.spines.right': False
    })


def create_distribution_plot(data: Union[pd.Series, np.ndarray],
                           title: str = "Distribution Plot",
                           bins: int = 30,
                           show_stats: bool = True) -> matplotlib.figure.Figure:
    """
    Create a comprehensive distribution plot with statistics.

    Parameters:
    -----------
    data : array-like
        Data to plot
    title : str
        Plot title
    bins : int
        Number of histogram bins
    show_stats : bool
        Whether to show statistical lines

    Returns:
    --------
    matplotlib.figure.Figure
        The created figure
    """
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15, 6))

    # Remove NaN values
    clean_data = pd.Series(data).dropna()

    # Histogram
    ax1.hist(clean_data, bins=bins, alpha=0.7, edgecolor='black', density=True)

    if show_stats:
        mean_val = clean_data.mean()
        median_val = clean_data.median()
        std_val = clean_data.std()

        ax1.axvline(mean_val, color='red', linestyle='--',
                   label=f'Mean: {mean_val:.2f}')
        ax1.axvline(median_val, color='blue', linestyle='--',
                   label=f'Median: {median_val:.2f}')
        ax1.axvline(mean_val + std_val, color='orange', linestyle=':',
                   label=f'+1 SD: {mean_val + std_val:.2f}')
        ax1.axvline(mean_val - std_val, color='orange', linestyle=':',
                   label=f'-1 SD: {mean_val - std_val:.2f}')
        ax1.legend()

    ax1.set_title(f'{title} - Histogram')
    ax1.set_xlabel('Value')
    ax1.set_ylabel('Density')

    # Box plot
    ax2.boxplot(clean_data, vert=True)
    ax2.set_title(f'{title} - Box Plot')
    ax2.set_ylabel('Value')
    ax2.grid(True, alpha=0.3)

    plt.tight_layout()
    return fig


def create_correlation_heatmap(corr_matrix: pd.DataFrame,
                              title: str = "Correlation Matrix",
                              figsize: Tuple[int, int] = (10, 8)) -> matplotlib.figure.Figure:
    """
    Create a professional correlation heatmap.

    Parameters:
    -----------
    corr_matrix : pd.DataFrame
        Correlation matrix
    title : str
        Plot title
    figsize : tuple
        Figure size

    Returns:
    --------
    matplotlib.figure.Figure
        The created figure
    """
    fig, ax = plt.subplots(figsize=figsize)

    # Create heatmap
    sns.heatmap(corr_matrix,
                annot=True,
                cmap='RdBu_r',
                center=0,
                square=True,
                fmt='.2f',
                cbar_kws={"shrink": .8},
                ax=ax)

    ax.set_title(title, fontsize=14, pad=20)
    plt.tight_layout()
    return fig


def create_scatter_with_regression(x: Union[pd.Series, np.ndarray],
                                  y: Union[pd.Series, np.ndarray],
                                  title: str = "Scatter Plot with Regression",
                                  xlabel: str = "X Variable",
                                  ylabel: str = "Y Variable") -> matplotlib.figure.Figure:
    """
    Create scatter plot with regression line and confidence interval.

    Parameters:
    -----------
    x, y : array-like
        Variables to plot
    title : str
        Plot title
    xlabel, ylabel : str
        Axis labels

    Returns:
    --------
    matplotlib.figure.Figure
        The created figure
    """
    fig, ax = plt.subplots(figsize=(10, 7))

    # Create scatter plot with regression line
    sns.scatterplot(x=x, y=y, alpha=0.6, ax=ax)
    sns.regplot(x=x, y=y, scatter=False, color='red', ax=ax)

    # Calculate correlation
    corr = np.corrcoef(pd.Series(x).dropna(), pd.Series(y).dropna())[0, 1]

    ax.set_title(f'{title}\nCorrelation: {corr:.3f}')
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)

    plt.tight_layout()
    return fig


def create_grouped_bar_plot(data: pd.DataFrame,
                           x_col: str,
                           y_cols: List[str],
                           title: str = "Grouped Bar Plot") -> matplotlib.figure.Figure:
    """
    Create a grouped bar plot for multiple variables.

    Parameters:
    -----------
    data : pd.DataFrame
        Input data
    x_col : str
        Column for x-axis categories
    y_cols : list
        Columns for y-axis values
    title : str
        Plot title

    Returns:
    --------
    matplotlib.figure.Figure
        The created figure
    """
    fig, ax = plt.subplots(figsize=(12, 7))

    x = np.arange(len(data[x_col]))
    width = 0.8 / len(y_cols)

    for i, col in enumerate(y_cols):
        offset = (i - len(y_cols)/2 + 0.5) * width
        ax.bar(x + offset, data[col], width, label=col)

    ax.set_title(title)
    ax.set_xlabel(x_col)
    ax.set_ylabel('Value')
    ax.set_xticks(x)
    ax.set_xticklabels(data[x_col])
    ax.legend()
    ax.grid(True, alpha=0.3)

    plt.tight_layout()
    return fig


def create_interactive_scatter(data: pd.DataFrame,
                              x_col: str,
                              y_col: str,
                              color_col: Optional[str] = None,
                              title: str = "Interactive Scatter Plot"):
    """
    Create an interactive scatter plot using Plotly.

    Parameters:
    -----------
    data : pd.DataFrame
        Input data
    x_col, y_col : str
        Column names for x and y axes
    color_col : str, optional
        Column name for color coding
    title : str
        Plot title

    Returns:
    --------
    plotly.graph_objects.Figure
        Interactive plotly figure
    """
    fig = px.scatter(data,
                    x=x_col,
                    y=y_col,
                    color=color_col,
                    title=title,
                    hover_data=data.columns.tolist())

    fig.update_layout(
        title_font_size=16,
        xaxis_title_font_size=14,
        yaxis_title_font_size=14,
        showlegend=True if color_col else False
    )

    return fig


def create_subplots_grid(data: pd.DataFrame,
                        columns: List[str],
                        plot_type: str = 'hist',
                        title: str = "Multiple Variables Analysis") -> matplotlib.figure.Figure:
    """
    Create a grid of subplots for multiple variables.

    Parameters:
    -----------
    data : pd.DataFrame
        Input data
    columns : list
        Columns to plot
    plot_type : str
        Type of plot ('hist', 'box', 'violin')
    title : str
        Overall title

    Returns:
    --------
    matplotlib.figure.Figure
        The created figure with subplots
    """
    n_cols = min(3, len(columns))
    n_rows = (len(columns) + n_cols - 1) // n_cols

    fig, axes = plt.subplots(n_rows, n_cols, figsize=(5*n_cols, 4*n_rows))

    if n_rows == 1:
        axes = axes.reshape(1, -1) if n_cols > 1 else [axes]
    elif n_cols == 1:
        axes = axes.reshape(-1, 1)

    for i, col in enumerate(columns):
        row = i // n_cols
        col_idx = i % n_cols
        ax = axes[row][col_idx] if n_rows > 1 else axes[col_idx]

        clean_data = data[col].dropna()

        if plot_type == 'hist':
            ax.hist(clean_data, bins=20, alpha=0.7, edgecolor='black')
        elif plot_type == 'box':
            ax.boxplot(clean_data)
        elif plot_type == 'violin':
            parts = ax.violinplot([clean_data])

        ax.set_title(f'{col}')
        ax.grid(True, alpha=0.3)

    # Hide empty subplots
    for i in range(len(columns), n_rows * n_cols):
        row = i // n_cols
        col_idx = i % n_cols
        if n_rows > 1:
            axes[row][col_idx].set_visible(False)
        else:
            axes[col_idx].set_visible(False)

    fig.suptitle(title, fontsize=16)
    plt.tight_layout()
    return fig


def save_publication_figure(fig: matplotlib.figure.Figure,
                           filename: str,
                           dpi: int = 300,
                           formats: List[str] = ['png', 'pdf']):
    """
    Save figure in publication-quality formats.

    Parameters:
    -----------
    fig : matplotlib.figure.Figure
        Figure to save
    filename : str
        Base filename (without extension)
    dpi : int
        Resolution for raster formats
    formats : list
        List of file formats to save
    """
    for fmt in formats:
        fig.savefig(f"{filename}.{fmt}",
                   dpi=dpi,
                   bbox_inches='tight',
                   facecolor='white',
                   edgecolor='none')
    print(f"Figure saved as: {', '.join([f'{filename}.{fmt}' for fmt in formats])}")


# Initialize styling when module is imported
setup_matplotlib_style()


# Example usage
if __name__ == "__main__":
    # Test visualization functions
    np.random.seed(42)

    # Generate sample data
    test_data = pd.DataFrame({
        'var1': np.random.normal(50, 10, 200),
        'var2': np.random.normal(30, 5, 200),
        'var3': np.random.exponential(2, 200),
        'category': np.random.choice(['A', 'B', 'C'], 200)
    })

    print("Testing visualization functions...")

    # Test distribution plot
    fig1 = create_distribution_plot(test_data['var1'], "Test Distribution")
    plt.show()

    # Test correlation heatmap
    corr_matrix = test_data[['var1', 'var2', 'var3']].corr()
    fig2 = create_correlation_heatmap(corr_matrix)
    plt.show()

    print("Visualization tests completed!")
