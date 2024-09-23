using WooldridgeDatasets, GLM, DataFrames

wage1 = DataFrame(wooldridge("wage1"))

# regression with boolean variable:
wage1.isfemale = Bool.(wage1.female)
reg = lm(@formula(wage ~ isfemale + educ + exper + tenure), wage1,
    contrasts=Dict(:isfemale => DummyCoding()))

table_reg = coeftable(reg)
println("table_reg: \n$table_reg")