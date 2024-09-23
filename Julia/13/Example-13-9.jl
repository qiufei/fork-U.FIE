using WooldridgeDatasets, GLM, DataFrames

crime4 = DataFrame(wooldridge("crime4"))
crime4.lcrmrte = log.(crime4.crmrte)

# sort data by county and year:
sort!(crime4, [:county, :year])

# manually calculate first differences for multiple variables:
vars_to_diff = ["lcrmrte", "d83", "d84", "d85", "d86", "d87",
    "lprbarr", "lprbconv", "lprbpris", "lavgsen", "lpolpc"]
grouped_df = groupby(crime4, :county)
diff_df = DataFrame()

for i in vars_to_diff
    tmp_diff_i = combine(grouped_df, Symbol(i) => diff)[:, 2]
    diff_df[!, i] = tmp_diff_i
end

# estimate FD model:
reg = lm(@formula(lcrmrte ~ d83 + d84 + d85 + d86 + d87 +
                            lprbarr + lprbconv + lprbpris +
                            lavgsen + lpolpc), diff_df)
table_reg = coeftable(reg)
println("table_reg: \n$table_reg")