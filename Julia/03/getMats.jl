# for details, see https://juliastats.org/StatsModels.jl/stable/internals/
using StatsModels

function getMats(formula, df)
    f = apply_schema(formula, schema(formula, df))
    resp, pred = modelcols(f, df)
    return (resp, pred)
end