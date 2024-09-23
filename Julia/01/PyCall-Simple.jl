using PyCall

# define a block of Python Code:
py"""
import numpy as np

# define arrays in numpy:
mat1 = np.array([[4, 9, 8],
                 [2, 6, 3]])
mat2 = np.array([[1, 5, 2],
                 [6, 6, 0],
                 [4, 8, 3]])
# matrix algebra:
matprod_py = mat1 @ mat2
"""

# automatic type conversion from Python to Julia:
matprod = py"matprod_py"
matprod_type = typeof(matprod)
println("matprod_type: $matprod_type\n")
println("matprod: $matprod")