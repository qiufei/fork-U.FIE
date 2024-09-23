using WooldridgeDatasets, GLM, DataFrames

hprice2 = DataFrame(wooldridge("hprice2"))

reg_ur = lm(@formula(log(price) ~
                log(nox) + log(dist) + rooms + (rooms^2) + stratio), hprice2)

# testing hypotheses rooms = 0 and rooms^2 = 0:
reg_r = lm(@formula(log(price) ~
                log(nox) + log(dist) + stratio), hprice2)

ftest_res = ftest(reg_r.model, reg_ur.model)
fstat = ftest_res.fstat[2]
fpval = ftest_res.pval[2]
println("fstat = $fstat\n")
println("fpval = $fpval")