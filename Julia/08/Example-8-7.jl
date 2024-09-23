using WooldridgeDatasets, GLM, DataFrames, HypothesisTests

smoke = DataFrame(wooldridge("smoke"))

# OLS:
reg_ols = lm(@formula(cigs ~ log(income) + log(cigpric) +
                             educ + age + age^2 + restaurn), smoke)
table_ols = DataFrame(coefficients=coeftable(reg_ols).rownms,
        b=round.(coef(reg_ols), digits=5),
        se=round.(stderror(reg_ols), digits=5))
println("table_ols: \n$table_ols\n")

# BP test:
X = modelmatrix(reg_ols)
result_bp = WhiteTest(X, residuals(reg_ols), type=:linear)
bp_statistic = result_bp.lm
bp_pval = pvalue(result_bp)
println("bp_statistic = $bp_statistic\n")
println("bp_pval = $bp_pval\n")

# FGLS (estimation of the variance function):
smoke.logu2 = log.(residuals(reg_ols) .^ 2)
reg_fgls = lm(@formula(logu2 ~ log(income) + log(cigpric) +
                               educ + age + age^2 + restaurn), smoke)

table_fgls = DataFrame(coefficients=coeftable(reg_fgls).rownms,
        b=round.(coef(reg_fgls), digits=5),
        se=round.(stderror(reg_fgls), digits=5))
println("table_fgls: \n$table_fgls\n")

# FGLS (WLS):
smoke.w = (1 ./ sqrt.(exp.(predict(reg_fgls))))

reg_wls = lm(@formula(identity(cigs * w) ~ 0 + w + identity(log(income) * w) +
                                           identity(log(cigpric) * w) +
                                           identity(educ * w) +
                                           identity(age * w) +
                                           identity(age^2 * w) +
                                           identity(restaurn * w)), smoke)

table_wls = DataFrame(coefficients=coeftable(reg_wls).rownms,
        b=round.(coef(reg_wls), digits=5),
        se=round.(stderror(reg_wls), digits=5))
println("table_wls: \n$table_wls")