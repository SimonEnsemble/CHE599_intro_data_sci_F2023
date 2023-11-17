### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 270166c0-7ab9-11ee-04f3-c7e8fe2c9cf5
begin
	import Pkg; Pkg.activate()
	using CSV, DataFrames, DecisionTree, CairoMakie, ColorSchemes, PlutoUI, Random, ARFFFiles, Statistics
	import StatisticalMeasures.ConfusionMatrices.confmat
	import StatisticalMeasures.bacc
	import MLJBase: partition, StratifiedCV, train_test_pairs
end

# ╔═╡ 65b99621-b662-4514-8db3-057df7dc5a91
update_theme!(fontsize=20, resolution=(450, 450), markersize=15, linewidth=3)

# ╔═╡ 923ccf15-c994-4e4c-a0cb-b1f23f5d80b3
TableOfContents()

# ╔═╡ 0dbc6f0f-e58e-428a-b060-1e13a8adf443
# how to get default CairoMakie color pallette
colors = CairoMakie.Makie.wong_colors()

# ╔═╡ fe8a65d8-d8f8-48ce-aa16-de81e0164088
md"## 🍚 classifying the variety of rice from its grains

!!! warning \"objective\"
	our objective is to train and test a decision tree classifier for the task of predicting the variety of rice based on measured features of its grains from imaging. see the following paper for details:
	> I Cinar, M Koklu. Classification of Rice Varieties Using Artificial Intelligence Methods. _International Journal ofIntelligent Systems and Applications in Engineering_ 2019. [link](https://ijisae.org/index.php/IJISAE/article/view/1068/599)
	unique to this assignment, we will employ a cross validation routine to determine the optimal hyperparameter for the decision tree---specifically, the minimum number of samples we allow a leaf of the tree to have.
	
!!! note
	to train your decision tree, use the `DecisionTree.jl` package. see their documentation [here](https://github.com/JuliaAI/DecisionTree.jl).

## read in the data
🍚 read in the [rice data from the UCI repository](http://archive.ics.uci.edu/dataset/545/rice+cammeo+and+osmancik) as a data frame. 

!!! hint
	look at how the file is formatted. I used the `ARFFFiles` package.
"

# ╔═╡ 79e5479c-ef34-46d1-b4af-cb03ee1eed06


# ╔═╡ 478c6a7b-0f6f-41e7-9900-f0186adbeba5


# ╔═╡ 11f7e4d0-0d36-4527-9185-6deb29063c23
md"🍚 how many examples of each class of rice are there? use a `combine` and `groupby`.
"

# ╔═╡ 348f2053-8f95-41b2-ac3e-74ca37bf7b0e


# ╔═╡ 4f18e348-158d-49b9-a132-c30bdd6f2346
md"🍚 are there any examples with missing attributes?"

# ╔═╡ d55856ba-4c40-4568-90cc-11855239eec9


# ╔═╡ e35161a0-c02c-4119-ab0a-c58bb4db00b6
md"## train, test decision tree classifier

### train/test split
🍚 randomly split the rice grains into a training and test set. 
* 70% train, 30% test. 
* use the `partition` function (see docs [here](https://docs.juliahub.com/General/MLJBase/0.18.15/datasets/#MLJBase.partition-Tuple{Any,%20Vararg{Any,%20N}%20where%20N})). 
* ensure `shuffle=true` for the partition to be random. 
* use the `stratify` kwarg to ensure the varieties of rice are balanced among the two splits. 
"

# ╔═╡ 3772b7af-9890-4759-9ac3-d325fffd9a56


# ╔═╡ 921ac973-8354-424a-9921-2eb2797984ea
md"🍚 how many rice grains are in the train and test set, respectively?"

# ╔═╡ 5562a323-c79e-49c5-82a3-85405cf95dc4


# ╔═╡ 8dac1d29-4431-4736-890f-aa98209c91fb


# ╔═╡ f5e24c3b-4643-43ac-b41f-f72cc8cfcbbc
md"🍚 prepare the _target vectors_ for training and testing a decision tree by creating two vectors, `y_train` and `y_test`, that list the class (variety) of each rice grain in the train and test set, respectively. (of course, order matters.)

!!! note
	the decision tree classifier and performance metric functions can handle `String`'s as labels, so no need to encode them as integers 😄.
"

# ╔═╡ a3d0ea5e-fc20-4208-a48d-320c4a872ccc


# ╔═╡ 6d854f3b-d0ca-4bec-bd97-c78146fdf0d8


# ╔═╡ ab06452b-8e51-4288-a1ba-1426b9d5733c
md"🍚 prepare the _feature matrices_ for training and testing the decision tree by creating two matrices, `X_train` and `X_test`, that list the feature vectors of each rice grain in the train and test set, respectively, in its rows. 

!!! hint
	you can strip the column names off of a `DataFrame`, say `data`, and convert it into a `Matrix` (preserving the ordering of the rows and columns) via `Matrix(data)`. 
"

# ╔═╡ cb6c47c6-51d3-4736-93f8-7709af426c95


# ╔═╡ 2b97fb4b-54c0-45f6-a5c0-a76c7174c2a4


# ╔═╡ e491430e-9e75-4ae0-ae07-8ab86b2b847e
md"### cross validation for tree hyperparameter tuning

let's employ a $K=5$-folds cross-validation procedure described [here](https://scikit-learn.org/stable/modules/cross_validation.html#cross-validation) to determine the optimal tree hyperparameter `min_samples_leaf`. see the excellent summary figure [here](https://scikit-learn.org/stable/_images/grid_search_cross_validation.png).

🍚 prepare for $K=5$-fold cross validation to optimize the `min_samples_leaf` hyperparameter. use `StratifiedCV` and `train_test_pairs` (see [here](https://alan-turing-institute.github.io/MLJ.jl/stable/evaluating_model_performance/#MLJBase.StratifiedCV)) to create an iterator over `(id_kf_train, id_kf_test)` tuples that give the indices of the training data that are further split into 5 rounds of train/test splits---in a way that the distribution of labels is preserved in the splits (hence, _stratified_).
"

# ╔═╡ 740a5a8f-a99d-4439-b456-bdb1613bb286


# ╔═╡ 5cd905f8-c5f2-48ba-b786-de9fefb3d694


# ╔═╡ 3551fe06-f74f-4ad5-bad5-c64773b90640


# ╔═╡ edd838f0-70c7-42f7-bbd0-5a214c05d312
md"🍚 we must define the hyperparameter set we will explore in the $K$-folds cross validation routine. I am giving this to you below."

# ╔═╡ 6b3e2a9e-5f17-4657-83d7-290e7c4d4cf4


# ╔═╡ 1a88abf5-b598-4520-a00a-c1dd90b192c9
md"🍚 loop over each candidate `min_samples_leaf` hyperparameter. nested within that loop, loop over the $K=5$ folds, unpack the train/test indices (referring to the rows of `X_train` and `y_train`), train a decision tree with that `min_samples_leaf` and that chunk of training data, and compute the balanced accuracy (`bacc`) on that test chunk of data. ultimately, generate an array `kf_bacc` containing the mean balanced accuracy over the $K=5$ folds of test data for each `min_samples_leaf`.

* plot the mean balanced accuracy over the $K=5$ test folds against the value of the `min_samples_leaf`.
* what is the optimal `min_samples_leaf`? extract it from `kf_bacc` with code.

!!! note
	balanced accuracy is a performance metric to judge the classification quality of a decision tree, appropriate for imbalanced classes. use the `bacc` function from `StatisticalMeasures` to compute it. make sure you understand what the metric is.

"

# ╔═╡ f757c351-6c7b-4481-8434-9b96ea4092c5


# ╔═╡ 26ab12e4-1a76-4d10-b78e-4d453f6413dd


# ╔═╡ d59e4591-97e9-485b-acf4-80149514f546
md"
### train the tree for testing
🍚 finally, construct and train a decision tree classifier on _all_ of the training data, using the optimal `min_samples_leaf` hyperparameter.
"

# ╔═╡ 73db4dbb-9aa7-4b2e-a642-57c02e2f1638


# ╔═╡ 42f86215-9120-4e09-8617-1e51c7c96053


# ╔═╡ 373e3c20-605e-4155-aafe-2eaa8f2c14fd
md"
### visualize the tree
🍚 use `print_tree` to visualize (1) the decisions being used by the tree to classify the rice grains and (2) how many of the training rice grains fell in each leaf node."

# ╔═╡ 2fff6577-a9cf-4d32-8b13-bc283a69a707


# ╔═╡ 43855ea9-ab44-49cb-9578-34eb81099256
md"
### evaluating/testing the tree
🍚 use the trained decision tree (_with the optimal hyperparameter_) to predict the class label (ie. rice variety) on the grains in the train set and the test set and store these predicted labels in vectors `ŷ_train` and `ŷ_test`. "

# ╔═╡ ffe73898-e129-4139-baac-3659861c390e


# ╔═╡ 59b8e697-6293-49a0-87b3-2124c9f68691


# ╔═╡ f6a95e5e-8643-48ae-877b-b10552bc1877
md"🍚 compute the balanced accuracy of the decision tree on both the training and testing data separately."

# ╔═╡ 24d4db28-2c01-4584-ac9e-2ac27718132b


# ╔═╡ 814f6a8e-ed70-449c-aecc-03257c6a8279


# ╔═╡ b78d4047-0d88-4a44-8c72-741e5c579149
md"🍚 based on the balanced accuracy score, how does the performance of the decision tree on train vs. test data compare? is this expected?

_compared to the accuracy on the training data, the accuracy on the test data is [lower or higher], and I [did or did not] expect this because [...]._
"

# ╔═╡ 51f3d909-537e-41df-9fe0-110d28971afc
md"🍚 use the `confmat` function to compute and visualize the confusion matrix on the test data.
"

# ╔═╡ 2aeef754-2f6b-4cae-9169-5926829793b4


# ╔═╡ 4a5578b8-25ff-438e-ad53-791ee3c4f8e8
md"### the deployment tree

the performance on the test set reflects the generalization error of the tree when we deploy it to make predictions on new rice grains---assuming there is no _distribution shift_ (see slides [here](https://docs.google.com/presentation/d/1tuCIbk9Pye-RK1xqiiZXPzT8lIgDUL6CqBkFSYZXkbY/edit#slide=id.g112c1e99806_0_529)). 

however, deploying the decision tree you just trained would \"waste\" some of the data we have. so, let's retrain a tree for deployment---with the optimal hyperparameter---using all of the data. of course, we cannot use this tree to report any performance metrics, since performance on train data does not indicate to us the performance on new examples, which we ultimately care about.

🍚 train the tree for deployment.
"

# ╔═╡ 32c0cc67-b6c6-461f-ad6e-7cf69b34739b


# ╔═╡ 16b1336e-988e-42ed-8afb-5bc069c7a982


# ╔═╡ df8850a0-cfae-477d-b8de-5ba62cfaa10e
md"🍚 suppose we obtain a new rice grain with the feature vector below. use your deployment model to predict its label."

# ╔═╡ 327557bd-7804-465a-be7d-1dbc3a0cc3fc


# ╔═╡ 422454a5-4733-432f-9ac5-39bf6e38f089


# ╔═╡ Cell order:
# ╠═270166c0-7ab9-11ee-04f3-c7e8fe2c9cf5
# ╠═65b99621-b662-4514-8db3-057df7dc5a91
# ╠═923ccf15-c994-4e4c-a0cb-b1f23f5d80b3
# ╠═0dbc6f0f-e58e-428a-b060-1e13a8adf443
# ╟─fe8a65d8-d8f8-48ce-aa16-de81e0164088
# ╠═79e5479c-ef34-46d1-b4af-cb03ee1eed06
# ╠═478c6a7b-0f6f-41e7-9900-f0186adbeba5
# ╟─11f7e4d0-0d36-4527-9185-6deb29063c23
# ╠═348f2053-8f95-41b2-ac3e-74ca37bf7b0e
# ╟─4f18e348-158d-49b9-a132-c30bdd6f2346
# ╠═d55856ba-4c40-4568-90cc-11855239eec9
# ╟─e35161a0-c02c-4119-ab0a-c58bb4db00b6
# ╠═3772b7af-9890-4759-9ac3-d325fffd9a56
# ╟─921ac973-8354-424a-9921-2eb2797984ea
# ╠═5562a323-c79e-49c5-82a3-85405cf95dc4
# ╠═8dac1d29-4431-4736-890f-aa98209c91fb
# ╟─f5e24c3b-4643-43ac-b41f-f72cc8cfcbbc
# ╠═a3d0ea5e-fc20-4208-a48d-320c4a872ccc
# ╠═6d854f3b-d0ca-4bec-bd97-c78146fdf0d8
# ╟─ab06452b-8e51-4288-a1ba-1426b9d5733c
# ╠═cb6c47c6-51d3-4736-93f8-7709af426c95
# ╠═2b97fb4b-54c0-45f6-a5c0-a76c7174c2a4
# ╟─e491430e-9e75-4ae0-ae07-8ab86b2b847e
# ╠═740a5a8f-a99d-4439-b456-bdb1613bb286
# ╠═5cd905f8-c5f2-48ba-b786-de9fefb3d694
# ╠═3551fe06-f74f-4ad5-bad5-c64773b90640
# ╟─edd838f0-70c7-42f7-bbd0-5a214c05d312
# ╠═6b3e2a9e-5f17-4657-83d7-290e7c4d4cf4
# ╟─1a88abf5-b598-4520-a00a-c1dd90b192c9
# ╠═f757c351-6c7b-4481-8434-9b96ea4092c5
# ╠═26ab12e4-1a76-4d10-b78e-4d453f6413dd
# ╟─d59e4591-97e9-485b-acf4-80149514f546
# ╠═73db4dbb-9aa7-4b2e-a642-57c02e2f1638
# ╠═42f86215-9120-4e09-8617-1e51c7c96053
# ╟─373e3c20-605e-4155-aafe-2eaa8f2c14fd
# ╠═2fff6577-a9cf-4d32-8b13-bc283a69a707
# ╟─43855ea9-ab44-49cb-9578-34eb81099256
# ╠═ffe73898-e129-4139-baac-3659861c390e
# ╠═59b8e697-6293-49a0-87b3-2124c9f68691
# ╟─f6a95e5e-8643-48ae-877b-b10552bc1877
# ╠═24d4db28-2c01-4584-ac9e-2ac27718132b
# ╠═814f6a8e-ed70-449c-aecc-03257c6a8279
# ╟─b78d4047-0d88-4a44-8c72-741e5c579149
# ╟─51f3d909-537e-41df-9fe0-110d28971afc
# ╠═2aeef754-2f6b-4cae-9169-5926829793b4
# ╟─4a5578b8-25ff-438e-ad53-791ee3c4f8e8
# ╠═32c0cc67-b6c6-461f-ad6e-7cf69b34739b
# ╠═16b1336e-988e-42ed-8afb-5bc069c7a982
# ╟─df8850a0-cfae-477d-b8de-5ba62cfaa10e
# ╠═327557bd-7804-465a-be7d-1dbc3a0cc3fc
# ╠═422454a5-4733-432f-9ac5-39bf6e38f089
