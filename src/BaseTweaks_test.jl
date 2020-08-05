using Tweaks.BaseTweaks


@testset "argmin" begin
    minelem = argmin(-5:5) do i
        i^2
    end
    @test minelem == 0
end

@testset "argmax" begin
    maxelem = argmax(-5:5) do i
        -i^2
    end
    @test maxelem == 0
end

@testset "totuple" begin
    @test totuple((1, 2, 3, 4, 5)) == (1, 2, 3, 4, 5)
    @test totuple(1:5) == (1, 2, 3, 4, 5)
    @test totuple(i for i in 1:5) == (1, 2, 3, 4, 5)
    @test totuple(collect(1:5)) == (1, 2, 3, 4, 5)
end

@testset "@tuple" begin
    @test @tuple((1, 2, 3, 4, 5)) == (1, 2, 3, 4, 5)
    @test @tuple(1:5) == (1, 2, 3, 4, 5)
    @test @tuple(i for i in 1:5) == (1, 2, 3, 4, 5)
    @test @tuple(collect(1:5)) == (1, 2, 3, 4, 5)
    n = 5
    @test @tuple(i for i in 1:n) == (1, 2, 3, 4, 5)
end
