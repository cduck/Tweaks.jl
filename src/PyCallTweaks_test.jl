using PyCall
using Tweaks


py"""
class X:
    def __str__(self): return 'Y'
"""

@testset "print" begin
    buf = IOBuffer()
    println(buf, py"X()")
    seek(buf, 0)
    @test read(buf, String) == "Y\n"
end

@testset "string" begin
    @test string(py"X()") == "Y"
end
