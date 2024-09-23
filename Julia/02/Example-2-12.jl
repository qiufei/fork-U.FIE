using WooldridgeDatasets, DataFrames, GLM, Statistics

meap93 = DataFrame(wooldridge("meap93"))

# estimate the model and save the results as reg:
reg = lm(@formula(math10 ~ lnchprg), meap93)

# number of obs.:
n = nobs(reg)

# SER:
u_hat_var = var(residuals(reg))
SER = sqrt(u_hat_var) * sqrt((n - 1) / (n - 2))
println("SER = $SER\n")

# SE of b0 and b1, respectively:
lnchprg_sq_mean = mean(meap93.lnchprg .^ 2)
lnchprg_var = var(meap93.lnchprg)
b0_se = SER / (sqrt(lnchprg_var) * sqrt(n - 1)) * sqrt(lnchprg_sq_mean)
b1_se = SER / (sqrt(lnchprg_var) * sqrt(n - 1))
println("b0_se = $b0_se\n")
println("b1_se = $b1_se\n")

# automatic calculations:
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")