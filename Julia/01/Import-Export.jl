using DataFrames, CSV

# import a .CSV file with CSV.read:
df1 = CSV.read("data/sales.csv", DataFrame, delim=",",
    header=["year", "product1", "product2", "product3"])
println("df1: \n$df1\n")

# import a .txt file with CSV.read:
df2 = CSV.read("data/sales.txt", DataFrame, delim=" ")
println("df2: \n$df2\n")

# add a row to df1:
push!(df1, [2014, 10, 8, 2])
println("df1: \n$df1")

# export with CSV.write:
CSV.write("data/sales2.csv", df1)