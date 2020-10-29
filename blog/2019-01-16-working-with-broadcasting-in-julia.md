@def title = "Working with broadcasting in Julia"
@def published = Date(2019, 1, 16)

Broadcasting in Julia is a way of writing vectorised code (think Matlab) that is performant and explicit. The benefits of performant code are obvious (faster!) but explicit vectorisation is also a significant benefit.

When I first saw Matlab and how you could call the `sin` with a vector input, I was (slightly) blown away by the usefulness of this. It didn't take too long for me to realise the limitations though; vectorising a complicated function can require quite a bit of code gymnastics, which doesn't usually help the readability, particularly for those students who are relatively new to programming.

This is where Julia's dot broadcasting (vectorisation) comes in. If you want a function to work on a vector of inputs (applying the same function to each element of the vector) you simply put a dot on the function call. For example,  the sine of a vector of values becomes `sin.([1.1, 0.3, 2.3])`; note the extra dot between the sin and the first bracket.

For a really good introduction to this, see the blog post [More Dots: Syntactic Loop Fusion in Julia.](https://julialang.org/blog/2017/01/moredots)

In Julia v0.7/1.0, there were some changes under the hood to how broadcasting works. (See [Extensible broadcast fusion](https://julialang.org/blog/2018/05/extensible-broadcast-fusion) for more details and how it can be customised by different types.) It now creates a series of `Broadcasted` objects that get fused together before finally being materialised to give the final answer. For example, consider

```julia
r = sqrt(sum(x.^2 .+ y.^2))
```

Internally this gets rewritten ("lowered") to

```julia
r = sqrt(sum(materialize(broadcasted(+, broadcasted(^, x, 2), broadcasted(^, y, 2)))))
```

(This isn't quite accurate on the details since the squaring is implemented slightly differently.) Notice the hierarchy of `broadcasted` calls enclosed within a call to `materialize`. This is where the magic of broadcast fusion happens (and enables Julia to construct performant code). The `broadcasted` calls create a nested set of `Broadcasted` objects that contain the (lazily evaluated) vectorised expression and the `materialize` call creates the final vector from this.

Most of the time this automatic magic is exactly what we want. But sometimes it's not.

Consider the case above where the sum is being computed; a vector will be allocated in memory for the calculation `x.^2 + y.^2` and if `x` and `y` are large then a large amount of memory will be allocated unnecessarily for this intermediate value. Since the sum function doesn't need all the values at the same time, couldn't we just lazily compute `x.^2 + y.^2` as individual numbers and feed them to the sum one-by-one? For example, we could do something like

```julia
acc = 0.0
for i = eachindex(x, y)
    acc += x[i]^2 + y[i]^2
end
r = sqrt(acc)
```

In this case writing out the explicit for loop is something we're trying to avoid (otherwise why bother with broadcasting?). Can we somehow extract the lazy representation from the broadcasting without materializing the intermediate result?

The answer is yes, but unfortunately it's not part of the base Julia (yet).  The code below gives us a lazy macro that enables us to get access to that lazy representation that broadcasting creates and use it explicitly in our surrounding code.

```julia
@inline _lazy(x) = x[1]  # unwrap the tuple
@inline Broadcast.broadcasted(::typeof(_lazy), x) = (x,)  # wrap the Broadcasted object in a tuple to avoid materializing
macro lazy(x)
    return esc(:(_lazy(_lazy.($x))))
end
```

Now we can compare the lazy version and the eager (materialized) versions.

```julia
julia> using BenchmarkTools

julia> x = rand(1_000_000) ; y = rand(1_000_000) ;

julia> @btime sqrt(sum(x.^2 .+ y.^2))  # normal eager evaluation
  2.837 ms (16 allocations: 7.63 MiB)
816.7514405417339

julia> @btime sqrt(sum(@lazy x.^2 .+ y.^2))  # lazy broadcasted evaluation
  1.075 ms (12 allocations: 208 bytes)
816.7514405417412
```

Notice the memory consumption: 7.63 MiB for the normal version versus 208 bytes for the lazily evaluated version. Similarly the lazy version is significantly faster (though that depends quite a lot on the size of the vectors used). There is a slightly different answer in the two cases since the Julia `sum` function uses slightly different algorithms for vectors versus iterators (so I'm not quite comparing like-for-like).

Why is the lazy version not the default? Well here is the caveat: as soon as you do lazy evaluation the performance becomes much more problem dependent - it can get faster (as in this case) but, equally, it can get slower. [BenchmarkTools.jl](https://github.com/JuliaCI/BenchmarkTools.jl) is your friend!
