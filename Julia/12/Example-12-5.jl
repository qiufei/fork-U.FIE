using PyCall, WooldridgeDatasets, GLM, DataFrames
# install Python's statsmodels with: using Conda; Conda.add("statsmodels")
sm = pyimport("statsmodels.api")
include("../03/getMats.jl")

barium = DataFrame(wooldridge("barium"))

# definition of model and hypotheses:
f = @formula(log(chnimp) ~ 1 + log(chempi) + log(gas) + log(rtwex) +
                           befile6 + affile6 + afdec6)
xy = getMats(f, barium)
y = xy[1]
X = xy[2]

# perform the Cochrane-Orcutt estimation (iterative procedure):
reg = sm.GLSAR(y, X)
CORC_results = reg.iterative_fit(maxiter=100)

reg_rho = reg.rho
table = DataFrame(
    coefnames=["Intercept", "log(chempi)", "log(gas)", "log(rtwex)",
        "befile6", "affile6", "afdec6"],
    b_CORC=CORC_results.params,
    se_CORC=round.(CORC_results.bse, digits=5))

println("reg_rho = $reg_rho\n")
println("table: \n$table")