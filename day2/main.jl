include("./part1.jl")

using .Part1

function do_part1()
    limits::Dict{String, Int} = Dict("red"=>12, "green"=>13, "blue"=>14)
    answer = Part1.compute(ARGS[1], limits)
    println(answer)
end

function do_part2()
end

function main()
    do_part1()
end

main()
