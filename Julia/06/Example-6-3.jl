using WooldridgeDatasets, GLM, DataFrames

attend = DataFrame(wooldridge("attend"))

reg_ur = lm(@formula(stndfnl ~ atndrte * priGPA + ACT +
                               (priGPA^2) + (ACT^2)), attend)
table_reg_ur = coeftable(reg_ur)
println("table_reg_ur: \n$table_reg_ur\n")

# estimate for partial effect at priGPA=2.59:
b = coef(reg_ur)
partial_effect = b[2] + 2.59 * b[7]
println("partial_effect = $partial_effect\n")

# F test for partial effect at priGPA=2.59:
attend.pe = -2.59 .* attend.atndrte .+ attend.atndrte .* attend.priGPA
reg_r = lm(@formula(stndfnl ~ pe + priGPA + ACT +
                              (priGPA^2) + (ACT^2)), attend)
ftest_res = ftest(reg_r.model, reg_ur.model)
fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")