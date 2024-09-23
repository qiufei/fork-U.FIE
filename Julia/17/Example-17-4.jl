using WooldridgeDatasets, GLM, DataFrames, Statistics, Distributions,
        LinearAlgebra, Optim

# load data and build data matrices:
recid = DataFrame(wooldridge("recid"))
f = @formula(ldurat ~ 1 + workprg + priors + tserved +
                      felon + alcohol + drugs + black +
                      married + educ + age)
xy = getMats(f, recid)
y = xy[1]
X = xy[2]

# define dummy for censored observations:
censored = recid.cens .!= 0

# generate starting solution:
reg_ols = lm(@formula(ldurat ~ workprg + priors + tserved +
                               felon + alcohol + drugs +
                               black + married +
                               educ + age), recid)
resid_ols = residuals(reg_ols)
sigma_start = log(sum(resid_ols .^ 2) / length(resid_ols))
params_start = vcat(coef(reg_ols), sigma_start)

# define a function that returns the negative log likelihood per observation:
function ll_censreg(params, y, X, cens)
        p = size(X, 2)
        beta = params[1:p]
        sigma = exp(params[p+1])
        y_hat = X * beta
        ll = zeros(length(y))
        # uncensored:
        ll[.!cens] = log.(pdf.(Normal(),
                (y.-y_hat)[.!cens] / sigma)) .- log(sigma)
        # censored:
        ll[cens] = log.(cdf.(Normal(), -(y.-y_hat)[cens] / sigma))

        # return the negative sum of log likelihoods for each observation:
        return -sum(ll)
end

# maximize the log likelihood = minimize the negative of the log likelihood:
optimum = optimize(par -> ll_censreg(par, y, X, censored), params_start, Newton())
mle_est = Optim.minimizer(optimum)
ll = -optimum.minimum

# print results of MLE:
table_mle = DataFrame(
        coef_names=vcat(coeftable(reg_ols).rownms, "exp_sigma"),
        mle_est=round.(mle_est, digits=5))
println("table_mle: \n$table_mle\n")
println("ll = $ll")