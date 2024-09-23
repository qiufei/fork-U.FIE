using WooldridgeDatasets, GLM, DataFrames

cps78_85 = DataFrame(wooldridge("cps78_85"))

# OLS results including interaction terms:
reg = lm(@formula(lwage ~ y85 * (educ + female) + exper +
                          ((exper^2) / 100) + union), cps78_85)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")