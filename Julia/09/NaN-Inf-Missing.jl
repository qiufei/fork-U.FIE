using Distributions, DataFrames, Statistics

# NaN, missings and infinite values in Julia:
x1 = [0, 2, NaN, Inf, missing]
logx = log.(x1)
invx = 0 ./ x1
isnanx = isnan.(x1)
isinfx = isinf.(x1)
ismissingx = ismissing.(x1)

results = DataFrame(x1=x1, logx=logx, invx=invx, ismissingx=ismissingx,
    isnanx=isnanx, isinfx=isinfx)
println("results = $results\n")

# mathematically not defined is not always NaN (like in R or Python):
test = try
    log(-1) # results in an ERROR
catch e
    NaN
end
println("test = $test\n")

# handling missings:
x2 = [4, 2, missing, 3]
meanx2_1 = mean(x2)
println("meanx2_1 = $meanx2_1\n")

meanx2_2 = mean(skipmissing(x2))
println("meanx2_2 = $meanx2_2\n")

x3 = [4, 2, NaN, 3]
meanx3_1 = mean(x3)
println("meanx3_1 = $meanx3_1\n")

meanx3_2 = mean(x3[.!isnan.(x3)])
println("meanx3_2 = $meanx3_2")