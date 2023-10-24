### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 2403b80a-224a-11ee-2a78-110b41bca561
begin
	import Pkg; Pkg.activate()
	using CairoMakie, PlutoUI, ColorSchemes

	update_theme!(fontsize=25, linewidth=3)

	colors = ColorSchemes.Accent_4;
end

# ╔═╡ 8b2d826c-d6da-4e0b-9e84-241850b705b4
md"# linear programming (LP)

💡 let's illustrate the graphical solution to the linear program (see pg. 11 [here](https://www.princeton.edu/~aaa/Public/Teaching/ORF363_COS323/F16/ORF363_COS323_F16_Lec11.pdf)):

```math
\begin{align}
&\max x_1+6x_2 \\
&\text{s.t. } x_1 \leq 200 \\
&\phantom{s.t. } x_2 \leq 300 \\
&\phantom{s.t. } x_1+x_2 \leq 400 \\
&\phantom{s.t. } x_1,x_2 \geq 0 
\end{align}
```

the feasible region, containing all $(x_1, x_2)$ that satisfy the constraints, is highlighted in yellow below. it's a polytope.
"

# ╔═╡ 39184945-f243-40ed-a5c8-35f87b19f421
md"the slider below changes $z$ to observe different level sets (black, dashed line) of the objective function $f(x_1, x_2):=x_1+6x_2$, $\{(x_1, x_2) : f(x_1, x_2)=z\}$.

 $z$ slider: $(@bind z PlutoUI.Slider(600:10:2500))"

# ╔═╡ f1a79bb9-2680-4aa6-8a00-d81d5db9507e
z

# ╔═╡ f48c0047-715b-464d-820f-0da9fea2f259
begin
	x₁s = range(-10, 300, length=2)
	
	fig = Figure()
	ax = Axis(fig[1, 1], xlabel="x₁", ylabel="x₂", aspect=DataAspect())

	# feasible region
	band!([0, 100, 200], zeros(3), [300, 300, 200], color=(colors[4], 0.5))
	text!(100, 150, text="feasible region", align=(:center, :center))
	
	# constraint 1
	lines!([200, 200], [-10, 400], color=colors[1])
	text!(200, 100, text="x₁ = 200", rotation=-π/2, color=colors[1], fontsize=18)
	
	# constraint 2
	lines!(x₁s, [300 for i = 1:2], color=colors[2])
	text!(220, 300, text="x₂ = 300", color=colors[2], fontsize=18)

	# constraint 3
	lines!(x₁s, 400 .- x₁s, color=colors[3])
	text!(120, 285, text="x₁ + x₂ = 400", rotation=-π/4, color=colors[3], fontsize=18)

	# objective value
	lines!(x₁s, (z .- x₁s) / 6, color="black", linestyle=:dash)

	# vertices
	scatter!([0, 0, 200, 200, 100], [0, 300, 0, 200, 300], color="black")
	
	xlims!(-10, 300)
	ylims!(-10, 400)
	fig
end

# ╔═╡ Cell order:
# ╠═2403b80a-224a-11ee-2a78-110b41bca561
# ╟─8b2d826c-d6da-4e0b-9e84-241850b705b4
# ╟─39184945-f243-40ed-a5c8-35f87b19f421
# ╠═f1a79bb9-2680-4aa6-8a00-d81d5db9507e
# ╟─f48c0047-715b-464d-820f-0da9fea2f259
