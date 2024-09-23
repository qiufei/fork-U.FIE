using WooldridgeDatasets, GLM, DataFrames

hprice2 = DataFrame(wooldridge("hprice2"))

reg = lm(@formula(log(price) ~ log(nox) + rooms), hprice2)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")