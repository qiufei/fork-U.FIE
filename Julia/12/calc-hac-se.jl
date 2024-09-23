using LinearAlgebra

# for details, see Equations 12.41 - 12.43 in Wooldridge (2019)
function calc_hac_se(reg, g)
    n = nobs(reg)
    X = reg.mm.m
    n = size(X, 1)
    K = size(X, 2)
    u = residuals(reg)
    ser = sqrt(sum(u .^ 2) / (n - K))
    se_ols = coeftable(reg).cols[2]
    se_hac = zeros(K)

    for k in 1:K
        yk = X[:, k]
        Xk = X[:, (1:K).!=k]
        bk = inv(transpose(Xk) * Xk) * transpose(Xk) * yk
        rk = yk .- Xk * bk
        ak = rk .* u
        vk = sum(ak .^ 2)
        for h in 1:g
            sum_h = 2 * (1 - h / (g + 1)) * sum(ak[(h+1):n] .* ak[1:(n-h)])
            vk = vk + sum_h
        end

        se_hac[k] = (se_ols[k] / ser)^2 * sqrt(vk)
    end
    return se_hac
end