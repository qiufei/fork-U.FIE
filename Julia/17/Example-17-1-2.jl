using WooldridgeDatasets, GLM, DataFrames

mroz = DataFrame(wooldridge("mroz"))

# estimate linear probability model:
reg_lin = lm(@formula(inlf ~ nwifeinc + educ + exper + (exper^2) +
                             age + kidslt6 + kidsge6), mroz)

# predictions for two "extreme" women:
X_new = DataFrame(nwifeinc=[100, 0], educ=[5, 17],
     exper=[0, 30], age=[20, 52],
     kidslt6=[2, 0], kidsge6=[0, 0])
predictions = round.(predict(reg_lin, X_new), digits=5)

print("predictions = $predictions")