#!/usr/bin/env python
# coding: utf-8

# In[4]:


import sys
import numpy
import matplotlib
import seaborn
import scipy
import sklearn

print('Python {}'.format(sys.version))
print('numpy {}'.format(numpy.__version__))
print('matplotlib {}'.format(matplotlib.__version__))
print('searborn {}'.format(seaborn.__version__))
print('Scipy {}'.format(scipy.__version__))
print('Sklearn {}'.format(sklearn.__version__))


# In[5]:



import sys
import numpy
import matplotlib
import seaborn
import scipy
import sklearn

print('Python {}'.format(sys.version))
print('numpy {}'.format(numpy.__version__))
print('matplotlib {}'.format(matplotlib.__version__))
print('searborn {}'.format(seaborn.__version__))
print('Scipy {}'.format(scipy.__version__))
print('Sklearn {}'.format(sklearn.__version__))



# In[6]:


#import  the necessary packages
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


# In[7]:


#load data set

data = pd.read_csv('creditcard.csv')


# In[8]:


#Understand data set

print(data.columns)


# In[9]:


print(data.shape)


# In[10]:


print(data.describe)


# In[11]:


print(data.describe())


# In[12]:


data = data.sample(frac=0.1, random_state=1)


# In[13]:


print(data.shape)


# In[14]:


#Historgram to understand the distribution
data.hist(figsize=(20,20))


# In[15]:


#Number of frauds
fraud = data[data['Class']== 1]
valid = data[data['Class']== 0]

outlier_fraction = len(fraud) / float(len(valid))

print(outlier_fraction)
print('Fraud cases: {}'.format(len(fraud)))
print('Valid transactions: {}'.format(len(valid)))


# In[16]:


# Correlation matrix
corrmat = data.corr()
fig = plt.figure(figsize=(12,9))
sns.heatmap(corrmat, vmax = .8, square = True)
plt.show()


# In[17]:


#get colums from data
columns = data.columns.tolist()
#filter the columns to remove data we don not want
columns = [c for c in columns if c not in ['Class']]

#Store the variable we'll be predicting on

target = "Class"

X = data[columns]
Y = data[target]

#Print the dimenstion of x and y

print(X.shape)
print(Y.shape)


# In[18]:


from sklearn.metrics import classification_report, accuracy_score
from sklearn.ensemble import IsolationForest
from sklearn.neighbors import LocalOutlierFactor

# define a random state
state =1 

# define the outlier detection methods
classifiers = {
    "Isolation Forest" : IsolationForest(max_samples = len(X),
                                         contamination = outlier_fraction,
                                        random_state = state),
    
    "Local Outlier Factor" : LocalOutlierFactor(
                                n_neighbors = 20,#can be tuned to get better results
                            contamination = outlier_fraction)
}


# In[19]:


# Fit the model
n_outlier = len(fraud)

for i, (clf_name, clf ) in enumerate(classifiers.items()):
    #fit  the data and tag outlier
    if clf_name == "Local Outlier Factor":
        y_pred = clf.fit_predict(X)
        score_pred = clf.negative_outlier_factor_
    else:
        clf.fit(X)
        score_pred = clf.decision_function(X)
        y_pred = clf.predict(X)
        
    #Reshape the prediction values to 0 for valid, 1 for fraud
    y_pred[y_pred == 1] = 0
    y_pred[y_pred == -1] = 1
    
    n_errors = (y_pred != Y).sum()
    
    #Run classification metrics
    print('{} : {}'.format(clf_name,n_errors))
    print(accuracy_score(Y,y_pred))
    print(classification_report(Y, y_pred))
    


# In[ ]:





# In[ ]:




