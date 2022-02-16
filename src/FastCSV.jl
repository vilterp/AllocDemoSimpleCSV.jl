module FastCSV

function serialize(io::IO, rows::Vector{Vector{T}}) where T
    for row in rows
        for col_idx in 1:length(row)
            val = row[col_idx]
            print(io, val)
            if col_idx < length(row)
                print(io, ",")
            end
        end
        print(io, "\n")
    end
end

function serialize(rows::Vector{Vector{T}}) where T
    io = IOBuffer()
    serialize(io, rows)
    return String(take!(io))
end

end # module
