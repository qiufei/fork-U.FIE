using WooldridgeDatasets, GLM, DataFrames, Econometrics

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# 1st stage (reduced form):
reg_redf = lm(@formula(educ ~ exper + (exper^2) +
                              motheduc + fatheduc), mroz)
mroz.educ_fitted = predict(reg_redf)
table_redf = coeftable(reg_redf)
println("table_redf: \n$table_redf\n")

# 2nd stage:
reg_secstg = lm(@formula(log(wage) ~ educ_fitted + exper +
                                     (exper^2)), mroz)
table_reg_secstg = coeftable(reg_secstg)
println("table_reg_secstg: \n$table_reg_secstg\n")

# IV automatically:
reg_iv = fit(EconometricModel,
    @formula(log(wage) ~ exper + (exper^2) +
                         (educ ~ motheduc + fatheduc)), mroz)
table_iv = coeftable(reg_iv)
println("table_iv: \n$table_iv")