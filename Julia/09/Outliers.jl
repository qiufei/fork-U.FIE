using WooldridgeDatasets, GLM, DataFrames, LinearAlgebra, Plots

rdchem = DataFrame(wooldridge("rdchem"))

# create dummys for each observation with an identity matrix:
n = nrow(rdchem)
dummys = DataFrame(Matrix(1I, n, n), Symbol.(:d, 1:n)) # colnames d1, ..., d32

# studentized residuals for all observations:
studres = zeros(n)
for i in 1:n
    rdchem.di = dummys[:, i]
    reg_i = lm(@formula(rdintens ~ sales + profmarg + di), rdchem)
    # save t statistic (3rd column) of di (4th element):
    studres[i] = coeftable(reg_i).cols[3][4]
end

# display extreme values:
studres_max = maximum(studres)
studres_min = minimum(studres)
println("studres_max = $studres_max\n")
println("studres_min = $studres_min")

# histogram:
histogram(studres, color="grey", legend=false)
xlabel!("studres")
savefig("JlGraphs/Outliers.pdf")