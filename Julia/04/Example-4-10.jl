using WooldridgeDatasets, GLM, DataFrames, RegressionTables

meap93 = DataFrame(wooldridge("meap93"))
meap93.b_s = meap93.benefits ./ meap93.salary

# estimate three different models:
reg1 = lm(@formula(log(salary) ~ b_s), meap93)
reg2 = lm(@formula(log(salary) ~ b_s + log(enroll) + log(staff)), meap93)
reg3 = lm(@formula(log(salary) ~
                b_s + log(enroll) + log(staff) + droprate + gradrate), meap93)

# print results with RegressionTables:
regtable(reg1, reg2, reg3)