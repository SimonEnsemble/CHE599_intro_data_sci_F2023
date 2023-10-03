### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 1fffda88-b222-4eb6-90d5-a7d7dc179ff4
begin
	import Pkg; Pkg.activate()
	using CSV, DataFrames, Printf, CairoMakie, ColorSchemes, PlutoUI, RDatasets, Statistics
end

# ╔═╡ b1284072-99ce-48ac-a902-b350fd9ad3dc
TableOfContents()

# ╔═╡ 4baf009a-a01d-4b50-baad-508fee233846
md"# data visualization

we will employ the `CairoMakie.jl` package to create data visualizations.

!!! note \"documentation on `CairoMakie`\"
	consult the [Makie docs](https://makie.juliaplots.org/dev/) to figure out how to create various data visualizations and tune them. for a gallery of examples, see [here](https://docs.makie.org/dev/examples/plotting_functions/) and the [Beautiful Makie project](https://beautiful.makie.org/dev/).

first, let's modify the `Makie.jl` [theme](https://makie.juliaplots.org/dev/documentation/theming/). pre-defined themes are listed [here](https://makie.juliaplots.org/dev/documentation/theming/predefined_themes/).
"

# ╔═╡ 71286712-22dc-4ad0-bdad-5003c5814cef

# ╔═╡ 975094ce-2465-417a-9260-63e1dd41e39e
md"## choosing colors via `ColorSchemes.jl`

to choose effective color palettes and colormaps, we will employ `ColorSchemes.jl`.

!!! note \"documentation on `ColorSchemes.jl`\"
	see [here](https://juliagraphics.github.io/ColorSchemes.jl/stable/).

distinguishable colors
"

# ╔═╡ 3f8ee97e-f7d8-47a7-861a-6e2782f3990d

# ╔═╡ eab60046-d543-4a16-8eb4-fbbad82a34f0

# ╔═╡ ce2b183c-40ae-43fd-a4d4-0920d9e4eeed
md"
color maps (sequential)
"

# ╔═╡ f43425b8-3c84-4f3a-8769-1381dd131f16

# ╔═╡ 85b24100-0883-4ff6-ad09-103f4894006c

# ╔═╡ 09d50ad2-5fc0-4578-8d27-d1f53aeb7d0e

# ╔═╡ aef19e67-11ad-4c59-8e25-b838e017a376
md"
color maps (diverging)---good for when there is a notion of positive and negative.
"

# ╔═╡ 69fa827c-84db-4ac2-8aa9-2bda187be53f

# ╔═╡ c6eca738-6c2e-47e0-96f2-53f4e1f9d267
md"
## scatter, line plots

let's visualize xenon adsorption data in a nano-porous material, [SBMOF-1](http://corysimon.github.io/structure_viz/sbmof1.html), from Fig. 2 [here](https://www.nature.com/articles/ncomms11831), and how the Langmuir model compares to the experimental data.

the raw data is [here](https://raw.githubusercontent.com/SimonEnsemble/intro_to_data_science_fall_2022/main/data/Xe_in_SBMOF-1.csv).

the [Langmuir adsorption model](https://en.wikipedia.org/wiki/Langmuir_adsorption_model) for gas adsorption in SBMOF-1 is:
```math
n(p) = M\frac{Kp}{1+Kp}
``` with:
- amount of gas adsorbed [mmol/g], $n$
- pressure [bar], $p$
- identified Langmuir parameters $M=1.412$ mmol/g and $K=37.2$ bar$^{-1}$.

🐸 download the data.
"

# ╔═╡ 1b4d72a3-fb0c-46cf-a651-cf40458134d7

# ╔═╡ 9548bba1-2d03-4e41-8fb5-021916ee71d2

# ╔═╡ 141d7367-4123-4607-844a-39de3a46559b
md"🐸 read in the data as a `DataFrame`.

!!! hint
	the first line is a comment, _not_ the column names as we'd expect.
"

# ╔═╡ 5ce0008e-a708-49d6-affc-e11606907cc2

# ╔═╡ 9ff60bb2-3a34-4181-951b-d8f02819c3b6
md"🐸 how to grab the columns in the `DataFrame`."

# ╔═╡ ccdcae4f-2242-43eb-a333-cd1736a51dde

# ╔═╡ 8568efe3-4610-45a3-9a39-a25842a97f37

# ╔═╡ 6d56b9bd-6b73-4962-bb28-3a1e09f69c6e
md"🐸 define the Langmuir model as a function."

# ╔═╡ 008f01f9-fe05-4ceb-bc02-b51463add2c4

# ╔═╡ 60d290b8-1353-4d5c-b6e0-dec91859ea25
md"
🐸 plot the data as points and the model as a line, on the same canvas. include a legend, x-axis label, y-axis label, and title.
"

# ╔═╡ 7f622486-10de-43c7-be47-27a088b760bc

# ╔═╡ 664e1624-639c-4dd3-80d3-9e3c64b3ddaf

# ╔═╡ 8be0ae67-2f7d-435d-a2b7-0722a7d6e28e
md"## line plots, colored by a parameter

to understand the Langmuir model, let's study how the parameter $K$ affect the adsorption isotherm $n(p)$.

🐸 draw a series of Langmuir curves with different $K$. color each curve according to $K$ and draw an associated colorbar to indicate the color to value mapping.
"

# ╔═╡ d8f93cf5-064e-493e-ad10-5457c8c861a4

# ╔═╡ a9e4ceb9-2d44-42bc-a891-d19134cd736a

# ╔═╡ a0a8a005-b9f8-461a-a160-dbe1c1304708

# ╔═╡ b6c9396a-a9e5-40f3-8bce-e573206ca3f8
md"## bar plots

see the docs for `barplot` [here](https://makie.juliaplots.org/stable/examples/plotting_functions/barplot/index.html).

*goal*: visualize how Americans like their steak done [[source](https://fivethirtyeight.com/features/how-americans-like-their-steak/)] via a bar plot showing preference for rare, medium rare, etc.

🐸 read the tabular data from the file `steak.csv` [here](https://raw.githubusercontent.com/SimonEnsemble/intro_to_data_science_fall_2022/main/data/steak.csv) as a `DataFrame`.
* rows: each row represents a survey response of a person
* first column: answer to \"do you eat steak?\"
* second column: answer to \"if you do like steak, how do you like your steak done?\"

!!! hint
	this file does not contain the column names.
"

# ╔═╡ d73eb64c-663d-4f5b-8fda-a39543dda27b

# ╔═╡ 95c1247e-00f1-4bf6-952c-317959e13ef7

# ╔═╡ 6b15f4f9-577c-406c-ad54-b9361b56968f

# ╔═╡ f2406b5f-a810-4962-9b5f-6efe8f97a79c
md"🐸 drop rows corresponding to folks that do not eat steak.
"

# ╔═╡ 59694b4d-dcb5-409e-8e0d-9e1bbc90dab6

# ╔═╡ 2a2c3377-6c23-44f5-8c19-1976408cdfd3

# ╔═╡ 009a4a15-9704-405b-9aa3-c2d5a5f995a8
md"
🐸 count the number of folks who prefer steak rare, medium rare, etc.

store the result in `steak_prefs::DataFrame` to use for visualization. sort according to time cooked.

!!! hint
    use `combine`. note the computer is not smart enough to sort the cooking levels encoded as words.
"

# ╔═╡ 13f8bce2-728c-4128-af6a-24e2967241e0

# ╔═╡ 04ca01f8-31b7-4aa7-8870-705284f961b7
md"
🐸 draw a bar plot showing how folks like their steak cooked.
"

# ╔═╡ 6f6cced6-6ead-43d2-bfe7-8374641c8fc0

# ╔═╡ 6dfdd6f9-ed6a-425b-8253-71c06b183d25

# ╔═╡ 4f81d47c-32c0-4b0f-8ecc-e143a164aadb
md"## histograms

see the `hist` function [docs](https://makie.juliaplots.org/stable/examples/plotting_functions/hist/).

🐸 visualize the empirical distribution of heights of a sample of boys in Oxford from the `Oxboys` data set from `RDatasets.jl`. [source](https://github.com/JuliaStats/RDatasets.jl).

"

# ╔═╡ cf04103f-cc40-4f23-be12-c34aa3525b1f

# ╔═╡ 14f634cc-46d4-4cf1-83bd-1a6719a34d7c

# ╔═╡ de732f20-ff77-4f10-a196-50a1d0de640d
md"
## boxplots

see the `boxplot` function [docs](https://makie.juliaplots.org/stable/examples/plotting_functions/boxplot/).

the Wikipedia page [here](https://en.wikipedia.org/wiki/Interquartile_range) explains box plots. I found the figure [here](https://en.wikipedia.org/wiki/Interquartile_range#/media/File:Boxplot_vs_PDF.svg) helpful.

e.g. let's visualize the distribution of petal lengths among different species of irises.
"

# ╔═╡ 0a1cdfaf-f869-47b7-b7d1-cfd7727a9b32

# ╔═╡ b0c27c31-34fe-48b8-9acd-ec8ffc480bf7

# ╔═╡ 56184a34-2b88-4a34-921d-072c32e8a4dd

# ╔═╡ efeab4e8-97ad-415f-9565-d6c131952528

# ╔═╡ 171496f1-1ce0-4971-9aa9-e33ee382e4f4
md"## Algebra of Graphics

the package `AlgebraOfGraphics.jl` offers an advanced, powerful syntax for creating data visualizations. it employs `Makie.jl` under the hood. see [here](https://aog.makie.org/stable/) if you are interested in using it.
"

# ╔═╡ Cell order:
# ╠═1fffda88-b222-4eb6-90d5-a7d7dc179ff4
# ╠═b1284072-99ce-48ac-a902-b350fd9ad3dc
# ╟─4baf009a-a01d-4b50-baad-508fee233846
# ╠═71286712-22dc-4ad0-bdad-5003c5814cef
# ╟─975094ce-2465-417a-9260-63e1dd41e39e
# ╠═3f8ee97e-f7d8-47a7-861a-6e2782f3990d
# ╠═eab60046-d543-4a16-8eb4-fbbad82a34f0
# ╟─ce2b183c-40ae-43fd-a4d4-0920d9e4eeed
# ╠═f43425b8-3c84-4f3a-8769-1381dd131f16
# ╠═85b24100-0883-4ff6-ad09-103f4894006c
# ╠═09d50ad2-5fc0-4578-8d27-d1f53aeb7d0e
# ╟─aef19e67-11ad-4c59-8e25-b838e017a376
# ╠═69fa827c-84db-4ac2-8aa9-2bda187be53f
# ╟─c6eca738-6c2e-47e0-96f2-53f4e1f9d267
# ╠═1b4d72a3-fb0c-46cf-a651-cf40458134d7
# ╠═9548bba1-2d03-4e41-8fb5-021916ee71d2
# ╟─141d7367-4123-4607-844a-39de3a46559b
# ╠═5ce0008e-a708-49d6-affc-e11606907cc2
# ╟─9ff60bb2-3a34-4181-951b-d8f02819c3b6
# ╠═ccdcae4f-2242-43eb-a333-cd1736a51dde
# ╠═8568efe3-4610-45a3-9a39-a25842a97f37
# ╟─6d56b9bd-6b73-4962-bb28-3a1e09f69c6e
# ╠═008f01f9-fe05-4ceb-bc02-b51463add2c4
# ╟─60d290b8-1353-4d5c-b6e0-dec91859ea25
# ╠═7f622486-10de-43c7-be47-27a088b760bc
# ╠═664e1624-639c-4dd3-80d3-9e3c64b3ddaf
# ╟─8be0ae67-2f7d-435d-a2b7-0722a7d6e28e
# ╠═d8f93cf5-064e-493e-ad10-5457c8c861a4
# ╠═a9e4ceb9-2d44-42bc-a891-d19134cd736a
# ╠═a0a8a005-b9f8-461a-a160-dbe1c1304708
# ╟─b6c9396a-a9e5-40f3-8bce-e573206ca3f8
# ╠═d73eb64c-663d-4f5b-8fda-a39543dda27b
# ╠═95c1247e-00f1-4bf6-952c-317959e13ef7
# ╠═6b15f4f9-577c-406c-ad54-b9361b56968f
# ╟─f2406b5f-a810-4962-9b5f-6efe8f97a79c
# ╠═59694b4d-dcb5-409e-8e0d-9e1bbc90dab6
# ╠═2a2c3377-6c23-44f5-8c19-1976408cdfd3
# ╟─009a4a15-9704-405b-9aa3-c2d5a5f995a8
# ╠═13f8bce2-728c-4128-af6a-24e2967241e0
# ╟─04ca01f8-31b7-4aa7-8870-705284f961b7
# ╠═6f6cced6-6ead-43d2-bfe7-8374641c8fc0
# ╠═6dfdd6f9-ed6a-425b-8253-71c06b183d25
# ╟─4f81d47c-32c0-4b0f-8ecc-e143a164aadb
# ╠═cf04103f-cc40-4f23-be12-c34aa3525b1f
# ╠═14f634cc-46d4-4cf1-83bd-1a6719a34d7c
# ╟─de732f20-ff77-4f10-a196-50a1d0de640d
# ╠═0a1cdfaf-f869-47b7-b7d1-cfd7727a9b32
# ╠═b0c27c31-34fe-48b8-9acd-ec8ffc480bf7
# ╠═56184a34-2b88-4a34-921d-072c32e8a4dd
# ╠═efeab4e8-97ad-415f-9565-d6c131952528
# ╟─171496f1-1ce0-4971-9aa9-e33ee382e4f4
