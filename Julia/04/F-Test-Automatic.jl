using WooldridgeDatasets, GLM, DataFrames

mlb1 = DataFrame(wooldridge("mlb1"))

# OLS regression:
reg_ur = lm(@formula(log(salary) ~
                years + gamesyr + bavg + hrunsyr + rbisyr), mlb1)
reg_r = lm(@formula(log(salary) ~
                years + gamesyr), mlb1)

# automated F test:
ftest_res = ftest(reg_r.model, reg_ur.model)

fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")