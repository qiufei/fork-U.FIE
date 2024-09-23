using WooldridgeDatasets, GLM, DataFrames, HypothesisTests
include("../03/getMats.jl")

hprice1 = DataFrame(wooldridge("hprice1"))

# estimate model:
f = @formula(log(price) ~ 1 + log(lotsize) + log(sqrft) + bdrms)
reg = lm(f, hprice1)

# BP test:
X = getMats(f, hprice1)[2]
result_bp = WhiteTest(X, residuals(reg), type=:linear)
bp_statistic = result_bp.lm
bp_pval = pvalue(result_bp)
println("bp_statistic = $bp_statistic\n")
println("bp_pval = $bp_pval\n")

# White test:
X_wh = hcat(ones(size(X)[1]),
    predict(reg),
    predict(reg) .^ 2)
result_white = WhiteTest(X_wh, residuals(reg), type=:linear)
white_statistic = result_white.lm
white_pval = pvalue(result_white)
println("white_statistic = $white_statistic\n")
println("white_pval = $white_pval")