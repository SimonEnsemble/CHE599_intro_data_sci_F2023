### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 560929d7-a01d-4475-bcd2-516ace7da08f
begin
	import Pkg; Pkg.activate()
	using DataFrames, CSV, Statistics, PlutoUI
end

# ╔═╡ e6830c0c-94de-4202-96e3-b4aed698ad46
TableOfContents()

# ╔═╡ 1b29c142-033b-11eb-1fcd-3167939de8d2
md"
# working with tabular data

!!! note \"packages to deal with tabular data: `DataFrames.jl` and `CSV.jl`\"
	to load, store, query, filter, sort, group, manipulate, etc. tables of data, we will employ the Julia packages:
	* `DataFrames.jl` [documentation](http://juliadata.github.io/DataFrames.jl/stable/)
	* `CSV.jl` [documentation](https://juliadata.github.io/CSV.jl/stable/)

## high-level ❓'s

### what's a `DataFrame`?
a `DataFrame` is a convenient data structure (in many languages) for storing data in tabular form.
* rows = instances/examples
* columns = features of those instances/examples

!!! note
	a `DataFrame`, being a table, bears some resemblance to a 2D array but with _named columns_. 

### what does the `DataFrames.jl` package do?
the `DataFrames.jl` package implements the `DataFrame` structure and offers many functions that operate on `DataFrame`'s to _efficiently_ query, filter, group, sort, manipulate etc. tables of data. `DataFrames.jl` handles missing values efficiently via a special type `Missing`.

### what does the `CSV.jl` package do?
the `CSV.jl` package offers functions to quickly and flexibly read CSV (= comma-separated value) files---a common file format for tables of data---and convert them into `DataFrame`'s, as well as to write `DataFrame`'s to a CSV file.
"

# ╔═╡ 31e25766-033c-11eb-3991-d55735f7977f
md"## simple operations on `DataFrames`

### construct from scratch

construct a `DataFrame`, `city_data`, that contains information about cities in the US.

* rows = instances = cities
* columns = features = attributes of cities
"

# ╔═╡ dd6128dd-bdf4-48a2-a6ec-b213231c4ad3
city = ["Corvallis", "Portland", "Eugene"]

# ╔═╡ 4ece318f-e083-40cf-803a-beed87b520fe
population = [57961, 647805, 168916]

# ╔═╡ 2071b5b6-038f-11eb-182d-f392b2198f2e
# city_data = DataFrame(city=city, population=population)
city_data = DataFrame(city=["Corvallis", "Portland", "Eugene"],
	                  population=[57961, 647805, 168916])

# ╔═╡ bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
md"### append rows

append two new rows to `city_data`:
* Bend, OR has a population of 94520.
* Berkeley, CA has a population of 122324.

_approach 1_: think of rows of a `DataFrame` as an `Array`.
"

# ╔═╡ d172a490-033c-11eb-157e-6b95587099dd
begin
	new_row = ["Bend", 94520]
	push!(city_data, new_row)
end

# ╔═╡ 78b1f924-033d-11eb-2937-ff9634f5aa9a
md"
_approach 2_: think of rows of a `DataFrame` as a `Dict`.
"

# ╔═╡ 4c407c9a-0353-11eb-0618-955711917f54
begin
	another_new_row = Dict("population" => 122324, "city" => "Berkeley")
	push!(city_data, another_new_row)
end

# ╔═╡ 5e293c82-033d-11eb-3984-7164bf9a351d
md"### append columns

append another two columns to `city_data` giving the (1) annual rainfall in each city and (2) state to which the city belongs.
* Corvallis, OR: 51.0 in
* Portland, OR: 43.0 in
* Eugene, OR: 47.0 in
* Bend, OR: 12.0 in
* Berkeley, CA: 25.0 in

!!! hint
	remember, the index `:` = \"all of them\".

*approach 1:* view the `DataFrame` as an array.
"

# ╔═╡ 400d2f1a-5033-4581-a5b4-f57f101bef4e
city_data[:, "rain"] = [51.0, 43.0, 47.0, 12.0, 25.0]

# ╔═╡ 452fee83-985a-4eab-9c9d-2223645056f0
city_data

# ╔═╡ 014a4866-a14d-444d-81cb-5c3e242f855d
md"*approach 2:* employ the `insertcols!` function, which allows you to insert a column at a specified location."

# ╔═╡ a5e9fc00-0353-11eb-1443-63b1c2edab7c
insertcols!(city_data, 2, "state" => ["OR", "OR", "OR", "OR", "CA"])

# ╔═╡ c94b33a0-3023-45fb-9c77-354579d742fb
md"*approach 3:* the `transform` function, which transforms current column(s) into a new one. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.transform!)."

# ╔═╡ 46f095d4-630a-4661-bb37-a0084d11b6b6
transform!(city_data, "rain" => (col -> 2 * col) => "twice_the_rainfall")

# ╔═╡ 5b7446f2-8cbb-462b-9c48-78d45f110d13
md"note: `transform` can apply a function that operates on multiple columns. the below does not modify the data frame because we omit the `!` from `transform!`; rather, it returns a copy of it."

# ╔═╡ 49fa8c65-1ac8-46d9-a064-2c24fe76accb
transform(city_data, 
	["city", "state"] => ((col_1, col_2) -> col_1 .* ", " .* col_2) => "city, state")

# ╔═╡ d90a8d38-292f-43e4-ac27-f02e46e0c307
md"### modify a column
e.g. round the `\"population\"` so it contains only two significant digits. we pass `renamecols=false` to `transform!` so that, instead of creating a _new_ column, it modifies the `\"population\"` column.
"

# ╔═╡ 1756c3e7-b0f3-4f4a-927d-e52dc5cef44a
transform!(city_data, "population" => 
	col -> Int.(round.(col, sigdigits=2)), 
	renamecols=false)

# ╔═╡ a67b30b0-0353-11eb-2d2f-871d7a5ffd36
md"### count the # of rows/columns"

# ╔═╡ 6249187e-035a-11eb-2f6a-d3318cf2a996
size(city_data) # (# rows, # cols)

# ╔═╡ 6f8ca3cc-5935-4abe-b628-ac3c8cf4cd97
nrow(city_data)

# ╔═╡ 84f3f188-b90c-4fcf-994b-5d32dd0551d5
ncol(city_data)

# ╔═╡ 9b63b70a-7ea6-48a6-a068-602de654681d
md"### retreive the names of the columns"

# ╔═╡ f2cbf254-69fc-4e9f-974d-468ce53040a8
names(city_data)

# ╔═╡ a3421e44-035e-11eb-3cf7-c70142f0591d
md"
### rename a column
"

# ╔═╡ a9d20a30-035e-11eb-14f4-ddf7cdaa34f6
rename!(city_data, "rain" => "rainfall")

# ╔═╡ 63716d2a-0362-11eb-3ce5-3b41d4bef04c
md"
### select a subset of columns

use the `select!` or `select` function. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.select!).
"

# ╔═╡ 5931d59e-0391-11eb-078b-ddb0bcaf6521
select!(city_data, Not("twice_the_rainfall"))

# ╔═╡ 48d7d749-c7d0-407c-8863-8ab7530d6c03
select(city_data, ["city", "state"]) # no !, hence city_data not modified.

# ╔═╡ 581bfc10-0362-11eb-1b29-cfd4320a5130
md"### delete a row"

# ╔═╡ a583d38b-c309-4b61-8820-159d67bf6874
# add a bogus row we'll want to remove
push!(city_data, ["bogus", "blah", 0, 100.0])

# ╔═╡ b7fb0648-0390-11eb-2dc5-8b6935d2545c
delete!(city_data, 6)

# ╔═╡ b8de77aa-0362-11eb-36d9-1d905442ca13
md"
### delete duplicate rows
"

# ╔═╡ 9063e224-053b-46a7-9ff1-bb550fa57964
# add duplicate row we'll want to remove
push!(city_data, ["Berkeley", "CA", 120000, 25.0]) 

# ╔═╡ cbf6250c-0362-11eb-365b-d327617f197e
unique!(city_data)

# ╔═╡ 5d7208d4-035b-11eb-00ef-cd70b6cb79d3
md"
### retreive a...

##### ... column

the columns are `Array`'s. treat the `DataFrame` like a 2D array.
"

# ╔═╡ 8d4f4ede-035b-11eb-2337-7bdb844389ae
city_data[:, "population"]

# ╔═╡ 7daa87e6-035b-11eb-3bb8-ff1bdd95714c
md"
##### ... row
"

# ╔═╡ f735e3ee-035b-11eb-33d1-755a1a9dc0a7
city_data[2, :]

# ╔═╡ 1821e936-035c-11eb-0cb1-014241a2599e
md"
##### ... entry
"

# ╔═╡ 1ad35930-035c-11eb-165d-2d70f7b07713
city_data[2, "population"]

# ╔═╡ 9e01dd3a-0362-11eb-3d19-392ec2d06bd6
md"
### find unique entries in a column
"

# ╔═╡ a6f99cc8-0362-11eb-1801-2dd5fa96efe1
unique(city_data[:, "state"])

# ╔═╡ d663dd98-035a-11eb-156f-ff237a3944b6
md"
## iterate through a `DataFrame`, row by row
"

# ╔═╡ 360eb67a-035b-11eb-2ab3-85adb264a387
for row in eachrow(city_data)
	# inside here, row is a ditionary. keys: column names.
	println(row["city"], " has a population of ", row[:population])
end

# ╔═╡ 366557f2-035c-11eb-31ce-9308dd49ce0c
md"## filter rows on some condition

use the `filter` function. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#Base.filter).
* first argument: a function that operates on a row of the `DataFrame` (treating the row as a `Dict`) and returns `true` if we want to keep that row and `false` if we want to throw it away.
* the second argument is the `DataFrame`.
* there is also a `filter!` function that will remove these rows from the dataframe instead of returning a copy with the relevant rows removed.

**example 1**: query all rows where the \"city\" column is \"Corvallis\".
"

# ╔═╡ 5abb815e-0392-11eb-3576-a7e39e8ac6af
filter(row -> row["city"] == "Corvallis", city_data)

# ╔═╡ 6ca4c6a8-035d-11eb-158c-3380a0cafdaa
md"**example 2**: query all cities (rows) where the population is less than 500,000."

# ╔═╡ 7dad5c94-035d-11eb-1f7b-2fedd834efaa
filter(row -> row["population"] < 500000, city_data)

# ╔═╡ 7e54ed24-035d-11eb-19e2-4986b3cfcab4
md"**example 3**: ... and that reside in Oregon."

# ╔═╡ 9879f190-035d-11eb-07c6-55453426c704
filter(row -> (row["population"] < 500000) && (row["state"] == "OR"), city_data)

# ╔═╡ 9926bdbc-035d-11eb-1824-438e97d78ab9
md"## sort rows

e.g. permute rows so that cities are listed by `\"population\"` in reverse (`rev`) order
"

# ╔═╡ ab918a54-035d-11eb-27ae-2d70b27460ac
sort!(city_data, "population", rev=true)

# ╔═╡ 9ed15498-035d-11eb-1369-53ae1eac0a27
md"
## group rows

the `groupby` command (common in many languages) partitions the rows in the `DataFrame` into multiple `DataFrame`'s such that the rows in each `DataFrame` share a common attribute (indicated in a column). a `GroupedDataFrame` is useful for performing computations on each group of rows in a `DataFrame` separately. see [the docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.groupby).

e.g., group the cities (rows) in `city_data` by state.
"

# ╔═╡ c1526020-035d-11eb-2d8a-d131aa445738
gb_state = groupby(city_data, "state")

# ╔═╡ c106f1b5-946c-44a1-bb63-ad3342adb6aa
md"the `GroupedDataFrame` works like an array and can be iterated over."

# ╔═╡ ed1a5928-be8b-4cd1-b9b8-2ed8c9e75996
gb_state[1]

# ╔═╡ 02419abb-7531-440d-8b19-03924c099b58
gb_state[2]

# ╔═╡ e80a4a9a-0392-11eb-2d35-09bb527d7a29
for df_by_state in gb_state
	# to which state does this group correspond?
	this_state = df_by_state[1, "state"]
	
	# perform computation on this group
	#  here, we get the rainfalls in this group and take the mean
	avg_rainfall_in_this_state = mean(df_by_state[:, "rainfall"])

	println("average rainfall in ", this_state, " is ", avg_rainfall_in_this_state)
end

# ╔═╡ 4dd5195c-035e-11eb-1991-3fd9e7bf5d25
md"
## split, apply, combine

1. split the rows into groups
2. apply a function to a column (map a column to a number) in each data frame in the group
3. combine the result back into one data frame where each row pertains to a group

so then we get a new data frame that lists attributes of the _groups_.
##### `combine`
`combine(gdf, \"col\" => f => \"new_col\")` takes as arguments `gdf::GroupedDataFrame`, applies the function `f` to the `\"col\"` column of each data frame in the group, then combines the results into a column `\"new_col\"` in a new `DataFrame`, with each row representing a group. see [docs](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.combine).

_example 1_: group by state, take `mean` of the rainfall column.
"

# ╔═╡ 03a59b6c-035f-11eb-0a39-79c770bf5544
df_rain = combine(groupby(city_data, "state"), "rainfall" => mean => "avg_rainfall")

# ╔═╡ 02fab01a-e9b8-4a43-aceb-31985194f4c6
md"
_example 2_: group by state, determine if `minimum` of the rainfall among the cities in that state is less than 20."

# ╔═╡ a5ad8099-c40a-40c4-9197-a47281937537
combine(groupby(city_data, "state"), 
	"rainfall" => (col -> minimum(col) < 20.0) => "has a dry city")

# ╔═╡ 27391eca-ce4b-434f-bba0-13fe0d700298
md"_example 3_: group by state, compute rainfall per person"

# ╔═╡ a6f0b99d-8b48-4758-89ee-9b2772965cab
combine(groupby(city_data, "state"),
	["population", "rainfall"] => 
	  ((pop_col, rain_col) -> sum(rain_col) / sum(pop_col)) => 
	  "rainfall_per_population"
	)

# ╔═╡ 8226dc8e-0362-11eb-17bf-47cae0df2907
md"## I/O with `.csv` files

use the `CSV.jl` package.

CSV = comma separated value

### `DataFrame` to `.csv`
"

# ╔═╡ 907832ea-0362-11eb-2132-a3abadd4b1ee
CSV.write("rainfall.csv", df_rain)

# ╔═╡ c711c3f8-0393-11eb-2fbc-77693069c73f
run(`cat rainfall.csv`)

# ╔═╡ 08e91b1c-035f-11eb-05d0-9fe60938a4e3
md"### `.csv` to `DataFrame`
first, let's download the `.csv` from Github [here](https://raw.githubusercontent.com/SimonEnsemble/CHE599_intro_data_sci_F2023/main/lectures/complete/data/incomes.csv) into our present working directory (`pwd`).
"

# ╔═╡ fdab541a-0393-11eb-0318-3390bd75a95d
pwd() # present working directory to see where CSV looks for files

# ╔═╡ 717b8f72-61ab-431c-9fc8-d518523b4674
url = "https://raw.githubusercontent.com/SimonEnsemble/CHE599_intro_data_sci_F2023/main/lectures/complete/data/incomes.csv"

# ╔═╡ 19233eb0-20b7-41a2-a636-16abdbb9be24
begin
	if ! isdir("data")
		mkdir("data")
	end
	download(url, joinpath("data", "incomes.csv"))
end

# ╔═╡ 1c01557a-035f-11eb-37e8-e9497003725f
income_data = CSV.read("incomes.csv", DataFrame)

# ╔═╡ 4cf973b8-0361-11eb-1777-cf02396ba052
md"
## joining two tables of data
\"join\" = combine the rows of two tables of data on a \"key\" column that indicates to us the identity of the entities that the rows represent.

there are [seven types of joins](http://juliadata.github.io/DataFrames.jl/stable/man/joins/). let's illustrate two here.

🌆 _goal_: join information about cities from `city_data` and `income_data`. each row of both of these data frames represents a certain city; the columns, however, describe different attributes of the cities. so, the *key* column here is `\"city\"`; we aim to merge a pair of rows of the two `DataFrames` if the same string is listed in this column.

there are two subtleties here:
* the city of San Francisco appears in `income_data` but is missing from `city_data`
* the cities of Bend, Eugene, Portland appear in `city_data` but are missing from `income_data`
`innerjoin` and `outerjoin` are distinguished by how they handle these subtleties.

### inner join
only keep rows where the value in the \"key\" column appears in _both_ `DataFrames`'s
(ie. throw out rows representing entities that aren't represented in _both_ data frames).
"

# ╔═╡ 74379f7c-0361-11eb-0192-c59bca513893
data_ij = innerjoin(city_data, income_data, on=:city)

# ╔═╡ 80c12360-0361-11eb-3eb3-eddb35dac4a5
md"
### outer join
keep all rows of both data frames. fill entries with `missing` if an attribute is missing in an entity represented by a row in either `DataFrame`.

!!! note
	the `?` appears in the type under the column name to indicate some entries are `missing`.
"

# ╔═╡ 02bef8b2-0362-11eb-130f-f99cc7311f5a
data_oj = outerjoin(city_data, income_data, on=:city)

# ╔═╡ 098a5628-0362-11eb-33af-9fc2fbceddba
md"## missing values
Julia has a data type to efficiently handle missing values.
"

# ╔═╡ 12deee64-0362-11eb-3612-ed369a623583
missing

# ╔═╡ 977c25ce-0394-11eb-0076-0955dcfe0ca1
typeof(missing)

# ╔═╡ 1e41218c-0362-11eb-2ae3-17339b033f7a
md"columns with missing values are arrays of whatever type but `Union`'d with the `Missing` type"

# ╔═╡ 25a8858c-0362-11eb-3405-95aeea8c1338
typeof(data_oj[:, "state"])

# ╔═╡ 2f441675-6930-4f97-b7e1-dfc1c25cdbc6
md"### removing rows with `missing` entries"

# ╔═╡ 2fb25d0c-0362-11eb-16b3-b75f845f82a9
md"..._all_ rows with a missing entry."

# ╔═╡ 36ba914e-0362-11eb-0aa7-6fda9f1b4d02
dropmissing(data_oj)

# ╔═╡ 38ab5560-0362-11eb-15cb-4595de21d218
md"...only rows with a `missing` entry in a certain column.

(note: `dropmissing!` is a function that modifies the `DataFrame` passed as an argument.)
"

# ╔═╡ 3edf858c-0362-11eb-3b47-5f53c1360718
dropmissing(data_oj, "state")

# ╔═╡ da29ea48-7cda-4286-8c59-a5b845268d6d
md"convert `missing` entries to something different."

# ╔═╡ 2919a4e2-895e-4ac7-b5eb-7f635519847c
coalesce.(data_oj, "?")

# ╔═╡ Cell order:
# ╠═560929d7-a01d-4475-bcd2-516ace7da08f
# ╠═e6830c0c-94de-4202-96e3-b4aed698ad46
# ╟─1b29c142-033b-11eb-1fcd-3167939de8d2
# ╟─31e25766-033c-11eb-3991-d55735f7977f
# ╠═dd6128dd-bdf4-48a2-a6ec-b213231c4ad3
# ╠═4ece318f-e083-40cf-803a-beed87b520fe
# ╠═2071b5b6-038f-11eb-182d-f392b2198f2e
# ╟─bc58ac1c-033c-11eb-2698-f5fc4c20b8ce
# ╠═d172a490-033c-11eb-157e-6b95587099dd
# ╟─78b1f924-033d-11eb-2937-ff9634f5aa9a
# ╠═4c407c9a-0353-11eb-0618-955711917f54
# ╟─5e293c82-033d-11eb-3984-7164bf9a351d
# ╠═400d2f1a-5033-4581-a5b4-f57f101bef4e
# ╠═452fee83-985a-4eab-9c9d-2223645056f0
# ╟─014a4866-a14d-444d-81cb-5c3e242f855d
# ╠═a5e9fc00-0353-11eb-1443-63b1c2edab7c
# ╟─c94b33a0-3023-45fb-9c77-354579d742fb
# ╠═46f095d4-630a-4661-bb37-a0084d11b6b6
# ╟─5b7446f2-8cbb-462b-9c48-78d45f110d13
# ╠═49fa8c65-1ac8-46d9-a064-2c24fe76accb
# ╟─d90a8d38-292f-43e4-ac27-f02e46e0c307
# ╠═1756c3e7-b0f3-4f4a-927d-e52dc5cef44a
# ╟─a67b30b0-0353-11eb-2d2f-871d7a5ffd36
# ╠═6249187e-035a-11eb-2f6a-d3318cf2a996
# ╠═6f8ca3cc-5935-4abe-b628-ac3c8cf4cd97
# ╠═84f3f188-b90c-4fcf-994b-5d32dd0551d5
# ╟─9b63b70a-7ea6-48a6-a068-602de654681d
# ╠═f2cbf254-69fc-4e9f-974d-468ce53040a8
# ╟─a3421e44-035e-11eb-3cf7-c70142f0591d
# ╠═a9d20a30-035e-11eb-14f4-ddf7cdaa34f6
# ╟─63716d2a-0362-11eb-3ce5-3b41d4bef04c
# ╠═5931d59e-0391-11eb-078b-ddb0bcaf6521
# ╠═48d7d749-c7d0-407c-8863-8ab7530d6c03
# ╟─581bfc10-0362-11eb-1b29-cfd4320a5130
# ╠═a583d38b-c309-4b61-8820-159d67bf6874
# ╠═b7fb0648-0390-11eb-2dc5-8b6935d2545c
# ╟─b8de77aa-0362-11eb-36d9-1d905442ca13
# ╠═9063e224-053b-46a7-9ff1-bb550fa57964
# ╠═cbf6250c-0362-11eb-365b-d327617f197e
# ╟─5d7208d4-035b-11eb-00ef-cd70b6cb79d3
# ╠═8d4f4ede-035b-11eb-2337-7bdb844389ae
# ╟─7daa87e6-035b-11eb-3bb8-ff1bdd95714c
# ╠═f735e3ee-035b-11eb-33d1-755a1a9dc0a7
# ╟─1821e936-035c-11eb-0cb1-014241a2599e
# ╠═1ad35930-035c-11eb-165d-2d70f7b07713
# ╟─9e01dd3a-0362-11eb-3d19-392ec2d06bd6
# ╠═a6f99cc8-0362-11eb-1801-2dd5fa96efe1
# ╟─d663dd98-035a-11eb-156f-ff237a3944b6
# ╠═360eb67a-035b-11eb-2ab3-85adb264a387
# ╟─366557f2-035c-11eb-31ce-9308dd49ce0c
# ╠═5abb815e-0392-11eb-3576-a7e39e8ac6af
# ╟─6ca4c6a8-035d-11eb-158c-3380a0cafdaa
# ╠═7dad5c94-035d-11eb-1f7b-2fedd834efaa
# ╟─7e54ed24-035d-11eb-19e2-4986b3cfcab4
# ╠═9879f190-035d-11eb-07c6-55453426c704
# ╟─9926bdbc-035d-11eb-1824-438e97d78ab9
# ╠═ab918a54-035d-11eb-27ae-2d70b27460ac
# ╟─9ed15498-035d-11eb-1369-53ae1eac0a27
# ╠═c1526020-035d-11eb-2d8a-d131aa445738
# ╟─c106f1b5-946c-44a1-bb63-ad3342adb6aa
# ╠═ed1a5928-be8b-4cd1-b9b8-2ed8c9e75996
# ╠═02419abb-7531-440d-8b19-03924c099b58
# ╠═e80a4a9a-0392-11eb-2d35-09bb527d7a29
# ╟─4dd5195c-035e-11eb-1991-3fd9e7bf5d25
# ╠═03a59b6c-035f-11eb-0a39-79c770bf5544
# ╟─02fab01a-e9b8-4a43-aceb-31985194f4c6
# ╠═a5ad8099-c40a-40c4-9197-a47281937537
# ╟─27391eca-ce4b-434f-bba0-13fe0d700298
# ╠═a6f0b99d-8b48-4758-89ee-9b2772965cab
# ╟─8226dc8e-0362-11eb-17bf-47cae0df2907
# ╠═907832ea-0362-11eb-2132-a3abadd4b1ee
# ╠═c711c3f8-0393-11eb-2fbc-77693069c73f
# ╟─08e91b1c-035f-11eb-05d0-9fe60938a4e3
# ╠═fdab541a-0393-11eb-0318-3390bd75a95d
# ╠═717b8f72-61ab-431c-9fc8-d518523b4674
# ╠═19233eb0-20b7-41a2-a636-16abdbb9be24
# ╠═1c01557a-035f-11eb-37e8-e9497003725f
# ╟─4cf973b8-0361-11eb-1777-cf02396ba052
# ╠═74379f7c-0361-11eb-0192-c59bca513893
# ╟─80c12360-0361-11eb-3eb3-eddb35dac4a5
# ╠═02bef8b2-0362-11eb-130f-f99cc7311f5a
# ╟─098a5628-0362-11eb-33af-9fc2fbceddba
# ╠═12deee64-0362-11eb-3612-ed369a623583
# ╠═977c25ce-0394-11eb-0076-0955dcfe0ca1
# ╟─1e41218c-0362-11eb-2ae3-17339b033f7a
# ╠═25a8858c-0362-11eb-3405-95aeea8c1338
# ╟─2f441675-6930-4f97-b7e1-dfc1c25cdbc6
# ╟─2fb25d0c-0362-11eb-16b3-b75f845f82a9
# ╠═36ba914e-0362-11eb-0aa7-6fda9f1b4d02
# ╟─38ab5560-0362-11eb-15cb-4595de21d218
# ╠═3edf858c-0362-11eb-3b47-5f53c1360718
# ╟─da29ea48-7cda-4286-8c59-a5b845268d6d
# ╠═2919a4e2-895e-4ac7-b5eb-7f635519847c
