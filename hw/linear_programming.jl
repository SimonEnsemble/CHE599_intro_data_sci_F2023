### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ a4aa940e-84c8-483e-a1d5-6fa235ed39b6
begin
	import Pkg; Pkg.activate()
	using JuMP, PlutoUI, Graphs, GraphMakie, CairoMakie, MetaGraphsNext
end

# ╔═╡ 299ada83-58d2-4bb3-ac21-dd7ce9e3b462
TableOfContents()

# ╔═╡ 7ebf114a-72a4-11ee-0c52-71b7ba3ec5ec
md"# linear programming (LP) exercises

!!! warning \"instructions\"
	solve these problems using `Jump.jl`. docs [here](https://jump.dev/JuMP.jl/stable/tutorials/linear/introduction/). add Markdown cells to structure your content and describe your code step-by-step.

## optimizing profits
🐶 the Canine Products company offers two dog foods, Frisky Pup and Husky Hound, that are made from a blend of cereal and meat. a package of Frisky Pup requires 1 pound of cereal and 1.5 pounds of meat, and sells for $7. a package of Husky Hound uses 2 pounds of cereal and 1 pound of meat, and sells for $6. Raw cereal costs $1 per pound and raw meat costs $2 per pound. it also costs $1.40 to package the Frisky Pup and $0.60 to package the Husky Hound. a total of 240,000 pounds of cereal and 180,000 pounds of meat are available each month. the only production bottleneck is that the factory can only package 110,000 bags of Frisky Pup per month. needless to say, management would like to maximize profit.

formulate as a linear program, then numerically solve for the solution.
"

# ╔═╡ f60668bc-85c5-4812-bcbb-573adb218956
md"## optimizing flow in a network

the directed graph below represents an oil transportation network. the edges are labeled with capacities for flows. find the maximum flow from node S to node T. visualize the optimal flow (as edge labels, as I did with the capacities below).
"

# ╔═╡ 55d53dc9-e6d0-4d2e-b22f-2604675be3bb
begin
	g = MetaGraph(
		DiGraph(),              # directed graph
		label_type=String,      # node labels are String's
	    edge_data_type=Float64, # edge labels are Float64's
		graph_data="oil pipeline network"
	)
	
	# add vertices
	for v in ["S", "T", "A", "B", "C", "D", "E", "F", "G"]
		add_vertex!(g, v)
	end

	# add edges
	add_edge!(g, "S", "A", 6.0)
	add_edge!(g, "S", "B", 6.0)
	add_edge!(g, "S", "C", 6.0)
	
	add_edge!(g, "A", "D", 4.0)
	add_edge!(g, "A", "E", 1.0)
	add_edge!(g, "A", "B", 2.0)
	
	add_edge!(g, "B", "E", 20.0)

	add_edge!(g, "C", "B", 2.0)
	add_edge!(g, "C", "F", 5.0)

	add_edge!(g, "D", "G", 5.0)
	add_edge!(g, "D", "E", 2.0)

	add_edge!(g, "E", "F", 10.0)
	add_edge!(g, "E", "G", 6.0)

	add_edge!(g, "F", "T", 4.0)

	add_edge!(g, "G", "T", 12.0)
end

# ╔═╡ e629e32a-c69d-4e50-a8e4-27c134af82c2
collect(labels(g)) # list of nodes

# ╔═╡ 6272ba29-f291-44b0-9eaa-c9e1c333672c
collect(edge_labels(g)) # list of edges

# ╔═╡ be8de682-eae1-4f52-bb37-13d2d292f865
g["S", "A"] # capacity label on an edge

# ╔═╡ 78a36975-51f2-4a74-8905-516ae23b65ac
begin
	fig = Figure()
	ax = Axis(fig[1, 1], title="oil pipeline network")
	hidedecorations!(ax)
	hidespines!(ax)
	graphplot!(
		g.graph, 
		edge_width=3, 
		arrow_size=20,
		node_color="green",
		node_size=30,
		edge_color="gray",
		nlabels=collect(labels(g)),
		nlabels_distance=5.0,
		nlabels_fontsize=25,
		elabels=["$(g[e...])" for e in edge_labels(g)],
		arrow_shift=:end,
	)
	ylims!(nothing, 3.4)
	fig
end

# ╔═╡ Cell order:
# ╠═a4aa940e-84c8-483e-a1d5-6fa235ed39b6
# ╠═299ada83-58d2-4bb3-ac21-dd7ce9e3b462
# ╟─7ebf114a-72a4-11ee-0c52-71b7ba3ec5ec
# ╟─f60668bc-85c5-4812-bcbb-573adb218956
# ╠═55d53dc9-e6d0-4d2e-b22f-2604675be3bb
# ╠═e629e32a-c69d-4e50-a8e4-27c134af82c2
# ╠═6272ba29-f291-44b0-9eaa-c9e1c333672c
# ╠═be8de682-eae1-4f52-bb37-13d2d292f865
# ╠═78a36975-51f2-4a74-8905-516ae23b65ac
