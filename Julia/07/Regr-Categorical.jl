using WooldridgeDatasets, GLM, DataFrames, FreqTables, CSV

CPS1985 = DataFrame(CSV.File("data/CPS1985.csv"))
# rename variable to make outputs more compact:
rename!(CPS1985, :occupation => :oc)

# table of categories and frequencies for two categorical variables:
freq_gender = freqtable(CPS1985.gender)
println("freq_gender: \n$freq_gender\n")

freq_occupation = freqtable(CPS1985.oc)
println("freq_occupation: \n$freq_occupation\n")

# directly using categorical variables in regression formula
# (the formula automatically interprets string
# columns as categorical variables and dummy codes them):
reg = lm(@formula(log(wage) ~ education + experience + gender + oc), CPS1985)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")

# rerun regression with different reference category:
reg_newref = lm(@formula(log(wage) ~ education + experience + gender + oc),
    CPS1985,
    contrasts=Dict(:gender => DummyCoding(base="male"),
        :oc => DummyCoding(base="technical")))
table_newref = coeftable(reg_newref)
println("table_newref: \n$table_newref")