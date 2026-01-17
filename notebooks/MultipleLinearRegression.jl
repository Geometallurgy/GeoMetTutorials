### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils
using Plots, GLM, DataFrames

begin
    # Create a DataFrame with two independent variables: x1 and x2
    x1 = 1:10
    x2 = 10:-1:1
    y = 3 .* x1 .+ 2 .* x2 .+ randn(10)  # y = 3*x1 + 2*x2 + noise

    df = DataFrame(x1 = x1, x2 = x2, y = y)

    # Fit a multiple linear regression model
    model = lm(@formula(y ~ x1 + x2), df)

    # Print model coefficients
    println("Regression coefficients:")
    println(coef(model))  # Intercept, coef_x1, coef_x2

    # Predict y values
    df.y_pred = predict(model)

    # Plot actual vs predicted y values
    scatter(1:10, df.y, label = "Actual y", xlabel = "Index", ylabel = "y", legend = :topleft, title = "Multiple Linear Regression")
    plot!(1:10, df.y_pred, label = "Predicted y", linewidth = 2, color = :green)
end
