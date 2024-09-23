import random
import numpy as np
import timeit
import pandas as pd
import scipy.stats as stats

np.random.seed(12345)


def simMean(n, reps):
    ybar = np.empty(reps)
    for j in range(1, reps):
        sample = stats.norm.rvs(0, 1, size=n)
        ybar[j] = np.mean(sample)
    return (ybar)


# call the function multiple times and measure each time:
n = 100
r = 10000
step_length = 100
reps = range(100, r+1, step_length)
runTime = np.empty(len(reps))
number = 100

for i in range(len(reps)):
    runTime[i] = timeit.repeat(lambda: simMean(
        n, reps[i]), number=100, repeat=1)[0] / number
# repeat gives total time, i.e. number * single iteration time

dfruntime = pd.DataFrame({"runtime": runTime})
dfruntime.to_csv("Jlprocessed/01/Adv-Performance-Py.csv")
