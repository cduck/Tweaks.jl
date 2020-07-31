module Plot

import PyPlot; plt = PyPlot
plt.svg(true)

export plt, make_bar_plot


"""
    make_bar_plot(lookup_value, groups, keys)

Create a bar plot.

# Example

```julia
fig, ax = make_bar_plot(
    ["A", "B", "C", "D", "E"], ["1", "2", "3", "4"],
) do group, key
    rand()
end
ax.set_title("...")
ax.set_xlabel("...")
ax.set_ylabel("...")
```
"""
function make_bar_plot(lookup_value::Function, groups, keys;
                       colors=nothing, ax=nothing)
    n_groups = length(groups)
    n_bars = length(keys)
    width = 0.35 * 2 / n_bars
    gap = 0.1 * 2 / n_bars
    step = width + gap
    x_arr = collect(1:n_groups)
    offset = -(step * (n_bars+1)) / 2

    if ax === nothing
        fig, ax = plt.subplots()
    else
        fig = nothing
    end

    for (i, key) in enumerate(keys)
        vals = [lookup_value(group, key) for group in groups]
        c = colors !== nothing && i <= length(colors) ? colors[i] : nothing
        ax.bar(x_arr .+ (offset + i*step), vals, width, color=c, label=key)
    end

    ax.set_xticks(collect(1:n_groups))
    ax.set_xticklabels(groups)
    ax.legend()
    fig === nothing ? nothing : (fig, ax)
end


end
