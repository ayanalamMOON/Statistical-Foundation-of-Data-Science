import pandas as pd
import numpy as np

def generate_synthetic_data(n_samples=1000, random_seed=42):
    """
    Generate synthetic dataset for statistical analysis.

    Parameters:
    - n_samples: Number of samples to generate
    - random_seed: Random seed for reproducibility

    Returns:
    - DataFrame with columns: age, income, score
    """
    np.random.seed(random_seed)

    # Generate age data (18-65 years)
    age = np.random.normal(40, 12, n_samples)
    age = np.clip(age, 18, 65)  # Clip to reasonable age range

    # Generate income data with correlation to age
    # Higher age tends to have higher income (with some noise)
    income_base = 30000 + (age - 18) * 1500 + np.random.normal(0, 15000, n_samples)
    income = np.clip(income_base, 20000, 200000)  # Reasonable income range

    # Generate score data (0-100) with some correlation to income
    score_base = 50 + (income - 50000) / 3000 + np.random.normal(0, 15, n_samples)
    score = np.clip(score_base, 0, 100)

    # Create DataFrame
    df = pd.DataFrame({
        'age': age,
        'income': income,
        'score': score
    })

    # Introduce some NaN values randomly
    nan_indices_income = np.random.choice(df.index, size=int(0.05 * n_samples), replace=False)
    nan_indices_score = np.random.choice(df.index, size=int(0.03 * n_samples), replace=False)

    df.loc[nan_indices_income, 'income'] = np.nan
    df.loc[nan_indices_score, 'score'] = np.nan

    # Round age to integers and income to 2 decimal places
    df['age'] = df['age'].round().astype(int)
    df['income'] = df['income'].round(2)
    df['score'] = df['score'].round(2)

    return df

if __name__ == "__main__":
    # Generate the dataset
    data = generate_synthetic_data(1000)

    # Save to CSV
    data.to_csv('synthetic_data.csv', index=False)

    print("Synthetic dataset generated successfully!")
    print(f"Dataset shape: {data.shape}")
    print("\nFirst 10 rows:")
    print(data.head(10))
    print("\nDataset info:")
    print(data.info())
    print("\nBasic statistics:")
    print(data.describe())
