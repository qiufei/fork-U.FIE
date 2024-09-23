using WooldridgeDatasets, GLM, DataFrames, Econometrics

jtrain = DataFrame(wooldridge("jtrain"))

# define panel data (for 1987 and 1988 only) and sort:
jtrain_8788 = subset(jtrain, :year => ByRow(<=(1988)))
sort!(jtrain_8788, [:fcode, :year])

# manual computation of deviations of entity means:
grouped_df = groupby(jtrain_8788, :fcode)
diff_df = DataFrame(fcode=unique(jtrain_8788.fcode))
diff_df.lscrap_diff1 = combine(grouped_df, :lscrap => diff).lscrap_diff
diff_df.hrsemp_diff1 = combine(grouped_df, :hrsemp => diff).hrsemp_diff
diff_df.grant_diff1 = combine(grouped_df, :grant => diff).grant_diff

# IV regression:
reg_iv = fit(EconometricModel,
    @formula(lscrap_diff1 ~ (hrsemp_diff1 ~ grant_diff1)), diff_df)
table_iv = coeftable(reg_iv)
println("table_iv: \n$table_iv")