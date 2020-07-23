# Tweaks.jl

Convenient tweaks and additions to various [Julia](https://julialang.org/) packages.
Also bits of generally useful code.


## Install

Install Tweaks with Julia's package manager:
```bash
julia -e 'using Pkg; Pkg.add("https://github.com/cduck/Tweaks.jl")'
```


## Examples

#### BiMaps
```julia
using Tweaks.BiMaps

map = BiMap('a'=>1, 'b'=>2)
@assert map['a'] == 1
@assert rev(map)[2] = 'b'
@assert haskey(map, 'a')
@assert hasval(map, 1)
@assert getkey(map, 'c', 'x') == 'x'
@assert getval(map, 3, 99) = 99
```

#### Graphs
```julia
using MetaGraphs
using Tweaks

g = MetaGraph(5)

get_weight(g, 2, 3, -1)
get_weight(g, Edge(2, 3), -1)
get_weight(g, 2)

for src, dst in edges(g)
    # ...
end

g  # Show in Jupyter notebook
```

#### Base
```julia
minelem = argmin(-5:5) do i
    i^2
end
@assert minelem == 0
```

#### PyCall
```julia
py"""
class X:
    def __str__(self): return 'X'
"""
@assert string(py"X()") == "X"
```
