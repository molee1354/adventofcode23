include("./part1.jl")

using Printf
using .Part1

function do_part1()
    Part1.compute(ARGS[1])
end


function main()
    do_part1()
end

main()
