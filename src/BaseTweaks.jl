module BaseTweaks

export totuple, @tuple


"""
    append!(dict, iter)

Update the dictionary with the new key-value pairs in the list or iterator.
"""
function Base.append!(dict::Dict, iter)
    for (k, v) in iter
        dict[k] = v
    end
end


"""
    argmin(f::Function, itr)

Return the element of `itr` with the minimum result of `f(itr)`.

If two elements result in the same value, the tie is broken by choosing the
one generated first by `itr`.
"""
function Base.argmin(f::Function, itr)
    next = iterate(itr)
    next === nothing && throw(ArgumentError("collection must be non-empty"))
    minelem = next[1]
    minval = f(next[1])
    next = iterate(itr, next[2])
    while next !== nothing
        val = f(next[1])
        if isless(val, minval)
            minelem, minval = next[1], val
        end
        next = iterate(itr, next[2])
    end
    minelem
end


"""
    argmax(f::Function, itr)

Return the element of `itr` with the maximum result of `f(itr)`.

If two elements result in the same value, the tie is broken by choosing the
one generated first by `itr`.
"""
function Base.argmax(f::Function, itr)
    next = iterate(itr)
    next === nothing && throw(ArgumentError("collection must be non-empty"))
    maxelem = next[1]
    maxval = f(next[1])
    next = iterate(itr, next[2])
    while next !== nothing
        val = f(next[1])
        if isless(maxval, val)
            maxelem, maxval = next[1], val
        end
        next = iterate(itr, next[2])
    end
    maxelem
end


"""
    totuple(itr)

Convert an iterator into a tuple.
"""
totuple(itr::Tuple) = itr
totuple(itr) = (itr...,)

"""
    @tuple itr

Convert an iterator into a tuple.
"""
macro tuple(expr)
    :($(esc(expr))...,)
end


end
