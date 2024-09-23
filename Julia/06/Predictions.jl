using WooldridgeDatasets, GLM, DataFrames

gpa2 = DataFrame(wooldridge("gpa2"))

reg = lm(@formula(colgpa ~ sat + hsperc + hsize + (hsize^2)), gpa2)

# print regression table:
table_reg = coeftable(reg)
println("table_reg: \n$table_reg\n")

# generate data set containing the regressor values for predictions:
cvalues1 = DataFrame(id="newPerson1", sat=1200, hsperc=30, hsize=5)
println("cvalues1: \n$cvalues1\n")

# point estimate of prediction (cvalues1):
colgpa_pred1 = round.(predict(reg, cvalues1), digits=5)
println("colgpa_pred1 = $colgpa_pred1\n")

# define three sets of regressor variables:
cvalues2 = DataFrame(id=["newPerson1", "newPerson2", "newPerson3"],
    sat=[1200, 900, 1400],
    hsperc=[30, 20, 5], hsize=[5, 3, 1])
println("cvalues2: \n$cvalues2\n")

# point estimate of prediction (cvalues2):
colgpa_pred2 = round.(predict(reg, cvalues2), digits=5)
println("colgpa_pred2 = $colgpa_pred2")