using LinearAlgebra
include("../03/getMats.jl")

# for details, see Wooldridge (2010), p. 57
function calc_white_se(reg, df)
    f = formula(reg)
    xy = getMats(f, df)
    y = xy[1]
    X = xy[2]
    u = residuals(reg)
    invXX = inv(X' * X)
    sumterm = (X .* u)' * (X .* u)
    avar = invXX' * sumterm * invXX
    std_white = sqrt.(diag(avar))
    return std_white
end