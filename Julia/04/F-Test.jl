using WooldridgeDatasets, GLM, DataFrames, Distributions

mlb1 = DataFrame(wooldridge("mlb1"))

# unrestricted OLS regression:
reg_ur = lm(@formula(log(salary) ~
        years + gamesyr + bavg + hrunsyr + rbisyr), mlb1)
r2_ur = r2(reg_ur)
println("r2_ur = $r2_ur\n")

# restricted OLS regression:
reg_r = lm(@formula(log(salary) ~ years + gamesyr), mlb1)
r2_r = r2(reg_r)
println("r2_r = $r2_r\n")

# F statistic:
n = nobs(reg_ur)
fstat = (r2_ur - r2_r) / (1 - r2_ur) * (n - 6) / 3
println("fstat = $fstat\n")

# CV for alpha=1% using the F distribution with 3 and 347 d.f.:
cv = quantile(FDist(3, 347), 1 - 0.01)
println("cv = $cv\n")

# p value = 1-cdf of the appropriate F distribution:
fpval = 1 - cdf(FDist(3, 347), fstat)
println("fpval = $fpval")