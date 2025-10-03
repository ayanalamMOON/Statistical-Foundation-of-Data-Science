import pandas as pd
import numpy as np


def generate_teacher_rating_data(n_teachers=500, random_seed=42):
    """
    Generate synthetic teacher rating dataset for statistical analysis.

    This dataset represents teacher evaluations with student ratings data.
    It is a CROSS-SECTIONAL dataset (snapshot at one point in time, not time series).

    Parameters:
    - n_teachers: Number of teacher records to generate
    - random_seed: Random seed for reproducibility

    Returns:
    - DataFrame with teacher rating data
    """
    np.random.seed(random_seed)

    # Generate gender (0 = Female, 1 = Male)
    # Assume roughly 55% female, 45% male in teaching profession
    gender = np.random.choice(["female", "male"], size=n_teachers, p=[0.55, 0.45])

    # Generate beauty score (standardized, mean=0, sd=1, roughly)
    # Beauty is subjective but we'll simulate it as approximately normal
    beauty = np.random.normal(0, 1, n_teachers)
    beauty = np.clip(beauty, -2.5, 2.5)  # Clip extreme outliers

    # Generate tenure status (0 = Not tenured, 1 = Tenured)
    # Assume 60% are tenured overall, but males have slightly higher tenure rate (65% vs 55%)
    tenure_probs = np.where(gender == "male", 0.65, 0.55)
    tenured = np.array([np.random.choice([0, 1], p=[1 - p, p]) for p in tenure_probs])

    # Generate age (correlated with tenure)
    # Tenured professors tend to be older
    age_base = np.where(
        tenured == 1,
        np.random.normal(48, 8, n_teachers),  # Tenured: older
        np.random.normal(38, 6, n_teachers),
    )  # Not tenured: younger
    age = np.clip(age_base, 25, 70).astype(int)

    # Generate years of teaching experience (correlated with age and tenure)
    experience_base = np.where(
        tenured == 1,
        age - np.random.randint(28, 35, n_teachers),  # Tenured: more experience
        age - np.random.randint(25, 32, n_teachers),
    )  # Not tenured: less experience
    experience = np.clip(experience_base, 0, 45).astype(int)

    # Generate number of students in their classes
    # This varies but let's make it realistic (15-250 students per course)
    # More experienced teachers might teach larger classes or more sections
    students_base = np.random.lognormal(
        4.2, 0.6, n_teachers
    )  # Lognormal for realistic distribution
    students = np.clip(students_base, 15, 250).astype(int)

    # Generate course evaluation score (1-5 scale)
    # Influenced by beauty (small effect), gender (small bias), tenure status, and random variation
    eval_base = 3.5  # Baseline rating
    eval_base += beauty * 0.15  # Beauty has small positive effect
    eval_base += np.where(gender == "male", 0.1, 0)  # Small gender bias in ratings
    eval_base += np.where(
        tenured == 1, 0.2, 0
    )  # Tenured (more experienced) rated slightly higher
    eval_base += np.random.normal(0, 0.5, n_teachers)  # Random variation
    eval_score = np.clip(eval_base, 1, 5)

    # Generate course difficulty rating (1-5 scale)
    # Harder courses might get slightly lower evaluations (negatively correlated)
    difficulty_base = 3.0 + np.random.normal(0, 0.8, n_teachers)
    difficulty = np.clip(difficulty_base, 1, 5)

    # Generate course type
    course_types = ["introductory", "intermediate", "advanced", "graduate"]
    course_type = np.random.choice(
        course_types, size=n_teachers, p=[0.35, 0.30, 0.25, 0.10]
    )

    # Generate department
    departments = [
        "Mathematics",
        "Statistics",
        "Computer Science",
        "Economics",
        "Physics",
        "Biology",
        "Chemistry",
        "Engineering",
    ]
    department = np.random.choice(departments, size=n_teachers)

    # Generate teaching format
    formats = ["in-person", "online", "hybrid"]
    teaching_format = np.random.choice(formats, size=n_teachers, p=[0.60, 0.25, 0.15])

    # Create DataFrame
    df = pd.DataFrame(
        {
            "teacher_id": range(1, n_teachers + 1),
            "gender": gender,
            "age": age,
            "beauty": beauty,
            "tenured": tenured,
            "experience_years": experience,
            "students": students,
            "eval_score": eval_score,
            "difficulty": difficulty,
            "course_type": course_type,
            "department": department,
            "teaching_format": teaching_format,
        }
    )

    # Introduce some missing values (realistic scenario)
    nan_indices_beauty = np.random.choice(
        df.index, size=int(0.02 * n_teachers), replace=False
    )
    nan_indices_eval = np.random.choice(
        df.index, size=int(0.01 * n_teachers), replace=False
    )

    df.loc[nan_indices_beauty, "beauty"] = np.nan
    df.loc[nan_indices_eval, "eval_score"] = np.nan

    # Round numerical values
    df["beauty"] = df["beauty"].round(3)
    df["eval_score"] = df["eval_score"].round(2)
    df["difficulty"] = df["difficulty"].round(2)

    return df


if __name__ == "__main__":
    # Generate the dataset
    print("Generating Teacher Rating Dataset...")
    print("=" * 60)

    data = generate_teacher_rating_data(500)

    # Save to CSV
    data.to_csv("teacher_ratings.csv", index=False)

    print("Teacher rating dataset generated successfully!")
    print(f"Dataset shape: {data.shape}")
    print(f"\nDataset Type: CROSS-SECTIONAL")
    print("(Single snapshot of teacher ratings at one point in time)")

    print("\n" + "=" * 60)
    print("First 10 rows:")
    print(data.head(10))

    print("\n" + "=" * 60)
    print("Dataset info:")
    print(data.info())

    print("\n" + "=" * 60)
    print("Basic statistics:")
    print(data.describe())

    print("\n" + "=" * 60)
    print("Missing values:")
    print(data.isnull().sum())

    print("\n" + "=" * 60)
    print("Categorical variable distributions:")
    print("\nGender distribution:")
    print(data["gender"].value_counts())
    print("\nTenure distribution:")
    print(data["tenured"].value_counts())
    print("\nCourse type distribution:")
    print(data["course_type"].value_counts())

    print("\n" + "=" * 60)
    print("Dataset saved to 'teacher_ratings.csv'")
