from sklearn import tree;

features = [[140,1],[130,1],[150,0],[170,0]]
labels = [0,0,1,1];

classifier = tree.DecisionTreeClassifier()
classifier = classifier.fit(features,labels);

print(classifier.predict([[150,0]]))

