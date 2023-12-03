include("./part1.jl")
include("./part2.jl")

using Printf
using .Part1
using .Part2

function do_part1()
    limits::Dict{String, Int} = Dict("red"=>12, "green"=>13, "blue"=>14)
    answer = Part1.compute(ARGS[1], limits)
    @printf("Day 2 Part 1 : %d\n", answer)
end

function do_part2()
    answer = Part2.compute(ARGS[1])
    @printf("Day 2 Part 2 : %d\n", answer)
end

function main()
    do_part1()
    do_part2()
end

main()
