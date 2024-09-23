using WooldridgeDatasets, GLM, DataFrames, Statistics

hprice2 = DataFrame(wooldridge("hprice2"))

# define a function for the standardization:
function scale(x)
    x_mean = mean(x)
    x_var = var(x)
    x_scaled = (x .- x_mean) ./ sqrt.(x_var)
    return x_scaled
end

# standardize and estimate:
hprice2.price_sc = scale(hprice2.price)
hprice2.nox_sc = scale(hprice2.nox)
hprice2.crime_sc = scale(hprice2.crime)
hprice2.rooms_sc = scale(hprice2.rooms)
hprice2.dist_sc = scale(hprice2.dist)
hprice2.stratio_sc = scale(hprice2.stratio)

reg = lm(@formula(price_sc ~
        0 + nox_sc + crime_sc + rooms_sc + dist_sc + stratio_sc),
    hprice2)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")