Housing project analysis
A real estate company in new York has a real estate portfolio of over 80k units and blocks all over New York.  They have provided the data set and requested the data analyst to provide a few insights to grow their business.
Process
-This sql analysis was done in azure data studio. The data was was hosted in a server inside docker where I connected to azure data studio.
-Loading the data to azure data studio was made using SQL Server import where the data was converted to various forms where appropriate and loaded successfully.
Analysis 
-the data contained an address with apartment number. This prompted me to populate the apartment column with the apartment number from the address column and delete the apartment section from the address. 
Where no apartment number was present, the column was left as null.
 The following questions were answered in the analysis:
1.classify the data to better understand the data.
2.stakeholders what to know the amount of money they have sold in each neighborhood each year
3.stakeholders want to know how many units they have not sold yet categorized by building class and broken down in years
4.stakeholders also want to know their sales in 2017 and 2018.

