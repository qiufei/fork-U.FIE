using WooldridgeDatasets, DataFrames, GLM

ceosal1 = DataFrame(wooldridge("ceosal1"))

reg = lm(@formula(salary ~ roe), ceosal1)
b = coef(reg)
println("b = $b")