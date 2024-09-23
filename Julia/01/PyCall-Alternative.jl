using PyCall

# using pyimport to work with modules:
np = pyimport("numpy")

# define matrices in Julia:
mat1 = [4 9 8
        2 6 3]
mat2 = [1 5 2
        6 6 0
        4 8 3]

# ... and pass them to numpys dot function:
matprod = np.dot(mat1, mat2)
println("matprod: $matprod\n")

matprod_type = typeof(matprod)
println("matprod_type: $matprod_type")