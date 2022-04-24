# Overview
This case requires trainees to develop a model for predicting customer churn at “Cell2Cell,” a fictitious wireless telecom company, and use insights from the model to develop an incentive plan for enticing would-be churners to remain with Cell2Cell. Data for the case are available in csv format. The data are a scaled down version of the full database generously donated by an anonymous wireless telephone company. There are still 71,047 customers in the database, and 75 potential predictors. Trainees can use whatever method they wish to develop their predictive model. Logistic regression is perhaps the most obvious choice and is adequate for the task. The data are available in one data file with 71,047 rows that combines the calibration and validation customers. “calibration” database consisting of 40,000 customers and a “validation” database consisting of 31,047 customers.

# Aim of Project
1. Demonstrate the predictive performance of the model.
2. Key factors that predict customer churn.
3. What offers should be made to which customers to encourage them to remain with Cell2Cell? Also generate net positive cash flow, i.e., generate additional customer revenues after subtracting out the cost of the incentive.


# Life Cycle of Project

1.Data Analysis

Exploratory data analysis through understanding of data. 
Looking at the distribution of dependent variable and also segregating categorical with numerical variable. 
45% data having missing value

2.Feature Engineering

Deleting the variables is not ideal, hence Imputing missing value by mean value treatment
Outliers is capped with 5 and 95 percentile. 

3.Feature Selection

Significant categorical variables are selected through chi sq. test and stepwise regression. 
For numerical variable, log and sqrt transformation is applied to make normally distributed.

4.Model Building

Building the final model through splitting the dataset into development and validation datasets.
Predicting the total spend in both the datasets and creating top 10 decile to test model’s ability to predict the intended outcome.

# Output

<img width="895" alt="Log Dev " src="https://user-images.githubusercontent.com/104310260/164984314-8519ce64-d596-479d-b456-0e23de285e27.png">
<img width="899" alt="Log Val" src="https://user-images.githubusercontent.com/104310260/164984324-ab24200e-c9ce-4ea3-b031-9304dfd1b3fe.png">
<img width="895" alt="Log Charts" src="https://user-images.githubusercontent.com/104310260/164984335-ea2ca19b-fbe9-4db1-b3e6-a9eb6d7bc765.png">

Logistic regressions have always been an influential method in data science and by using it, I found that the accuracy of the model is close to 62% on both training and testing datasets. This amount of accuracy on such a database is significantly enough and implies that the model is robust. 

Revenue, Mean monthly minutes of use, percentage change in minutes of use, Mean no. of dropped voice calls, No. of unique and active subs, Age, Refurbished headset, Credit Rating, Equipment days. Percentage change in minutes of use and Mean no. of dropped voice calls can be intuitively understood to be linked to churn as those who cannot afford to pay an increase in bill tend to churn to maintain balance. 

Here are some ways to reduce the customer churn: 

1- Cell2Cell would want customers to sign up for additional products, thereby, ensuring the increase in revenue as well as customer retention because surveys have shown that the retention rate of a customer in a telecom industry is directly proportional to the number of products that a customer is buying from a company. 

2-Another way is addressing to the customers problem efficiently and effectively. Wireless-telecom industry involves a list of problem such as slow network, billing errors, ease of assistance etc. Cell2Cell can structure a system where a customer can know the way Cell2Cell is using to resolve their queries, the tentative date by which the problem will get fixed and how to provide the contact details of right person for further inquiry. 

