# define function:
function mysqrt(x)
    if x >= 0
        result = x^0.5
    else
        result = "You fool!"
    end
    return result
end

# call function and save result:
result1 = mysqrt(4)
println("result1 = $result1\n")

result2 = mysqrt(-1.5)
println("result2 = $result2")