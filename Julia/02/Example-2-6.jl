using WooldridgeDatasets, DataFrames, GLM

ceosal1 = DataFrame(wooldridge("ceosal1"))

# OLS regression:
reg = lm(@formula(salary ~ roe), ceosal1)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# obtain predicted values and residuals:
salary_hat = predict(reg)
u_hat = residuals(reg)

# Wooldridge, Table 2.2:
table = DataFrame(roe=ceosal1.roe,
    salary=ceosal1.salary,
    salary_hat=salary_hat,
    u_hat=u_hat)
table_preview = first(table, 10)
println("table_preview: \n$table_preview")