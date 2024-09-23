using Distributions

# CV for alpha=5% and 1% using the t distribution with 522 d.f.:
alpha = [0.05, 0.01]
cv_t = round.(quantile.(TDist(522), 1 .- alpha), digits=5)
println("cv_t = $cv_t\n")

# CV for alpha=5% and 1% using the normal approximation:
cv_n = round.(quantile.(Normal(), 1 .- alpha), digits=5)
println("cv_n = $cv_n")