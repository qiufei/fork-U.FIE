using WooldridgeDatasets, GLM, DataFrames, Econometrics, Distributions

mroz_wm = DataFrame(wooldridge("mroz"))

# restrict to non-missing wage observations:
mroz = mroz_wm[.!ismissing.(mroz_wm.wage), :]

# IV regression:
reg_iv = fit(EconometricModel,
    @formula(log(wage) ~ exper + (exper^2) +
                         (educ ~ motheduc + fatheduc)), mroz)
table_iv = coeftable(reg_iv)
println("table_iv: \n$table_iv\n")

# auxiliary regression:
mroz.resid_iv = residuals(reg_iv)
reg_aux = lm(@formula(resid_iv ~ exper + (exper^2) +
                                 motheduc + fatheduc), mroz)

# calculations for test:
R2 = r2(reg_aux)
n = nobs(reg_aux)
teststat = n * R2
pval = 1 - cdf(Chisq(1), teststat)

println("R2 = $R2\n")
println("n = $n\n")
println("teststat = $teststat\n")
println("pval = $pval")