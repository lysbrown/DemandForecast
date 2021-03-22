OVERALL PURPOSE
The overall purpose of this project was to predict the sales over a 90 day period of 50 different items from 10 different stores. This was part of a Kaggle competition, https://www.kaggle.com/c/demand-forecasting-kernels-only/overview, which is where the train and test data was obtained from. 

FILE PURPOSE
This readme file serves to guide readers who view my code. The RSNotebook.R file contains the code that I submitted and ran through the Kaggle server for scoring. It contains necessary libraries and code required to read in the data. It takes the training data provided, runs it through prophet and outputs predictions in the format required for scoring (ds, y). 

CLEANING AND FEATURE ENGINEERING
For this project, the data had no missing values and therefore required no cleaning. When I looked at the response variable, sales, I saw some skewedness which I corrected by taking the log of sales, using the log1p() function. All predictions were made in the log scale before being transformed back using the exmp1() function. Because it was a very large dataset, I used a double for loop in order to iterate through each store and item pair and make individual predictions that were joined together. I focused less on feature engineering and more on learning about how prophet functions, tinkering with its seasonality options. The result was a simple prophet model with no feature engineering done. I would be interested in the future on adding a variable, "previous day's sales" as a possible predictor of future sales. 

METHODS FOR PREDICITON
I used the prophet package in order to generate my predictions, run through a double for loop. The double for loop iterated through each store-item pair and gave predictions for each. In the for loop, the model was trained, tested, and ID's were attached before being organized for submission. The best model I was able to create had no additional seasonality features enabled, had daily.seasonality = FALSE, and made predictions on log1p(y = sales) before being transformed back into the original scale.
