### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ ce73aea0-0bd8-45d2-940a-b5b3f12302c3
# importing packages
import Pkg

# ╔═╡ d87b6f25-0a46-45fb-aeac-921caf3aa777
begin
    
    Pkg.add("GeoMet")
    Pkg.add("HTTP")
    Pkg.add("Plots")
    Pkg.add("CSV")
    Pkg.add("DataFrames")
end

# ╔═╡ c19ac41e-68ff-11f0-2fe7-b118027f42ad
begin
	
	using Markdown
	using InteractiveUtils
end

# ╔═╡ f89bfa47-4c1b-4297-9d2a-e5e0f8ca2115
using GeoMet, HTTP, CSV, DataFrames, Plots

# ╔═╡ d7bdf0f8-f105-470d-a2b5-33946a3835c1

begin
    url = "https://zenodo.org/record/6587598/files/comminution.csv?download=1"
    df = CSV.read(HTTP.get(url).body, DataFrame)
    first(df, 5)
end

# ╔═╡ d5157a40-b0a5-44d6-8689-587d810c0ee9
begin
  
    features = [:P80, :F80]  
    target = :Wi            
    
   
    results = run_ridge_regression(df, target, features; lambda=0.1)
    
  
    @info "Coeficients:" results.coef
end

# ╔═╡ 0c47946d-8d8c-4f50-a380-0dc96baa54bf
begin
    scatter(df[!, target], results.predicted,
        title = "reall values vs Predicts",
        xlabel = "Wi Real",
        ylabel = "Wi Predict",
        legend = false,
        color = :blue)
    
    
    plot!([minimum(df[!, target]), maximum(df[!, target])],
        [minimum(df[!, target]), maximum(df[!, target])],
        linestyle = :dash,
        color = :red,
        label = "perfect adjustment")
end

# ╔═╡ f8cb65d2-793e-4729-8356-1a2553a7309e
begin
    df_results = hcat(df, DataFrame(Wi_predict = results.predicted))
    select!(df_results, [target, :Wi_predict, :P80, :F80]) 
    first(df_results, 10) 
end

# ╔═╡ Cell order:
# ╠═c19ac41e-68ff-11f0-2fe7-b118027f42ad
# ╠═ce73aea0-0bd8-45d2-940a-b5b3f12302c3
# ╠═d87b6f25-0a46-45fb-aeac-921caf3aa777
# ╠═f89bfa47-4c1b-4297-9d2a-e5e0f8ca2115
# ╠═d7bdf0f8-f105-470d-a2b5-33946a3835c1
# ╠═d5157a40-b0a5-44d6-8689-587d810c0ee9
# ╠═0c47946d-8d8c-4f50-a380-0dc96baa54bf
# ╠═f8cb65d2-793e-4729-8356-1a2553a7309e
