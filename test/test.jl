module SquarenessTest

using Squareness
using Test

@testset "Bool" begin
    @test issquare(false)
    @test issquare(true)
end

@testset "Int8" begin
    @testset "is a square" begin
        dataset_sq_i8 = Int8[i^2 for i=0:11]
        @test all(issquare, dataset_sq_i8)
    end

    @testset "is not a square" begin
        dataset_nosq_i8 = setdiff(typemin(Int8):typemax(Int8), Int8[i^2 for i=0:11])
        @test all(!issquare, dataset_nosq_i8)
    end
end

@testset "UInt8" begin
    @testset "is a square" begin
        dataset_sq_ui8 = UInt8[i^2 for i=0:15]
        @test all(issquare, dataset_sq_ui8)
    end

    @testset "is not a square" begin
        dataset_nosq_ui8 = setdiff(typemin(UInt8):typemax(UInt8), UInt8[i^2 for i=0:15])
        @test all(!issquare, dataset_nosq_ui8)
    end
end

@testset "Int16" begin
    @testset "is a square" begin
        dataset_sq_i16 = Int16[i^2 for i=0:181]
        @test all(issquare, dataset_sq_i16)
    end

    @testset "is not a square" begin
        dataset_nosq_i16 = setdiff(typemin(Int16):typemax(Int16), Int16[i^2 for i=0:181])
        @test all(!issquare, dataset_nosq_i16)
    end
end

@testset "UInt16" begin
    @testset "is a square" begin
        dataset_sq_ui16 = UInt16[i^2 for i=0:255]
        @test all(issquare, dataset_sq_ui16)
    end

    @testset "is not a square" begin
        dataset_nosq_ui16 = setdiff(typemin(UInt16):typemax(UInt16), UInt16[i^2 for i=0:255])
        @test all(!issquare, dataset_nosq_ui16)
    end
end

@testset "Int32" begin
    @testset "is a square" begin
        dataset_sq_i32 = Int32[i^2 for i=0:46340]
        @test all(issquare, dataset_sq_i32)
    end

    @testset "is not a square" begin
        # dataset_nosq_i32 = setdiff(typemin(Int32):typemax(Int32), Int32[i^2 for i=0:46340])
        dataset_nosq_i32 = setdiff(rand(Int32, 1000000), Int32[i^2 for i=0:46340])
        @test all(!issquare, dataset_nosq_i32)
    end
end

@testset "UInt32" begin
    @testset "is a square" begin
        dataset_sq_ui32 = UInt32[i^2 for i=0:65535]
        @test all(issquare, dataset_sq_ui32)
    end

    @testset "is not a square" begin
        # dataset_nosq_ui32 = setdiff(typemin(UInt32):typemax(UInt32), UInt32[i^2 for i=0:65535])
        dataset_nosq_ui32 = setdiff(rand(UInt32, 1000000), UInt32[i^2 for i=0:65535])
        @test all(!issquare, dataset_nosq_ui32)
    end
end

@testset "Int64" begin
    @testset "is a square" begin
        # dataset_sq_i64 = Int64[i^2 for i=0:3037000499]
        dataset_sq_i64 = Int64[i^2 for i in rand(0:3037000499, 1000000)]
        @test all(issquare, dataset_sq_i64)
    end

    @testset "random (may not be a square)" begin
        dataset_random_i64 = rand(Int64, 1000000)
        @test all(@.(issquare(dataset_random_i64) == Squareness.issquare_with_isqrt(dataset_random_i64)))
    end
end

@testset "UInt64" begin
    @testset "is a square" begin
        # dataset_sq_ui64 = UInt64[i^2 for i=0:4294967295]
        dataset_sq_ui64 = UInt64[i^2 for i in rand(UInt64(0):UInt64(4294967295), 1000000)]
        @test all(issquare, dataset_sq_ui64)
    end

    @testset "random (may not be a square)" begin
        dataset_random_ui64 = rand(UInt64, 1000000)
        @test all(@.(issquare(dataset_random_ui64) == Squareness.issquare_with_isqrt(dataset_random_ui64)))
    end
end

@testset "Int128" begin
    @testset "is a square" begin
        # dataset_sq_i128 = Int128[i^2 for i=0:13043817825332782212]
        dataset_sq_i128 = Int128[i^2 for i in rand(int128"0":int128"13043817825332782212", 1000000)]
        @test all(issquare, dataset_sq_i128)
    end

    @testset "random (may not be a square)" begin
        dataset_random_i128 = rand(Int128, 1000000)
        @test all(@.(issquare(dataset_random_i128) == Squareness.issquare_with_isqrt(dataset_random_i128)))
    end
end

@testset "UInt128" begin
    @testset "is a square" begin
        # dataset_sq_ui128 = UInt128[i^2 for i=0:18446744073709551615]
        dataset_sq_ui128 = UInt128[i^2 for i in rand(uint128"0":uint128"18446744073709551615", 1000000)]
        @test all(issquare, dataset_sq_ui128)
    end

    @testset "random (may not be a square)" begin
        dataset_random_ui128 = rand(UInt128, 1000000)
        @test all(@.(issquare(dataset_random_ui128) == Squareness.issquare_with_isqrt(dataset_random_ui128)))
    end
end

@testset "BigInt" begin
    @testset "is a square" begin
        dataset_sq_mpz = BigInt[i^2 for i in (big.(rand(UInt128, 10000)) .<< 128 .+ rand(UInt128, 10000))]
        @test all(issquare, dataset_sq_mpz)
    end

    @testset "random (may not be a square)" begin
        dataset_random_mpz = big.(rand(Int128, 10000)) .<< 128 .+ rand(Int128, 10000)
        @test all(@.(issquare(dataset_random_mpz) == Squareness.issquare_with_isqrt(dataset_random_mpz)))
    end
end

end