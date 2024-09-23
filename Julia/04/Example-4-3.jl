using WooldridgeDatasets, GLM, DataFrames, Distributions

gpa1 = DataFrame(wooldridge("gpa1"))

# store and display results:
reg = lm(@formula(colGPA ~ hsGPA + ACT + skipped), gpa1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# manually confirm the formulas, i.e. extract coefficients and SE:
b = coef(reg)
se = stderror(reg)

# reproduce t statistic:
tstat = round.(b ./ se, digits=5)
println("tstat = $tstat\n")

# reproduce p value:
pval = round.(2 * cdf.(TDist(137), -abs.(tstat)), digits=5)
println("pval = $pval")