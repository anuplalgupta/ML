import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import re
#matplotlib.use('Agg')

#print (pd.__version__)

#create a series object 

city_names = pd.Series(['San Francisco', 'San Jose', 'Sacramento'])
#print(city_names)

population = pd.Series([852469, 1015785, 485199]);

city_details = pd.DataFrame({'CityName' : city_names, 'Population' : population});

#print(city_details);
california_housing_dataframe = pd.read_csv("https://storage.googleapis.com/mledu-datasets/california_housing_train.csv", sep=",")
#print(california_housing_dataframe.describe());
#print("california_housing_dataframe.head()");
#print(california_housing_dataframe.head());

#print("california_housing_dataframe.hist()");

california_housing_dataframe.hist();
#plt.show();

#print(type(city_details));
#print(city_details['CityName'][1]);
#print (type(city_details[0:2]))
#print(city_details[0:2]);
#print (population/100)

#print(np.log(population));
#print(population.apply(lambda val: val > 100000))
city_details['Area square miles'] = pd.Series([46.87, 176.53, 97.92])
city_details['Population density'] = city_details['Population'] / city_details['Area square miles']

#print(city_details)

####Exercersice 1##################
area = pd.Series(city_details['Area square miles']>50);
saintCity = city_details['CityName'].apply(lambda name: name.startswith('San'));

#city_details['saint city'] = city_details.apply(lambda val: val['Population'] > 10000) 
# & val['Population'] > 100000);
city_details['saint city'] = area & saintCity

#print(city_details.index);
#print(city_names.index);
#print(city_details)
city_details = city_details.reindex([2,0,1]);
#print(city_details);

#for x in range(3):
 #   print(city_details.reindex(np.random.permutation(city_details.index)))
print(city_details)
city_details = city_details.reindex([3,6,8])
print(city_details);
print(city_details.index)