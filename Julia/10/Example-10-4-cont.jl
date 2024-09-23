using WooldridgeDatasets, GLM, DataFrames, Distributions

fertil3 = DataFrame(wooldridge("fertil3"))

# add all lags of pe up to order 2:
fertil3.pe_lag1 = lag(fertil3.pe, 1)
fertil3.pe_lag2 = lag(fertil3.pe, 2)

# handle missings due to lagged data manually (important for ftest):
fertil3 = fertil3[Not([1, 2]), :]

# linear regression of model with lags:
reg_ur = lm(@formula(gfr ~ pe + pe_lag1 + pe_lag2 + ww2 + pill), fertil3)

# F test (H0: all pe coefficients are zero):
reg_r = lm(@formula(gfr ~ ww2 + pill), fertil3)
ftest_res = ftest(reg_r.model, reg_ur.model)
fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval\n")

# calculating the LRP:
b_pe_tot = sum(coef(reg_ur)[[2, 3, 4]])
println("b_pe_tot = $b_pe_tot\n")

# testing LRP=0:
fertil3.ptm1pt = fertil3.pe_lag1 - fertil3.pe
fertil3.ptm2pt = fertil3.pe_lag2 - fertil3.pe
reg_LRP = lm(@formula(gfr ~ pe + ptm1pt + ptm2pt + ww2 + pill), fertil3)
table_res_LRP = coeftable(reg_LRP)
println("table_res_LRP: \n$table_res_LRP")