using DataFrames, GLM, Dates, MarketData

# download data for "AAPL" (= Apple) and define start and end:
ticker = "AAPL"
start_date = DateTime(2007, 12, 31)
end_date = DateTime(2017, 01, 01)

# import data as DataFrame:
AAPL_data = DataFrame(yahoo(ticker,
    YahooOpt(period1=start_date, period2=end_date)))

# calculate return as the difference of logged prices:
AAPL_data.ret = vcat(missing, diff(log.(AAPL_data.AdjClose)))
AAPL_data.ret_lag1 = lag(AAPL_data.ret, 1)
AAPL_data = AAPL_data[Not(1, 2), :]

# AR(1) model for returns:
reg = lm(@formula(ret ~ ret_lag1), AAPL_data)

# squared residuals:
AAPL_data.resid_sq = residuals(reg) .^ 2
AAPL_data.resid_sq_lag1 = lag(AAPL_data.resid_sq, 1)

# model for squared residuals:
ARCHreg = lm(@formula(resid_sq ~ resid_sq_lag1), AAPL_data)
table_ARCHreg = coeftable(ARCHreg)
println("table_ARCHreg: \n$table_ARCHreg")