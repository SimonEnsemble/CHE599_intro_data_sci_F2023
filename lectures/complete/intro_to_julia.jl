### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 23c448da-3628-4db1-b91f-b7fa2ac2d843
begin
	import Pkg; Pkg.activate() # enforce Julia to use your locally installed packages
	using PlutoUI, PlutoTeachingTools, Random, StatsBase
end

# ╔═╡ 3b6ceee5-0817-4b19-a597-7c98ed230130
TableOfContents()

# ╔═╡ 1f74ddfe-fd19-11ea-1a0f-678021182d2c
md"
# introduction

## the Julia programming language
![Julia logo](https://julialang.org/assets/infra/logo.svg)

_why Julia?_
* free, open-source
* high-level, thus easy to use
* dynamic, thus feels interactive
* expressive, read-like-a-book syntax
* high-performance (fast) (design choices allow just-in-time compiler to make optimizations, resulting in fast code)
* safety (offers optional type assertion)
* designed especially for scientific computing
* easy parallelization accross cores
* multiple dispatch (we'll see later)

> Julia: A language that walks like Python, runs like C

[link to Julia website](https://julialang.org/)

[link to _Nature_ article on Julia](https://www.nature.com/articles/d41586-019-02310-3)

_resources_:
* [Julia documentation](https://docs.julialang.org/en/v1/)
* [Learn Julia in Y minutes](https://learnxinyminutes.com/docs/julia/)
* [Julia express](http://bogumilkaminski.pl/files/julia_express.pdf)
* [list of learning resources maintained by Julia](https://julialang.org/learning/)
"

# ╔═╡ 2f9e20c0-fd1c-11ea-1064-411a3bbb014e
md"
## the Pluto notebook

(we're in one)

a [`Pluto` notebook](https://github.com/fonsp/Pluto.jl) is a dynamic, interactive Julia programming environment composed of [linked] code cells. each code cell contains a snippet of Julia code---a single line or multiple lines. 
when we run a code cell, the code contained in it is executed, and the output of the last line is printed. variables defined in preceding code cells are available to later code cells. Pluto is reactive; when a variable or function changes in one code cell, the other code cells dependent upon that variable automatically rerun.

YouTube videos on `Pluto` at [JuliaCon 2020](https://www.youtube.com/watch?v=IAF8DjrQSSk) and [JuliaCon 2021](https://www.youtube.com/watch?v=HiI4jgDyDhY).

### Markdown text formatting
Pluto supports Markdown, a plain-text language to create formatted text. see [here](https://docs.julialang.org/en/v1/stdlib/Markdown/) for the possibilities. this enables `Pluto` to be a sharable, reproducible, self-contained document combining code and text.

eg. code formatting:
- inline `f(x)=cos(3.0 * π)`
- in display:
```julia
function f(x)
	return cos(3.0 * π)
end
```

eg. math formatting via ``\LaTeX``:
- inline $f(x)=x^2\sin(x)$
- in display: 
```math
f(x)=x^2 \sin(x)
```

eg. quotes:
> time flies like an arrow; fruit flies like a banana.

!!! note
	edit any of my Markdown-formatted text by moving your cursor to the top left and clicking the eye symbol to hide/unhide the raw text composing this cell.

### package management
a [built-in package manager](https://plutojl.org/docs/packages/) to easily install packages and store their versions. since compiling packages take some time, I append `import Pkg; Pkg.activate()` to instead use locally-installed versions of the packages.
"

# ╔═╡ f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
md"
# learn Julia by example

## variable assignment

> an assignment statement sets and/or re-sets the value stored in the storage location(s) denoted by a variable name; in other words, it copies a value into the variable - [Wikipedia](https://en.wikipedia.org/wiki/Assignment_(computer_science))
"

# ╔═╡ b99409d6-fd1f-11ea-1cd5-e97615600cea
x = 5.3 # not "x equals 5.3" but, "assign x to be 5.3"

# ╔═╡ e267492c-fd1f-11ea-20a3-9f7759e16280
md"
\"we assign `x` to be 5.3\", *not* \"x equals 5.3\"!

read [here](https://en.wikipedia.org/wiki/Assignment_(computer_science)#Assignment_versus_equality).
"

# ╔═╡ 0ae926cc-fd20-11ea-3e7f-1b8af64f05d8
x == 5.3

# ╔═╡ 21ec295a-7b45-4db5-8b58-942180413f33
md"## reactivity
compute `2x² + 1` in a code cell below, then change the value of `x` above. note, the cell below will automatically update.
"

# ╔═╡ b23f0981-af7a-4302-84fb-556cdb906c4d
2 * x ^ 2 + 1

# ╔═╡ 181fec1c-fd21-11ea-042c-23828f908e52
md"## basic types

### `Float64`

in the [double-precision floating point format](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) of a number, the number is represented on your computer using a chuck of memory consisting of 64 bits (bit = binary digit).

![](https://upload.wikimedia.org/wikipedia/commons/a/a9/IEEE_754_Double_Floating_Point_Format.svg)

"

# ╔═╡ 11aa062e-fd21-11ea-068b-495c13f48386
typeof(x)

# ╔═╡ 16342ee8-b797-4c37-8b21-20fa4fa3999b
sizeof(x) # bytes

# ╔═╡ 501952e9-da2f-46cf-9131-266d03e336ac
4 / 0 # infinity

# ╔═╡ 99070218-4e28-4e8d-b168-005e5469e054
4 / 0 - 2 / 0 # Not a Number (NaN)

# ╔═╡ 32d07345-7f33-4d6f-a601-862e9a2e5919
md"### `Int64`
an integer is represented by 64 bits as well.
"

# ╔═╡ 2d622f08-fd22-11ea-2d6a-6bd48280b429
y = 5 # not 5.0

# ╔═╡ 315b0efe-fd22-11ea-1cdd-a5ded834ab2a
typeof(y)

# ╔═╡ 31055b1d-eabc-40ea-a860-d50923018c2c
sizeof(y)

# ╔═╡ 9ba7684f-d5f0-4cbc-bb2f-11a347eba508
y == x

# ╔═╡ 2b0adfe9-028b-437c-99cc-39b993e036fa
md"### `String`

text is represented as a `String`."

# ╔═╡ 2ecab27a-fd22-11ea-09f6-03f120a4e4e2
my_name = "Cory" # construct strings with quotation marks

# ╔═╡ d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7
typeof(my_name)

# ╔═╡ e87a9ca8-fd22-11ea-28f2-b55daeb0032e
md"
### `Symbol`
a `Symbol` is an [interned string](https://en.wikipedia.org/wiki/String_interning), which eg. makes string comparison operations faster. a more advanced discussion on `Symbol`'s is [here](https://stackoverflow.com/questions/23480722/what-is-a-symbol-in-julia#).

!!! hint
    the function `pointer_from_objref` gives the memory address of a variable. experiment with a `Symbol` and `String` to illustrate that `Symbol`s are *interned* strings. 
"

# ╔═╡ 97e1060a-fd23-11ea-0724-b57130b840a0
dog_name = :Oslo # or Symbol("Oslo")

# ╔═╡ ad38b10e-fd23-11ea-39c7-abec457dd0a9
typeof(dog_name)

# ╔═╡ b8b5d778-b3e5-4c04-9e73-43a43017d75e
md"### `Bool`
a Boolean variable is either `true` or `false`.
"

# ╔═╡ 73201488-bd70-473b-b12c-0cff76189138
oslo_isa_dog = true

# ╔═╡ bca6e98c-fd23-11ea-3435-7de54b441520
typeof(oslo_isa_dog)

# ╔═╡ c6038724-fd23-11ea-26f1-95f83c18b73a
md"## other important data structures
### `Dict`

a dictionary stores an unordered collection of (key, value) pairs. it stores a mapping from keys to values.
"

# ╔═╡ df7265ae-fd23-11ea-2062-590489759192
atom_to_mass = Dict("C" => 12.01, 
				    "N" => 14.0067, 
	                "O" => 15.999, 
	                "H" => 1.01)
# note the order is not the same as when we constructed the dictionary... so never assume the dictionary is in a certain order. for ordered elements, use an `Array`

# ╔═╡ a5eef120-fd24-11ea-1fbc-9716cad65315
typeof(atom_to_mass)

# ╔═╡ 06068334-fd25-11ea-380c-adf3a922c2ee
keys(atom_to_mass)

# ╔═╡ 0bcf7bea-fd25-11ea-02fd-734a32e86dfc
values(atom_to_mass)

# ╔═╡ f8d312f4-1c16-4f97-abc3-767030b794c8
md"retreive the value associated with a given key"

# ╔═╡ ef434eee-fd23-11ea-19e3-2578be44f9a0
atom_to_mass["O"]

# ╔═╡ 62d22a05-8971-43d5-99ba-c98eed82ed5f
md"add a new (key, value) pair"

# ╔═╡ fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4
begin
	atom_to_mass["He"] = 4.0 # add a (key, value) pair
	atom_to_mass
end

# ╔═╡ d9bc41ea-fbd2-4102-8bbb-2cb0a3ba987d
md"iterate through the (key, value) pairs of a dictionary"

# ╔═╡ 197e253a-fd24-11ea-3ba6-2bb768ca610a
for (element, mass) in atom_to_mass # iterate over, unpack the (key, value) pairs
	println("the atomic mass of ", element, " is ", mass)
end

# ╔═╡ 7b440f50-fd24-11ea-24e6-43ea33e3a9bb
md"### `Array`

an array is an ordered list of objects (could be `Float64`'s, `Int64`'s, `String`'s, etc.).

construct an array of `Float64`'s.
"

# ╔═╡ 92493d42-fd24-11ea-277e-73ee6f34697f
z = [6.3, 1.2, 8.2] # column vector

# ╔═╡ a1574ae0-fd24-11ea-1d13-6bd7232b61dd
typeof(z)

# ╔═╡ 6303f191-f5c8-4681-babe-368910562b6c
md"retreive or change an element (indexing starts at `1`).
"

# ╔═╡ 598be54f-01cc-4a17-94db-b0bb2d011d22
z[3]

# ╔═╡ 9b569d44-fd24-11ea-3ae9-d9e86b734398
begin
	z[3] = -1.0
	z
end

# ╔═╡ 0a366ce0-59e0-4c06-a00a-7d9f14bb4931
md"what is the length of the array?"

# ╔═╡ bdd6b318-fd24-11ea-03ca-05534b38845d
length(z)

# ╔═╡ d363b716-fd25-11ea-11c9-8905dd4f3dc4
md"iterating through an array (3 ways)

1. iterating through the indices
"

# ╔═╡ b0312d60-fd24-11ea-2338-e33d7b7c7326
for i in eachindex(z)
	println("z[$i] = ", z[i])
end

# ╔═╡ 61f2c93c-c003-4b4a-b96e-f4f0a718f814
md"2. directly iterating through the elements (if we don't need the indices inside the loop)"

# ╔═╡ 2bf8581d-d343-416d-921d-d0f92b257d5a
for zᵢ in z
	println(zᵢ)
end

# ╔═╡ 69fb90f3-9a18-4bc4-912f-2b1cd45e04c7
md"3. iterating through both the indices and the elements simultaneously"

# ╔═╡ 40f9dac7-9ab9-47e3-8655-b346b51f2aca
for (i, zᵢ) in enumerate(z)
	println("z[$i] = $zᵢ")
end

# ╔═╡ 88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
md"adding elements to an array

... at the end
"

# ╔═╡ 8d7abd34-fd26-11ea-2ac8-59aa1152a963
begin
	push!(z, 23.0) # exlamation => function will modify its argument
	z
end

# ╔═╡ 305e9461-7fda-4bc0-9140-c4fccfd3fc22
md"...at the beginning"

# ╔═╡ 9c9cf930-fd26-11ea-369d-05487ebb4a2c
begin
	pushfirst!(z, 0.0) # exlamation => function will modify its argument
	z
end

# ╔═╡ adea9760-fd26-11ea-0507-db19248c356d
md"slicing an array

1. by indices"

# ╔═╡ b37ab55c-fd26-11ea-0d2f-43020e094843
begin
	ids_i_want = [1, 4]
	z[ids_i_want]
end

# ╔═╡ 0bf7b687-86d4-46f7-9100-d59b10850354
z[begin:4]

# ╔═╡ 126a590e-fd28-11ea-1c02-c3262b85add7
z[1:4]

# ╔═╡ 185775c2-fd28-11ea-03b1-a50001c813db
z[3:end]

# ╔═╡ 74f433aa-4cd3-4fc6-b33c-15598b32aefc
md"2. by an array of `Bool`s"

# ╔═╡ 259be740-fd28-11ea-3cce-0959719ea489
begin
	i_want = [true, false, false, true, false] # a Vector{Bool}
	z[i_want]
end

# ╔═╡ 6081e190-fd28-11ea-37d5-81d995c5da53
md"filtering an array. i.e. retreive all values (in the same order) that satisfy some condition.
"

# ╔═╡ 7b50b3a5-ef8c-4a3b-982f-df6a53cdf5ca
z

# ╔═╡ c8a37d7a-3479-482a-a54a-a69e90d83b32
md"1. via `Vector{Bool}` slicing"

# ╔═╡ 75e95b6a-fd28-11ea-3574-09b696391ec0
z .> 0.0 # dot is for "apply element-wise"

# ╔═╡ 8c4574e6-fd28-11ea-2d7b-41a82e763605
z[z .> 0.0]

# ╔═╡ 054070f8-9aa4-43c7-a419-d96d14c8b397
md"2. the `filter` function."

# ╔═╡ c5d16e3a-da25-428c-b998-a06bde5a2779
filter(zᵢ -> zᵢ > 0, z)

# ╔═╡ 382d122a-fd29-11ea-136e-3763d3b27fff
md"multi-dimensional arrays"

# ╔═╡ 3df06fcc-fd29-11ea-242e-459a5796c5e8
u = [1 3 1; 
    0 8 3]

# ╔═╡ 47a89d1c-fd29-11ea-1249-716bfbaff87d
size(u) # two rows, three columns

# ╔═╡ 56adbdc6-fd29-11ea-219a-07848f5ddbfd
u[2, 1] # second row, first column

# ╔═╡ 4d477196-fd29-11ea-1eeb-dd8885fafa93
u[:, 2] # all the rows, second column

# ╔═╡ 8cafc58a-fd2a-11ea-2d83-7fb53e343317
md"constructing an array, without typing out each entry manually

1. list comprehension (fast, beautiful)
"

# ╔═╡ 9a16deb6-fd2a-11ea-1810-8d0c1c22a39a
v₁ = [2.0 * i for i = 1:5] # think "what do I want in element i?"

# ╔═╡ 5ae77a48-537d-4d9e-828d-8b3f362ed6a1
md"2. pre-allocate memory, fill in (fast, flexible, clear, but takes a few lines)"

# ╔═╡ 7a9e8be2-f906-4208-8816-7837e884ea2d
begin
	v₂ = zeros(Float64, 5) # construct a 5-element array with zeros
	for i = 1:5
		v₂[i] = 2 * i
	end
	v₂
end

# ╔═╡ 5ebbbb2b-2c58-4219-9c79-dc33a8b000a3
md"3. start with empty array, add values (slow; only do when you don't know the size beforehand)"

# ╔═╡ 1c1caef9-3a3a-4ad5-a72c-3a69bb83f7f5
begin
	v₃ = Float64[]
	for i = 1:5
		push!(v₃, 2 * i)
	end
	v₃
end

# ╔═╡ 4b34114b-df6e-4e76-9704-30c1e1986285
md"4. special constructors"

# ╔═╡ e3ecf6eb-52ba-4219-bc78-244801b33908
zeros(3)

# ╔═╡ d94ab0cd-c061-4277-b116-04301de1b91d
ones(3, 4)

# ╔═╡ d5bb8a81-e46d-4db0-9a19-7f1451373add
falses(4)

# ╔═╡ b9cce99e-fd2a-11ea-03fe-3d20bfb629a7
begin
	t = range(0.0, stop=1.0, length=5)
	collect(t) # collect to actually build the array
end

# ╔═╡ 8349134c-fd2b-11ea-3426-7f3ad78a3384
md"element-wise operations on arrays"

# ╔═╡ 8d985c22-fd2b-11ea-38c8-25c40abddf44
begin
	a = [0.0, 1.0, 2.0]
	b = [5.0, 6.0, 7.0]
	
	a .* b # dot for element-wise
end

# ╔═╡ a0a2a016-fd2b-11ea-1be7-595c50ab3751
2.0 * a

# ╔═╡ a5c49b8a-fd2b-11ea-317a-814aa9d072ff
sin.(a) # dot to apply function element-wise

# ╔═╡ bb84580c-fd2b-11ea-34fe-03e69a043bc4
md"matrix multiplication"

# ╔═╡ c8fe380e-fd2b-11ea-3d76-edf4546e3d6b
A = rand(3, 3) # 3 × 3 matrix with random U[0, 1] entries

# ╔═╡ cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4
A * b

# ╔═╡ 644e6466-edc8-4aa0-93b0-6d5250262da4
md"concatenate two arrays together, either vertically or horizontally.
"

# ╔═╡ dcaf697f-10c6-4ee4-b2a8-05179beffcd4
begin
	# two column vectors
	u₁ = [1.0, 2.0]
	u₂ = [3.0, 4.0]
end

# ╔═╡ d5df7396-cb2a-48b1-8d6d-f4078b992542
vcat(u₁, u₂)

# ╔═╡ a52e18c1-8441-4cca-b474-abbdc533d721
hcat(u₁, u₂)

# ╔═╡ a7773da3-737f-4dc6-9da0-a81e15af0f5a
md"### `Tuple`
see [here](https://docs.julialang.org/en/v1/manual/types/#Tuple-Types).
"

# ╔═╡ 5b9cb1c5-ef85-4967-aba4-08c92c1a2544
my_tuple = ("year", 2023)

# ╔═╡ 8d53dbf7-42b6-47cb-b3f5-f1bdaf5fa075
typeof(my_tuple)

# ╔═╡ 1b39b4d0-4d63-47a4-9256-0034822dc1a1
md"### `NamedTuple`
see [here](https://docs.julialang.org/en/v1/manual/types/#Named-Tuple-Types).
"

# ╔═╡ 8f085b00-4f56-4d35-8f81-e1af92e3c95e
my_named_tuple = (; year=2023, month="Oct")

# ╔═╡ b3e219b7-890e-45d3-ab1d-9939eec7a481
typeof(my_named_tuple)

# ╔═╡ eaff6ae2-177a-462b-b4ae-16cc94f8b652
my_named_tuple.year

# ╔═╡ 2724fc99-2433-41d1-aec7-e91156d7fd23
my_named_tuple.month

# ╔═╡ e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
md"### custom data structure"

# ╔═╡ e9f164b4-fd2b-11ea-1b4b-4b95e685950a
begin
	struct Molecule
	    species::String
	    atoms::Vector{String}
		coords::Matrix{Float64}
	end
	
	molecule = Molecule("water", 
		                ["H", "H", "O"],
						[0.0   0.0 0.0;
			             0.759 0.0 0.504;
			             0.759 0.0 -0.504])
	
	molecule.coords # access attributes
end

# ╔═╡ 376ef642-fd2d-11ea-10e8-c35996c11e35
md"## `function`'s

a function maps an input to an output:

$$x \mapsto f(x)$$
"

# ╔═╡ b0432b82-4189-4df2-8072-896ce3ece6b8
md"1. inline construction (if a short function)"

# ╔═╡ 05f1d5ae-ad6b-4d9c-908c-da80373711d9
f₁(x) = 2 * x + 3

# ╔═╡ d1d463b4-8771-432a-af8b-0c5661fee1a3
md"2. expanded construction (if more code involved)"

# ╔═╡ 51d6689e-d3f2-49f2-ae65-66699eb2f4d8
function f₂(x)
	ψ = 2 * x
	return ψ + 3
end

# ╔═╡ e6b61903-1743-43d1-8b5c-b76288ec9837
md"
3. anonymous function"

# ╔═╡ 72ed7db8-610e-495d-925b-3a44218924a1
f₃ = x -> 2 * x + 3 # useful for filter, map, etc.

# ╔═╡ 65ceb9db-57d8-4487-adf2-7f8511f68a66
md"evaluating a function"

# ╔═╡ 47fdafd4-8ff2-4735-b63f-f928d93d6569
f₁(2.0)

# ╔═╡ 90f43dd5-22bc-4c06-b4d9-1f740924aa07
f₂(2.0)

# ╔═╡ 426c4694-f636-4772-9106-952fbd32253d
f₃(2.0)

# ╔═╡ 6c006879-19fd-48a5-960a-9db0cc03296c
md"note on scope: variables defined inside functions not available to us outside of the function in the global scope. if you are new to programming, read Julia's [docs on scope](https://docs.julialang.org/en/v1/manual/variables-and-scoping/)."

# ╔═╡ 2118fe6a-fcdf-4a46-b14b-ea4227c99b61
ψ = "cory"

# ╔═╡ a4174d88-0958-4c90-ba1d-0cb21ce21934
f₂(1.0) # ψ = 2.0 inside function

# ╔═╡ 89084880-3646-44d9-a2cb-239852655288
ψ # not defined.

# ╔═╡ cd43a9d8-b891-44b2-803b-25f422b2e551
md"apply our function to each element of an array.

1. via the `.` syntax, indicating element-wise operation. ie. broadcast the function to each element of the array, returning another array.
"

# ╔═╡ 805bf238-4d54-4649-8d77-d6a12622f6b6
f₂.(z)

# ╔═╡ c9989f22-7f2a-415e-9932-5ff83f677eee
md"2. via `map` and an anonomous function"

# ╔═╡ 9a496a9a-fd2d-11ea-036e-05a28c1882d9
# https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions-1
# "primary use for anonymous functions is passing them 
#   to functions which take other functions as arguments"
map(x -> 2 * x + 3, z)

# ╔═╡ 9489510c-f362-4df9-ba9f-7c9e92cfbf13
md"reduce an array"

# ╔═╡ cc1e8a11-bf09-4149-9c82-45fc9692a42b
reduce(+, z)

# ╔═╡ 44c62dbc-79f5-4d61-940a-126e22110857
sum(z)

# ╔═╡ 4166dd29-b05d-47c6-9446-3e37917ec0e9
reduce(max, z)

# ╔═╡ 73a418f9-4822-40d8-b469-8162d7aa8433
maximum(z)

# ╔═╡ dda5183d-b203-4c3d-95b5-e7bdd0656ba3
reduce(*, z)

# ╔═╡ 12a7ec42-b597-4c7b-a580-7300a0bd51e7
prod(z)

# ╔═╡ 94901605-67b0-409b-bb20-a0955f5ae2ea
md"functions with multiple arguments"

# ╔═╡ d7cf8796-fd2d-11ea-2dae-13cf938bd877
begin
	g(x, y) = x + y
	g(2.0, 3.0)
end

# ╔═╡ ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
md"optional positional arguments

> In many cases, function arguments have sensible default values and therefore might not need to be passed explicitly in every call. [source](https://docs.julialang.org/en/v1/manual/functions/#Optional-Arguments-1)

suppose for the mathematical function $h(x, m, b)=mx+b$, `b` is almost always 0.0. let's not force the user to pass this arugment, yet let's also allow some flexibility if the user wants to change `b` from the default of `b=0.0`."

# ╔═╡ 066b7bfa-fd2e-11ea-34b5-5d23f5a433e4
begin
	# constructor
	h(x, m, b=0.0) = m * x + b
	
	h(2.0, 1.0) # b assumed zero
end

# ╔═╡ 1781a568-fd2e-11ea-1280-43c4591acacd
h(2.0, 1.0, 3.0) # the third argument is assumed `b` if passed

# ╔═╡ 28534fae-fd2e-11ea-3f5a-836d16c725f8
md"optional keyword arguments

> Some functions need a large number of arguments, or have a large number of behaviors. Remembering how to call such functions can be difficult. Keyword arguments can make these complex interfaces easier to use and extend by allowing arguments to be identified by name instead of only by position. [source](https://docs.julialang.org/en/v1/manual/functions/#Keyword-Arguments-1)
"

# ╔═╡ 334d0616-fd2e-11ea-2d83-3d37fee60a74
begin
	θ(x; m=3.0, b=0.0) = m * x + b
	θ(2.0, b=1.0)
end

# ╔═╡ 6a9fd648-fd2e-11ea-09f8-098fd33d82ff
md"type declarations in functions
> the :: operator can be used to attach type annotations to expressions and variables in programs. There are two primary reasons to do this:
> * as an assertion to help confirm that your program works the way you expect,
> * to provide extra type information to the compiler, which can then improve performance in some cases
> when appended to an expression computing a value, the :: operator is read as \"is an instance of\". It can be used anywhere to assert that the value of the expression on the left is an instance of the type on the right.
> [source](https://docs.julialang.org/en/v1/manual/types/index.html#Type-Declarations-1)
"

# ╔═╡ 8c73923c-fd2e-11ea-2520-1736af901c1f
ξ(x::Float64, y::Float64) = 2 * x + y

# ╔═╡ 0c569f90-efa3-485b-a70e-1773f12fe786
md"multiple dispatch

> The choice of which method to execute when a function is applied is called dispatch. Julia allows the dispatch process to choose which of a function's methods to call based on the number of arguments given, and on the types of all of the function's arguments. [source](https://docs.julialang.org/en/v1/manual/methods/#Methods)
"

# ╔═╡ a00e7f75-5a34-447e-b23b-26dbeb15aa9a
ξ(x::String, y::String) = x * " " * y # a bit different than x * y

# ╔═╡ d833eeef-32ae-4622-b411-78e25ed68551
ξ(4.0, 3.0)

# ╔═╡ d7e662c9-f2cc-4b83-a2b2-76fc2f01d06d
ξ("OSU", 3) # fails

# ╔═╡ d9da3921-1e3b-42e9-a103-50a8a1561169
ξ("OSU", "rocks")

# ╔═╡ dd21f7a1-d76a-4a00-b036-db307ce67666
md"functions can take in our custom data types as arguments"

# ╔═╡ 0dacb54c-fd2f-11ea-05ff-4df8be2ef053
"""
calculate and return the molecular weight of a molecule
"""
function molecular_wt(
	molecule::Molecule, 
	atom_to_mass::Dict{String, Float64};
	print_stuff::Bool=false
)
	mw = 0.0
	for atom in molecule.atoms
		if print_stuff
			@show atom
			@show atom_to_mass[atom]
		end
		mw += atom_to_mass[atom]
		# same as:
		#   mw = mw + atom_to_mass[atom]
	end
	return mw
	# or, in one line:
	#   return sum(atom_to_mass[atom] for atom in molecule.atoms)
end

# ╔═╡ 8eb9d71d-7755-458a-92ab-b429d6b121d5
molecular_wt(molecule, atom_to_mass, print_stuff=true)

# ╔═╡ 0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
md"## control flow
> a control flow statement is a statement, the execution of which results in a choice being made as to which of two or more paths a computer program will follow - [Wikipedia](https://en.wikipedia.org/wiki/Control_flow)

e.g., is the indoor air temperature comfortable? what is your preferred drink based on the air temperature?
"

# ╔═╡ d21c1ce4-33fe-48ca-8fd1-422ad1667d2d
temperature = 45.0 # °F

# ╔═╡ 933d5544-fd33-11ea-06af-8debefdb728a
my_drink = temperature > 74.0 ? "ice water" : "hot tea"

# ╔═╡ 9ff8ba12-fd33-11ea-2eca-0fe897359d25
# && = "and"
comfy = temperature > 65.0 && temperature < 75.0

# ╔═╡ 21153e31-158f-47c5-a918-ae0d1a18812d
md"e.g. write a function to determine if a `Molecule` is a hydrocarbon or not."

# ╔═╡ 82eb1752-fd31-11ea-17be-11666cb6e2e8
function is_hydrocarbon(molecule::Molecule)
	for atom in molecule.atoms
		if ! (atom == "C" || atom == "H")
		# or:
		#  if ! (atom in ["C", "H"])
			return false
		end
	end
	return true # if made it this far, all atoms are :C or :H
end

# ╔═╡ da8ea3cd-a6dd-4e33-89dc-627d917c4b82
is_hydrocarbon(molecule)

# ╔═╡ 19cddf3a-fd35-11ea-328f-9397bc118698
md"## randomness, sampling"

# ╔═╡ 85dc7b27-b5bc-41c1-941e-7053531270b8
md"generate a uniformly distributed number in $[0, 1]$"

# ╔═╡ 27ef6938-fd35-11ea-07e2-0b28886507bb
rand()

# ╔═╡ 47edae53-22a0-413e-9708-15089cd97aef
md"flip a coin"

# ╔═╡ 31f083f4-fd35-11ea-34d3-81f1d3e8dc6b
coin_flip = rand() < 0.5 ? "H" : "T"

# ╔═╡ b9b40963-50f1-4b8b-a353-42b1da3021ca
rand(["H", "T"])

# ╔═╡ d65edc64-2b36-435e-ad92-22931078da45
md"generate a normally distributed number (μ = 0, σ = 1)"

# ╔═╡ 37b27476-fd35-11ea-1892-79927795db0f
randn()

# ╔═╡ 11537618-9916-485e-a6ca-a92756d87166
md"shuffle an array"

# ╔═╡ 4f4660e0-fd35-11ea-1186-252d22ca1c33
z

# ╔═╡ 55288cb8-fd35-11ea-3d35-e548167cb52e
shuffle(z)

# ╔═╡ d8dc6878-fa05-4508-a1c0-1a1f7dfa8021
md"sample elements from an array (uniform)"

# ╔═╡ 62314e4a-fd35-11ea-271c-d90066d6cdd9
sample(z, 4, replace=false) # sample four elements randomly, with replacement

# ╔═╡ a2693913-4e59-4d16-839c-ab83a18e7e11
md"sample elements from an array (nonuniform)"

# ╔═╡ 7432ae22-fd35-11ea-35f2-170288e9c358
# simulate the weather:
#  rainy 10%, cloudy 60%, sunny 30%
sample(["rainy", "cloudy", "sunny"], ProbabilityWeights([0.1, 0.6, 0.3]))

# ╔═╡ 8554b92a-fd35-11ea-2956-cdf98a96f9d1
md"## mutable vs. immutable data structures

let's illustrate by creating a data structure for a tree that keeps track of its species and height, then writing a function to simulate tree growth.
"

# ╔═╡ 1966f615-5abc-4de7-9bdf-b0b91a8046e6
mutable struct Tree
	species::String
	height::Float64 # m
end

# ╔═╡ 2f4ae3e2-eca8-4d9a-9da3-5ea3da8fc76f
function grow!(tree::Tree)
	tree.height += 0.1 * rand()
end

# ╔═╡ 73055b2c-8627-46c6-bb4a-b31c0baba986
tree = Tree("oak", 1.0)

# ╔═╡ d97bcb89-85b3-448f-a32d-aade11747a0e
grow!(tree)

# ╔═╡ Cell order:
# ╠═23c448da-3628-4db1-b91f-b7fa2ac2d843
# ╠═3b6ceee5-0817-4b19-a597-7c98ed230130
# ╟─1f74ddfe-fd19-11ea-1a0f-678021182d2c
# ╟─2f9e20c0-fd1c-11ea-1064-411a3bbb014e
# ╟─f3fee3ca-fd1c-11ea-2906-9d8d6b874f66
# ╠═b99409d6-fd1f-11ea-1cd5-e97615600cea
# ╟─e267492c-fd1f-11ea-20a3-9f7759e16280
# ╠═0ae926cc-fd20-11ea-3e7f-1b8af64f05d8
# ╟─21ec295a-7b45-4db5-8b58-942180413f33
# ╠═b23f0981-af7a-4302-84fb-556cdb906c4d
# ╟─181fec1c-fd21-11ea-042c-23828f908e52
# ╠═11aa062e-fd21-11ea-068b-495c13f48386
# ╠═16342ee8-b797-4c37-8b21-20fa4fa3999b
# ╠═501952e9-da2f-46cf-9131-266d03e336ac
# ╠═99070218-4e28-4e8d-b168-005e5469e054
# ╟─32d07345-7f33-4d6f-a601-862e9a2e5919
# ╠═2d622f08-fd22-11ea-2d6a-6bd48280b429
# ╠═315b0efe-fd22-11ea-1cdd-a5ded834ab2a
# ╠═31055b1d-eabc-40ea-a860-d50923018c2c
# ╠═9ba7684f-d5f0-4cbc-bb2f-11a347eba508
# ╟─2b0adfe9-028b-437c-99cc-39b993e036fa
# ╠═2ecab27a-fd22-11ea-09f6-03f120a4e4e2
# ╠═d9b74a2e-fd22-11ea-39e1-7311dbdfdfa7
# ╟─e87a9ca8-fd22-11ea-28f2-b55daeb0032e
# ╠═97e1060a-fd23-11ea-0724-b57130b840a0
# ╠═ad38b10e-fd23-11ea-39c7-abec457dd0a9
# ╟─b8b5d778-b3e5-4c04-9e73-43a43017d75e
# ╠═73201488-bd70-473b-b12c-0cff76189138
# ╠═bca6e98c-fd23-11ea-3435-7de54b441520
# ╟─c6038724-fd23-11ea-26f1-95f83c18b73a
# ╠═df7265ae-fd23-11ea-2062-590489759192
# ╠═a5eef120-fd24-11ea-1fbc-9716cad65315
# ╠═06068334-fd25-11ea-380c-adf3a922c2ee
# ╠═0bcf7bea-fd25-11ea-02fd-734a32e86dfc
# ╟─f8d312f4-1c16-4f97-abc3-767030b794c8
# ╠═ef434eee-fd23-11ea-19e3-2578be44f9a0
# ╟─62d22a05-8971-43d5-99ba-c98eed82ed5f
# ╠═fdc4e874-fd23-11ea-19e4-b3cfa1e8f9b4
# ╟─d9bc41ea-fbd2-4102-8bbb-2cb0a3ba987d
# ╠═197e253a-fd24-11ea-3ba6-2bb768ca610a
# ╟─7b440f50-fd24-11ea-24e6-43ea33e3a9bb
# ╠═92493d42-fd24-11ea-277e-73ee6f34697f
# ╠═a1574ae0-fd24-11ea-1d13-6bd7232b61dd
# ╟─6303f191-f5c8-4681-babe-368910562b6c
# ╠═598be54f-01cc-4a17-94db-b0bb2d011d22
# ╠═9b569d44-fd24-11ea-3ae9-d9e86b734398
# ╟─0a366ce0-59e0-4c06-a00a-7d9f14bb4931
# ╠═bdd6b318-fd24-11ea-03ca-05534b38845d
# ╟─d363b716-fd25-11ea-11c9-8905dd4f3dc4
# ╠═b0312d60-fd24-11ea-2338-e33d7b7c7326
# ╟─61f2c93c-c003-4b4a-b96e-f4f0a718f814
# ╠═2bf8581d-d343-416d-921d-d0f92b257d5a
# ╟─69fb90f3-9a18-4bc4-912f-2b1cd45e04c7
# ╠═40f9dac7-9ab9-47e3-8655-b346b51f2aca
# ╟─88989cc8-fd26-11ea-2ad1-e54b6dfa0d75
# ╠═8d7abd34-fd26-11ea-2ac8-59aa1152a963
# ╟─305e9461-7fda-4bc0-9140-c4fccfd3fc22
# ╠═9c9cf930-fd26-11ea-369d-05487ebb4a2c
# ╟─adea9760-fd26-11ea-0507-db19248c356d
# ╠═b37ab55c-fd26-11ea-0d2f-43020e094843
# ╠═0bf7b687-86d4-46f7-9100-d59b10850354
# ╠═126a590e-fd28-11ea-1c02-c3262b85add7
# ╠═185775c2-fd28-11ea-03b1-a50001c813db
# ╟─74f433aa-4cd3-4fc6-b33c-15598b32aefc
# ╠═259be740-fd28-11ea-3cce-0959719ea489
# ╟─6081e190-fd28-11ea-37d5-81d995c5da53
# ╠═7b50b3a5-ef8c-4a3b-982f-df6a53cdf5ca
# ╟─c8a37d7a-3479-482a-a54a-a69e90d83b32
# ╠═75e95b6a-fd28-11ea-3574-09b696391ec0
# ╠═8c4574e6-fd28-11ea-2d7b-41a82e763605
# ╟─054070f8-9aa4-43c7-a419-d96d14c8b397
# ╠═c5d16e3a-da25-428c-b998-a06bde5a2779
# ╟─382d122a-fd29-11ea-136e-3763d3b27fff
# ╠═3df06fcc-fd29-11ea-242e-459a5796c5e8
# ╠═47a89d1c-fd29-11ea-1249-716bfbaff87d
# ╠═56adbdc6-fd29-11ea-219a-07848f5ddbfd
# ╠═4d477196-fd29-11ea-1eeb-dd8885fafa93
# ╟─8cafc58a-fd2a-11ea-2d83-7fb53e343317
# ╠═9a16deb6-fd2a-11ea-1810-8d0c1c22a39a
# ╟─5ae77a48-537d-4d9e-828d-8b3f362ed6a1
# ╠═7a9e8be2-f906-4208-8816-7837e884ea2d
# ╟─5ebbbb2b-2c58-4219-9c79-dc33a8b000a3
# ╠═1c1caef9-3a3a-4ad5-a72c-3a69bb83f7f5
# ╟─4b34114b-df6e-4e76-9704-30c1e1986285
# ╠═e3ecf6eb-52ba-4219-bc78-244801b33908
# ╠═d94ab0cd-c061-4277-b116-04301de1b91d
# ╠═d5bb8a81-e46d-4db0-9a19-7f1451373add
# ╠═b9cce99e-fd2a-11ea-03fe-3d20bfb629a7
# ╟─8349134c-fd2b-11ea-3426-7f3ad78a3384
# ╠═a0a2a016-fd2b-11ea-1be7-595c50ab3751
# ╠═8d985c22-fd2b-11ea-38c8-25c40abddf44
# ╠═a5c49b8a-fd2b-11ea-317a-814aa9d072ff
# ╟─bb84580c-fd2b-11ea-34fe-03e69a043bc4
# ╠═c8fe380e-fd2b-11ea-3d76-edf4546e3d6b
# ╠═cc7c41c4-fd2b-11ea-0fdc-9d18add5fea4
# ╟─644e6466-edc8-4aa0-93b0-6d5250262da4
# ╠═dcaf697f-10c6-4ee4-b2a8-05179beffcd4
# ╠═d5df7396-cb2a-48b1-8d6d-f4078b992542
# ╠═a52e18c1-8441-4cca-b474-abbdc533d721
# ╟─a7773da3-737f-4dc6-9da0-a81e15af0f5a
# ╠═5b9cb1c5-ef85-4967-aba4-08c92c1a2544
# ╠═8d53dbf7-42b6-47cb-b3f5-f1bdaf5fa075
# ╟─1b39b4d0-4d63-47a4-9256-0034822dc1a1
# ╠═8f085b00-4f56-4d35-8f81-e1af92e3c95e
# ╠═b3e219b7-890e-45d3-ab1d-9939eec7a481
# ╠═eaff6ae2-177a-462b-b4ae-16cc94f8b652
# ╠═2724fc99-2433-41d1-aec7-e91156d7fd23
# ╟─e3af0b56-fd2b-11ea-1a50-cd73d2d9fd48
# ╠═e9f164b4-fd2b-11ea-1b4b-4b95e685950a
# ╟─376ef642-fd2d-11ea-10e8-c35996c11e35
# ╟─b0432b82-4189-4df2-8072-896ce3ece6b8
# ╠═05f1d5ae-ad6b-4d9c-908c-da80373711d9
# ╟─d1d463b4-8771-432a-af8b-0c5661fee1a3
# ╠═51d6689e-d3f2-49f2-ae65-66699eb2f4d8
# ╟─e6b61903-1743-43d1-8b5c-b76288ec9837
# ╠═72ed7db8-610e-495d-925b-3a44218924a1
# ╟─65ceb9db-57d8-4487-adf2-7f8511f68a66
# ╠═47fdafd4-8ff2-4735-b63f-f928d93d6569
# ╠═90f43dd5-22bc-4c06-b4d9-1f740924aa07
# ╠═426c4694-f636-4772-9106-952fbd32253d
# ╟─6c006879-19fd-48a5-960a-9db0cc03296c
# ╠═2118fe6a-fcdf-4a46-b14b-ea4227c99b61
# ╠═a4174d88-0958-4c90-ba1d-0cb21ce21934
# ╠═89084880-3646-44d9-a2cb-239852655288
# ╟─cd43a9d8-b891-44b2-803b-25f422b2e551
# ╠═805bf238-4d54-4649-8d77-d6a12622f6b6
# ╟─c9989f22-7f2a-415e-9932-5ff83f677eee
# ╠═9a496a9a-fd2d-11ea-036e-05a28c1882d9
# ╟─9489510c-f362-4df9-ba9f-7c9e92cfbf13
# ╠═cc1e8a11-bf09-4149-9c82-45fc9692a42b
# ╠═44c62dbc-79f5-4d61-940a-126e22110857
# ╠═4166dd29-b05d-47c6-9446-3e37917ec0e9
# ╠═73a418f9-4822-40d8-b469-8162d7aa8433
# ╠═dda5183d-b203-4c3d-95b5-e7bdd0656ba3
# ╠═12a7ec42-b597-4c7b-a580-7300a0bd51e7
# ╟─94901605-67b0-409b-bb20-a0955f5ae2ea
# ╠═d7cf8796-fd2d-11ea-2dae-13cf938bd877
# ╟─ea3373ca-fd2d-11ea-25d4-0942d7faeb0b
# ╠═066b7bfa-fd2e-11ea-34b5-5d23f5a433e4
# ╠═1781a568-fd2e-11ea-1280-43c4591acacd
# ╟─28534fae-fd2e-11ea-3f5a-836d16c725f8
# ╠═334d0616-fd2e-11ea-2d83-3d37fee60a74
# ╟─6a9fd648-fd2e-11ea-09f8-098fd33d82ff
# ╠═8c73923c-fd2e-11ea-2520-1736af901c1f
# ╠═d833eeef-32ae-4622-b411-78e25ed68551
# ╠═d7e662c9-f2cc-4b83-a2b2-76fc2f01d06d
# ╟─0c569f90-efa3-485b-a70e-1773f12fe786
# ╠═a00e7f75-5a34-447e-b23b-26dbeb15aa9a
# ╠═d9da3921-1e3b-42e9-a103-50a8a1561169
# ╟─dd21f7a1-d76a-4a00-b036-db307ce67666
# ╠═0dacb54c-fd2f-11ea-05ff-4df8be2ef053
# ╠═8eb9d71d-7755-458a-92ab-b429d6b121d5
# ╟─0e0a8cba-fd31-11ea-26ed-2d27f95f54ff
# ╠═d21c1ce4-33fe-48ca-8fd1-422ad1667d2d
# ╠═933d5544-fd33-11ea-06af-8debefdb728a
# ╠═9ff8ba12-fd33-11ea-2eca-0fe897359d25
# ╟─21153e31-158f-47c5-a918-ae0d1a18812d
# ╠═82eb1752-fd31-11ea-17be-11666cb6e2e8
# ╠═da8ea3cd-a6dd-4e33-89dc-627d917c4b82
# ╟─19cddf3a-fd35-11ea-328f-9397bc118698
# ╟─85dc7b27-b5bc-41c1-941e-7053531270b8
# ╠═27ef6938-fd35-11ea-07e2-0b28886507bb
# ╟─47edae53-22a0-413e-9708-15089cd97aef
# ╠═31f083f4-fd35-11ea-34d3-81f1d3e8dc6b
# ╠═b9b40963-50f1-4b8b-a353-42b1da3021ca
# ╟─d65edc64-2b36-435e-ad92-22931078da45
# ╠═37b27476-fd35-11ea-1892-79927795db0f
# ╟─11537618-9916-485e-a6ca-a92756d87166
# ╠═4f4660e0-fd35-11ea-1186-252d22ca1c33
# ╠═55288cb8-fd35-11ea-3d35-e548167cb52e
# ╟─d8dc6878-fa05-4508-a1c0-1a1f7dfa8021
# ╠═62314e4a-fd35-11ea-271c-d90066d6cdd9
# ╟─a2693913-4e59-4d16-839c-ab83a18e7e11
# ╠═7432ae22-fd35-11ea-35f2-170288e9c358
# ╟─8554b92a-fd35-11ea-2956-cdf98a96f9d1
# ╠═1966f615-5abc-4de7-9bdf-b0b91a8046e6
# ╠═2f4ae3e2-eca8-4d9a-9da3-5ea3da8fc76f
# ╠═73055b2c-8627-46c6-bb4a-b31c0baba986
# ╠═d97bcb89-85b3-448f-a32d-aade11747a0e
