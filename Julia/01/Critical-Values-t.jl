using Distributions, DataFrames

# degrees of freedom = n-1:
df = 19

# significance levels:
alpha_one_tailed = [0.1, 0.05, 0.025, 0.01, 0.005, 0.001]
alpha_two_tailed = alpha_one_tailed * 2

# critical values & table:
CV = quantile.(TDist(df), 1 .- alpha_one_tailed)
table = DataFrame(alpha_one_tailed=alpha_one_tailed,
    alpha_two_tailed=alpha_two_tailed,
    CV=CV)
println("table: \n$table")