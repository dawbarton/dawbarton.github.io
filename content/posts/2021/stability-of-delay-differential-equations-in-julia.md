---
title: "Stability of delay differential equations (DDEs) in Julia"
description: "Another in my series of 'try not to implement it yet again', this time on how to calculate the stability of (linearised) delay differential equations."
date: 2021-06-30
tags: ["julia", "mathematics"]
math: true
---

My PhD was on the topic of delay differential equations (DDEs) and, at the time, I wrote lots of utilities to do things like calculate the stability of linearised equations. All that code has been lost to the mists of time but I still have call for it every now and again (e.g., for real-time dynamic substructuring where I need to model the delays in the control loop).

Here is some code in Julia that calculates the stability of a DDE in the form

$$
x'(t) = Ax(t) + Bx(t-\tau)
$$

where $A$ and $B$ can be (square) matrices, i.e., systems of DDEs. If you've got a nonlinear model, you just need to linearise around an equilibrium first.

The algorithm implemented is that of *Pseudospectral Differencing Methods for Characteristic Roots of Delay Differential Equations*; D. Breda, S. Maset, and R. Vermiglio, SIAM Journal on Scientific Computing 2005 27:2, 482-495. It has the property that it approximates the characteristic roots of the DDE closest to the origin best.

```julia
using LinearAlgebra

"""
    cheb_mesh(T::Type, N::Integer)
    cheb_mesh(N::Integer)

Return the Chebyshev nodes of degree `N` on the interval [0, 1].
"""
cheb_mesh(T::Type, N::Integer) = (-cos.((T(π) * (0:N)) ./ N) .+ 1) ./ 2
cheb_mesh(N::Integer) = cheb_mesh(Float64, N)

"""
    cheb(T::Type, N::Integer)
    cheb(N::Integer)

Return a tuple `(x, D)` where `x` contains the Chebyshev nodes of degree `N` on the interval
[0, 1] using the numerical type `T` and `D` is the Chebyshev differentiation matrix on the
same interval.

## Example - differentiate a sinusoid

    julia> (x, D) = cheb(10) ;

    julia> D * sinpi.(x) ≈ π * cospi.(x)
    true
"""
function cheb(T::Type, N::Integer)
    if N == 0
        return (ones(T, 1), zeros(T, 1, 1))
    else
        x = cheb_mesh(T, N)
        c = [2; ones(T, N - 1, 1); 2] .* (-1) .^ (0:N)
        dx = x .- x'
        D = (c * (1 ./ c)') ./ (dx + I)
        D[diagind(D)] .-= vec(sum(D; dims=2))
        return (x, D)
    end
end
cheb(N::Integer) = cheb(Float64, N)

"""
    dde_stability(A, B, τ; N=10)

Calculate (a finite number of) the characteristic roots of the linear delay differential
equation

    x'(t) = Ax(t) + Bx(t-τ)

where `A` and `B` can be (square) matrices. `N` controls the order of the Chebyshev
polynomial approximation to the infinitesimal generator; higher values of `N` result in a
more accurate approximation. A property of the algorithm used is that characteristic roots
closest to the origin are approximated best.

## Reference

Pseudospectral Differencing Methods for Characteristic Roots of Delay Differential
Equations; D. Breda, S. Maset, and R. Vermiglio, SIAM Journal on Scientific Computing 2005
27:2, 482-495
"""
function dde_stability(A, B, τ; N=10)
    @assert size(A) == size(B)
    @assert size(A, 1) == size(A, 2)
    T = eltype(A) == Int ? Float64 : eltype(A)
    n = size(A, 1)
    (x, D) = cheb(T, N)
    M = kron(-D, Matrix(I / convert(T, τ), n, n))
    M[1:n, 1:n] .= A
    M[1:n, (n + 1):(end - n)] .= 0
    M[1:n, (end - n + 1):end] .= B
    return eigen(M)
end

# Tests
# 1. x'(t) = 2x(t) - exp(1)*x(t - 1) has a double root at λ = 1
# 2. x'(t) = -x(t - τ) goes unstable at τ=π/2
# 3. x'(t) = α*A*x(t) + (1-α)*A*x(t-τ)
#    A = [
#          50  284   41   23   50   32
#        -280  -46  -19  -37  -10  -28
#          35   -1   26  143   35   17
#          5   -31 -139  -22    5  -13
#          20  -16   11   -7 -115  137
#         -10  -46  -19  -37 -145 -163
#    ]
#    with α=0.9 is stable for 3π/(270*(2*0.9 - 1)) ≤ τ ≤ 4π/270
#    that is 0.04363323129985824 ≤ τ ≤ 0.046542113386515455
```
