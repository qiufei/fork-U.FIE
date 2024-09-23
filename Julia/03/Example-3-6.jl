using WooldridgeDatasets, DataFrames, GLM

wage1 = DataFrame(wooldridge("wage1"))

reg = lm(@formula(log(wage) ~ educ), wage1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")