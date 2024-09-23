using WooldridgeDatasets, GLM, DataFrames, Econometrics

wagepan = DataFrame(wooldridge("wagepan"))

# estimate different models:
reg_ols = lm(@formula(lwage ~ educ + black + hisp + exper + (exper^2) +
                              married + union + year),
    wagepan,
    contrasts=Dict(:year => DummyCoding()))

reg_re = fit(RandomEffectsEstimator,
    @formula(lwage ~ educ + black + hisp + exper + (exper^2) +
                     married + union + year),
    wagepan,
    panel=:nr,
    time=:year,
    contrasts=Dict(:year => DummyCoding()))

reg_fe = fit(EconometricModel,
    @formula(lwage ~ (exper^2) + married + union + year + absorb(nr)),
    wagepan,
    contrasts=Dict(:year => DummyCoding()))

# print results:
table_ols = coeftable(reg_ols)
println("table_ols: \n$table_ols\n")

table_re = coeftable(reg_re)
println("table_re: \n$table_re\n")

table_fe = coeftable(reg_fe)
println("table_fe: \n$table_fe")