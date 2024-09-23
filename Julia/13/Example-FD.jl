using WooldridgeDatasets, GLM, DataFrames

crime2 = DataFrame(wooldridge("crime2"))

# create an index in this balanced data set by combining two vectors:
id_tmp = 1:46
crime2.id = sort(vcat(id_tmp, id_tmp))

# sort data by id and year:
sort!(crime2, [:id, :year])

# manually calculate first differences per entity for crmrte and unem:
grouped_df = groupby(crime2, :id)
diff_df = DataFrame(id=id_tmp)
diff_df.crmrte_diff1 = combine(grouped_df, :crmrte => diff).crmrte_diff
diff_df.unem_diff1 = combine(grouped_df, :unem => diff).unem_diff

preview = diff_df[1:5, :]
println("preview: \n$preview\n")

# estimate FD model with OLS on differenced data:
reg_sm = lm(@formula(crmrte_diff1 ~ unem_diff1), diff_df)
table_sm = coeftable(reg_sm)
println("table_sm: \n$table_sm")