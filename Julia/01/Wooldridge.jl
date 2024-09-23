using WooldridgeDatasets, DataFrames

# load data:
wage1 = DataFrame(wooldridge("wage1"))

# get type:
type_wage1 = typeof(wage1)
println("type_wage1: $type_wage1\n")

# get first four observations and first eight variables:
preview_wage1 = wage1[1:4, 1:8]
println("preview_wage1: \n$preview_wage1")