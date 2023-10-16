### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 99004b2e-36f7-11ed-28ae-f3f75c823964
begin
	import Pkg; Pkg.activate()
	using CSV, DataFrames, CairoMakie, PlutoUI, Colors, LinearAlgebra, MolecularGraph
end

# ╔═╡ eb94cba7-7bbe-4948-bcdb-99e24fb36386
TableOfContents()

# ╔═╡ d952b919-f534-432a-a5c9-44bb98063ab2
md"tuning the theme for `Makie`."

# ╔═╡ f1538e5a-c3ce-4c19-a588-ca89d7cb7d1f
update_theme!(
	resolution=(500, 400), 
	font="Noto Sans", 
	linewidth=3, 
	backgroundcolor="#FAF7F2", 
	Axis=(xgridstyle=:dash, 
		  ygridstyle=:dash, 
		  xtickalign=1, 
		  ytickalign=1, 
		  titlefont="Noto Sans"
	),
	palette = (color=["#34495e", "#3498db", "#2ecc71", "#f1c40f", 
					"#e74c3c", "#9b59b6", "#1abc9c", "#f39c12",
					"#d35400"], 
			   marker=[:circle, :utriangle, :cross, :rect, 
				 	 :diamond, :dtriangle, :pentagon, :xcross]
	)
)

# ╔═╡ f548409f-bb9b-4903-b66f-c76ac64e0e31
md"# processing odorant perception data

**objective**: pre-process, combine, and analyze the odorant perception data of _Goodscents_ and _Leffingwell_, obtained from [_The Pyrfume Project_](https://pyrfume.org/). 

!!! warning \"the data\"
	loosely, each instance in the tabular data fundamentally represents the outcome of an experiment where we expose a human to a pure compound and ask them what it smells like.

!!! note \"why are we doing this?\"
	we combine this data to mimic the procedure in [\"Machine Learning for Scent: Learning Generalizable
	Perceptual Representations of Small Molecules\"](https://arxiv.org/abs/1910.10685). this study treated the machine learning task of odorant perception as a multi-class classification problem: a molecule is input to the machine learning model, and the output is the predicted odor descriptor for the molecule. 
	i.e., the machine learning model serves as a surrogate for the olfactory perception system in humans! read more at the [Google AI blog](https://ai.googleblog.com/2019/10/learning-to-smell-using-deep-learning.html). a more recent follow-up olfactory study was published in _Science_ [here](https://www.science.org/doi/10.1126/science.ade4401).

!!! note \"the raw data\"
	I wrote a Python script `get_data.py` that employs the `pyrfume` package to query the raw data from Goodscents and Leffingwell. both the Python script and the resulting `.csv` files are on the Github repo [here](https://github.com/SimonEnsemble/CHE599_intro_data_sci_F2023/tree/main/activites/odorant_data_processing).

!!! note \"SMILES strings\"
	[simplified molecular-input line-entry system (SMILES)](https://en.wikipedia.org/wiki/Simplified_molecular-input_line-entry_system) is used to specify the molecule in the olfaction survey.

"

# ╔═╡ 4c6c310e-130c-4334-86c0-74b271c5a353
md"## read in and process the Leffingwell data set

### behaviors

👃 read in `behaviors_sparse.csv`, which lists the olfactory perception labels on the molecules in the Leffingwell data set, as a `DataFrame`, `leffingwell_behaviors`.
"

# ╔═╡ dc7bd01b-17d7-4276-986e-e273d6072430

# ╔═╡ 9583319c-abbf-4986-8a0e-c98aaba0bfdd
md"### stimuli

👃 read in `stimuli.csv` as a `DataFrame`, `leffingwell_stimuli`."

# ╔═╡ 00f67da6-4d8f-46cf-bdf1-4baba2b33253

# ╔═╡ 4c232ff2-5d7a-4c70-88ce-bf9937b01076
md"### join
👃 we wish to match up molecules described by their SMILES strings with their olfactory perception labels. join the `leffingwell_stimuli` and `leffingwell_behaviors` data tables to do so. assign the joined tables to a variable `leffingwell`.
"

# ╔═╡ 19613f27-7358-417e-b77d-15d734a88e42

# ╔═╡ fdc340bd-28f1-4278-88ef-1edbe4f5bb7f
md"
### trim/clean
👃 to avoid distraction, remove all columns from the `leffingwell` data frame except for the `\"IsomericSMILES\"` and `\"Labels\"` columns."

# ╔═╡ 5fc8cd54-139c-4511-9c42-e06a2b992a68

# ╔═╡ 5957d5e7-a71e-4e10-a33c-959885a91f36
md"👃 for clarity, rename the `\"IsomericSMILES\"` column in `leffingwell` to `\"molecule\"` and the `\"Labels\"` column to `\"odor (Leffingwell)\"`."

# ╔═╡ de7614bb-2037-46c2-9fa3-1d7590f672ce

# ╔═╡ 397a08ef-5ff3-41a2-8d13-78d9c72ad706
md"👃 in the `\"odor (Leffingwell)\"` column, remove all characters `]`, `[`, `'`, and `,` in preparation for splitting the long string into a vector of odor perception labels.

!!! hint
	use `transform!`. you can over-write a column. also use the `replace` command for `String`'s.
"

# ╔═╡ 6e6f641c-f6c6-4387-9271-ffc32b69f5d4

# ╔═╡ 8f5e6978-9016-4bff-ae41-033f5be4219a
md"👃 compare the number of _unique_ molecules in the rows of the `leffingwell` data frame with the number of rows. i.e., is the molecule represented in each row unique?"

# ╔═╡ bc94bbbe-c2e4-46bf-804c-e51256b2373d

# ╔═╡ 89422b3f-72f9-4de4-bb5e-76a975376b38
md"## read in and process the Goodscents data

### behaviors
👃 read in the `behaviors.csv` of the Goodscents data set as a data frame, `goodscents_behaviors`. the odor perception labels are stored in the `\"Descriptors\"` column, and the identity of the molecule is indicated by the `\"Stimulus\"` column.
"

# ╔═╡ 07ce7883-f61f-4113-99ba-2195b4e41dfa

# ╔═╡ 08b97919-4b89-494f-80d4-ab3aec6da6c5
md"### stimuli
👃 read in the `stimuli.csv` of the Goodscents data set as a data frame, `goodscents_stimuli`."

# ╔═╡ f7d72939-f78d-476a-978a-b48fe6a51cec

# ╔═╡ 46eeac6d-77ac-4002-9fb0-43f4e9fb42d1
md"### molecules
👃 read in the `molecules.csv` of the Goodscents data set as a data frame, `goodscents_molecules`."

# ╔═╡ bd1bdb6a-51e8-43f3-85d5-cbf757686cc8

# ╔═╡ 540533e3-7a14-4f01-a291-e4bb8b86fda9
md"### join

👃 again, we wish to join the three tables so as to link together (i) the molecule described by its SMILES string with (ii) its odor perception labels. conduct these necessary joins and assign the final joined table as `goodscents`.
"

# ╔═╡ 90f9b206-6e16-440e-801c-8ac198ad970a

# ╔═╡ 600197f1-a9d5-478b-8fa0-6deac3d25b57

# ╔═╡ 25fcc550-342c-46f5-b70d-74314c9680f6
md"### trim/clean

for clarity and to remove distraction, modify the `goodscents` data frame by:
* renaming the `\"IsomericSMILES\"` column to \"molecule\"
* renaming the `\"Descriptors\"` column to `\"odor (Goodscents)\"`.
* removing all columns except `\"molecule\"` and `\"odor (Goodscents)\"`.
"

# ╔═╡ 0ef23c71-c420-4f0c-8f7b-5ee2da0d765a

# ╔═╡ 5366f0cf-e533-4b91-a5aa-e6d116fca206
md"👃 display the rows with missing entries so we can see what molecules they pertain to and see how many there are.

!!! hint
	`filter`
"

# ╔═╡ 7f5d3228-e1a4-4972-b3b1-37650267859c

# ╔═╡ e0aa196d-bbd2-42ff-8ba1-95f3f9120db4
md"👃 drop the missing rows from the `goodscents` data table."

# ╔═╡ 7844b67b-b329-4fdb-8b2e-dd386b8e00e6

# ╔═╡ a5d0d0de-b54e-4e11-8176-8c2cb45f15e5
md"👃 to make the `\"odor (Goodscents)\"` column match the formatting of labels in the `leffingwell` data frame, convert the `;` characters to spaces."

# ╔═╡ 0efb02f9-c787-4565-aa58-cd4cc8f5fbb6

# ╔═╡ e221d029-7526-4cb1-9df5-fd9624f74635
md"👃 compare the number _unique_ molecules (SMILES strings) in the `goodscents` data frame with the number of rows in it.

!!! hint
	there are duplicate molecules! 😱
"

# ╔═╡ 1c87d0fd-8eef-4284-8d9d-05e02472d26e

# ╔═╡ 14a1bb54-35fe-4e77-acab-fca1f7671165

# ╔═╡ eff6c147-d2d0-4cb6-8ff7-67a9c7469a9e
md"👃 display the rows of the data frame that pertain to duplicate molecules. sort according to the molecule to _really easily_ see the duplications. 

!!! hint
	use `filter`. I found it to have 119 rows.
"

# ╔═╡ 1a0004f9-714a-4fda-beb8-b38647bc223a

# ╔═╡ 54bdbcdc-dff8-4771-b1d7-a89c0f4b164c
md"👃 merge rows in `goodscents` that pertain to the same molecule by concatenating the list of their odors with a space in between. e.g.

| molecule | odor (Goodscents) |
| --- | ----------- |
| \"C(=O)O\" | \"acetic vinegar pungent\" |
| \"C(=O)O\" | \"acetic fermented sharp fruity\" |

--->

| molecule | odor (Goodscents) |
| --- | ----------- |
| \"C(=O)O\" | \"acetic vinegar pungent acetic fermented sharp fruity\" |

we will remove duplicate odor labels later.

!!! hint
	I wrote a function `combine_col` and used it for a `combine` and `groupby`. also, string concatenation works as follows: `\"cory\" * \" \" * \"simon\"`.

assign the new data frame as `goodscents_fixed`.
"

# ╔═╡ d962f970-e62c-4a05-8219-2c81a54bdaba

# ╔═╡ 9ad586da-ccbc-46e8-8e93-7f59ffb3bfd3

# ╔═╡ 614195ed-bd2f-444f-ac82-f2b8511117da
md"👃 check, _now_, that the number of rows in `goodscents_fixed` is equal to the number of unique molecules in the `\"molecules\"` column."

# ╔═╡ 1704b383-163e-47e8-93ea-9e28170fbb6d

# ╔═╡ 26a2edab-2bb5-4ca6-89ff-d2358ae9512c
md"## 🚀 join the Leffingwell and Goodscents data sets

👃 conduct an outer-join of your `leffingwell` and `goodscents_fixed` data frames. of course, join on the `molecule`. explain what we mean by \"outer join\". assigned the joined data as a data frame `_data`.
"

# ╔═╡ b3c8b89e-0806-410e-b991-f288454811e6

# ╔═╡ f6768d02-f015-4a0b-bce0-5478e7d613f1
md"how many molecules:
* are present in the joined data frame, `data`?
judging from the pattern of `missing`'s, 
* are present in _both_ the Leffingwell and Goodscents data sets?
* are present in the Goodscents data set, but not the Leffingwell data set?
* are present in the Leffingwell data set, but not the Goodscents data set?
"

# ╔═╡ 1e270a21-497e-48fb-bdc5-7d25634e7e98

# ╔═╡ 20a0fee0-1436-409d-93c1-07c2cb15c31b

# ╔═╡ 526c3b02-0aca-413d-b45b-f8ed477e494c

# ╔═╡ 7ed96a3d-3509-4c1d-8b40-9abc67f42b9c

# ╔═╡ e02f4169-d3b5-4807-a561-ad8004ebdd7d
md"
👃 getting ready to combine the odor columns into one, replace each occurance of `missing` with an empty string `\"\"`. assign the resulting data frame to variable `data`.
"

# ╔═╡ e03e0656-9198-4419-ac8b-97ef98f37c3f

# ╔═╡ d83bcd9b-895f-47b8-b99e-a6eaabd9a62c
md"👃 append a new column to `data`, `\"odor\"` that contains the union of the odor labels from the Goodscents and Leffingwell studies.

!!! hint
	use `transform` where two columns are combined. this is a string concatenation. ensure you put a space between the words to avoid eg. `grassyfishy`.
"

# ╔═╡ 58930559-7dd7-461b-8ca8-cdeab3cdb14f

# ╔═╡ 788a8f26-b22a-4035-ab15-20c8d776fa71
md"👃 convert the `odor` column, currently a long `String` where olfactory labels are separated by spaces, into a vector of `String`'s, one for each olfactory perception label. also, avoid repeated olfactory labels on the same molecule using `unique`."

# ╔═╡ 5b968cbc-e084-4a4b-be7b-59947e760175

# ╔═╡ 664a1da4-e753-4617-9dd6-09e7e1fea44d
md"👃 to avoid distraction, delete all columns from `data` except for `\"molecule\"` and `\"odor\"`.
"

# ╔═╡ 5dbf1a4d-60f1-4d34-947b-cf6408b4c903

# ╔═╡ d44d24ed-5c20-4003-bbb3-75a5dec7b499
md"🚀 voila! this is the joined data! machine learning studies are predicated on large data sets, so combining the data from these two sources should help with e.g. predictivity of the smell of a molecule by a machine learning algorithm trained on this data (compared to e.g. just using Leffingwell or Goodscents alone).
"

# ╔═╡ 905dc26a-fc2c-47a0-8569-a4b7a4541cfa
md"## analysis of the joined data
the goal here is to conduct a similar analysis of the olfactory data as in Fig. 3 [here](https://arxiv.org/pdf/1910.10685.pdf).
"

# ╔═╡ 9208b96f-963f-4fca-9a2e-3803160f11b1
md"
### odor labels per molecule
👃 append a new column to `data`, `\"# odor labels\"`, that lists the number of unique olfactory perception labels on each molecule in the data."

# ╔═╡ a11f06bb-9fcc-431d-9967-f8d26aa44bf2

# ╔═╡ b562ad25-45e5-4fc9-8d74-27b9727e4766
md"👃 create a data frame `odor_label_counts` that lists the # of molecules with a given number of odor labels.

| # odor labels | # molecules |
| ---- | ---- |
| 1 | 703 | 
| 2 | 665 |
| ... | ... |

"

# ╔═╡ 0233d3e0-c934-48c2-be82-8e041227aec5

# ╔═╡ 2a2910af-dcf2-4aa7-bfc3-32950d73cc9e
md"👃 like in Fig. 3a [here](https://arxiv.org/pdf/1910.10685.pdf) (yours will be a bit different), create a bar plot visualizing the number of molecules with a given number of olfactory labels on it. use your data frame `odor_label_counts` for this."

# ╔═╡ ec3b2463-4284-41bb-9c60-63ba8a7b6705

# ╔═╡ 53f58ff1-1f99-4205-9346-bf2f8ad4e74d
md"
### molecules that smell a certain way
👃 how many molecules in the data include a label \"mint\"?"

# ╔═╡ b1a04dc4-b281-413d-8cc0-3f704d1e6e3b

# ╔═╡ 82b4049e-5c34-43a4-85e4-fd95c1693989
md"👃 draw the molecular structure of the molecules that are labeled \"mint\" _and_ \"eucalyptus\".

!!! hint
	use `smilestomol` [here](https://mojaie.github.io/MolecularGraph.jl_notebook/molecular_graph_basics.jl.html).
"

# ╔═╡ 9e69ba26-4f61-4b54-94d8-986ed3d5a704

# ╔═╡ c8c928e8-f16c-4c6c-a807-5d64183e6d4d

# ╔═╡ 832897f7-88fb-4389-b051-51adfec3db01

# ╔═╡ 64bfc9fb-5866-426d-93ce-90521bf93356

# ╔═╡ 47478ef0-a512-47d4-a171-74e073cab810
md"
### molecules per odor label
👃 we now wish to visualize the prevalence of each odor descriptor. create a bar plot that shows, for each unique odor label, how many molecules have that odor (according to the experts in the studies). 
* sort the bars according to odor prevalance
* make the bars go from left to right
* include the odor name on the y-axis
* include x- and y-axis labels (x-axis = # molecules, y-axis = odor)

in my view, this is a better way to present the (actually, MORE) information (than) in Fig. 3b [here](https://arxiv.org/pdf/1910.10685.pdf).

!!! warning
	this is very challenging. 

!!! hint
	to actually read the many odor labels, use `Figure(resolution=(500, 10000))` to make a long figure that you can scroll through.
"

# ╔═╡ 25a5c232-a0f6-4a1b-8f91-3cee5d97b3db

# ╔═╡ 75e8312d-1614-4626-99d1-3e07fdec8bab

# ╔═╡ 3d1f7cfa-ae9b-4ed1-9261-595fee65a974

# ╔═╡ fa50cac7-64f9-4439-9645-c6c0b4fa0b99

# ╔═╡ 28ec1019-f51e-4dd9-a5ca-cfd0a095fcea

# ╔═╡ 2045e894-396b-44d3-8dd8-ff0b88c598c2
md"
### molecules with certain chemistry
👃 how many of the odorants have a carbonyl group in their structure? this is expressed as the SMARTS pattern \"[CX3]=[OX1]\".

!!! hint
	see `has_substruct_match` [here](https://mojaie.github.io/MolecularGraph.jl_notebook/substructure_and_query.jl.html).
"

# ╔═╡ 86683b41-7b2a-471f-b817-bc0925c3770f

# ╔═╡ 493328f4-fcfd-49d4-84f7-6540ea6d2319

# ╔═╡ 72101250-16ae-4c20-a7aa-e1479a41860f

# ╔═╡ 58b6234b-a10e-46de-8031-ab65028d3c89
md"
### co-occurances of labels
the paper notes
> there is an extremely strong co-occurrence structure among odor descriptors that reflects a common-sense intuition of which odor descriptors are similar and dissimilar.

👃 (a strong co-occurance) among all molecules with \"apple\" as an olfactory label, what fraction of these also have the label `\"fruity\"?
"

# ╔═╡ 8bd8627b-9884-4efd-acf9-e1e57a52c833

# ╔═╡ 06eabbc3-94af-4b76-9369-9e5df468cbbc

# ╔═╡ 494521db-50e9-48ee-913e-1ac3c70d3172

# ╔═╡ 380f9d36-fb68-490a-9021-16c265056a3e
md"👃 (a weak co-occurance) among all molecules with the label \"cabbage\", what fraction also have the label \"musk\"?"

# ╔═╡ c63f9137-574d-4c70-91ce-99fdc304bf02

# ╔═╡ 1b3230db-bdda-4c71-9b33-31c779d50a7b

# ╔═╡ 7242a8c3-362c-4df9-b518-1a2a40ca2f39

# ╔═╡ ecafa8cd-d3ea-4d9e-b3c6-b95f3cc40d81
md"
### fruity or not
suppose we wish to build a binary classifier that predicts if a molecule is fruity or not.

👃 create a new data frame `fruity_or_not` that indicates whether the molecule smells fruity or not and looks as follows:

| molecule | fruity |
| ---- | ---- |
| CC(=O)C1=CC=C(C=C1)OC | false | 
| C1=CC=C(C=C1)CO | true |
| ... | ... |

"


# ╔═╡ 9957624b-4e09-498e-940b-180bda75aea0

# ╔═╡ 341adcd7-3241-492b-b150-bb43492168b4

# ╔═╡ 0817a02b-42f1-4b56-a41c-e93aa24f6129
md"👃 write the data frame `fruity_or_not` to a `.csv` file for using later in the class, `fruity_or_not.csv`."

# ╔═╡ 5e167ec5-7529-4fdd-8c60-39ea2779bf10

# ╔═╡ e1dd2552-6846-41a9-a9b1-a360f719cc22
md"### 🤔 be curious about your data

part of being a data scientist is being curious about your data. asking the right questions to get insights. come up with your _own_ question about the data and answer it below.

👃 [...]
"

# ╔═╡ ed30f9b0-8336-4d14-81a2-a3e777ea8b40


# ╔═╡ Cell order:
# ╠═99004b2e-36f7-11ed-28ae-f3f75c823964
# ╠═eb94cba7-7bbe-4948-bcdb-99e24fb36386
# ╟─d952b919-f534-432a-a5c9-44bb98063ab2
# ╠═f1538e5a-c3ce-4c19-a588-ca89d7cb7d1f
# ╟─f548409f-bb9b-4903-b66f-c76ac64e0e31
# ╟─4c6c310e-130c-4334-86c0-74b271c5a353
# ╠═dc7bd01b-17d7-4276-986e-e273d6072430
# ╟─9583319c-abbf-4986-8a0e-c98aaba0bfdd
# ╠═00f67da6-4d8f-46cf-bdf1-4baba2b33253
# ╟─4c232ff2-5d7a-4c70-88ce-bf9937b01076
# ╠═19613f27-7358-417e-b77d-15d734a88e42
# ╟─fdc340bd-28f1-4278-88ef-1edbe4f5bb7f
# ╠═5fc8cd54-139c-4511-9c42-e06a2b992a68
# ╟─5957d5e7-a71e-4e10-a33c-959885a91f36
# ╠═de7614bb-2037-46c2-9fa3-1d7590f672ce
# ╟─397a08ef-5ff3-41a2-8d13-78d9c72ad706
# ╠═6e6f641c-f6c6-4387-9271-ffc32b69f5d4
# ╟─8f5e6978-9016-4bff-ae41-033f5be4219a
# ╠═bc94bbbe-c2e4-46bf-804c-e51256b2373d
# ╟─89422b3f-72f9-4de4-bb5e-76a975376b38
# ╠═07ce7883-f61f-4113-99ba-2195b4e41dfa
# ╟─08b97919-4b89-494f-80d4-ab3aec6da6c5
# ╠═f7d72939-f78d-476a-978a-b48fe6a51cec
# ╟─46eeac6d-77ac-4002-9fb0-43f4e9fb42d1
# ╠═bd1bdb6a-51e8-43f3-85d5-cbf757686cc8
# ╟─540533e3-7a14-4f01-a291-e4bb8b86fda9
# ╠═90f9b206-6e16-440e-801c-8ac198ad970a
# ╠═600197f1-a9d5-478b-8fa0-6deac3d25b57
# ╟─25fcc550-342c-46f5-b70d-74314c9680f6
# ╠═0ef23c71-c420-4f0c-8f7b-5ee2da0d765a
# ╟─5366f0cf-e533-4b91-a5aa-e6d116fca206
# ╠═7f5d3228-e1a4-4972-b3b1-37650267859c
# ╟─e0aa196d-bbd2-42ff-8ba1-95f3f9120db4
# ╠═7844b67b-b329-4fdb-8b2e-dd386b8e00e6
# ╟─a5d0d0de-b54e-4e11-8176-8c2cb45f15e5
# ╠═0efb02f9-c787-4565-aa58-cd4cc8f5fbb6
# ╟─e221d029-7526-4cb1-9df5-fd9624f74635
# ╠═1c87d0fd-8eef-4284-8d9d-05e02472d26e
# ╠═14a1bb54-35fe-4e77-acab-fca1f7671165
# ╟─eff6c147-d2d0-4cb6-8ff7-67a9c7469a9e
# ╠═1a0004f9-714a-4fda-beb8-b38647bc223a
# ╟─54bdbcdc-dff8-4771-b1d7-a89c0f4b164c
# ╠═d962f970-e62c-4a05-8219-2c81a54bdaba
# ╠═9ad586da-ccbc-46e8-8e93-7f59ffb3bfd3
# ╟─614195ed-bd2f-444f-ac82-f2b8511117da
# ╠═1704b383-163e-47e8-93ea-9e28170fbb6d
# ╟─26a2edab-2bb5-4ca6-89ff-d2358ae9512c
# ╠═b3c8b89e-0806-410e-b991-f288454811e6
# ╟─f6768d02-f015-4a0b-bce0-5478e7d613f1
# ╠═1e270a21-497e-48fb-bdc5-7d25634e7e98
# ╠═20a0fee0-1436-409d-93c1-07c2cb15c31b
# ╠═526c3b02-0aca-413d-b45b-f8ed477e494c
# ╠═7ed96a3d-3509-4c1d-8b40-9abc67f42b9c
# ╟─e02f4169-d3b5-4807-a561-ad8004ebdd7d
# ╠═e03e0656-9198-4419-ac8b-97ef98f37c3f
# ╟─d83bcd9b-895f-47b8-b99e-a6eaabd9a62c
# ╠═58930559-7dd7-461b-8ca8-cdeab3cdb14f
# ╟─788a8f26-b22a-4035-ab15-20c8d776fa71
# ╠═5b968cbc-e084-4a4b-be7b-59947e760175
# ╟─664a1da4-e753-4617-9dd6-09e7e1fea44d
# ╠═5dbf1a4d-60f1-4d34-947b-cf6408b4c903
# ╟─d44d24ed-5c20-4003-bbb3-75a5dec7b499
# ╟─905dc26a-fc2c-47a0-8569-a4b7a4541cfa
# ╟─9208b96f-963f-4fca-9a2e-3803160f11b1
# ╠═a11f06bb-9fcc-431d-9967-f8d26aa44bf2
# ╟─b562ad25-45e5-4fc9-8d74-27b9727e4766
# ╠═0233d3e0-c934-48c2-be82-8e041227aec5
# ╟─2a2910af-dcf2-4aa7-bfc3-32950d73cc9e
# ╠═ec3b2463-4284-41bb-9c60-63ba8a7b6705
# ╟─53f58ff1-1f99-4205-9346-bf2f8ad4e74d
# ╠═b1a04dc4-b281-413d-8cc0-3f704d1e6e3b
# ╟─82b4049e-5c34-43a4-85e4-fd95c1693989
# ╠═9e69ba26-4f61-4b54-94d8-986ed3d5a704
# ╠═c8c928e8-f16c-4c6c-a807-5d64183e6d4d
# ╠═832897f7-88fb-4389-b051-51adfec3db01
# ╠═64bfc9fb-5866-426d-93ce-90521bf93356
# ╟─47478ef0-a512-47d4-a171-74e073cab810
# ╠═25a5c232-a0f6-4a1b-8f91-3cee5d97b3db
# ╠═75e8312d-1614-4626-99d1-3e07fdec8bab
# ╠═3d1f7cfa-ae9b-4ed1-9261-595fee65a974
# ╠═fa50cac7-64f9-4439-9645-c6c0b4fa0b99
# ╠═28ec1019-f51e-4dd9-a5ca-cfd0a095fcea
# ╟─2045e894-396b-44d3-8dd8-ff0b88c598c2
# ╠═86683b41-7b2a-471f-b817-bc0925c3770f
# ╠═493328f4-fcfd-49d4-84f7-6540ea6d2319
# ╠═72101250-16ae-4c20-a7aa-e1479a41860f
# ╟─58b6234b-a10e-46de-8031-ab65028d3c89
# ╠═8bd8627b-9884-4efd-acf9-e1e57a52c833
# ╠═06eabbc3-94af-4b76-9369-9e5df468cbbc
# ╠═494521db-50e9-48ee-913e-1ac3c70d3172
# ╟─380f9d36-fb68-490a-9021-16c265056a3e
# ╠═c63f9137-574d-4c70-91ce-99fdc304bf02
# ╠═1b3230db-bdda-4c71-9b33-31c779d50a7b
# ╠═7242a8c3-362c-4df9-b518-1a2a40ca2f39
# ╟─ecafa8cd-d3ea-4d9e-b3c6-b95f3cc40d81
# ╠═9957624b-4e09-498e-940b-180bda75aea0
# ╠═341adcd7-3241-492b-b150-bb43492168b4
# ╟─0817a02b-42f1-4b56-a41c-e93aa24f6129
# ╠═5e167ec5-7529-4fdd-8c60-39ea2779bf10
# ╟─e1dd2552-6846-41a9-a9b1-a360f719cc22
# ╠═ed30f9b0-8336-4d14-81a2-a3e777ea8b40
