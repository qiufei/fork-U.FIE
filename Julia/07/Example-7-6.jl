using WooldridgeDatasets, GLM, DataFrames

wage1 = DataFrame(wooldridge("wage1"))

reg = lm(@formula(log(wage) ~
        married * female + educ + exper + (exper^2) +
        tenure + (tenure^2)), wage1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")