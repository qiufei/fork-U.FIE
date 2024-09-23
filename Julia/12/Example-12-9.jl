using WooldridgeDatasets, GLM, DataFrames

nyse = DataFrame(wooldridge("nyse"))
nyse.ret = nyse.return
nyse.ret_lag1 = lag(nyse.ret, 1)
nyse = nyse[Not(1, 2), :]

# linear regression of model:
reg = lm(@formula(ret ~ ret_lag1), nyse)

# squared residuals:
nyse.resid_sq = residuals(reg) .^ 2
nyse.resid_sq_lag1 = lag(nyse.resid_sq, 1)

# model for squared residuals:
ARCHreg = lm(@formula(resid_sq ~ resid_sq_lag1), nyse)
table_ARCHreg = coeftable(ARCHreg)
println("table_ARCHreg: \n$table_ARCHreg")