using WooldridgeDatasets, GLM, DataFrames

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# 1st stage (reduced form):
reg_redf = lm(@formula(educ ~ exper + (exper^2) +
                              motheduc + fatheduc), mroz)
mroz.resid = residuals(reg_redf)

# 2nd stage:
reg_secstg = lm(@formula(log(wage) ~ resid + educ +
                                     exper + (exper^2)), mroz)
table_reg_secstg = coeftable(reg_secstg)
println("table_reg_secstg: \n$table_reg_secstg")