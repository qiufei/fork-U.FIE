using WooldridgeDatasets, GLM, DataFrames

wage1 = DataFrame(wooldridge("wage1"))

reg = lm(@formula(wage ~ female + educ + exper + tenure), wage1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")