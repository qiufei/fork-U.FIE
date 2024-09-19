import numpy as np
import pandas as pd
import yfinance as yf
import statsmodels.formula.api as smf

# download data for 'AAPL' (= Apple) and define start and end:
tickers = ['AAPL']
start_date = '2007-12-31'
end_date = '2016-12-31'

# use yfinance for the import:
AAPL_data = yf.download(tickers, start_date, end_date)

# calculate return as the difference of logged prices:
AAPL_data['ret'] = np.log(AAPL_data['Adj Close']).diff()
AAPL_data['ret_lag1'] = AAPL_data['ret'].shift(1)

# AR(1) model for returns:
reg = smf.ols(formula='ret ~ ret_lag1', data=AAPL_data)
results = reg.fit()

# squared residuals:
AAPL_data['resid_sq'] = results.resid ** 2
AAPL_data['resid_sq_lag1'] = AAPL_data['resid_sq'].shift(1)

# model for squared residuals:
ARCHreg = smf.ols(formula='resid_sq ~ resid_sq_lag1', data=AAPL_data)
results_ARCH = ARCHreg.fit()

# print regression table:
table = pd.DataFrame({'b': round(results_ARCH.params, 4),
                      'se': round(results_ARCH.bse, 4),
                      't': round(results_ARCH.tvalues, 4),
                      'pval': round(results_ARCH.pvalues, 4)})
print(f'table: \n{table}\n')