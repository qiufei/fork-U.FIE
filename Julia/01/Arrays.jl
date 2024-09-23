# define arrays:
testarray1D = [1, 5, 41.3, 2.0]
println("type(testarray1D): $(typeof(testarray1D))\n")

testarray2D = [4 9 8 3
    2 6 3 2
    1 1 7 4]

# same as:
#testarray2D = [4 9 8 3; 2 6 3 2; 1 1 7 4]
#testarray2D = [[4 9 8 3]
#   [ 2 6 3 2]
#   [ 1 1 7 4]]
#testarray2D = [[4, 2, 1] [9, 6, 1] [8, 3, 7] [3, 2, 4]]

# get dimensions of testarray2D:
dim = size(testarray2D)
println("dim: $dim\n")

# access elements by indices:
third_elem = testarray1D[3]
println("third_elem = $third_elem\n")

second_third_elem = testarray2D[2, 3] # element in 2nd row and 3rd column
println("second_third_elem = $second_third_elem\n")

second_to_third_col = testarray2D[:, 2:3] # each row in the 2nd and 3rd column
println("second_to_third_col = $second_to_third_col\n")

last_col = testarray2D[:, end] # each row in the last column
println("last_col = $last_col\n")

# access elements by array:
first_third_elem = testarray1D[[1, 3]]
println("first_third_elem: $first_third_elem\n")

# same with Boolean array:
first_third_elem2 = testarray1D[[true, false, true, false]]
println("first_third_elem2 = $first_third_elem2\n")

k = [[true false false false]
    [false false true false]
    [true false true false]]
elem_by_index = testarray2D[k] # 1st elem in 1st row, 1st elem in 3rd row...
print("elem_by_index: $elem_by_index")