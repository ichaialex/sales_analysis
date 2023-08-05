SELECT *
FROM [housing project]

--classify  NEIGHBORHOOD, building_class_category,tax_class_present, building_class_present,building_class_sale, year to better understand the data.
 --NEIGHBORHOOD
SELECT distinct NEIGHBORHOOD 
from [housing project] 
 --building_class_category
 SELECT distinct building_class_category
 from [housing project]
 --tax_class_present
 SELECT distinct tax_class_present
  from [housing project]
 --building_class_present
  SELECT distinct building_class_present
  from [housing project]
  --building_class_sale
  SELECT distinct building_class_sale
  FROM [housing project]
  --YEAR
  SELECT distinct YEAR( sale_date) as YEAR
  from [housing project]
--replace null values in apartment_number with an apartment number where appropriate
 
 SELECT
    address,
    CASE
        WHEN CHARINDEX(', ', address) > 0 THEN
            SUBSTRING(address, CHARINDEX(', ', address) + 2, LEN(address) - CHARINDEX(', ', address) + 1)
        ELSE
            NULL
    END AS apartment_number
FROM [housing project]
  -- delete apartment in the address section and update the table to include the apartment number from address.
   UPDATE [housing project]
SET
    apartment_number = SUBSTRING(address, CHARINDEX(', ', address) + 2, LEN(address) - CHARINDEX(', ', address) + 1),
    address = LEFT(address, CHARINDEX(', ', address) - 1)
WHERE CHARINDEX(', ', address) > 0

--add year column in the data set
 ALTER TABLE [housing project]
 add year_column INT
 --POPULATE YEAR COLUMN WITH DATA
  UPDATE [housing project]
   SET year_column= YEAR(SALE_DATE)

   UPDATE [housing project]
SET SALE_PRICE = 
    CASE 
        WHEN SALE_PRICE = N'-' THEN N'0'
        ELSE TRY_CONVERT(int, SALE_PRICE)
    END;
--amount sold in each neighborhood each year.
      --2016
    SELECT neighborhood,SUM(TRY_CONVERT(int, SALE_PRICE)) AS price_total
    from [housing project]
    WHERE year_column = 2016
    GROUP by NEIGHBORHOOD
     --2017
     SELECT neighborhood,SUM(CONVERT(NUMERIC(18), REPLACE(sale_price, '-', '0'))) as total_sale
    from [housing project]
    WHERE year_column = 2017
    GROUP by NEIGHBORHOOD

--stakeholders want to know how many units they have not sold yet categorized by building class and broken down in years
 --units yet to be sold in 2016
 SELECT building_class_category,COUNT (sale_price) AS sale_count
 FROM [housing project]
 WHERE SALE_PRICE =0 and year_column= 2016
 GROUP by BUILDING_CLASS_CATEGORY
 --units yet to be sold in 2017
 SELECT building_class_category,COUNT (sale_price) AS sale_count
 FROM [housing project]
 WHERE SALE_PRICE =0 and year_column= 2017
 GROUP by BUILDING_CLASS_CATEGORY

--stakeholders also want to know their sales in 2017 and 2018
  SELECT year_column, SUM(TRY_CONVERT(numeric(18), SALE_PRICE)) as total_sales
  from [housing project]
  GROUP by year_column
--stakeholders want to know the top neighborhood,building category
SELECT top 1(NEIGHBORHOOD), SUM(TRY_CONVERT(numeric(18), SALE_PRICE)) as top_sale
FROM [housing project]
GROUP by NEIGHBORHOOD
order by top_sale DESC



