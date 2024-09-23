using WooldridgeDatasets, GLM, DataFrames, Econometrics, Statistics

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# 2SLS regressions:
reg_iv1 = fit(EconometricModel,
    @formula(hours ~ educ + age + kidslt6 + nwifeinc +
                     (log(wage) ~ exper + (exper^2))), mroz)
table_iv1 = coeftable(reg_iv1)
println("table_iv1: \n$table_iv1\n")

reg_iv2 = fit(EconometricModel,
    @formula(log(wage) ~ educ + exper + (exper^2) +
                         (hours ~ age + kidslt6 + nwifeinc)), mroz)
table_iv2 = coeftable(reg_iv2)
println("table_iv2: \n$table_iv2\n")

cor_u1u2 = cor(residuals(reg_iv1), residuals(reg_iv2))
println("cor_u1u2 =$cor_u1u2")