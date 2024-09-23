using WooldridgeDatasets, GLM, DataFrames

gpa3 = DataFrame(wooldridge("gpa3"))

# estimate model for males (& spring data):
reg_m = lm(@formula(cumgpa ~ sat + hsperc + tothrs),
    subset(gpa3, :spring => ByRow(==(1)), :female => ByRow(==(0))))
table_reg_m = coeftable(reg_m)
println("table_reg_m: \n$table_reg_m")

# estimate model for females (& spring data):
reg_f = lm(@formula(cumgpa ~ sat + hsperc + tothrs),
    subset(gpa3, :spring => ByRow(==(1)), :female => ByRow(==(1))))
table_reg_f = coeftable(reg_f)
println("table_reg_f: \n$table_reg_f")