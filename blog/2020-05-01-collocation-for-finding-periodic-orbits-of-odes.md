@def title = "Collocation for finding periodic orbits of ODEs"
@def published = Date(2020, 5, 1)

Every now and again I'm asked how to compute the periodic orbits of ODEs using a boundary value solver. Each time, I go looking for old code that does this and, each time, I can't find it and end up rewriting the collocation code from scratch.

This time I thought I'd put my code here so that I have a better chance of finding it again in the future!

The basic idea is to use a Fourier differentiation matrix to approximate the derivatives along the orbit and use a nonlinear solver to ensure that those derivatives match the vector field. If you want to know more about these types of spectral methods, take a look at the excellent (and short!) introduction by Trefethen in "Spectral Methods in MATLAB", SIAM 2000. If you want more detail then the magnum opus by Boyd ["Chebyshev and Fourier Spectral Methods"](http://www-personal.umich.edu/~jpboyd/BOOK_Spectral2000.html), Dover 2001 (freely available on his personal website) is also very good.

Nowadays, my preference is for coding in Julia - it's very clean and flexible. Here is the code (which could be better!).

```julia
# Released under the MIT expat license by David A.W. Barton (david.barton@bristol.ac.uk) 2020
using StaticArrays
using NLsolve
using OrdinaryDiffEq

"""
    duffing(u, p, t)

The vector field of the forced Duffing equation.
"""
duffing(u, p, t) = SVector(u[2], p.Γ*sin(p.ω*t) - 2p.ξ*u[2] - p.ωₙ^2*u[1] - p.β*u[1]^3)

"""
    fourier_diff([T=Float64,] N; order=1)

Create a Fourier differentiation matrix of the specified order with numerical type T on the
domain `x = LinRange{T}(0, 2π, N+1)[1:end-1]`.
"""
function fourier_diff(T::Type{<:Number}, N::Integer; order=1)
    D = zeros(T, N, N)
    n1 = (N - 1) ÷ 2
    n2 = N ÷ 2
    x = LinRange{T}(0, π, N+1)
    if order == 1
        for i in 2:N
            sgn = (one(T)/2 - iseven(i))
            D[i, 1] = iseven(N) ? sgn*cot(x[i]) : sgn*csc(x[i])
        end
    elseif order == 2
        D[1, 1] = iseven(N) ? -N^2*one(T)/12 - one(T)/6 : -N^2*one(T)/12 + one(T)/12
        for i in 2:N
            sgn = -(one(T)/2 - iseven(i))
            D[i, 1] = iseven(N) ? sgn*csc(x[i]).^2 : sgn*cot(x[i])*csc(x[i])
        end
    else
        error("Not implemented")
    end
    for j in 2:N
        D[1, j] = D[N, j-1]
        D[2:N, j] .= D[1:N-1, j-1]
    end
    return D
end
fourier_diff(N::Integer; kwargs...) = fourier_diff(Float64, N; kwargs...)

"""
    collocation_setup(u)

Return a data structure used internally by the `collocation!` function. `u` should be a
matrix with states down the columns and time across the rows (used for size/type information
only).
"""
function collocation_setup(u::AbstractMatrix)
    return (ndim=size(u, 1), nmesh=size(u, 2), Dt=-fourier_diff(eltype(u), size(u, 2))*2π)
end

"""
    collocation!(res, f, u, p, T, coll)

Calculate the residual of the collocation equations using a Fourier discretisation. Assumes
that a phase condition is not required (i.e., the equations are non-autonomous or the period
is known).

# Arguments
- `res`: residual (mutated)
- `f`: vector field function (expected to take the arguments (u, p, t))
- `u`: state variables along the orbit (vector)
- `p`: parameter vector passed to the vector field function
- `T`: period of oscillation
- `coll`: the output of `collocation_setup`

# Returns
- `res`: residual
"""
function collocation!(res, f, u, p, T, coll)
    # Matrix of derivatives along the orbit
    D = reshape(u, (coll.ndim, coll.nmesh))*coll.Dt
    ii = 1:coll.ndim
    for i in 1:coll.nmesh
        # Subtract the desired derivative from the actual derivative
        res[ii] .= D[ii] .- T.*f(u[ii], p, T*(i-1)/coll.nmesh)
        ii = ii .+ coll.ndim
    end
    return res
end

function example(; nmesh=20)
    p = (Γ=0.1, ω=1.0, ξ=0.05, ωₙ=1.0, β=0.1)
    # Do initial value simulation to get a reasonable starting point
    prob = ODEProblem(duffing, SVector(0.0, 0.0), (0.0, 100*2π/p.ω), p)
    odesol = solve(prob, Tsit5())
    # Refine using collocation
    t = range(0, 2π/p.ω, length=nmesh+1)[1:end-1]
    uvec = reinterpret(Float64, odesol(99*2π/p.ω .+ t).u)
    umat = reshape(uvec, (:, nmesh))
    coll = collocation_setup(umat)
    nlsol1 = nlsolve((res, u) -> collocation!(res, duffing, u, p, 2π/p.ω, coll), uvec)
    # Adjust the parameters slightly (actually quite a bit!) and correct
    p = (Γ=0.1, ω=1.1, ξ=0.05, ωₙ=1.0, β=0.1)
    nlsol2 = nlsolve((res, u) -> collocation!(res, duffing, u, p, 2π/p.ω, coll), uvec)
    return (nlsol1, nlsol2)
end

function plot_example()
    # Needs `using Plots` or similar
    nmesh = 20
    # The two solutions don't actually have the same period but normalize to [0, 2π]
    t = linspace(0, 2π, length=nmesh+1)[1:end-1]
    (sol1, sol2) = example()
    plot(t, sol1.zero[1:2:end])
    plot!(t, sol2.zero[1:2:end])
end
```

If you insist on using Matlab, the translation of the Julia code is below. Note that this uses the [`fourdif` function](https://www.math.purdue.edu/~shen7/sp_cfd/programs/dmsuite_matlab/fourdif.m) by Reddy and Weideman to generate the Fourier differentiation matrix. (Also note that this can be put in a single file called `fourier_collocation.m`.)

```matlab
function [nlsol1, nlsol2] = fourier_collocation()
% FOURIER_COLLOCATION Implement Fourier collocation for an arbitrary autonomous
% ODE. Assumes that the equations are non-autonomous or the period is known.

% Released under the MIT expat license by David A.W. Barton (david.barton@bristol.ac.uk) 2020

nmesh = 20;
p = struct('Gamma', 0.1, 'omega', 1.0, 'xi', 0.05, 'omegan', 1.0, 'beta', 0.1);
% Do initial value simulation to get a reasonable starting point
sol = ode45(@(t, u)duffing(t, u, p), [0, 100*2*pi/p.omega], [0, 0]);
% Refine using collocation
t = linspace(0, 2*pi/p.omega, nmesh+1);
t = t(1:end-1);
umat = deval(sol, 99*2*pi/p.omega + t);
uvec = umat(:);
coll = collocation_setup(umat);
nlsol1 = fsolve(@(u)collocation(@duffing, u, p, 2*pi/p.omega, coll), uvec)
% Adjust the parameters slightly (actually quite a bit!) and correct
p = struct('Gamma', 0.1, 'omega', 1.1, 'xi', 0.05, 'omegan', 1.0, 'beta', 0.1);
nlsol2 = fsolve(@(u)collocation(@duffing, u, p, 2*pi/p.omega, coll), uvec)

plot(t, nlsol1(1:2:end), 'b', t, nlsol2(1:2:end), 'r');

end

function du = duffing(t, u, p)
    du = [u(2); p.Gamma*sin(p.omega*t) - 2*p.xi*u(2) - p.omegan^2*u(1) - p.beta*u(1)^3];
end

function coll = collocation_setup(u)
    [~, D] = fourdif(size(u, 2), 1);
    coll = struct('ndim', size(u, 1), 'nmesh', size(u, 2), 'Dt', -D*2*pi);
end

function res = collocation(f, u, p, T, coll)
    % Matrix of derivatives along the orbit
    res = zeros(size(u));
    D = reshape(u, [coll.ndim, coll.nmesh])*coll.Dt;
    ii = 1:coll.ndim;
    for i = 1:coll.nmesh
        % Subtract the desired derivative from the actual derivative
        res(ii) = D(ii) - T*f(T*(i-1)/coll.nmesh, u(ii), p)';
        ii = ii + coll.ndim;
    end
end
```
