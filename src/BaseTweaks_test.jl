using Tweaks


@testset "argmin" begin
    minelem = argmin(-5:5) do i
        i^2
    end
    @test minelem == 0
end
