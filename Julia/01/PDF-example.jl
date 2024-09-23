using Plots, Distributions

# support of normal density:
x_range = range(-4, 4, length=100)

# PDF for all these values:
pdf_normal = pdf.(Normal(), x_range)

# plot:
plot(x_range, pdf_normal, color=:black, legend=false)
xlabel!("x")
ylabel!("dx")
savefig("JlGraphs/PDF-example.pdf")