using WooldridgeDatasets, DataFrames, LinearAlgebra

gpa1 = DataFrame(wooldridge("gpa1"))

# determine sample size & no. of regressors:
n = size(gpa1)[1]
k = 2

# extract y:
y = gpa1.colGPA

# extract X and add a column of ones:
X = hcat(ones(n), gpa1.hsGPA, gpa1.ACT)
# display first rows of X:
X_preview = round.(X[1:3, :], digits=5)
println("X_preview = $X_preview\n")

# parameter estimates:
b = inv(transpose(X) * X) * transpose(X) * y
println("b = $b\n")

# residuals, estimated variance of u and SER:
u_hat = y - X * b
sigsq_hat = (transpose(u_hat) * u_hat) / (n - k - 1)
SER = sqrt(sigsq_hat)
println("SER = $SER\n")

# estimated variance of the parameter estimators and SE:
Vbeta_hat = sigsq_hat .* inv(transpose(X) * X)
se = sqrt.(diag(Vbeta_hat))
println("se = $se")