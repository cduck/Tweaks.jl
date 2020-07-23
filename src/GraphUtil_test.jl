using LightGraphs
using MetaGraphs
using Tweaks.GraphUtil


@testset "edge_weight" begin
    g = MetaGraph(5, 0.5)
    @test get_weight(g, Edge(1, 2), -11) == -11
    @test get_weight(g, 1, 2, -11) == -11

    add_edge!(g, 2, 3)
    @test get_weight(g, Edge(2, 3), -11) == 0.5
    @test get_weight(g, 2, 3, -11) == 0.5

    add_edge!(g, 3, 4)
    set_prop!(g, 3, 4, :weight, 34)
    @test get_weight(g, Edge(3, 4), -11) == 34
    @test get_weight(g, 3, 4, -11) == 34
end

@testset "vertex_weight" begin
    g = MetaGraph(5, 0.5)
    @test get_weight(g, 2) == 0.5
    set_prop!(g, 3, :weight, 0.3)
    @test get_weight(g, 3) == 0.3
end

@testset "set_weight" begin
    g = MetaGraph(5, 0.5)
    add_edge!(g, 2, 3)
    set_weight!(g, 2, 3, 23)
    @test get_prop(g, 2, 3, :weight) == 23
    add_edge!(g, 3, 4)
    set_weight!(g, Edge(3, 4), 34)
    @test get_prop(g, 3, 4, :weight) == 34
    set_weight!(g, 2, 0.2)
    @test get_prop(g, 2, :weight) == 0.2
end

@testset "add_edge" begin
    g = MetaGraph(5, 0.5)
    add_edge!(g, 2, 3, 23)
    @test get_prop(g, 2, 3, :weight) == 23
    add_edge!(g, Edge(3, 4), 34)
    @test get_prop(g, 3, 4, :weight) == 34
end

@testset "iterate_edge" begin
    @test collect(Edge(1, 2)) == [1, 2]
end

@testset "show_light_graph" begin
    buf = IOBuffer()
    show(buf, MIME("image/svg+xml"), Graph(1))
    seek(buf, 0)
    @test String(read(buf, 5)) == "<?xml"
end

@testset "show_meta_graph" begin
    buf = IOBuffer()
    show(buf, MIME("image/svg+xml"), MetaGraph(1))
    seek(buf, 0)
    @test String(read(buf, 5)) == "<?xml"
end
