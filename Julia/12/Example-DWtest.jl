using WooldridgeDatasets, GLM, DataFrames, HypothesisTests
include("../03/getMats.jl")

phillips = DataFrame(wooldridge("phillips"))
yt96 = subset(phillips, :year => ByRow(<=(1996)))

# estimation of both Phillips curve models and 
# extraction of regressor matrices and residuals:
reg_s = lm(@formula(inf ~ unem), yt96)
X_s = getMats(formula(reg_s), yt96)[2]
resid_s = residuals(reg_s)

yt96.inf_diff1 = vcat(missing, diff(yt96.inf))
yt96 = yt96[Not(1), :]
reg_ea = lm(@formula(inf_diff1 ~ unem), yt96)
X_ea = getMats(formula(reg_ea), yt96)[2]
resid_ea = residuals(reg_ea)

# DW tests:
DW_s = DurbinWatsonTest(X_s, resid_s)
DW_ea = DurbinWatsonTest(X_ea, resid_ea)
println("DW_s: \n$DW_s\n")
println("DW_ea: \n$DW_ea")