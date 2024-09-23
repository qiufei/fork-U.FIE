# define arrays:
vec1 = [1, 4, 64, 36]
mat1 = [4 9 8 3
    2 6 3 2
    1 1 7 4]

# apply some functions:
sort!(vec1)
println("vec1: $vec1\n")

vec2 = sqrt.(vec1)
vec3 = vec1 .+ vec2
println("vec3: $vec3\n")

# get dimensions of mat1:
dim_mat1 = size(mat1)
println("dim_mat1: $dim_mat1")