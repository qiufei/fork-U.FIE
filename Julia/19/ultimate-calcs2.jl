# load packages:
using Dates

# create a time stamp:
ts = now()

# print to logfile2.txt (write=true resets the logfile before writing output)
# in the provided path (make sure that the folder structure
# you may provide already exists):
open("Jlout/19/logfile2.txt", write=true) do io
    println(io, "This is a log file from: \n $ts\n")

    # the first calculation using the square root function:
    result1 = sqrt(1764)
    # print to logfile2.txt:
    println(io, "result1: $result1\n")

    # the second calculation reverses the first one:
    result2 = result1^2
    # print to logfile2.txt:
    println(io, "result2: $result2")
end