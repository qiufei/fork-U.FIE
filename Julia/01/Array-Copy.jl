# define arrays:
testarray = [1, 5, 41.3, 2.0]

# be careful with changes on variables pointing on testarray:
duplicate_array = testarray
duplicate_array[3] = 10000
println("duplicate_array: $duplicate_array\n")
println("testarray: $testarray\n")

# work on a copy of example_list:
testarray = [1, 5, 41.3, 2.0]
duplicate_array = deepcopy(testarray)
duplicate_array[3] = 10000
println("duplicate_array: $duplicate_array\n")
println("testarray: $testarray")