module SquarenessBenchmark

import Squareness
using Squareness: issquare_with_isqrt
using BenchmarkTools

issquare_with_padic_newton(n::Signed) = n < 0 ? false : Squareness.issquare_with_padic_newton(n % Unsigned)
# issquare_with_padic_newton(n::Unsigned) = Squareness.issquare_with_padic_newton(n)
issquare_with_padic_newton(n::BigInt) = n < 0 ? false : Squareness.issquare_with_padic_newton(n)

function _issquare_with_simple_newton(x::I) where {I <: Integer}
    x == 0 && return true
    xtz = trailing_zeros(x)
    isodd(xtz) && return false
    x >>= unsigned(xtz)
    o_xrt::I = x
    xrt::I = (x + 0x1) >> 0x1
    xrt == 0 && return false  # overflow
    while xrt < o_xrt
        o_xrt = xrt
        xrt = (xrt + x ÷ xrt) >> 0x1
    end
    xrt * xrt == x
end
issquare_with_simple_newton(x::Signed) = x < 0 ? false : _issquare_with_simple_newton(x % Unsigned)
# issquare_with_simple_newton(x::Unsigned) = _issquare_with_simple_newton(x)
issquare_with_simple_newton(x::BigInt) = x < 0 ? false : _issquare_with_simple_newton(x)

println("## Int64 ≥ 0\n")

rand_int64() = rand(Int64) & typemax(Int64)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_int64()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_int64()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_int64()))
println("\n```\n\n")

println("## Int64 ≥ 0 × 100\n")

rand_int64(N) = rand(Int64, N) .& typemax(Int64)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton.(n) setup=(n=rand_int64(100)))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt.(n) setup=(n=rand_int64(100)))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton.(n) setup=(n=rand_int64(100)))
println("\n```\n\n")

println("## Int32 ≥ 0\n")

rand_int32() = rand(Int32) & typemax(Int32)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_int32()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_int32()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_int32()))
println("\n```\n\n")

println("## Int32 ≥ 0 × 100\n")

rand_int32(N) = rand(Int32, N) .& typemax(Int32)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton.(n) setup=(n=rand_int32(100)))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt.(n) setup=(n=rand_int32(100)))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton.(n) setup=(n=rand_int32(100)))
println("\n```\n\n")

println("## Int16 ≥ 0\n")

rand_int16() = rand(Int16) & typemax(Int16)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_int16()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_int16()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_int16()))
println("\n```\n\n")

println("## Int16 ≥ 0 × 100\n")

rand_int16(N) = rand(Int16, N) .& typemax(Int16)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton.(n) setup=(n=rand_int16(100)))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt.(n) setup=(n=rand_int16(100)))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton.(n) setup=(n=rand_int16(100)))
println("\n```\n\n")

println("## Int8 ≥ 0\n")

rand_int8() = rand(Int8) & typemax(Int8)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_int8()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_int8()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_int8()))
println("\n```\n\n")

println("## Int8 ≥ 0 × 100\n")

rand_int8(N) = rand(Int8, N) .& typemax(Int8)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton.(n) setup=(n=rand_int8(100)))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt.(n) setup=(n=rand_int8(100)))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton.(n) setup=(n=rand_int8(100)))
println("\n```\n\n")

println("## Int128 ≥ 0\n")

rand_int128() = rand(Int128) & typemax(Int128)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_int128()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_int128()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_int128()))
println("\n```\n\n")

println("## Int128 ≥ 0 × 100\n")

rand_int128(N) = rand(Int128, N) .& typemax(Int128)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton.(n) setup=(n=rand_int128(100)))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt.(n) setup=(n=rand_int128(100)))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton.(n) setup=(n=rand_int128(100)))
println("\n```\n\n")

println("## BigInt ≥ 0\n")

rand_mpz() = (big(rand(UInt128)) << rand(0:128)) + rand(UInt128)

println("### P-adic Newton Method\n")
println("```")
display(@benchmark issquare_with_padic_newton(n) setup=(n=rand_mpz()))
println("\n```\n\n")

println("### With `isqrt()`\n")
println("```")
display(@benchmark issquare_with_isqrt(n) setup=(n=rand_mpz()))
println("\n```\n\n")

println("### Simple Newton Method\n")
println("```")
display(@benchmark issquare_with_simple_newton(n) setup=(n=rand_mpz()))
println("\n```\n\n")

end