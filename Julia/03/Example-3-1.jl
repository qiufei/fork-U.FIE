using WooldridgeDatasets, GLM, DataFrames

gpa1 = DataFrame(wooldridge("gpa1"))

reg = lm(@formula(colGPA ~ hsGPA + ACT), gpa1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

r2_automatic = r2(reg)
println("r2_automatic = $r2_automatic")