using WooldridgeDatasets, GLM, DataFrames, Econometrics, Statistics

wagepan = DataFrame(wooldridge("wagepan"))

# include group specific means:
grouped_means = combine(groupby(wagepan, :nr), [:married, :union] .=> mean)
wagepan = innerjoin(grouped_means, wagepan, on=:nr)

# estimate FE parameters in 3 different ways:
reg_we = fit(EconometricModel,
    @formula(lwage ~ married + union + absorb(nr) +
                     d81 + d81 + d82 + d83 + d84 + d85 + d86 + d87 +
                     d81 & educ + d81 & educ + d82 & educ + d83 & educ +
                     d84 & educ + d85 & educ + d86 & educ + d87 & educ),
    wagepan)

reg_dum = lm(@formula(lwage ~ married + union + year * educ + nr),
    wagepan,
    contrasts=Dict(:year => DummyCoding(), :nr => DummyCoding()))


reg_cre = fit(RandomEffectsEstimator,
    @formula(lwage ~ married + union + year * educ +
                     married_mean + union_mean),
    wagepan,
    panel=:nr,
    time=:year,
    contrasts=Dict(:year => DummyCoding()))

# compare to RE estimates:
reg_re = fit(RandomEffectsEstimator,
    @formula(lwage ~ married + union + year * educ),
    wagepan,
    panel=:nr,
    time=:year,
    contrasts=Dict(:year => DummyCoding()))

# print results for married and union:
table = DataFrame(coef_names=["married", "union"],
    b_we=round.(coef(reg_we)[[2, 3]], digits=5),
    b_dum=round.(coef(reg_dum)[[2, 3]], digits=5),
    b_cre=round.(coef(reg_cre)[[2, 3]], digits=5),
    b_re=round.(coef(reg_re)[[2, 3]], digits=5))
println("table:\n $table")