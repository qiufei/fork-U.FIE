using WooldridgeDatasets, DataFrames, GLM

wage1 = DataFrame(wooldridge("wage1"))

reg = lm(@formula(wage ~ educ), wage1)
b = coef(reg)
println("b = $b")