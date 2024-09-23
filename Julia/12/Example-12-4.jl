using WooldridgeDatasets, GLM, DataFrames

barium = DataFrame(wooldridge("barium"))

reg = lm(@formula(log(chnimp) ~ log(chempi) + log(gas) + log(rtwex) +
                                befile6 + affile6 + afdec6), barium)

# testing resid_lag1 = 0, resid_lag2 = 0 and resid_lag3 = 0:
barium.resid = residuals(reg)
barium.resid_lag1 = lag(barium.resid, 1)
barium.resid_lag2 = lag(barium.resid, 2)
barium.resid_lag3 = lag(barium.resid, 3)
barium = barium[Not(1:3), :]

reg_manual_ur = lm(@formula(resid ~ resid_lag1 + resid_lag2 + resid_lag3 +
                                    log(chempi) + log(gas) + log(rtwex) +
                                    befile6 + affile6 + afdec6), barium)
reg_manual_r = lm(@formula(resid ~ log(chempi) + log(gas) + log(rtwex) +
                                   befile6 + affile6 + afdec6), barium)
ftest_manual_res = ftest(reg_manual_r.model, reg_manual_ur.model)

fstat_manual = ftest_manual_res.fstat[2]
fpval_manual = ftest_manual_res.pval[2]
println("fstat_manual = $fstat_manual\n")
println("fpval_manual = $fpval_manual")