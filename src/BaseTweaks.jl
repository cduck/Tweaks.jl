module BaseTweaks

import Base: show, print, argmin


"""
Return the element of `itr` with the minimum result of `f(itr)`.

If two elements result in the same value, the tie is broken by choosing the
one generated first by `itr`.
"""
function argmin(f::Function, itr)
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


end
