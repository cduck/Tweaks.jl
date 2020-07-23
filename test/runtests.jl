using Test

@testset "Tweaks.jl" begin
    # Run all test in src/*_test.jl
    cd(joinpath(@__DIR__, ".."))
    for (root, dirs, files) in walkdir("src")
        for file in files
            endswith(file, "_test.jl") || continue
            fpath = joinpath(root, file)
            @testset "$fpath" begin
                include(joinpath("..", fpath))
            end
        end
    end
end
