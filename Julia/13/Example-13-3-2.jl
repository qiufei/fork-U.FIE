using WooldridgeDatasets, GLM, DataFrames

kielmc = DataFrame(wooldridge("kielmc"))
kielmc.is1981 = kielmc.year .== 1981

# difference in difference (DiD):
reg_did = lm(@formula(log(rprice) ~ nearinc * is1981), kielmc)
table_did = coeftable(reg_did)
println("table_did: \n$table_did\n")

# DiD with control variables:
reg_didC = lm(@formula(log(rprice) ~ nearinc * is1981 + age + (age^2) +
                                     log(intst) + log(land) + log(area) +
                                     rooms + baths), kielmc)
table_didC = coeftable(reg_didC)
println("table_didC: \n$table_didC")