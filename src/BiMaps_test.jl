using Tweaks.BiMaps


@testset "init" begin
    map = BiMap(Dict('a'=>1, 'b'=>2), Dict(1=>'a', 2=>'b'))
    @test Dict(map) == Dict('a'=>1, 'b'=>2)
    @test Dict(rev(map)) == Dict(1=>'a', 2=>'b')

    map = BiMap(Dict('a'=>1, 'b'=>2))
    @test Dict(map) == Dict('a'=>1, 'b'=>2)
    @test Dict(rev(map)) == Dict(1=>'a', 2=>'b')

    map = BiMap('a'=>1, 'b'=>2)
    @test Dict(map) == Dict('a'=>1, 'b'=>2)
    @test Dict(rev(map)) == Dict(1=>'a', 2=>'b')
end

@testset "rev" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test map == rev(rev(map))
end

@testset "length" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test length(map) == 2
end
@testset "iterate" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test sort(collect(map)) == ['a'=>1, 'b'=>2]
end
@testset "getindex" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test map['a'] == 1
end
@testset "setindex" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test (map['b'] = 99) == 99
    @test map['b'] == 99
    @test rev(map)[99] == 'b'
end
@testset "haskey" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test haskey(map, 'a')
    @test !haskey(map, 'z')
end
@testset "get" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test get(map, 'a', 5) == 1
    @test get(map, 'z', 5) == 5
end
@testset "get_do" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test get(map, 'a') do; 5 end == 1
    @test get(map, 'z') do; 5 end == 5
end
@testset "get!" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test get!(map, 'a', 5) == 1
    @test get!(map, 'z', 5) == 5
    @test map['z'] == 5
    @test rev(map)[5] == 'z'
end
@testset "get!_do" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test get!(map, 'a') do; 5 end == 1
    @test get!(map, 'z') do; 5 end == 5
    @test map['z'] == 5
    @test rev(map)[5] == 'z'
end
@testset "getkey" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test getkey(map, 'a', 'T') == 'a'
    @test getkey(map, 'z', 'T') == 'T'
end
@testset "delete!" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test delete!(map, 'a') === map
    @test !haskey(map, 'a')
    @test !haskey(rev(map), 1)
end
@testset "pop!_default" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test pop!(map, 'b', 99) == 2
    @test !haskey(map, 'b')
    @test !haskey(rev(map), 2)
    @test pop!(map, 'b', 100) == 100
end
@testset "pop!" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test pop!(map, 'b') == 2
    @test !haskey(map, 'b')
    @test !haskey(rev(map), 2)
    @test_throws KeyError pop!(map, 'b')
end
@testset "keys" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test sort!(collect(keys(map))) == ['a', 'b']
end
@testset "values" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test sort!(collect(values(map))) == [1, 2]
end
@testset "pairs" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test sort!(collect(pairs(map))) == ['a'=>1, 'b'=>2]
end
@testset "sizehint!" begin
    map = BiMap('a'=>1, 'b'=>2)
    sizehint!(map, 20)
    # Nothing to test
end
@testset "keytype" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test keytype(map) == Char
end
@testset "valtype" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test valtype(map) == Int
end
@testset "hasval" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test hasval(map, 1)
    @test !hasval(map, 99)
end
@testset "getval" begin
    map = BiMap('a'=>1, 'b'=>2)
    @test getval(map, 2, 99) == 2
    @test getval(map, 9, 99) == 99
end
