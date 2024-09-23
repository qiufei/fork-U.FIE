using WooldridgeDatasets, GLM, DataFrames

intdef = DataFrame(wooldridge("intdef"))

# linear regression of static model:
reg = lm(@formula(i3 ~ inf + def), intdef)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")