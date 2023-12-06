module Part1

export compute

mutable struct Number
    value::Int
    const coords::Vector{Int}
    length::Int
end

mutable struct Clues
    all_parts::Vector{Number}
    all_symbols::Vector{Int}
end

function parse_file(filename::String)::Vector{String}
    file = open(filename)
    lines = Vector{String}()
    for line in readlines(file)
        push!(lines, line)
    end
    close(file)
    return lines
end

function get_coords(lines::Vector{String})::Clues
    out_parts::Vector{Number} = []
    out::Clues = Clues(
        out_parts,
        Vector{Vector{Int}}[]
    )
    for (line_num, line) in enumerate(lines)
        cursor = 1
        number_start = 1
        number_str = ""
        while cursor <= length(line)
            current_char = line[cursor]
            if isnumeric(current_char)
                number_str *= current_char
                cursor += 1
                continue
            end
            if length(number_str) > 0
                number::Number = Number(
                    parse(Int, number_str),
                    Vector{Int}([line_num, number_start]),
                    length(number_str)
                )
                push!(out.all_parts, number)
            end
            if current_char == '.' # skip
                number_str = ""
                cursor += 1
                number_start = cursor
            else # for symbol
                # push!(out.all_symbols, Vector{Int}([line_num, cursor]))
                push!(out.all_symbols, line_num, cursor)
                number_str = ""
                cursor += 1
                number_start = cursor
            end
        end
    end
    return out
end

function compute(filename::String)
    lines = parse_file(filename)
    figures = get_coords(lines)
    println(figures.all_parts)
    println(figures.all_symbols)
end

end
