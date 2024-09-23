using WooldridgeDatasets, GLM, DataFrames, Econometrics, Statistics

wagepan = DataFrame(wooldridge("wagepan"))

# include group specific means:
grouped_means = combine(groupby(wagepan, :nr), [:married, :union] .=> mean)
wagepan = innerjoin(grouped_means, wagepan, on=:nr)

# estimate CRE:
reg_CRE = fit(RandomEffectsEstimator,
    @formula(lwage ~ married + union + educ + black +
                     hisp + married_mean + union_mean),
    wagepan,
    panel=:nr,
    time=:year)
table_reg = coeftable(reg_CRE)
println("table_reg: \n$table_reg")