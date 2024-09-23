using WooldridgeDatasets, DataFrames, GLM, QuantileRegressions

rdchem = DataFrame(wooldridge("rdchem"))

# OLS regression:
reg_ols = lm(@formula(rdintens ~ sales / 1000 + profmarg), rdchem)
table_reg_ols = coeftable(reg_ols)
println("table_reg_ols: \n$table_reg_ols\n")

# LAD regression:
reg_lad = qreg(@formula(rdintens ~ sales / 1000 + profmarg), rdchem, 0.5)
table_reg_lad = coeftable(reg_lad)
println("table_reg_lad: \n$table_reg_lad")