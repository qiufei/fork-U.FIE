using WooldridgeDatasets, DataFrames, GLM

ceosal1 = DataFrame(wooldridge("ceosal1"))

# estimate log-log model:
reg = lm(@formula(log(salary) ~ log(sales)), ceosal1)
b = coef(reg)
println("b = $b")