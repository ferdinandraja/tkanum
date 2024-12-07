import numpy as np
import pandas as pd
from numpy.linalg import cond
from scipy.linalg import solve
import matplotlib.pyplot as plt

# Load data from CSV
csv_filename = "xt_yt_data.csv"
df = pd.read_csv(csv_filename)

# Extract time (t), x_t, and y_t values
t_values = df['t'].to_numpy()
x_values = df['xt'].to_numpy()
y_values = df['yt'].to_numpy()

# Basis functions
def compute_basis_matrix(t, basis_type="A"):
    """
    Compute the basis matrix A for the given basis type.
    """
    n = len(t)
    A = np.zeros((n, n))
    
    if basis_type == "A":  # Φi(t) = t^i
        for i in range(n):
            A[:, i] = np.array(t)**i
    elif basis_type == "B":  # Φi(t) = (t - 60)^i
        for i in range(n):
            A[:, i] = (np.array(t) - 60)**i
    elif basis_type == "C":  # Φi(t) = (t - 480)^i
        for i in range(n):
            A[:, i] = (np.array(t) - 480)**i
    elif basis_type == "D":  # Φi(t) = ((t - 480)/30)^i
        for i in range(n):
            A[:, i] = ((np.array(t) - 480) / 30)**i
    return A

# Compute condition numbers for all bases
bases = ["A", "B", "C", "D"]
condition_numbers = {}

for basis in bases:
    A = compute_basis_matrix(t_values, basis_type=basis)
    condition_numbers[basis] = cond(A)

print("Condition Numbers for Different Bases:")
for basis, cond_number in condition_numbers.items():
    print(f"Basis {basis}: {cond_number}")

# Select the basis with the lowest condition number (most stable)
best_basis = min(condition_numbers, key=condition_numbers.get)
print(f"\nBest basis: {best_basis}")

# Solve for coefficients using the best basis
A_best = compute_basis_matrix(t_values, basis_type=best_basis)
coefficients_x = solve(A_best, x_values)
coefficients_y = solve(A_best, y_values)
print("\nInterpolation Coefficients (x):", coefficients_x)
print("Interpolation Coefficients (y):", coefficients_y)

# Horner's method for polynomial evaluation
def horner(coefficients, t):
    result = 0
    for c in reversed(coefficients):
        result = result * t + c
    return result

# Evaluate p9(t) at given t values
t_eval = np.arange(0, 541, 1)  # From 0 to 540 in steps of 1
x_interp = [horner(coefficients_x, t) for t in t_eval]
y_interp = [horner(coefficients_y, t) for t in t_eval]

# Extrapolation to t = 600
t_extrap = 600
x_extrap = horner(coefficients_x, t_extrap)
y_extrap = horner(coefficients_y, t_extrap)
print(f"\nExtrapolated coordinates at t = 600: ({x_extrap}, {y_extrap})")

# Plot results
plt.figure(figsize=(10, 6))
plt.plot(t_eval, x_interp, label="Interpolated x(t)", color="blue")
plt.plot(t_eval, y_interp, label="Interpolated y(t)", color="orange")
plt.scatter(t_values, x_values, color="blue", label="Original x(t) Data", marker='x')
plt.scatter(t_values, y_values, color="orange", label="Original y(t) Data", marker='o')
plt.axvline(t_extrap, color="red", linestyle="--", label="Extrapolated t = 600")
plt.scatter([t_extrap], [x_extrap], color="blue", label=f"Extrapolated x({t_extrap})")
plt.scatter([t_extrap], [y_extrap], color="orange", label=f"Extrapolated y({t_extrap})")
plt.title("Polynomial Interpolation and Extrapolation")
plt.xlabel("Time (t)")
plt.ylabel("Coordinates")
plt.legend()
plt.grid()
plt.show()
