using WooldridgeDatasets, GLM, DataFrames

fertil3 = DataFrame(wooldridge("fertil3"))

# compute first differences (first difference is always missing):
fertil3.gfr_diff1 = vcat(missing, diff(fertil3.gfr))
fertil3.pe_diff1 = vcat(missing, diff(fertil3.pe))
preview = fertil3[1:5, ["gfr", "gfr_diff1", "pe", "pe_diff1"]]
println("preview: \n$preview\n")

# linear regression of model with first differences:
reg1 = lm(@formula(gfr_diff1 ~ pe_diff1), fertil3)
table_reg1 = coeftable(reg1)
println("table_reg1: \n$table_reg1\n")

# linear regression of model with lagged differences:
fertil3.pe_diff1_lag1 = lag(fertil3.pe_diff1, 1)
fertil3.pe_diff1_lag2 = lag(fertil3.pe_diff1, 2)

reg2 = lm(@formula(gfr_diff1 ~ pe_diff1 + pe_diff1_lag1 + pe_diff1_lag2),
    fertil3)
table_reg2 = coeftable(reg2)
println("table_reg2: \n$table_reg2")