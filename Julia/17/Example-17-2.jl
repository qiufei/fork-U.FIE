using WooldridgeDatasets, GLM, DataFrames, Statistics, Distributions,
    LinearAlgebra, Optim
include("../03/getMats.jl")

# load data and build data matrices:
mroz = DataFrame(wooldridge("mroz"))
f = @formula(hours ~ 1 + nwifeinc + educ + exper +
                     (exper^2) + age + kidslt6 + kidsge6)
xy = getMats(f, mroz)
y = xy[1]
X = xy[2]

# define a function that returns the negative log likelihood per observation
# (for details on the implementation see Wooldridge (2019), formula 17.22):
function ll_tobit(params, y, X)
    p = size(X, 2)
    beta = params[1:p]
    sigma = exp(params[p+1])
    y_hat = X * beta
    y_eq = (y .== 0)
    y_g = (y .> 0)
    ll = zeros(length(y))
    ll[y_eq] = log.(cdf.(Normal(), -y_hat[y_eq] / sigma))
    ll[y_g] = log.(pdf.(Normal(), (y.-y_hat)[y_g] / sigma)) .- log(sigma)
    # return the negative sum of log likelihoods for each observation:
    return -sum(ll)
end


# generate starting solution:
reg_ols = lm(@formula(hours ~ nwifeinc + educ + exper + (exper^2) +
                              age + kidslt6 + kidsge6), mroz)
resid_ols = residuals(reg_ols)
sigma_start = log(sum(resid_ols .^ 2) / length(resid_ols))
params_start = vcat(coef(reg_ols), sigma_start)

# maximize the log likelihood = minimize the negative of the log likelihood:
optimum = optimize(par -> ll_tobit(par, y, X), params_start, Newton())
mle_est = Optim.minimizer(optimum)
ll = -optimum.minimum

# print results:
table_mle = DataFrame(
    coef_names=vcat(coeftable(reg_ols).rownms, "exp_sigma"),
    mle_est=round.(mle_est, digits=5))
println("table_mle: \n$table_mle\n")
println("ll = $ll")