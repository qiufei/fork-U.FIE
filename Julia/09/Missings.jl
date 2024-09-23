using WooldridgeDatasets, GLM, DataFrames

lawsch85 = DataFrame(wooldridge("lawsch85"))
lsat = lawsch85.LSAT

# create boolean indicator for missings:
missLSAT = ismissing.(lsat)

# LSAT and indicator for Schools No. 120-129:
preview = DataFrame(lsat=lsat[120:129],
    missLSAT=missLSAT[120:129])
println("preview: \n$preview\n")

# frequencies of indicator:
tot_missing = count(missLSAT) # same as sum(missLSAT)
tot_nonmissings = count(.!missLSAT)
println("tot_missing = $tot_missing\n")
println("tot_nonmissings = $tot_nonmissings\n")

# missings for all variables in data frame (counts):
miss_all = ismissing.(lawsch85)
freq_missLSAT = mapcols(count, miss_all)
freq_missLSAT_preview = freq_missLSAT[:, 1:9] # print only first nine columns
println("freq_missLSAT_preview: \n$freq_missLSAT_preview\n")

# computing amount of complete cases:
lsat_compl_cases1 = dropmissing(lawsch85)
complete_cases1 = nrow(lsat_compl_cases1)
println("complete_cases1 = $complete_cases1\n")

lsat_compl_cases2 = completecases(lawsch85)
complete_cases2 = count(lsat_compl_cases2)
println("complete_cases2 = $complete_cases2")