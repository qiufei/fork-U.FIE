# define function (only positional arguments):
function mysqrt_pos(x, add)
    if x >= 0
        result = x^0.5 + add
    else
        result = "You fool!"
    end
    return result
end

# define function ("x" as positional and "add" as keyword argument):
function mysqrt_kwd(x; add)
    if x >= 0
        result = x^0.5 + add
    else
        result = "You fool!"
    end
    return result
end

# call functions:
result1 = mysqrt_pos(4, 3)
println("result1 = $result1")
# mysqrt_pos(4, add = 3) is not valid

result2 = mysqrt_kwd(4, add=3)
println("result2 = $result2")
# mysqrt_kwd(4, 3) is not valid