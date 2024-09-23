using WooldridgeDatasets, DataFrames, GLM

wage1 = DataFrame(wooldridge("wage1"))

# estimate log-level model:
reg = lm(@formula(log(wage) ~ educ), wage1)
b = coef(reg)
println("b = $b")