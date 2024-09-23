# define a vector: 
example_list = [1, 5, 41.3, 2.0] # note: integers are casted to floats automatically
type_example_list = typeof(example_list)
println("type(example_list): $type_example_list\n")

# access first entry by index:
first_entry = example_list[1]
println("first_entry: $first_entry\n")

# access second to fourth entry by index:
range2to4 = example_list[2:4]
println("range2to4: $range2to4\n")

# replace third entry by new value:
example_list[3] = 3
println("example_list: $example_list\n")

# apply a function:
function_output = minimum(example_list)
println("function_output: $function_output\n")
# apply another function:
example_list = sort(example_list)
println("example_list: $example_list\n")
# delete third element of sorted list:
deleteat!(example_list, 3)
println("example_list: $example_list\n")