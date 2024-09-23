using WooldridgeDatasets, GLM, DataFrames

phillips = DataFrame(wooldridge("phillips"))
yt96 = subset(phillips, :year => ByRow(<=(1996)))

# estimation of static Phillips curve:
reg_s = lm(@formula(inf ~ unem), yt96)

# residuals and AR(1) test:
yt96.resid_s = residuals(reg_s)
yt96.resid_s_lag1 = lag(yt96.resid_s, 1)

reg = lm(@formula(resid_s ~ resid_s_lag1), yt96)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")