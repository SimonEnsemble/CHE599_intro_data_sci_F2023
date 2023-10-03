### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 670804ed-0dba-474a-8b92-91fdab418a01
begin
	import Pkg; Pkg.activate()
	using CairoMakie, Random, LinearAlgebra, Statistics
end

# ╔═╡ 4ba4acdc-61fd-11ee-24eb-4308b22b19c8
md"# 🪡 Buffon's needle problem, with a bubble floor pattern

!!! warning \"background: Buffon's needle problem\"
	for background on Buffon's needle problem, see [Wikipedia](https://en.wikipedia.org/wiki/Buffon%27s_needle_problem). for background on Monte Carlo simulation of Buffon's needle, see [our blog post](https://simonensemble.github.io/posts/2018-04-11-buffon/).

!!! note \"a variation of Buffon's needle problem\"
	a tiled floor exhibits a repeated pattern: circles of radius $r$ are arranged periodically in a cubic square topology. each consecutive circle is a distance $\delta$ apart. though the floor is infinitely repeating, we will represent the floor within a computer simulation using a $B\times B$ grid of circles. then, our simulation box has dimensions $L \times L$, with $L$ related to $B$, $r$, and $\delta$.

	suppose we toss a needle of length $\ell$ (approximated as a line segment) onto the floor. the needle lands at a uniform random position on the floor. specifically, the first end of the needle $\mathbf{x}_1$ lands within the $L\times L$ simulation box. the next end $\mathbf{x}_2$ lands a distance $\ell$ from $\mathbf{x}_1$ uniformly distributed on the circle centered at $\mathbf{x}_1$ (note, this could fall outside the simulation box). ie., the needle lands at a uniform random position and orientation.

	let the event $E$ be that the needle lands on the floor without overlapping a circle on the floor. we wish to find $\pi(E)$ ie. the probability that the needle will not overlap any circle on the floor.

	your task is to code up and analyze Monte Carlo simulations of needle tossing to estimate $\pi(E)$. the idea is that, by simulating $N$ random tosses of needles, the fraction of them that don't overlap the floor in the simulation is an estimate of $\pi(E)$. the larger $N$, the better the Monte Carlo estimate of $\pi(E)$ becomes.
"

# ╔═╡ e1bb6129-a34b-4ab8-b6e9-929754252d2b
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE599_intro_data_sci_F2023/main/hw/buffon.jpeg\" width=500>"

# ╔═╡ cfcd7ec1-a1dc-456b-b0d4-e7fc3a1b607a
set_theme!(theme_minimal()); update_theme!(fontsize=20)

# ╔═╡ f16718b4-983d-4170-bd22-f84f3ea591db
md"## the floor

🪡 create a data structure (`struct`) `Floor` that stores the radius $r$ of the circles on the floor and the distance $\delta$ bewteen the circles.
"

# ╔═╡ 087a23bb-6993-43de-ab18-4a4bd71d8f2a

# ╔═╡ 105b3c71-d10f-42aa-9678-875862e281a3
md"🪡 construct an instance `floor` with `r=4.0` and `δ=1.0`.

!!! note
	use this specific `floor` for the remainder of the assignment.
"

# ╔═╡ 063f8f9a-793b-4168-bdc7-bfb553d76d72

# ╔═╡ b47c300b-9065-45c9-a875-4b304640203a
md"🪡 the length $L$ of the simulation box follows from $r$, $\delta$, and $B$. write a function `sim_box_length` with two arguments (1) a `Floor` and (2) `B`, that returns the value of $L$."

# ╔═╡ 9ddb3dcf-9143-4f29-802c-2ea4bab97286

# ╔═╡ 5db38594-c03e-43c4-abd9-f2e12300aeae
md"🪡 use `sim_box_length` to compute $L$ for your instance `floor::Floor` with `B=3`.
"

# ╔═╡ f06c179c-2d4e-4157-adff-3980faab0e9a
B = 3

# ╔═╡ effe8b45-7f4f-4520-a676-49c8920818c5

# ╔═╡ c5e2acf0-991f-4dd3-8064-7a79fdadd060
md"🪡 write a function `viz_floor` with two arguments (1) a `Floor` and (2) `B`, that draws the repeated circular pattern on the floor and the simulation box representing the periodic boundary.

ie. `viz_floor(floor, B)` should use `CairoMakie` to draw an image mimicking my hand-drawn figure above.

call `viz_floor` with your instance `floor` and `B=3` to visualize the floor.

!!! hint
	* call `poly!` to draw the `B` by `B` pattern of circles within a `for` loop. see the `Circle` object. [docs](https://docs.makie.org/stable/reference/plots/poly/)
	* call `lines!` four times to draw the simulation box. 
"

# ╔═╡ b66b1c50-8825-4002-89c9-9847e21005fc

# ╔═╡ ab13f0c2-51f8-4fce-857a-a0442ea01f32

# ╔═╡ 9cd7f7be-29d4-4061-a837-f68e4b2349e6
md"## the needles
🪡 create a data structure (`struct`) `Needle` that stores the two end points $\mathbf{x}_1$ and $\mathbf{x}_2$ of a needle that landed on the floor.
"

# ╔═╡ 9fe9b531-bc1f-4444-a0ab-bd5035dd69e6

# ╔═╡ 36f9256a-5499-47a4-ab7b-33791e45ef1e
md"## needle tossing"

# ╔═╡ 0b945e59-a5f1-4e00-978a-47aba53ad285
md"🪡 write a function `toss_needle` with two arguments (1) $\ell$ and (2) $L$ that returns an instance of `Needle` that randomly landed on the floor. this is the heart of the Monte Carlo simulation."

# ╔═╡ dcc80d89-920e-4171-bfd9-b568638429a5

# ╔═╡ dbbd92eb-d083-4e0c-bba7-7238e69e5a63
md"🪡 suppose $\ell=2$. call `toss_needle` to toss a needle within the simulation box. run it a few times to make sure the endpoints change (they should; this is a random toss!)"

# ╔═╡ 28155726-6b92-43a0-a90b-e3415f3604d8
ℓ = 2.0 # length of needle

# ╔═╡ 8ab8f578-7644-4ddc-b589-7ffdb83bd882

# ╔═╡ 5db2444a-4197-43ca-ad92-3a0cea047176
md"🪡 toss `nb_tosses = 100` needles and store them in a vector."

# ╔═╡ 61de0584-d7a9-4d80-b872-ed50c6e47253

# ╔═╡ 436ffe60-1f18-4852-81a5-3eaba18e54d3

# ╔═╡ b8946a58-0791-48f9-b00a-84cb184c3b95
md"## needle-floor overlap
🪡 to determine if any given tossed needle `needle` overlapped with a circle on the floor, write a function `overlaps_bubble` with three arguments (1) an instance `floor::Floor` (2) `B` and (3) an instance `needle::Needle`, that returns `true` if the `needle` overlaps with a circle in the `floor` and `false` otherwise.

!!! hint
	loop through the circles, check for overlap with each.
"

# ╔═╡ 370b3563-2daa-499a-8e3b-9505263cac22

# ╔═╡ b785bb1e-5f52-4526-9f8d-4ceb0fcac85d
md"## needle viz

🪡 to visually check your `toss_needle` and `overlaps_bubble` functions, write a new function `viz_needle_tosses` that takes arguments (1) a `floor::Floor`, (2) `B`, and (3) a vector of tossed `Needle`'s, and (A) draws the floor by calling your previous function `viz_floor` then (B) _adds_ to the figure visualizations of the needles (as lines). color each needle black if it intersects a circle and green if it does not.
call `viz_needle_tosses` to draw the needles tossed from your `needles` vector above.
"

# ╔═╡ 56920f17-62dd-4657-b3de-bfd8eacaa535

# ╔═╡ cb207841-a6b7-40c0-842c-fc7edc1f0c0b

# ╔═╡ bb493c9f-c308-48a3-a360-53c06f2b0d3b
md"## the full Monte Carlo simulation
🪡 write a function `π_no_overlap` with arguments (1) `floor::Floor`, (2) `B::Int`, (3) `nb_tosses::Int`, and (4) `ℓ::Float64`, that tosses `nb_tosses` needles onto the `floor` represented as a periodic `B` by `B` pattern then returns the fraction of those needles that didn't overlap. this is an estimate of $\pi(E)$.
"

# ╔═╡ 2006f8b1-b9df-4260-a541-d08e703e0c60

# ╔═╡ f7b42f80-7a3b-465a-bb02-41df1da16232
md"🪡 call your function `π_no_overlap` to estimate $\pi(E)$ using 50,000 needle tosses (using the `floor`, `B`, and `ℓ` from above)."

# ╔═╡ 8fce1d50-2428-4cc5-93a9-4397ba0bdafb

# ╔═╡ cb672165-1e2b-430d-8806-85da10c52370
md"## analysis of the Monte Carlo simulation
🪡 to examine how the estimate for $\pi(E)$ provided by the Monte Carlo simulation depends on the number of tosses, loop over `nb_tossess = [10, 100, 1000, 10000, 100000]` different numbers of needle tosses used for the estimation. inside the loop, run `nb_sims=25` simulations of needle tosses with this many tosses. compute the mean and standard deviation of the estimates for $\pi(E)$ and store them in an array. finally, once the loop is done, plot:
* the mean estimate of $\pi(E)$ among the simulations vs. the \# of tosses, as points
* the standard deviation of the stimate of $\pi(E)$ among the simulations vs. the \# of tosses, as error bars. (see `errorbars` in `CairoMakie`.)
plot the # of tosses on the x-axis on a log10-scale.

what do you observe?

[my observations are ...]
"

# ╔═╡ 95ec0db0-2541-462e-9c28-ad9232341cb2

# ╔═╡ c4fc6e86-fee7-4e94-8164-ff8090ef3c54

# ╔═╡ 346c1dc4-c5b7-4a88-a520-23b15574802e
md"## dependence of $\pi(E)$ on needle length
🪡 loop over a `range` of ten different needle lengths evenly spaced between $\ell=1/10$ and $\ell=4$. compute an estimate for $\pi(E)$ under each needle length, using 50,000 tosses. plot the estimate for $\pi(E)$ vs. the needle length. 

what do you observe?
[as the needles shorten, I observe...]
"

# ╔═╡ dd9bfb11-5c27-4207-a28e-b894693c0026

# ╔═╡ 9a8b4e01-8e30-4be4-832f-d06fde3c0629

# ╔═╡ 114056e4-5b79-48c1-aae3-376eb356aa56
md"## a limitation in your code

🪡 if I asked you to simulate a needle with $\ell=25$ and $r=1$, would your code still work? why or why not? how might you modify your code to account for this? (no need to actually modify it.)

!!! hint
	at least, _my_ implementation of the function `overlaps_bubble` would not work any more with `B=3`.
"

# ╔═╡ Cell order:
# ╟─4ba4acdc-61fd-11ee-24eb-4308b22b19c8
# ╟─e1bb6129-a34b-4ab8-b6e9-929754252d2b
# ╠═670804ed-0dba-474a-8b92-91fdab418a01
# ╠═cfcd7ec1-a1dc-456b-b0d4-e7fc3a1b607a
# ╟─f16718b4-983d-4170-bd22-f84f3ea591db
# ╠═087a23bb-6993-43de-ab18-4a4bd71d8f2a
# ╟─105b3c71-d10f-42aa-9678-875862e281a3
# ╠═063f8f9a-793b-4168-bdc7-bfb553d76d72
# ╟─b47c300b-9065-45c9-a875-4b304640203a
# ╠═9ddb3dcf-9143-4f29-802c-2ea4bab97286
# ╟─5db38594-c03e-43c4-abd9-f2e12300aeae
# ╠═f06c179c-2d4e-4157-adff-3980faab0e9a
# ╠═effe8b45-7f4f-4520-a676-49c8920818c5
# ╟─c5e2acf0-991f-4dd3-8064-7a79fdadd060
# ╠═b66b1c50-8825-4002-89c9-9847e21005fc
# ╠═ab13f0c2-51f8-4fce-857a-a0442ea01f32
# ╟─9cd7f7be-29d4-4061-a837-f68e4b2349e6
# ╠═9fe9b531-bc1f-4444-a0ab-bd5035dd69e6
# ╟─36f9256a-5499-47a4-ab7b-33791e45ef1e
# ╟─0b945e59-a5f1-4e00-978a-47aba53ad285
# ╠═dcc80d89-920e-4171-bfd9-b568638429a5
# ╟─dbbd92eb-d083-4e0c-bba7-7238e69e5a63
# ╠═28155726-6b92-43a0-a90b-e3415f3604d8
# ╠═8ab8f578-7644-4ddc-b589-7ffdb83bd882
# ╟─5db2444a-4197-43ca-ad92-3a0cea047176
# ╠═61de0584-d7a9-4d80-b872-ed50c6e47253
# ╠═436ffe60-1f18-4852-81a5-3eaba18e54d3
# ╟─b8946a58-0791-48f9-b00a-84cb184c3b95
# ╠═370b3563-2daa-499a-8e3b-9505263cac22
# ╟─b785bb1e-5f52-4526-9f8d-4ceb0fcac85d
# ╠═56920f17-62dd-4657-b3de-bfd8eacaa535
# ╠═cb207841-a6b7-40c0-842c-fc7edc1f0c0b
# ╟─bb493c9f-c308-48a3-a360-53c06f2b0d3b
# ╠═2006f8b1-b9df-4260-a541-d08e703e0c60
# ╟─f7b42f80-7a3b-465a-bb02-41df1da16232
# ╠═8fce1d50-2428-4cc5-93a9-4397ba0bdafb
# ╟─cb672165-1e2b-430d-8806-85da10c52370
# ╠═95ec0db0-2541-462e-9c28-ad9232341cb2
# ╠═c4fc6e86-fee7-4e94-8164-ff8090ef3c54
# ╟─346c1dc4-c5b7-4a88-a520-23b15574802e
# ╠═dd9bfb11-5c27-4207-a28e-b894693c0026
# ╠═9a8b4e01-8e30-4be4-832f-d06fde3c0629
# ╟─114056e4-5b79-48c1-aae3-376eb356aa56
