# initialize matrix with each element set to zero:
zero_mat = zeros(4, 3)
println("zero_mat: \n$zero_mat\n")

# initialize matrix with each element set to one:
one_mat = ones(2, 5)
println("one_mat: \n$one_mat\n")

# uninitialized matrix (filled with arbitrary nonsense elements):
empty_mat = Array{Float64}(undef, 2, 2)
println("empty_mat: \n$empty_mat")