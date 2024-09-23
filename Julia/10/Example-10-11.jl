using WooldridgeDatasets, GLM, DataFrames

barium = DataFrame(wooldridge("barium"))

# linear regression with seasonal effects:
reg = lm(@formula(log(chnimp) ~ log(chempi) + log(gas) +
                                log(rtwex) + befile6 + affile6 + afdec6 +
                                feb + mar + apr + may + jun + jul +
                                aug + sep + oct + nov + dec), barium)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")