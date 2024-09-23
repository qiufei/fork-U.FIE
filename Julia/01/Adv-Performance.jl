using Random, Distributions
# set the random seed:
Random.seed!(12345)

function simMean(n, reps)
    ybar = zeros(reps)
    for j in 1:reps
        # sample from normal distribution of size n
        sample = rand(Normal(), n)
        ybar[j] = mean(sample)
    end
    return ybar
end

# call the function and measure time:
n = 100
reps = 10000
stats = @timed simMean(n, reps);
runTime = stats.time
println("runTime = $runTime")