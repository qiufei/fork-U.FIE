using WooldridgeDatasets, GLM, DataFrames, HypothesisTests

hprice1 = DataFrame(wooldridge("hprice1"))

# estimate model:
f = @formula(price ~ 1 + lotsize + sqrft + bdrms)
reg = lm(f, hprice1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# automatic BP test (LM version),
# type = :linear specifies Breusch-Pagan test:
X = getMats(f, hprice1)[2]
result_bp_lm = WhiteTest(X, residuals(reg), type=:linear)
bp_lm_statistic = result_bp_lm.lm
bp_lm_pval = pvalue(result_bp_lm)
println("bp_lm_statistic = $bp_lm_statistic\n")
println("bp_lm_pval = $bp_lm_pval\n")

# manual BP test (F version):
hprice1.resid_sq = residuals(reg) .^ 2
reg_resid = lm(@formula(resid_sq ~ lotsize + sqrft + bdrms), hprice1)
bp_F = ftest(reg_resid.model)
bp_F_statistic = bp_F.fstat
bp_F_pval = bp_F.pval
println("bp_F_statistic = $bp_F_statistic\n")
println("bp_F_pval = $bp_F_pval")