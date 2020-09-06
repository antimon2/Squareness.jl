# using Squareness
using Test

tests = ("test",)
# tests = ("test", "benchmark")

for test in tests
    @testset "$test" begin
        include(joinpath(@__DIR__, "$(test).jl"))
    end
end