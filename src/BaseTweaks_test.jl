using Tweaks


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
