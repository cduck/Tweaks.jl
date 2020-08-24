module Plot

import PyPlot; plt = PyPlot
plt.svg(true)
using PyCall

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
                       colors=nothing, patterns=nothing, ax=nothing,
                       width::Real=0.7, gap::Real=0.2, label_rotation::Real=0.0,
                       label_anchor=nothing)
    is_latex = ax isa PyObject && startswith(ax.__module__, "latextools")

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

    group_strs = [g isa Pair ? g[1] : string(g) for g in groups]
    groups = [g isa Pair ? g[2] : g for g in groups]
    for (i, key) in enumerate(keys)
        key_str, key = (key isa Pair ? (key[1], key[2])
                        : (string(key), key))
        vals = [lookup_value(g isa Pair ? g[2] : g, key) for g in groups]
        c = colors !== nothing && i <= length(colors) ? colors[i] : nothing
        p = (patterns !== nothing && i <= length(patterns)
             ? patterns[i] : nothing)
        if is_latex
            ax.bar(group_strs, vals, color=c, pattern=p, legend=key_str,
                   extra_config="pattern color=$c,")
        else
            ax.bar(x_arr .+ (offset + i*step), vals, width, color=c,
                   label=key_str)
        end
    end

    if !is_latex
        ax.set_xticks(collect(1:n_groups))
        ax.set_xticklabels(group_strs, rotation=label_rotation, ha=label_anchor)
        ax.legend()
    end
    fig === nothing ? nothing : (fig, ax)
end


end
