using WooldridgeDatasets, DataFrames, CategoricalArrays, FreqTables

affairs = DataFrame(wooldridge("affairs"))

# attach labels to kids and convert it to a categorical variable:
affairs.haskids = categorical(
    recode(affairs.kids, 0 => "no", 1 => "yes")
)

# ... and ratemarr (for example: 1 = "very unhappy", 2 = "unhappy",...):
affairs.marriage = categorical(
    recode(affairs.ratemarr,
        1 => "very unhappy",
        2 => "unhappy",
        3 => "average",
        4 => "happy",
        5 => "very happy"
    )
)

# frequency table (alphabetical order of elements):
ft_marriage = freqtable(affairs.marriage)
println("ft_marriage: \n$ft_marriage\n")

# frequency table with groupby:
ft_groupby = combine(
    groupby(affairs, :haskids),
    nrow)
println("ft_groupby: \n$ft_groupby\n")

# contingency tables with absolute and relative values:
ct_all_abs = freqtable(affairs.marriage, affairs.haskids)
println("ct_all_abs: \n$ct_all_abs\n")

ct_all_rel = proptable(affairs.marriage, affairs.haskids)
println("ct_all_rel: \n$ct_all_rel\n")

# share within "marriage" (i.e. within a row):
ct_row = proptable(affairs.marriage, affairs.haskids, margins=1)
println("ct_row: \n$ct_row\n")

# share within "haskids" (i.e. within a column):
ct_col = proptable(affairs.marriage, affairs.haskids, margins=2)
println("ct_col: \n$ct_col")