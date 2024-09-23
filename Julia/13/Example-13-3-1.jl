using WooldridgeDatasets, GLM, DataFrames, RegressionTables

kielmc = DataFrame(wooldridge("kielmc"))
kielmc.is1981 = kielmc.year .== 1981

# separate regressions for 1978 and 1981:
y78 = subset(kielmc, :year => ByRow(==(1978)))
reg78 = lm(@formula(rprice ~ nearinc), y78)

y81 = subset(kielmc, :year => ByRow(==(1981)))
reg81 = lm(@formula(rprice ~ nearinc), y81)

# joint regression including an interaction term:
reg_joint = lm(@formula(rprice ~ nearinc * is1981), kielmc)

# print results with RegressionTables:
regtable(reg78, reg81, reg_joint)