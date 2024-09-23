using WooldridgeDatasets, GLM, DataFrames
include("../08/calc-white-se.jl")

mroz = DataFrame(wooldridge("mroz"))

# estimate linear probability model:
reg_lin = lm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) +
                             age + kidslt6 + kidsge6), mroz)
hc0 = calc_white_se(reg_lin, mroz)

table_reg_lin = DataFrame(
    coefficients=coeftable(reg_lin).rownms,
    b=round.(coef(reg_lin), digits=5),
    se_white=hc0)
println("table_reg_lin: \n$table_reg_lin")