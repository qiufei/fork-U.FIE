using WooldridgeDatasets, DataFrames, Econometrics

wagepan = DataFrame(wooldridge("wagepan"))

# FE model estimation:
reg = fit(EconometricModel,
    @formula(lwage ~ married + union +
                     d81 + d81 + d82 + d83 + d84 + d85 + d86 + d87 +
                     d81 & educ + d81 & educ + d82 & educ + d83 & educ +
                     d84 & educ + d85 & educ + d86 & educ + d87 & educ +
                     absorb(nr)),
    wagepan)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")