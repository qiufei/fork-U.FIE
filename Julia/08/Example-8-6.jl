using WooldridgeDatasets, GLM, DataFrames
include("calc-white-se.jl")

k401ksubs = DataFrame(wooldridge("401ksubs"))

# subsetting data:
k401ksubs_sub = subset(k401ksubs, :fsize => ByRow(==(1)))

# OLS (only for singles, i.e. ’fsize’==1):
reg_ols = lm(@formula(nettfa ~ inc + ((age - 25)^2) + male + e401k),
        k401ksubs_sub)
hc0 = calc_white_se(reg_ols, k401ksubs_sub)

# print regression table with hc0:
table_ols = DataFrame(coefficients=coeftable(reg_ols).rownms,
        b=round.(coef(reg_ols), digits=5),
        se=round.(hc0, digits=5))
println("table_ols: \n$table_ols\n")

# WLS:
k401ksubs_sub.w = (1 ./ sqrt.(k401ksubs_sub.inc))
reg_wls = lm(@formula(identity(nettfa * w) ~ 0 + w + identity(inc * w) +
                                             identity((age - 25)^2 * w) +
                                             identity(male * w) +
                                             identity(e401k * w)), k401ksubs_sub)

# print regression table:
table_wls = DataFrame(coefficients=coeftable(reg_wls).rownms,
        b=round.(coef(reg_wls), digits=5),
        se=round.(coeftable(reg_wls).cols[2], digits=5))
println("table_wls: \n$table_wls\n")