# define matrices:
mat1 = [4 9 8
        2 6 3]
mat2 = [1 5 2
        6 6 0
        4 8 3]

# use exp() and apply it to each element:
result1 = exp.(mat1)
result1_rounded = round.(result1, digits=4)
println("result1_rounded: \n$result1_rounded\n")

result2 = mat1 .+ mat2[1:2, :]
println("result2: $result2\n")

# use another function:
mat1_tr = transpose(mat1) #or simply: mat1'
println("mat1_tr: $mat1_tr\n")

# matrix algebra:
matprod = mat1 * mat2
println("matprod: $matprod")