using WooldridgeDatasets, DataFrames, Statistics

ceosal1 = DataFrame(wooldridge("ceosal1"))
x = ceosal1.roe
y = ceosal1.salary

# ingredients to the OLS formulas:
cov_xy = cov(x, y)
var_x = var(x)
x_bar = mean(x)
y_bar = mean(y)

# manual calculation of OLS coefficients:
b1 = cov_xy / var_x
b0 = y_bar - b1 * x_bar
println("b1 = $b1\n")
println("b0 = $b0")