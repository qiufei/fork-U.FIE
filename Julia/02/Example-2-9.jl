using WooldridgeDatasets, DataFrames, GLM

vote1 = DataFrame(wooldridge("vote1"))

# OLS regression:
reg = lm(@formula(voteA ~ shareA), vote1)

# print results using coeftable:
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# accessing R^2:
r2_automatic = r2(reg)
println("r2_automatic = $r2_automatic")