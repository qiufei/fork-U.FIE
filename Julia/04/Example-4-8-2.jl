using WooldridgeDatasets, GLM, DataFrames

rdchem = DataFrame(wooldridge("rdchem"))

# OLS regression:
reg_ur = lm(@formula(log(rd) ~ log(sales) + profmarg), rdchem)
reg_r = lm(@formula(log(rd) ~ 1), rdchem)

# automated F test:
ftest_res = ftest(reg_r.model, reg_ur.model)

fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")