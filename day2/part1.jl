module Part1

using Base: RegexMatchIterator
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

function is_possible(game::Vector{String}, limits::Dict{String, Int})::Int
    id = parse(Int, game[1])
    picks = game[2:end]
    iter_length::Int = length(picks)/2
    for i in 1:iter_length
        number = parse(Int, picks[2*i-1])
        value = picks[2*i]
        if number > limits[value]
            return 0
        end
    end
    return id
end

function compute(filename::String, limits::Dict{String, Int})::Int
    games = extract_gameinfo(filename)
    sum = 0
    for game in games
        sum += is_possible(game, limits)
    end
    return sum
end

end
