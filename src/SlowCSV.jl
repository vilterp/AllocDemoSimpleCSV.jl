module SlowCSV

function serialize(rows::Vector{Vector{T}}) where T
    output = ""
    for row in rows
        for col_idx in 1:length(row)
            val = row[col_idx]
            output = output * string(val)
            if col_idx < length(row)
                output = output * ","
            end
        end
        output = output * "\n"
    end
    return output
end

end # module
