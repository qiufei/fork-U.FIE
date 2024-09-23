using WooldridgeDatasets, GLM, DataFrames
include("calc-hac-se.jl")

prminwge = DataFrame(wooldridge("prminwge"))
prminwge.time = prminwge.year .- 1949

# OLS with regular SE:
reg = lm(@formula(log(prepop) ~ log(mincov) + log(prgnp) +
                                log(usgnp) + time), prminwge)

# OLS with HAC SE: 
hac_se = calc_hac_se(reg, 2)

# print different SEs:
table = DataFrame(coefficients=coeftable(reg).rownms,
    b=round.(coef(reg), digits=5),
    se_default=round.(coeftable(reg).cols[2], digits=5),
    hac_se=round.(hac_se, digits=5))
println("table: \n$table")