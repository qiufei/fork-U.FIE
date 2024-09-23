using WooldridgeDatasets, GLM, DataFrames, Distributions

rdchem = DataFrame(wooldridge("rdchem"))

# OLS regression:
reg = lm(@formula(log(rd) ~ log(sales) + profmarg), rdchem)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# replicating 95% CI:
alpha = 0.05
CI95_upper = coef(reg) .+ stderror(reg) .* quantile(TDist(32 - 3), alpha / 2)
CI95_lower = coef(reg) .- stderror(reg) .* quantile(TDist(32 - 3), alpha / 2)
println("CI95_upper = $CI95_upper\n")
println("CI95_lower = $CI95_lower\n")

# calculating 99% CI:
alpha = 0.01
CI99_upper = coef(reg) .+ stderror(reg) .* quantile(TDist(32 - 3), alpha / 2)
CI99_lower = coef(reg) .- stderror(reg) .* quantile(TDist(32 - 3), alpha / 2)
println("CI99_upper = $CI99_upper\n")
println("CI99_lower = $CI99_lower")