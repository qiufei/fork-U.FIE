########################################################################
# Project X:
# "The Ultimate Question of Life, the Universe, and Everything"
# Project Collaborators: Mr. H, Mr. B
#
# Julia Script "ultimate-calcs"
# by: F Heiss
# Date of this version: December 1, 2022
########################################################################
# load packages:
using Dates

# create a time stamp:
ts = now()

# print to logfile.txt (write=true resets the logfile before writing output)
# in the provided path (make sure that the folder structure
# you may provide already exists):
open("Jlout/19/logfile.txt", write=true) do io
    println(io, "This is a log file from: \n $ts\n")
end

# the first calculation using the square root function:
result1 = sqrt(1764)
# print to logfile.txt but with keeping the previous results (append=true):
open("Jlout/19/logfile.txt", append=true) do io
    println(io, "result1: $result1\n")
end

# the second calculation reverses the first one:
result2 = result1^2
# print to logfile.txt but with keeping the previous results (append=true):
open("Jlout/19/logfile.txt", append=true) do io
    println(io, "result2: $result2")
end