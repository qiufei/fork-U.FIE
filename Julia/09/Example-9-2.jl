using WooldridgeDatasets, GLM, DataFrames

hprice1 = DataFrame(wooldridge("hprice1"))

# original OLS:
reg = lm(@formula(price ~ lotsize + sqrft + bdrms), hprice1)

# regression for RESET test:
hprice1.fitted_sq = predict(reg) .^ 2 ./ 1000
hprice1.fitted_cub = predict(reg) .^ 3 ./ 1000

reg_reset = lm(@formula(price ~ lotsize + sqrft + bdrms +
                                fitted_sq + fitted_cub), hprice1)
table_reg_reset = coeftable(reg_reset)
println("table_reg_reset: \n$table_reg_reset\n")

# RESET test (H0: all coefficients including "fitted" are zero):
ftest_res = ftest(reg.model, reg_reset.model)
fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")