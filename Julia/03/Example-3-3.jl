using WooldridgeDatasets, DataFrames, GLM

k401k = DataFrame(wooldridge("401k"))

reg = lm(@formula(prate ~ mrate + age), k401k)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")