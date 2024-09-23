using WooldridgeDatasets, GLM, DataFrames, CategoricalArrays, FreqTables

lawsch85 = DataFrame(wooldridge("lawsch85"))

# define cut points for the rank:
cutpts = [1, 11, 26, 41, 61, 101, 176]
# note that "cut" takes intervals only in the form of [lower, upper)

# create categorical variable containing ranges for the rank:
lawsch85.rc = cut(lawsch85.rank, cutpts,
        labels=["[1,11)", "[11,26)", "[26,41)",
                "[41,61)", "[61,101)", "[101,176)"])

# display frequencies:
freq = freqtable(lawsch85.rc)
println("freq: \n$freq\n")

# run regression:
reg = lm(@formula(log(salary) ~ rc + LSAT + GPA + log(libvol) + log(cost)),
        lawsch85,
        contrasts=Dict(:rc => DummyCoding(base="[101,176)",
                levels=["[1,11)", "[11,26)", "[26,41)",
                        "[41,61)", "[61,101)", "[101,176)"])))
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")