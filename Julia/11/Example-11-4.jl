using WooldridgeDatasets, GLM, DataFrames, RegressionTables

nyse = DataFrame(wooldridge("nyse"))
nyse.ret = nyse.return

# add all lags up to order 3:
nyse.ret_lag1 = lag(nyse.ret, 1)
nyse.ret_lag2 = lag(nyse.ret, 2)
nyse.ret_lag3 = lag(nyse.ret, 3)

# linear regression of model with lags:
reg1 = lm(@formula(ret ~ ret_lag1), nyse)
reg2 = lm(@formula(ret ~ ret_lag1 + ret_lag2), nyse)
reg3 = lm(@formula(ret ~ ret_lag1 + ret_lag2 + ret_lag3), nyse)

# print results with RegressionTables:
regtable(reg1, reg2, reg3)