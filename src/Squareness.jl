module Squareness

export issquare

_num_iteration(::I) where (I <: Integer) = 10 - leading_zeros(sizeof(I) % UInt8 - 0x01)
_num_iteration(::Bool) = 0
_num_iteration(x::BigInt) = 66 - leading_zeros(sizeof(x.d) * UInt64(abs(x.size)) - 0x01)

function issquare_with_padic_newton(x::I) where {I <: Integer}
    x == 0 && return true
    xtz = trailing_zeros(x)
    isodd(xtz) && return false
    x >>= unsigned(xtz)
    y::I = 1
    N = _num_iteration(x)
    for _ in 1:N
        y = ((I(3) - y * y * x) * y) >> 0x1
    end
    xrt = x * y
    m = one(I) << (UInt(1) << N)
    if xrt & m != 0
        xrt = -xrt
    end
    xrt &= m - one(I)
    xrt * xrt == x
end

function issquare_with_isqrt(x::Integer)
    if x < 0
        false
    else
        xrt = isqrt(x)
        xrt * xrt == x
    end
end

issquare(n::Unsigned) = issquare_with_padic_newton(n)
issquare(n::Signed) = n < 0 ? false : issquare_with_padic_newton(n % Unsigned)
issquare(b::Bool) = true
# issquare(n::BigInt) = n < 0 ? false : issquare_with_padic_newton(n)
issquare(n::BigInt) = issquare_with_isqrt(n)

end # module
