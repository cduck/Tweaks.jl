module Plot

import PyPlot; plt = PyPlot
plt.svg(true)

export plt, make_bar_plot


"""
    make_bar_plot(lookup_value, groups, keys; ...)

Create a bar plot.

# Examples

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
```julia
fig, ax = make_bar_plot(
    ["A"=>1, "B"=>2, "C"=>3, "D"=>4, "E"=>5], [1, 2, 3, 4, 5],
    label_rotation=45, label_anchor="right",
) do group, key
    group * key
end
ax.set_title("...")
ax.set_xlabel("...")
ax.set_ylabel("...")
```
"""
function make_bar_plot(lookup_value::Function, groups, keys;
                       colors=nothing, ax=nothing, width::Real=0.7,
                       gap::Real=0.2, label_rotation::Real=0.0,
                       label_anchor=nothing)
    n_groups = length(groups)
    n_bars = length(keys)
    width /= n_bars
    gap /= n_bars
    step = width + gap
    x_arr = collect(1:n_groups)
    offset = -(step * (n_bars+1)) / 2

    if ax === nothing
        fig, ax = plt.subplots()
    else
        fig = nothing
    end

    for (i, key) in enumerate(keys)
        key_str, key = (key isa Pair ? (string(key[1]), key[2])
                        : (string(key), key))
        vals = [lookup_value(g isa Pair ? g[2] : g, key) for g in groups]
        c = colors !== nothing && i <= length(colors) ? colors[i] : nothing
        ax.bar(x_arr .+ (offset + i*step), vals, width, color=c, label=key_str)
    end

    ax.set_xticks(collect(1:n_groups))
    ax.set_xticklabels([string(g isa Pair ? g[1] : g) for g in groups],
                       rotation=label_rotation, ha=label_anchor)
    ax.legend()
    fig === nothing ? nothing : (fig, ax)
end


end
