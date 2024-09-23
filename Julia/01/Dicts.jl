# define and print a dict:
var1 = ["Florian", "Daniel"]
var2 = [96, 49]
example_dict = Dict("name" => var1, "points" => var2)
println("example_dict: \n$example_dict\n")

# get data type:
type_example_dict = typeof(example_dict)
println("type_example_dict: $type_example_dict\n")

# access "points":
points_all = example_dict["points"]
println("points_all: $points_all\n")

# access "points" of Daniel:
points_daniel = example_dict["points"][2]
println("points_daniel: $points_daniel\n")

# add 4 to "points" of Daniel:
example_dict["points"][2] = example_dict["points"][2] + 4
println("example_dict: \n$example_dict\n")

# add a new component "grade":
example_dict["grade"] = [1.3, 4.0]

# delete component "points":
delete!(example_dict, "points")
print("example_dict: \n$example_dict\n")