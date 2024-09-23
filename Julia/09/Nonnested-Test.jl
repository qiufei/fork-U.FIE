using WooldridgeDatasets, GLM, DataFrames

hprice1 = DataFrame(wooldridge("hprice1"))

# two alternative models:
reg1 = lm(@formula(price ~ lotsize + sqrft + bdrms), hprice1)
reg2 = lm(@formula(price ~ log(lotsize) + log(sqrft) + bdrms), hprice1)

# encompassing test of Davidson & MacKinnon:
# comprehensive model:
reg3 = lm(@formula(price ~ lotsize + sqrft + bdrms +
                           log(lotsize) + log(sqrft)), hprice1)

# test model 1:
ftest_res1 = ftest(reg1.model, reg3.model)

fstat1 = ftest_res1.fstat[2]
fpval1 = ftest_res1.pval[2]
println("fstat1 = $fstat1\n")
println("fpval1 = $fpval1\n")

# test model 2:
ftest_res2 = ftest(reg2.model, reg3.model)

fstat2 = ftest_res2.fstat[2]
fpval2 = ftest_res2.pval[2]
println("fstat2 = $fstat2\n")
println("fpval2 = $fpval2")