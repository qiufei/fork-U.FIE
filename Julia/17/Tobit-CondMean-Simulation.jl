using Random, Distributions, Statistics, Plots, GLM, DataFrames, LinearAlgebra, Optim

# set the random seed:
Random.seed!(12345)

x = sort(rand(Normal(), 100) .+ 4)
xb = -4 .+ 1 * x
y_star = xb .+ rand(Normal(), 100)
y = copy(y_star)
y[y_star.<0] .= 0
sim_data = DataFrame(y_star=y_star, y=y, x=x)


# define likelihood:
function ll_tobit(params, y, X)
    p = size(X, 2)
    beta = params[1:p]
    sigma = exp(params[p+1])
    y_hat = X * beta
    y_eq = (y .=== 0.0)
    y_g = (y .> 0)
    ll = zeros(length(y))
    ll[y_eq] = log.(cdf.(Normal(), -y_hat[y_eq] / sigma))
    ll[y_g] = log.(pdf.(Normal(), (y-y_hat)[y_g] / sigma)) .- log(sigma)
    # return the negative sum of log likelihoods for each observation:
    return -sum(ll)
end


# predictions:
reg_ols = lm(@formula(y ~ x), sim_data)
yhat_ols = fitted(reg_ols)
resid_ols = residuals(reg_ols)
sigma_start = log(sum(resid_ols .^ 2) / length(resid_ols))
params_start = vcat(coef(reg_ols), sigma_start)

# maximise the log likelihood = minimize the negative of the log likelihood:
X = hcat(ones(100), x)
optimum = optimize(par -> ll_tobit(par, y, X), params_start, Newton())
mle_est = Optim.minimizer(optimum)
yhat_tobit = X * mle_est[1:2]

# plot data and model predictions:

hline([0], color="grey", label=false, legend=:topleft)
scatter!(x, y_star, color="black", markershape=:xcross, label="real data")
scatter!(x, y, color="black", markershape=:cross, label="truncated data")
plot!(x, yhat_ols, color="black", linewidth=2, linestyle=:solid, label="OLS fit")
plot!(x, yhat_tobit, color="black", linewidth=2, linestyle=:dash, label="Tobit fit")
ylabel!("y")
xlabel!("x")
savefig("JlGraphs/Tobit-CondMean-Simulation.pdf")