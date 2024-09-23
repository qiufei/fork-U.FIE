using Random, Distributions, Statistics, Plots, GLM, DataFrames

# set the random seed:
Random.seed!(12345)

pvals = zeros(10000)

for i in 1:10000
    # i.i.d. N(0,1) innovations:
    n = 51
    e = rand(Normal(), n)
    e[1] = 0
    a = rand(Normal(), n)
    a[1] = 0

    # independent random walks:
    x = cumsum(a)
    y = cumsum(e)
    sim_data = DataFrame(y=y, x=x)

    # regression:
    reg = lm(@formula(y ~ x), sim_data)
    reg_table = coeftable(reg)

    # save the p value of x:
    pvals[i] = reg_table.cols[4][2]
end

# how often is p<=5%:
count_pval_smaller = sum(pvals .<= 0.05)  # counts true elements
println("count_pval_smaller = $count_pval_smaller\n")

# how often is p>5%:
count_pval_greater = sum(pvals .> 0.05)  # counts true elements
println("count_pval_greater = $count_pval_greater")