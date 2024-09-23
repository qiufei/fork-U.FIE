using WooldridgeDatasets, GLM, DataFrames
include("calc-white-se.jl")

k401ksubs = DataFrame(wooldridge("401ksubs"))

# subsetting data:
k401ksubs_sub = subset(k401ksubs, :fsize => ByRow(==(1)))

# WLS:
k401ksubs_sub.w = (1 ./ sqrt.(k401ksubs_sub.inc))
reg_wls = lm(@formula(identity(nettfa * w) ~ 0 + w + identity(inc * w) +
                                             identity((age - 25)^2 * w) +
                                             identity(male * w) +
                                             identity(e401k * w)), k401ksubs_sub)

# robust results (White SE):
hc0 = calc_white_se(reg_wls, k401ksubs_sub)

# print regression table:
table_default = DataFrame(coefficients=coeftable(reg_wls).rownms,
        b=round.(coef(reg_wls), digits=5),
        se_default=round.(coeftable(reg_wls).cols[2], digits=5),
        se_robust=round.(hc0, digits=5))
println("table_default: \n$table_default")