include("./part1.jl")

using .Part1

function do_part1()
    answer::Answer = Part1.compute(ARGS[1])
    println("Part 1: $(answer.part1)")
    println("Part 2: $(answer.part2)")
end


function main()
    do_part1()
end

main()
