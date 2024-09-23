using WooldridgeDatasets, DataFrames, StatsModels, LinearAlgebra
include("getMats.jl")

gpa1 = DataFrame(wooldridge("gpa1"))

# build y and X from a formula:
f = @formula(colGPA ~ 1 + hsGPA + ACT)
xy = getMats(f, gpa1)
y = xy[1]
X = xy[2]

# parameter estimates:
b = inv(transpose(X) * X) * transpose(X) * y
println("b = $b")