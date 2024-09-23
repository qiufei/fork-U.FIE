using WooldridgeDatasets, DataFrames, GLM

crime1 = DataFrame(wooldridge("crime1"))

# model without avgsen:
reg = lm(@formula(narr86 ~ pcnv + ptime86 + qemp86), crime1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")