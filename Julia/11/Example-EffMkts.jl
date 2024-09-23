using DataFrames, GLM, Dates, MarketData, Plots, RegressionTables

# download data for "AAPL" (= Apple) and define start and end:
ticker = "AAPL"
start_date = DateTime(2007, 12, 31)
end_date = DateTime(2017, 01, 01)

# import data as DataFrame:
AAPL_data = DataFrame(yahoo(ticker,
    YahooOpt(period1=start_date, period2=end_date)))

# calculate return as the difference of logged prices:
AAPL_data.ret = vcat(missing, diff(log.(AAPL_data.AdjClose)))

# time series plot of returns:
plot(AAPL_data.timestamp, AAPL_data.ret, legend=false, color="grey")
ylabel!("returns")
savefig("JlGraphs/Example-EffMkts.pdf")

# linear regression of models with lags:
AAPL_data.ret_lag1 = lag(AAPL_data.ret, 1)
AAPL_data.ret_lag2 = lag(AAPL_data.ret, 2)
AAPL_data.ret_lag3 = lag(AAPL_data.ret, 3)

reg1 = lm(@formula(ret ~ ret_lag1), AAPL_data)
reg2 = lm(@formula(ret ~ ret_lag1 + ret_lag2), AAPL_data)
reg3 = lm(@formula(ret ~ ret_lag1 + ret_lag2 + ret_lag3), AAPL_data)

# print results with RegressionTables:
regtable(reg1, reg2, reg3)