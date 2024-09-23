seq = [1, 2, 3, 4, 5, 6]

for i in eachindex(seq)
    if seq[i] < 4
        println(seq[i]^3)
    else
        println(seq[i]^2)
    end
end