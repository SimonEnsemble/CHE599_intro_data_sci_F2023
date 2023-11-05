### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 270166c0-7ab9-11ee-04f3-c7e8fe2c9cf5
begin
	import Pkg; Pkg.activate()
	using CSV, DataFrames, DecisionTree, CairoMakie, ColorSchemes, PlutoUI, Random
	import StatisticalMeasures.ConfusionMatrices.confmat
	import MLJBase: partition, StratifiedCV, train_test_pairs
end

# ╔═╡ 65b99621-b662-4514-8db3-057df7dc5a91
set_theme!(theme_minimal()); update_theme!(fontsize=20)

# ╔═╡ 923ccf15-c994-4e4c-a0cb-b1f23f5d80b3
TableOfContents()

# ╔═╡ 0dbc6f0f-e58e-428a-b060-1e13a8adf443
# how to get default CairoMakie color pallette
colors = CairoMakie.Makie.wong_colors()

# ╔═╡ fe8a65d8-d8f8-48ce-aa16-de81e0164088
md"## 🍷 classifying the variety of wine from its attributes

!!! warning \"objective\"
	our objective is to train and test a decision tree classifier for the task of predicting the variety of a bottle of wine based on measured features such as alcohol content, hue, etc. the data set that enables a machine learning approach to wine classifiation is from:
	> Aeberhard S, Coomans D, De Vel O. Comparative analysis of statistical pattern recognition methods in high dimensional settings. _Pattern Recognition_. 1994
	and is available for download from the UCI Machine Learning repository [here](https://archive.ics.uci.edu/dataset/109/wine). the summary of the data is:
	> these data are the results of a chemical analysis of wines grown in the same region in Italy but derived from three different cultivars. the analysis determined the quantities of 13 constituents found in each of the three types of wines. 
	note, all of the features are ~continuous. ie., they are not categorical, even though this would not be too much of a problem because decision trees can handle categorical variables.

## read in the data
🍷 read in the wine data from the UCI repository as a data frame. 

!!! hint
	the header is missing. see the `header` argument of `CSV.read`.
"

# ╔═╡ b7a7a030-758a-4af7-83df-28d49bbe7108
header = [
	"Variety", 
	"Alcohol", 
	"Malic acid", 
	"Ash",
	"Alcalinity of ash", 
	"Magnesium", 
	"Total phenols", 
	"Flavanoids", 
	"Nonflavanoid phenols", 
	"Proanthocyanins", 
	"Color intensity", 
	"Hue", 
	"OD280/OD315 of diluted wines", 
	"Proline"
] # you're welcome

# ╔═╡ 79e5479c-ef34-46d1-b4af-cb03ee1eed06


# ╔═╡ 4a4ef016-cead-4c5a-a7fc-5c32429c7983
md"🍷 how many different samples of wine are there in the data set?"

# ╔═╡ 8c0655a0-24e7-49b6-a85d-1094ea8ed19c


# ╔═╡ 4249a8f0-e719-464f-837f-a877ad745bc2
md"🍷 how many unique varities of wine are represented in the data set?"

# ╔═╡ 867a49d5-bdc8-4d83-a83e-6e78516ec191


# ╔═╡ 4f18e348-158d-49b9-a132-c30bdd6f2346
md"🍷 are there any wines with missing attributes?"

# ╔═╡ ec05464e-b0ff-43df-ba81-2e68ec25caec


# ╔═╡ e35161a0-c02c-4119-ab0a-c58bb4db00b6
md"## train, test decision tree classifier

### train/test split
🍷 randomly split the wines into a training and test set. 
* 60% train, 40% test. 
* use the `partition` function (see docs [here](https://docs.juliahub.com/General/MLJBase/0.18.15/datasets/#MLJBase.partition-Tuple{Any,%20Vararg{Any,%20N}%20where%20N})). 
* keep track of the split by storing the list of indices of the rows in the data frame that belong to each split (train, test). (so, like in the example in the docs, partition `1:n` where `n` is the number of wines.)
* ensure `shuffle=true` for the partition to be random. 
* use the `stratify` kwarg to ensure the varieties of wine are balanced among the two splits. 


"

# ╔═╡ 3772b7af-9890-4759-9ac3-d325fffd9a56


# ╔═╡ 921ac973-8354-424a-9921-2eb2797984ea
md"🍷 how many wines are in the train and test set, respectively?"

# ╔═╡ 5562a323-c79e-49c5-82a3-85405cf95dc4


# ╔═╡ 8dac1d29-4431-4736-890f-aa98209c91fb


# ╔═╡ f5e24c3b-4643-43ac-b41f-f72cc8cfcbbc
md"🍷 prepare the _target vectors_ for training and testing a decision tree by creating two vectors, `y_train` and `y_test`, that list the class (variety) of each wine in the train and test set, respectively. (of course, order matters.) use the output of `partition` to query the appropriate rows of the data frame."

# ╔═╡ a3d0ea5e-fc20-4208-a48d-320c4a872ccc


# ╔═╡ 6d854f3b-d0ca-4bec-bd97-c78146fdf0d8


# ╔═╡ fdbdc2fc-79d3-4dd1-b38e-1c2367753901


# ╔═╡ ab06452b-8e51-4288-a1ba-1426b9d5733c
md"🍷 prepare the _feature matrices_ for training and testing the decision tree by creating two matrices, `X_train` and `X_test`, that list the feature vectors of each wine in the train and test set, respectively, in its rows. (of course, order matters, and so does whether you put the feature vectors in the rows (correct for `DecisionTree.jl`) or columns (incorrect for `DecisionTree.jl`; you'd get an error message)).

!!! hint
	you can strip the column names off of a `DataFrame`, say `data`, and convert it into a `Matrix` (preserving the ordering of the rows and columns) via `Matrix(data)`. 
"

# ╔═╡ cb6c47c6-51d3-4736-93f8-7709af426c95


# ╔═╡ 2b97fb4b-54c0-45f6-a5c0-a76c7174c2a4


# ╔═╡ 8da5b581-bda3-4ff1-8cd9-22d495a44752
md"
!!! note
	when I say \"order matters\" I mean that eg. row 4 of `X_train`, `X_train[4, :]` gives the 13-dimensional feature vector for a wine whose label is `y_train[4]`.
"

# ╔═╡ d59e4591-97e9-485b-acf4-80149514f546
md"
### build the tree
🍷 construct and train a decision tree classifier on the training data. while usually we would tune the hyper-parameters of the tree using cross-validation, for the sake of simplicity for this assignment, set the hyperparameters _a priori_ as: 
* the tree may be grown to a maximum depth of 3
* the minimum number of training wines a leaf node can contain is 3
* the minimum number of wines needed to allow another split is 5
* (no pruning)

!!! note
	to train your decision tree, use the `DecisionTree.jl` package. see their documentation [here](https://github.com/JuliaAI/DecisionTree.jl).
"

# ╔═╡ c0e4bd97-7cd6-4dfb-b4d9-191937792764


# ╔═╡ da18aa42-5984-4253-acc2-993dd01ad101


# ╔═╡ 373e3c20-605e-4155-aafe-2eaa8f2c14fd
md"
### visualize the tree
🍷 use `print_tree` to visualize (1) the decisions being used by the tree to classify the wines and (2) how many of the training wines fell in each leaf node. which features are used by the decision tree?"

# ╔═╡ 2fff6577-a9cf-4d32-8b13-bc283a69a707


# ╔═╡ 43855ea9-ab44-49cb-9578-34eb81099256
md"
### evaluating/testing the tree
🍷 use the trained decision tree to predict the class label (ie. wine variety) on the wines in the train set and the test set and store these predicted labels in vectors `ŷ_train` and `ŷ_test`. use the `predict` function of `DecisionTree.jl` and your `X_train` and `X_test` feature matrices you constructed above."

# ╔═╡ ffe73898-e129-4139-baac-3659861c390e


# ╔═╡ 59b8e697-6293-49a0-87b3-2124c9f68691


# ╔═╡ f6a95e5e-8643-48ae-877b-b10552bc1877
md"🍷 compute the accuracy (fraction of examples for which the decision tree got its predictions right) of the decision tree on both the training and testing data separately."

# ╔═╡ 24d4db28-2c01-4584-ac9e-2ac27718132b


# ╔═╡ 814f6a8e-ed70-449c-aecc-03257c6a8279


# ╔═╡ 51f3d909-537e-41df-9fe0-110d28971afc
md"🍷 the _confusion matrix_ displays more information about the predictivity of the decision tree classifier than the accuracy score. use the `confmat` function from `StatisticalMeasures.jl` to compute and visualize the confusion matrix on (1) the training data and (2) the testing data.

!!! warning
	read about confusion matrices to make sure you understand what they are telling us. explain to your classmate to check your understanding.
"

# ╔═╡ 60336766-aa44-4844-98e7-08074fd5ac55


# ╔═╡ 2aeef754-2f6b-4cae-9169-5926829793b4


# ╔═╡ b78d4047-0d88-4a44-8c72-741e5c579149
md"🍷 based on (i) the accuracy score and (2) the confusion matrix, how does the performance of the decision tree on train vs. test data compare? is this expected?

_compared to the accuracy on the training data, the accuracy on the test data is [lower or higher], and I [did or did not] expect this because [...]._
"

# ╔═╡ db7472e6-b516-49b4-9ef4-beeffe0d23e3
md"
## post-classifier data analysis

🍷 the feature used at the root node of the decision tree led to the best first split. let's visualize how well the three varities of wines are separated according to this single feature. draw three histograms, on the same panel but with different colors, showing the distributions of this feature for the three varieties. make the histograms have a transparency and use a legend to indicate which variety is which color. as always, include x- and y-axis labels.

💡 if these distributions are well-separated, then classification based on this single feature would have decent accuracy. on the other hand, if the histograms exhibit a lot of overlap, then classification based on this feature is impossible. note, the power of decision trees is that they can leverage all 13 variables instead of just one---we can't make a histogram like this in 13 dimensions!
"

# ╔═╡ 63c26d1b-dde4-49d1-8e21-4a17aef83bc8


# ╔═╡ ebbf4a61-b462-43be-88cc-1b872cb616d8


# ╔═╡ Cell order:
# ╠═270166c0-7ab9-11ee-04f3-c7e8fe2c9cf5
# ╠═65b99621-b662-4514-8db3-057df7dc5a91
# ╠═923ccf15-c994-4e4c-a0cb-b1f23f5d80b3
# ╠═0dbc6f0f-e58e-428a-b060-1e13a8adf443
# ╟─fe8a65d8-d8f8-48ce-aa16-de81e0164088
# ╠═b7a7a030-758a-4af7-83df-28d49bbe7108
# ╠═79e5479c-ef34-46d1-b4af-cb03ee1eed06
# ╟─4a4ef016-cead-4c5a-a7fc-5c32429c7983
# ╠═8c0655a0-24e7-49b6-a85d-1094ea8ed19c
# ╟─4249a8f0-e719-464f-837f-a877ad745bc2
# ╠═867a49d5-bdc8-4d83-a83e-6e78516ec191
# ╟─4f18e348-158d-49b9-a132-c30bdd6f2346
# ╠═ec05464e-b0ff-43df-ba81-2e68ec25caec
# ╟─e35161a0-c02c-4119-ab0a-c58bb4db00b6
# ╠═3772b7af-9890-4759-9ac3-d325fffd9a56
# ╟─921ac973-8354-424a-9921-2eb2797984ea
# ╠═5562a323-c79e-49c5-82a3-85405cf95dc4
# ╠═8dac1d29-4431-4736-890f-aa98209c91fb
# ╟─f5e24c3b-4643-43ac-b41f-f72cc8cfcbbc
# ╠═a3d0ea5e-fc20-4208-a48d-320c4a872ccc
# ╠═6d854f3b-d0ca-4bec-bd97-c78146fdf0d8
# ╠═fdbdc2fc-79d3-4dd1-b38e-1c2367753901
# ╟─ab06452b-8e51-4288-a1ba-1426b9d5733c
# ╠═cb6c47c6-51d3-4736-93f8-7709af426c95
# ╠═2b97fb4b-54c0-45f6-a5c0-a76c7174c2a4
# ╟─8da5b581-bda3-4ff1-8cd9-22d495a44752
# ╟─d59e4591-97e9-485b-acf4-80149514f546
# ╠═c0e4bd97-7cd6-4dfb-b4d9-191937792764
# ╠═da18aa42-5984-4253-acc2-993dd01ad101
# ╟─373e3c20-605e-4155-aafe-2eaa8f2c14fd
# ╠═2fff6577-a9cf-4d32-8b13-bc283a69a707
# ╟─43855ea9-ab44-49cb-9578-34eb81099256
# ╠═ffe73898-e129-4139-baac-3659861c390e
# ╠═59b8e697-6293-49a0-87b3-2124c9f68691
# ╟─f6a95e5e-8643-48ae-877b-b10552bc1877
# ╠═24d4db28-2c01-4584-ac9e-2ac27718132b
# ╠═814f6a8e-ed70-449c-aecc-03257c6a8279
# ╟─51f3d909-537e-41df-9fe0-110d28971afc
# ╠═60336766-aa44-4844-98e7-08074fd5ac55
# ╠═2aeef754-2f6b-4cae-9169-5926829793b4
# ╠═b78d4047-0d88-4a44-8c72-741e5c579149
# ╟─db7472e6-b516-49b4-9ef4-beeffe0d23e3
# ╠═63c26d1b-dde4-49d1-8e21-4a17aef83bc8
# ╠═ebbf4a61-b462-43be-88cc-1b872cb616d8
