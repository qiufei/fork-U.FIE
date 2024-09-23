using WooldridgeDatasets, GLM, DataFrames
include("calc-white-se.jl")

gpa3 = DataFrame(wooldridge("gpa3"))

reg_default = lm(@formula(cumgpa ~ sat + hsperc + tothrs +
                                   female + black + white),
        subset(gpa3, :spring => ByRow(==(1))))

hc0 = calc_white_se(reg_default, subset(gpa3, :spring => ByRow(==(1))))

table_se = DataFrame(coefficients=coeftable(reg_default).rownms,
        b=round.(coef(reg_default), digits=5),
        se_default=round.(coeftable(reg_default).cols[2], digits=5),
        se_white=hc0)
println("table_se: \n$table_se")