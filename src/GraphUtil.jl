module GraphUtil

using LightGraphs
using GraphPlot
using MetaGraphs

import Base.show

export get_weight


struct _Raise end
_raise = _Raise()

"""
    get_weight(graph, vertex)
    get_weight(graph, edge, [nonexistent])
    get_weight(graph, src, dst, [nonexistent])

Return a vertex or edge weight of a ``MetaGraph``.

If `nonexistent` is specified, it will be returned when a missing edge is
queried.  Otherwise a ``KeyError`` is raised.
"""
function get_weight end

function get_weight(g, s, d, nonexistent=_raise)
    get_weight(g, Edge(s, d), nonexistent)
end

function get_weight(g, e::AbstractEdge, nonexistent=_raise)
    if !has_edge(g, e)
        nonexistent === _raise && throw(KeyError("$e does not exist"))
        nonexistent
    elseif has_prop(g, e, :weight)
        get_prop(g, e, :weight)
    else
        defaultweight(g)
    end
end

function get_weight(g, v)
    if has_prop(g, v, :weight)
        get_prop(g, v, :weight)
    else
        defaultweight(g)
    end
end

"""
Expand `Edge` like a tuple: `x, y = Edge(1, 2)`.
"""
Base.iterate(edge::Edge) = edge.src, false
Base.iterate(edge::Edge, done::Bool) = done ? nothing : edge.dst, true

"""
Draw graphs directly as SVG without typing gplot(g, ...).
"""
function show(io, mime::MIME"image/svg+xml", g::AbstractGraph)
    length(g) > 0 || throw(ArgumentError)
    context = gplot(g, nodelabel=1:nv(g))
    show(io, mime, context)
end

function show(io, mime::MIME"image/svg+xml", g::MetaGraph)
    length(g) > 0 || throw(ArgumentError)
    w = weights(g)
    edgelabel = [
        get_weight(g, edge)
        for edge in edges(g)
    ]
    context = gplot(g, nodelabel=1:nv(g), edgelabel=edgelabel)
    show(io, mime, context)
end


end
