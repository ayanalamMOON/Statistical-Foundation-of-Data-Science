# Linear Algebra for Statistics - Study Notes

**Author:** Md Ayan Alam
**Roll Number:** GF202342645
**Course:** Statistical Foundation of Data Science

---

## Overview

Linear algebra provides the mathematical foundation for many statistical methods. Understanding matrices, vectors, and their operations is essential for modern data science and statistical computing.

## 1. Vectors and Vector Operations

### Vector Basics
**Definition**: An ordered collection of numbers (scalars)
**Notation**: Bold lowercase letters (e.g., **v**, **x**)
**Types**:
- **Column vector**: n×1 matrix
- **Row vector**: 1×n matrix

**Example**:
```
v = [3, -2, 5]'  (column vector)
w = [1, 4, -1]   (row vector)
```

### Vector Operations
**Addition**: Element-wise operation
- **v** + **w** = [v₁+w₁, v₂+w₂, ..., vₙ+wₙ]'

**Scalar Multiplication**: Multiply each element
- c**v** = [cv₁, cv₂, ..., cvₙ]'

**Dot Product (Inner Product)**:
- **v** · **w** = v₁w₁ + v₂w₂ + ... + vₙwₙ
- Result is a scalar
- Measures "similarity" between vectors

**Vector Length (Norm)**:
- ||**v**|| = √(v₁² + v₂² + ... + vₙ²)
- Euclidean distance from origin

### Geometric Interpretation
**Angle Between Vectors**:
- cos(θ) = (**v** · **w**) / (||**v**|| ||**w**||)
- θ = 90° when vectors are orthogonal (dot product = 0)

**Unit Vectors**: Vectors with length 1
- **û** = **v** / ||**v**||

## 2. Matrices and Matrix Operations

### Matrix Basics
**Definition**: Rectangular array of numbers
**Notation**: Bold uppercase letters (e.g., **A**, **X**)
**Dimensions**: m×n (m rows, n columns)

**Types**:
- **Square matrix**: m = n
- **Identity matrix**: I (1s on diagonal, 0s elsewhere)
- **Zero matrix**: All elements are 0
- **Diagonal matrix**: Non-zero elements only on diagonal

### Matrix Operations

#### Addition and Subtraction
**Requirement**: Same dimensions
**Operation**: Element-wise
- (**A** + **B**)ᵢⱼ = aᵢⱼ + bᵢⱼ

#### Scalar Multiplication
- (c**A**)ᵢⱼ = c·aᵢⱼ

#### Matrix Multiplication
**Requirement**: Columns of first = rows of second
**Dimension**: (m×k) × (k×n) = (m×n)
**Element**: (**AB**)ᵢⱼ = Σ aᵢₖbₖⱼ

**Properties**:
- Not commutative: **AB** ≠ **BA** (generally)
- Associative: (**AB**)**C** = **A**(**BC**)
- Distributive: **A**(**B** + **C**) = **AB** + **AC**

#### Matrix Transpose
**Definition**: Flip rows and columns
**Notation**: **A**' or **A**ᵀ
**Property**: (**A**')ᵢⱼ = aⱼᵢ

**Properties**:
- (**A**')' = **A**
- (**A** + **B**)' = **A**' + **B**'
- (**AB**)' = **B**'**A**'

## 3. Special Matrices in Statistics

### Symmetric Matrices
**Definition**: **A** = **A**' (aᵢⱼ = aⱼᵢ)
**Examples**: Correlation matrices, covariance matrices
**Properties**: All eigenvalues are real

### Positive Definite Matrices
**Definition**: **x**'**A****x** > 0 for all non-zero **x**
**Properties**:
- All eigenvalues positive
- Determinant positive
- Covariance matrices are positive semi-definite

### Orthogonal Matrices
**Definition**: **Q**'**Q** = **I**
**Properties**:
- **Q**⁻¹ = **Q**'
- Preserves lengths and angles
- Determinant = ±1

## 4. Matrix Inversion

### Definition and Properties
**Inverse**: **A**⁻¹ such that **A****A**⁻¹ = **A**⁻¹**A** = **I**
**Existence**: Only for square, non-singular matrices

**Properties**:
- (**A**⁻¹)⁻¹ = **A**
- (**AB**)⁻¹ = **B**⁻¹**A**⁻¹
- (**A**')⁻¹ = (**A**⁻¹)'

### 2×2 Matrix Inverse
For **A** = [a b; c d]:
**A**⁻¹ = (1/det(**A**)) × [d -b; -c a]
where det(**A**) = ad - bc

### Computational Methods
1. **Gaussian elimination**: Row operations
2. **LU decomposition**: Factor into lower × upper
3. **Cholesky decomposition**: For symmetric positive definite
4. **QR decomposition**: Orthogonal × upper triangular

### Numerical Considerations
- **Condition number**: Measures sensitivity to errors
- **Ill-conditioned matrices**: Small changes cause large effects
- **Regularization**: Add small values to diagonal

## 5. Determinants

### Definition and Calculation
**2×2 Matrix**: det(**A**) = ad - bc
**3×3 Matrix**: Expansion by minors
**General**: det(**A**) = Σ aᵢⱼCᵢⱼ (cofactor expansion)

### Properties
- det(**AB**) = det(**A**) × det(**B**)
- det(**A**') = det(**A**)
- det(c**A**) = cⁿdet(**A**) for n×n matrix

### Interpretation
**Geometric**: Volume of parallelepiped formed by column vectors
**Zero determinant**: Matrix is singular (not invertible)
**Statistical**: Related to generalized variance

## 6. Eigenvalues and Eigenvectors

### Definitions
**Eigenvalue equation**: **A****v** = λ**v**
- **v**: Eigenvector (non-zero)
- λ: Eigenvalue

**Characteristic equation**: det(**A** - λ**I**) = 0

### Properties
**For n×n matrix**:
- n eigenvalues (counting multiplicity)
- Eigenvectors corresponding to different eigenvalues are orthogonal
- Sum of eigenvalues = trace(**A**)
- Product of eigenvalues = det(**A**)

### Eigendecomposition
**For symmetric matrices**: **A** = **Q**Λ**Q**'
- **Q**: Matrix of eigenvectors (orthogonal)
- Λ: Diagonal matrix of eigenvalues

### Applications in Statistics
1. **Principal Component Analysis**: Eigenvectors of covariance matrix
2. **Factor Analysis**: Eigenvalues determine number of factors
3. **Stability Analysis**: Eigenvalues indicate system stability
4. **Optimization**: Second derivatives (Hessian matrix)

## 7. Matrix Decompositions

### Singular Value Decomposition (SVD)
**Any matrix**: **A** = **U**Σ**V**'
- **U**: Left singular vectors (orthogonal)
- Σ: Diagonal matrix of singular values
- **V**: Right singular vectors (orthogonal)

**Applications**:
- Dimensionality reduction
- Least squares solutions
- Matrix approximation
- Data compression

### QR Decomposition
**Any matrix**: **A** = **Q****R**
- **Q**: Orthogonal matrix
- **R**: Upper triangular matrix

**Applications**:
- Least squares regression
- Solving linear systems
- Gram-Schmidt orthogonalization

### Cholesky Decomposition
**Symmetric positive definite**: **A** = **L****L**'
- **L**: Lower triangular matrix

**Applications**:
- Efficient matrix inversion
- Generating correlated random numbers
- Numerical stability

## 8. Linear Systems and Least Squares

### Linear System: **A****x** = **b**
**Unique solution**: When **A** is square and invertible
**Solution**: **x** = **A**⁻¹**b**

**Overdetermined system** (m > n):
- More equations than unknowns
- Generally no exact solution
- Use least squares: minimize ||**A****x** - **b**||²

### Normal Equations
**Least squares solution**: **x** = (**A**'**A**)⁻¹**A**'**b**
**Conditions**:
- **A**'**A** must be invertible
- Requires full column rank

### Geometric Interpretation
**Projection**: **A****x** is projection of **b** onto column space of **A**
**Residual**: **r** = **b** - **A****x** (orthogonal to column space)

## 9. Statistical Applications

### Covariance Matrix
**Definition**: **S** = (1/(n-1))(**X** - **μ**1')(**X** - **μ**1')'
**Properties**:
- Symmetric
- Positive semi-definite
- Diagonal elements are variances
- Off-diagonal elements are covariances

### Correlation Matrix
**Definition**: **R**ᵢⱼ = Sᵢⱼ / √(SᵢᵢSⱼⱼ)
**Properties**:
- Symmetric
- Diagonal elements = 1
- |rᵢⱼ| ≤ 1

### Linear Regression in Matrix Form
**Model**: **y** = **X**β + ε
**OLS estimate**: β̂ = (**X**'**X**)⁻¹**X**'**y**
**Fitted values**: ŷ = **X**β̂ = **H****y**
**Hat matrix**: **H** = **X**(**X**'**X**)⁻¹**X**'

### Properties of Hat Matrix
- **H** is idempotent: **H**² = **H**
- **H** is symmetric
- Diagonal elements are leverages
- Sum of diagonal elements = rank(**X**)

## 10. Principal Component Analysis (PCA)

### Mathematical Foundation
**Objective**: Find linear combinations with maximum variance
**First PC**: **z**₁ = **a**₁'**x** where **a**₁ maximizes Var(**z**₁)
**Constraint**: ||**a**₁|| = 1

**Solution**: Eigenvectors of covariance matrix
- PC directions = eigenvectors
- PC variances = eigenvalues

### PCA Algorithm
1. Center the data: **X** - **μ**1'
2. Compute covariance matrix **S**
3. Find eigenvalues and eigenvectors of **S**
4. Order by eigenvalue magnitude
5. Select top k components

### Interpretation
**Proportion of variance explained**:
- λᵢ / Σλⱼ for i-th component
- Cumulative proportion for dimension reduction decisions

**Loading matrix**: Eigenvectors scaled by √eigenvalues
**Score matrix**: Transformed data in PC space

## 11. Practical Considerations

### Numerical Stability
**Condition number**: κ(**A**) = λₘₐₓ/λₘᵢₙ
**Well-conditioned**: κ close to 1
**Ill-conditioned**: κ very large

**Solutions**:
- Use SVD instead of normal equations
- Regularization techniques
- Centering and scaling variables

### Computational Complexity
**Matrix multiplication**: O(n³) for n×n matrices
**Matrix inversion**: O(n³)
**Eigendecomposition**: O(n³)

**Large data considerations**:
- Use iterative methods
- Sparse matrix techniques
- Parallel computing

### Software Implementation
**R**: Built-in matrix operations, eigen(), svd()
**Python**: NumPy, SciPy for linear algebra
**Specialized**: LAPACK, BLAS for high-performance computing

## 12. Advanced Topics

### Generalized Eigenvalue Problem
**Problem**: **A****v** = λ**B****v**
**Applications**: Canonical correlation, discriminant analysis

### Matrix Calculus
**Derivatives with respect to vectors/matrices**
**Applications**: Optimization, maximum likelihood estimation

### Kronecker Products
**Definition**: **A** ⊗ **B** (combines two matrices)
**Applications**: Mixed effects models, time series

### Random Matrices
**Distribution theory for matrices**
**Applications**: Wishart distribution, random matrix theory

---

## Study Tips

1. **Practice with small examples** before tackling large problems
2. **Visualize in 2D/3D** when possible to build geometric intuition
3. **Understand the connections** between linear algebra and statistics
4. **Focus on applications** that motivate the mathematical concepts
5. **Use software** to verify hand calculations
6. **Learn to recognize patterns** in matrix structures
7. **Understand computational trade-offs** between different methods

---

## Key Relationships Summary

### Matrix-Vector Relationships
- **Ax** = linear combination of columns of **A**
- **x'A** = linear combination of rows of **A**
- **x'Ay** = quadratic form

### Statistical Connections
- **Sample mean**: (1/n)**1'x**
- **Sample variance**: **x'x**/n - (1/n)**1'x**
- **Regression coefficients**: (**X'X**)⁻¹**X'y**
- **Principal components**: Eigenvectors of **S**

### Geometric Interpretations
- **Dot product**: Measures similarity/angle
- **Determinant**: Volume/orientation
- **Eigenvalues**: Stretching factors
- **SVD**: Rotation-scaling-rotation decomposition

---

*These notes provide the linear algebra foundation needed to understand advanced statistical methods and their computational implementation.*
