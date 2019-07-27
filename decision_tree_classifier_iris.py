from sklearn.datasets import load_iris

iris_data = load_iris()
print (iris_data.feature_names)
print (iris_data.target_names)
print(iris_data.data[0])
print(iris_data.target[0])

for i in range(len(iris_data.target)):
	print("Example %d, label %s, features %s" % (i, iris_data.target[i], iris_data.data[i]))



