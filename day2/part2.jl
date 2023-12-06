module Part2

export compute

function parse_file(filename::String)::Vector{String}
    file = open(filename)
    lines = Vector{String}()
    for line in readlines(file)
        push!(lines, line)
    end
    close(file)
    return lines
end

function extract_gameinfo(filename::String)::Vector{Vector{String}}
    lines = parse_file(filename)
    out = Vector{Vector{String}}()
    pattern = Regex("[0-9]+|red|green|blue")
    for line in lines
        result = [match.match for match in eachmatch(pattern, line)]
        push!(out, result)
    end
    return out
end

function find_power(game::Vector{String})::Int
    picks = game[2:end]
    iter_length::Int = length(picks)/2
    mins::Dict{String, Int} = Dict("red"=>0, "green"=>0, "blue"=>0)
    for i in 1:iter_length
        number = parse(Int, picks[2*i-1])
        value = picks[2*i]
        if number > mins[value]
            mins[value] = number
        end
    end
    return mins["red"] * mins["green"] * mins["blue"]
end

function compute(filename::String)::Int
    games::Vector{Vector{String}} = extract_gameinfo(filename)
    sum = 0
    for game in games
        sum += find_power(game)
    end
    return sum
end

end
