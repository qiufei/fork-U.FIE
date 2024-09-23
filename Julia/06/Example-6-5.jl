using WooldridgeDatasets, GLM, DataFrames

gpa2 = DataFrame(wooldridge("gpa2"))

reg = lm(@formula(colgpa ~ sat + hsperc + hsize + (hsize^2)), gpa2)

# define three sets of regressor variables:
cvalues2 = DataFrame(
    id=["newPerson1", "newPerson2", "newPerson3"],
    sat=[1200, 900, 1400],
    hsperc=[30, 20, 5],
    hsize=[5, 3, 1])

# point estimates and 95% confidence and prediction intervals:
colgpa_CI_95 = predict(reg, cvalues2, interval=:confidence)
println("colgpa_CI_95: \n$colgpa_CI_95\n")
colgpa_PI_95 = predict(reg, cvalues2, interval=:prediction)
println("colgpa_PI_95: \n$colgpa_PI_95\n")

# point estimates and 99% confidence and prediction intervals:
colgpa_CI_99 = predict(reg, cvalues2, interval=:confidence, level=0.99)
println("colgpa_CI_99: \n$colgpa_CI_99\n")
colgpa_PI_99 = predict(reg, cvalues2, interval=:prediction, level=0.99)
println("colgpa_PI_99: \n$colgpa_PI_99")