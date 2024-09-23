using WooldridgeDatasets, GLM, DataFrames

hseinv = DataFrame(wooldridge("hseinv"))

# linear regression without time trend:
reg_wot = lm(@formula(log(invpc) ~ log(price)), hseinv)
table_reg_wot = coeftable(reg_wot)
println("table_reg_wot: \n$table_reg_wot\n")

# linear regression with time trend (data set includes a time variable t):
reg_wt = lm(@formula(log(invpc) ~ log(price) + t), hseinv)
table_reg_wt = coeftable(reg_wt)
println("table_reg_wt: \n$table_reg_wt")