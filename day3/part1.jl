module Part1

export compute, Answer

mutable struct Number
    value::Int
    const coords::Vector{Int}
    length::Int
    is_valid::Bool
    is_gear::Bool
end

mutable struct Clues
    all_parts::Vector{Number}
    all_symbols::Vector{Int}
    all_gears::Vector{Int}
    width::Int
    height::Int
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
        Vector{Vector{Int}}[], # all symbols
        Vector{Vector{Int}}[], # all gears
        length(lines),
        length(lines[1])
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
                    length(number_str),
                    false, # part 1
                    false  # part 2
                )
                push!(out.all_parts, number)
            end
            if current_char == '.' # skip
                number_str = ""
                cursor += 1
                number_start = cursor
            else # for symbol
                if current_char == '*'
                    push!(out.all_gears, line_num, cursor)
                end
                push!(out.all_symbols, line_num, cursor)
                number_str = ""
                cursor += 1
                number_start = cursor
            end
        end
    end
    return out
end

function not_bounds(idx::Int, lim::Int)::Bool
    return idx < 1 || idx > lim
end

function search_around(x::Int, y::Int, dim_x::Int, dim_y::Int)::Vector{Int}
    out = Vector{Int}([])
    for i in y-1:y+1
        if not_bounds(i, dim_y)
            continue
        end
        for j in x-1:x+1
            if not_bounds(j, dim_x) || (i==y && j==x)
                continue
            end
            push!(out, i, j)
        end
    end
    return out
end

function check_parts(x::Int, y::Int, part::Number)::Bool
    for i in 0:part.length-1
        if (y,x) == (part.coords[1], part.coords[2]+i)
            return true
        end
    end
    return false
end

function check_parts2(x::Int, y::Int, part::Number)::Int
    for i in 0:part.length-1
        if (y,x) == (part.coords[1], part.coords[2]+i)
            return 1
        end
    end
    return 0
end

function get_valid_parts(state::Clues)
    for i in 1:Int(length(state.all_symbols)/2)
        # current symbol coords
        current_symbol_x = state.all_symbols[2*i-1]
        current_symbol_y = state.all_symbols[2*i]
        # current symbol search coords
        check_coords::Vector{Int} = search_around(current_symbol_x,
                                                  current_symbol_y,
                                                  state.width,
                                                  state.height)
        # looping current symbol coords
        for j in 1:Int(length(check_coords)/2)
            check_x = check_coords[2*j-1]
            check_y = check_coords[2*j]
            for part in state.all_parts
                if part.is_valid
                    continue
                end
                part.is_valid = check_parts(check_x, check_y, part)
            end
        end
    end
end
 
function get_valid_gears(state::Clues)::Int
    out::Int = 0
    for i in 1:Int(length(state.all_gears)/2)
        # current symbol coords
        current_gear_x = state.all_gears[2*i-1]
        current_gear_y = state.all_gears[2*i]
        # current symbol search coords
        check_coords::Vector{Int} = search_around(current_gear_x,
                                                  current_gear_y,
                                                  state.width,
                                                  state.height)
        # looping current symbol coords
        gear::Int = 0
        gear_ratio = 1
        for j in 1:Int(length(check_coords)/2)
            check_x = check_coords[2*j-1]
            check_y = check_coords[2*j]
            for part in state.all_parts
                if check_parts(check_x, check_y, part)
                    gear += 1
                    gear_ratio *= part.value
                end
            end
            if gear > 1
                out += gear_ratio
                gear = 0
                gear_ratio = 1
            end
        end
    end
    return out
end

struct Answer
    part1::Int
    part2::Int
end

function compute(filename::String)::Answer
    part1_ans::Int = 0
    lines = parse_file(filename)
    figures::Clues = get_coords(lines)
    get_valid_parts(figures)
    part2_ans::Int = get_valid_gears(figures)
    for part in figures.all_parts
        if part.is_valid
            # println(part.value)
            part1_ans += part.value
        end
    end
    return Answer(part1_ans, part2_ans)
end

end
