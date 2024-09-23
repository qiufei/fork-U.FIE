using WooldridgeDatasets, DataFrames, GLM

gpa1 = DataFrame(wooldridge("gpa1"))

# parameter estimates for full and simple model:
reg = lm(@formula(colGPA ~ ACT + hsGPA), gpa1)
b = coef(reg)
println("b = $b\n")

# relation between regressors:
reg_delta = lm(@formula(hsGPA ~ ACT), gpa1)
delta_tilde = coef(reg_delta)
println("delta_tilde = $delta_tilde\n")

# omitted variables formula for b1_tilde:
b1_tilde = b[2] + b[3] * delta_tilde[2]
println("b1_tilde = $b1_tilde\n")

# actual regression with hsGPA omitted:
reg_om = lm(@formula(colGPA ~ ACT), gpa1)
b_om = coef(reg_om)
println("b_om = $b_om")