using WooldridgeDatasets, GLM, DataFrames, RegressionTables

bwght = DataFrame(wooldridge("bwght"))

# regress and report coefficients:
reg = lm(@formula(bwght ~ cigs + faminc), bwght)

# weight in pounds, manual way:
bwght.bwght_lbs = bwght.bwght ./ 16
reg_lbs1 = lm(@formula(bwght_lbs ~ cigs + faminc), bwght)

# weight in pounds, direct way:
reg_lbs2 = lm(@formula((bwght / 16) ~ cigs + faminc), bwght)

# packs of cigaretts:
reg_packs = lm(@formula(bwght ~ (cigs / 20) + faminc), bwght)

# weight in ounces using bwght_lbs:
reg_pds = lm(@formula(identity(bwght_lbs * 16) ~ cigs + faminc), bwght)

# print results with RegressionTables:
regtable(reg, reg_lbs1, reg_lbs2, reg_packs, reg_pds)