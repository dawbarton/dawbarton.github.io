@def title = "Barycentric.jl"
@def published = Date(2018, 12, 4)

Over the past couple of years or so I've been getting into the Julia programming language; it's been great to watch the language mature over time. Many people proclaim the virtues of its speed (it's very fast for a dynamic language) but really I like its elegance - it's a very well designed language that makes full use of multiple dispatch. (Multiple dispatch is something that I doubt most coders know much about but once you are used to it, it's indispensable!)

My first foray into the world of Julia package development is [Barycentric.jl](https://github.com/dawbarton/Barycentric.jl), a small package to do polynomial interpolation using a Barycentric representation. This approach is espoused in [Berrut and Trefethen, SIAM Review 2004](https://people.maths.ox.ac.uk/trefethen/barycentric.pdf) as a way to do polynomial interpolation with O(n) operations, rather than O(n2) operations as is more typical for interpolation with Lagrange polynomials.

While this package isn't really a general purpose interpolation code (see [Interpolations.jl](https://github.com/JuliaMath/Interpolations.jl) for that), it is good for building numerical algorithms such as collocation.

One example of this is a simple(ish) simulation of a dynamic cantilever beam. The [Euler-Bernoulli equation](https://en.wikipedia.org/wiki/Euler%E2%80%93Bernoulli_beam_theory) is the most straightforward, non-trivial model  we can use -

$$ \frac{EI}{\rho AL^4}\frac{\partial^4u}{\partial x^4} + \frac{\partial^2 u}{\partial t^2} + \xi\frac{\partial u}{\partial t} = 0 $$

where $E$ is Young's modulus, $I$ is the second moment of area, $\rho A$ is the mass per unit length, $L$ is the length, and $\xi$ is the (external) damping coefficient.

Since it is a fourth-order partial differential equation in space we need four boundary conditions. For a cantilever beam we have (primes denote derivatives with respect to $x$)

$u(0, t) = 0$ (zero displacement at wall)

$u'(0,t) = 0$ (zero slope at wall)

$u''(1,t) = 0$ (zero torque at free end)

$u'''(1,t) = 0$ (zero shear at free end)

To solve the Euler-Bernoulli equation we discretise the model in space using Chebyshev polynomials (for an introduction to Chebyshev approximations to differential equations see the excellent, and relatively short, book Spectral Methods in Matlab by Nick Trefethen). This is where Barycentric.jl comes in.

In a nutshell, we're going to use an $N$ degree polynomial to approximate the solution in the $x$ direction by constraining the polynomial to satisfy the four boundary conditions at $x=0$ and $x=1$ and then evaluating the fourth derivative for the interior of the Euler-Bernoulli equation.

I'm going to arbitrarily choose to evaluate the Euler-Bernoulli equation at the Chebyshev nodes of the $N-2$ degree Chebyshev polynomial, excluding the end points, so $N-3$ points in total. Hence these points plus the four boundary conditions gives $N+1$ equations to match the $N+1$ unknowns of the $N$ degree Chebyshev polynomial.

The code to do this is as follows. The end result is a fourth-order derivative matrix defined on the collocation points.

```julia
using Barycentric

N = 10  # degree of the polynomial
n = N-2  
# Construct the polynomial
P = Chebyshev2{N}()
# Generate the differentiation matrix y' ≈ Dy
D = differentiation_matrix(P)
# Collocation points (nodes of the N-2 degree second-kind Chebyshev polynomial)
x_coll = [-cospi(j/n) for j = 1:n-1]
# Interpolation matrix from nodes(P) to x_coll
In = interpolation_matrix(P, x_coll)  

# Construct the mapping from the values at the collocation points to the
# values at the nodes of the Chebyshev polynomial, simultaneously
# incorporating the  boundary conditions
In⁻¹ = inv([In;                           # interpolation to collocation points
            [1 zeros(1, N)];              # u(0, t) = 0
            D[1:1, :];                    # u'(0, t) = 0
            (D^2)[end:end, :]             # u''(1, t) = 0
            (D^3)[end:end, :]             # u'''(1, t) = 0
           ])[:, 1:end-4]  # remove the boundary condition inputs since they are zero

# Construct the differentiation matrix that incorporates the boundary conditions
D₄ = In*(D^4)*In⁻¹
```

The basic premise is to construct a fourth-order differentiation matrix on the $N$-degree Chebyshev polynomial whilst incorporating the boundary conditions. This is done by mapping from the collocation points onto the nodes of the Chebyshev polynomial, incorporating the boundary conditions, then applying the differentiation matrix before mapping back to the collocation points.

To integrate the equations of motion, the second-order (in time) differential equation is rewritten as a system of first-order ODEs and thrown into [DifferentialEquations.jl](https://diffeq.sciml.ai/latest/).

```julia
function beammodel!(dudt, u, p, t)
    n = size(p.D₄, 2)  # number of collocation points
    dudt[1:n] .= u[n+1:2n]  # u̇₁ = u₂
    dudt[n+1:2n] .= -p.EI/p.ρA*(p.D₄*u[1:n]) .- p.ξ*u[n+1:2n]  # u̇₂ = -EI/ρA*u₁'''' - ξ*u₂
end
```

Before integrating, we need some initial conditions. To avoid putting energy into the higher modes of the beam, I use the mode shape of the first beam mode for the initial conditions.

```julia
# A parameter vector for integration; a steel beam (1m × 10mm × 1mm)
p = (D₄ = D₄, EI = 1666.6, ρA = 8.0, ξ = 0.2)

# Jacobian matrix of the differential equation
using LinearAlgebra
A = [zeros(size(p.D₄)) I; -p.EI/p.ρA*p.D₄ -p.ξ*I]
ev = eigen(A)
idx = argmin(abs.(ev.values))  # lowest mode
u0 = real.(ev.vectors[:, idx])  # ignore rotations

# Integrate!
using OrdinaryDiffEq
prob = ODEProblem(beammodel!, u0, (0, 10.0), p)
sol = solve(prob, Rodas5(), dtmax=0.05)  # use a stiff solver
```

And to plot

```julia
using Makie
sc = Scene()
wf = wireframe!(sc, x_coll, sol.t, sol[1:N-3, :])
scale!(wf, 1.0, 1.0, 10.0)
l = lines!(sc, [x_coll[end]], sol.t, sol[N-3, :], color=:red, linewidth=3.0)
```

The result is at the top of this post!

While this is a largely academic example (we could solve this problem analytically) there are lots of extensions that can be made with this approach.
