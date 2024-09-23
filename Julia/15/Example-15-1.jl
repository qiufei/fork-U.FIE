using WooldridgeDatasets, GLM, DataFrames, Econometrics, Statistics

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# OLS slope parameter manually:
cov_yz = cov(mroz.lwage, mroz.fatheduc)
cov_xy = cov(mroz.educ, mroz.lwage)
cov_xz = cov(mroz.educ, mroz.fatheduc)
var_x = var(mroz.educ)
x_bar = mean(mroz.educ)
y_bar = mean(mroz.lwage)
b_ols_man = cov_xy / var_x
println("b_ols_man = $b_ols_man\n")

# IV slope parameter manually:
b_iv_man = cov_yz / cov_xz
println("b_iv_man = $b_iv_man\n")

# OLS automatically:
reg_ols = lm(@formula(lwage ~ educ), mroz)
table_ols = coeftable(reg_ols)
println("table_ols: \n$table_ols\n")

# IV automatically:
reg_iv = fit(EconometricModel,
    @formula(lwage ~ (educ ~ fatheduc)), mroz)
table_iv = coeftable(reg_iv)
println("table_iv: \n$table_iv")