seq = [1, 2, 3, 4, 5, 6]
for i in seq
    if i < 4
        println(i^3)
    else
        println(i^2)
    end
end