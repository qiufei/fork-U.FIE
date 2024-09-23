using WooldridgeDatasets, GLM, DataFrames

phillips = DataFrame(wooldridge("phillips"))
yt96 = subset(phillips, :year => ByRow(<=(1996)))

# estimation of expectations-augmented Phillips curve:
yt96.inf_diff1 = vcat(missing, diff(yt96.inf))
yt96 = yt96[Not(1), :]
reg_ea = lm(@formula(inf_diff1 ~ unem), yt96)

yt96.resid_ea = residuals(reg_ea)
yt96.resid_ea_lag1 = lag(yt96.resid_ea, 1)

reg = lm(@formula(resid_ea ~ resid_ea_lag1), yt96)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")