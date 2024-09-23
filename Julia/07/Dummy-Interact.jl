using WooldridgeDatasets, GLM, DataFrames

gpa3 = DataFrame(wooldridge("gpa3"))

# model with full interactions with female dummy (only for spring data):
reg_ur = lm(@formula(cumgpa ~ female * (sat + hsperc + tothrs)),
    subset(gpa3, :spring => ByRow(==(1))))
table_reg_ur = coeftable(reg_ur)
println("table_reg_ur: \n$table_reg_ur\n")

# F test for H0 (the interaction coefficients of "female" are zero):
reg_r = lm(@formula(cumgpa ~ sat + hsperc + tothrs),
    subset(gpa3, :spring => ByRow(==(1))))

ftest_res = ftest(reg_r.model, reg_ur.model)
fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")