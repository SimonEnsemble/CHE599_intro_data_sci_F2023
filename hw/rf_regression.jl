### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 15afe64e-8b35-11ee-215d-9f190a59d2e5
begin
	import Pkg; Pkg.activate()
	using DecisionTree, CairoMakie, DataFrames, CSV, PlutoUI, Statistics
	# note: I do import to avoid importing all functions in these libraries,
	#  which would lead to name-clashes with the functions in each library
	import MultivariateStats.llsq
	import MLJBase: partition
	import StatisticalMeasures.rmse
	import StatisticalMeasures.rsquared
end

# ╔═╡ e05c767a-dca4-4205-98ab-7a3649757c9f
TableOfContents()

# ╔═╡ d61e4d95-d141-4f57-9c86-af710b214695
update_theme!(fontsize=20)

# ╔═╡ d989151b-0472-4347-baea-562f46cc65ec
md"# regression with a random forest

!!! warning \"learning objectives\"
	* train a random forest
	* compare performance of an advanced ML model like a random forest to a baseline model like a linear regression model
	* evaluate performance of a ML model on a regression task with a parity plot, root mean squared error, and R² value.
	* practice the inevitable necessity to pre-process data for a machine learning task

!!! note \"overall objective\"
	your task is to build a regression model that predicts the concentration of NO₂ in the air based on the response of an array of five metal-oxide gas sensors. each row of the data frame pertains to a time-averaged sample of air exposed to the sensor. the quantitative _label_ is the ground-truth NO₂ concentration in the `\"NO2(GT)\"` column. the sensor responses, the _features_ of the air, are in the `PTO8.S*` columns.

👃 download, read in as a `DataFrame`, and clean the air quality data set from the UCI ML repo [here](http://archive.ics.uci.edu/dataset/360/air+quality).

* remove non-pertinent columns---the columns except for the five sensor responses and the NO₂ concentrations. 
* ensure the `\"-200\"` values are read in as `missing` values.
* remove the rows whose (a) sensor responses or (b) ground-truth NO₂ concentrations are `missing` or empty strings.
* replace the commas used to represent decimals with periods, then use `parse(Float64, x)` to convert the relevant (incorrectly labeled) columns of `String`'s to columns of `Float64`'s.

"

# ╔═╡ 13e34da2-2be2-4521-94fd-6b414871863b

# ╔═╡ 6b68de3e-7af6-44d2-85a7-db71af1342f7

# ╔═╡ 515d38e1-c6cd-4426-957a-4909cce99fec

# ╔═╡ 54969850-41b5-4331-b853-e97663effe3c

# ╔═╡ c185b551-2619-4d9c-a9e1-e09a3c2f7f4e

# ╔═╡ fa322dc4-192f-4b94-84e4-9aa56687b358

# ╔═╡ fc353b1d-98cb-4c67-9b88-679a24ba9448
md"👃 randomly partition the data into 70% train, 30% test."

# ╔═╡ be77074e-6eb3-4fb5-a591-721c5c07070e

# ╔═╡ cc78330a-c399-4cc8-94ce-9c14534c2b96
md"👃 create the `X_train`, `X_test`, `y_train`, and `y_test` matrices/vectors in preparation for training and testing a random forest."

# ╔═╡ dcf69960-d40d-41c0-8533-50864551a74c

# ╔═╡ a8505dad-3921-482c-8b11-b308b385b416

# ╔═╡ 5704acd6-43f8-48f5-924d-72b2bb103243

# ╔═╡ 789bae6d-aa1e-4b26-ab90-edf5e50a9d87

# ╔═╡ a8e9d068-193a-45d6-8c3d-ff574bb9fce1
md"👃 grow a random forest using the training data. since random forests work well out-of-the-box 
there is no need to tune its hyperparameters. include 500 trees in the forest."

# ╔═╡ b905e3ea-f22b-485c-8ed9-37dff68eb46c

# ╔═╡ 780a9910-61fe-4bbb-b169-4f1830ca0025

# ╔═╡ f89cebd9-62c5-4c51-846d-2a865cf0aa2d
md"👃 make predictions on the NO₂ concentration in the air samples in the test set. compute the root mean squared error (RMSE), the R² value, and draw a parity plot (scatter plot of predicted vs. actual values; include a diagonal line for parity; pass `aspect=DataAspect()` for equal scales on both axes; plot the data as small markers to avoid overlap/burying; use the `text` or `Label` function to print the RMSE and R² value inside the panel)."

# ╔═╡ 1dd391ed-e3b3-4537-87fe-5e5b05681490

# ╔═╡ c28ba52e-5f68-4871-821b-21b9a5102028

# ╔═╡ 2d67112f-3a47-46d9-9e1d-ff79f56a6e64

# ╔═╡ 20cb0c5e-00ce-4bc4-880e-c007c578ae25
md"👃 when training a relatively complicated machine learning model like a random forest, one should compare its performance with a simpler baseline model. here, compare the test-set performance of the random forest to a linear regression model fit to the training data---using another parity plot with the RMSE and R² printed.

does the random forest out-perform the linear regression model?

!!! hint
	use `llsq` from `MultivariateStats.jl` [here](https://docs.juliahub.com/MultivariateStats/l7I74/0.9.0/lreg/) to fit a linear regression model.

	turn your code for a parity plot above into a function, to reuse your code for the linear regression model.

"

# ╔═╡ 07ffcee8-7ca6-4511-8333-d4b3871e0cb3

# ╔═╡ 7da30464-d623-4243-b89d-73db4c8547a9

# ╔═╡ 6881dcac-55fe-4911-ab93-2630fa9fa3cf

# ╔═╡ a8416cef-89d0-44fa-a018-f3fc836e4235

# ╔═╡ 99136c03-ff2f-413b-9270-a3a4de066084

# ╔═╡ 22361b50-9406-4e30-a326-6f84f4b0db23
md"
💡 using our test/train split, we obtained an estimate of how well the random forest can predict NO₂ concentrations in the air from the response of these five sensors. 

👃  now, use _all_ of the data to train a _deployment_ random forest model that we would use to, for _new_ air samples where we don't know the ground-truth NO₂ concentration, predict the NO₂ concentration from the response of the five sensors.
"

# ╔═╡ 63db6506-6f4b-45e9-830f-68fd0037b66e

# ╔═╡ cdb30c2b-aea9-41ce-bb7a-0523303487ee

# ╔═╡ 9000cb18-d225-45d9-9d36-497eda564169
md"👃 when we deploy the sensor array, suppose we obtain the sensor array response below. what does your deployment random forest predict the NO₂ concentration to be?"

# ╔═╡ 21135bd5-2fe1-4d41-b6d6-4520b1e26224
sensor_array_response = [1392.0  1159.0  909.0  1760.0  1202.0]

# ╔═╡ 5bbf8579-bc93-4b2c-82ee-94f21534fbe8

# ╔═╡ Cell order:
# ╠═15afe64e-8b35-11ee-215d-9f190a59d2e5
# ╠═e05c767a-dca4-4205-98ab-7a3649757c9f
# ╠═d61e4d95-d141-4f57-9c86-af710b214695
# ╟─d989151b-0472-4347-baea-562f46cc65ec
# ╠═13e34da2-2be2-4521-94fd-6b414871863b
# ╠═6b68de3e-7af6-44d2-85a7-db71af1342f7
# ╠═515d38e1-c6cd-4426-957a-4909cce99fec
# ╠═54969850-41b5-4331-b853-e97663effe3c
# ╠═c185b551-2619-4d9c-a9e1-e09a3c2f7f4e
# ╠═fa322dc4-192f-4b94-84e4-9aa56687b358
# ╟─fc353b1d-98cb-4c67-9b88-679a24ba9448
# ╠═be77074e-6eb3-4fb5-a591-721c5c07070e
# ╟─cc78330a-c399-4cc8-94ce-9c14534c2b96
# ╠═dcf69960-d40d-41c0-8533-50864551a74c
# ╠═a8505dad-3921-482c-8b11-b308b385b416
# ╠═5704acd6-43f8-48f5-924d-72b2bb103243
# ╠═789bae6d-aa1e-4b26-ab90-edf5e50a9d87
# ╟─a8e9d068-193a-45d6-8c3d-ff574bb9fce1
# ╠═b905e3ea-f22b-485c-8ed9-37dff68eb46c
# ╠═780a9910-61fe-4bbb-b169-4f1830ca0025
# ╟─f89cebd9-62c5-4c51-846d-2a865cf0aa2d
# ╠═1dd391ed-e3b3-4537-87fe-5e5b05681490
# ╠═c28ba52e-5f68-4871-821b-21b9a5102028
# ╠═2d67112f-3a47-46d9-9e1d-ff79f56a6e64
# ╟─20cb0c5e-00ce-4bc4-880e-c007c578ae25
# ╠═07ffcee8-7ca6-4511-8333-d4b3871e0cb3
# ╠═7da30464-d623-4243-b89d-73db4c8547a9
# ╠═6881dcac-55fe-4911-ab93-2630fa9fa3cf
# ╠═a8416cef-89d0-44fa-a018-f3fc836e4235
# ╠═99136c03-ff2f-413b-9270-a3a4de066084
# ╟─22361b50-9406-4e30-a326-6f84f4b0db23
# ╠═63db6506-6f4b-45e9-830f-68fd0037b66e
# ╠═cdb30c2b-aea9-41ce-bb7a-0523303487ee
# ╟─9000cb18-d225-45d9-9d36-497eda564169
# ╠═21135bd5-2fe1-4d41-b6d6-4520b1e26224
# ╠═5bbf8579-bc93-4b2c-82ee-94f21534fbe8
