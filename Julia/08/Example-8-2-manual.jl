using WooldridgeDatasets, GLM, DataFrames
include("../03/getMats.jl")
gpa3 = DataFrame(wooldridge("gpa3"))

reg_default = lm(@formula(cumgpa ~ sat + hsperc + tothrs +
                                   female + black + white),
        subset(gpa3, :spring => ByRow(==(1))))

# extract formula parts for SE calculation:
f = formula(reg_default)
xy = getMats(f, subset(gpa3, :spring => ByRow(==(1))))
y = xy[1]
X = xy[2]
u = residuals(reg_default)
df = DataFrame(X, :auto)


# calculate all rij:
ri1 = residuals(lm(@formula(x1 ~ 0 + x2 + x3 + x4 + x5 + x6 + x7), df))
ri2 = residuals(lm(@formula(x2 ~ 0 + x1 + x3 + x4 + x5 + x6 + x7), df))
ri3 = residuals(lm(@formula(x3 ~ 0 + x1 + x2 + x4 + x5 + x6 + x7), df))
ri4 = residuals(lm(@formula(x4 ~ 0 + x1 + x2 + x3 + x5 + x6 + x7), df))
ri5 = residuals(lm(@formula(x5 ~ 0 + x1 + x2 + x3 + x4 + x6 + x7), df))
ri6 = residuals(lm(@formula(x6 ~ 0 + x1 + x2 + x3 + x4 + x5 + x7), df))
ri7 = residuals(lm(@formula(x7 ~ 0 + x1 + x2 + x3 + x4 + x5 + x6), df))

# calculate SE according to Wooldridge (2019), Ch. 8.2:
se1 = sqrt(sum((ri1 .^ 2) .* (u .^ 2)) / (sum((ri1 .^ 2))^2))
se2 = sqrt(sum((ri2 .^ 2) .* (u .^ 2)) / (sum((ri2 .^ 2))^2))
se3 = sqrt(sum((ri3 .^ 2) .* (u .^ 2)) / (sum((ri3 .^ 2))^2))
se4 = sqrt(sum((ri4 .^ 2) .* (u .^ 2)) / (sum((ri4 .^ 2))^2))
se5 = sqrt(sum((ri5 .^ 2) .* (u .^ 2)) / (sum((ri5 .^ 2))^2))
se6 = sqrt(sum((ri6 .^ 2) .* (u .^ 2)) / (sum((ri6 .^ 2))^2))
se7 = sqrt(sum((ri7 .^ 2) .* (u .^ 2)) / (sum((ri7 .^ 2))^2))

se_white = round.([se1, se2, se3, se4, se5, se6, se7], digits=5)
println("se_white = $se_white")