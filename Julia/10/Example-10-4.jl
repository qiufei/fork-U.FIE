using WooldridgeDatasets, GLM, DataFrames

fertil3 = DataFrame(wooldridge("fertil3"))

# add all lags of pe up to order 2:
fertil3.pe_lag1 = lag(fertil3.pe, 1)
fertil3.pe_lag2 = lag(fertil3.pe, 2)

# linear regression of model with lags:
reg = lm(@formula(gfr ~ pe + pe_lag1 + pe_lag2 + ww2 + pill), fertil3)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")