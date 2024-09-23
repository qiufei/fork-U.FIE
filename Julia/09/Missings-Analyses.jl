using WooldridgeDatasets, GLM, DataFrames, Statistics

lawsch85 = DataFrame(wooldridge("lawsch85"))

# missings:
x = lawsch85.LSAT
x_bar1 = mean(x)
x_bar2 = mean(skipmissing(x))
println("x_bar1 = $x_bar1\n")
println("x_bar2 = $x_bar2\n")

# observations and variables:
nrows = nrow(lawsch85)
ncols = ncol(lawsch85)
println("nrows = $nrows\n")
println("ncols = $ncols\n")

# regression (missings are taken care of by default):
reg = lm(@formula(log(salary) ~ LSAT + cost + age), lawsch85)
n = nobs(reg)
println("n = $n")