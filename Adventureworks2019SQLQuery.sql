--1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.
SELECT * FROM [HumanResources].[Employee]

--2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.  
SELECT * FROM [Person].[Person]
ORDER BY LastName 

--3. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname. 
SELECT FirstName, LastName, businessentityid AS employeeid FROM [Person].[Person]
ORDER BY LastName 

--4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
select productid, productnumber,name from [Production].[Product]
where SellStartDate is not null and ProductLine = 'T'
order by name 

--5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in descending order on subtotal.

select salesordernumber, customerid, orderdate, subtotal,(TaxAmt/SubTotal)*100 as percentage_of_tax from [Sales].[SalesOrderHeader]
order by SubTotal desc

--6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
select distinct JobTitle from [HumanResources].[Employee]
order by JobTitle

--7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.
select CustomerID,sum (Freight) as Freight_by_customer from [Sales].[SalesOrderHeader]
group by CustomerID
order by CustomerID

--8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order. 
select CustomerID,salespersonid, sum(SubTotal) as 'sum', AVG(Subtotal ) as average from [Sales].[SalesOrderHeader]
group by CustomerID,SalesPersonID
order by CustomerID desc

--9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order. 
select * from (select productid,sum(Quantity) as sum_quantity from [Production].[ProductInventory]
where Shelf in ('a','c','h')
group by ProductID) a
where a.sum_quantity>500

--10.From the following table write a query in SQL to find the total quantity for a group of locationid multiplied by 10
select sum(quantity) as total_quantity from [Production].[ProductInventory]
group by ( LocationID*10)

--11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.
select p.BusinessEntityID, p.FirstName, p.LastName,ph.PhoneNumber from [Person].[Person] P
join [Person].PersonPhone PH
on p.BusinessEntityID=PH.BusinessEntityID
where lastname like 'L%'
order by LastName,FirstName

--12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.  
select distinct SalesPersonID,CustomerID,sum(subtotal) sub_total from [Sales].[SalesOrderHeader]
group by SalesPersonID,CustomerID
order by SalesPersonID

--13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.  
select locationid, shelf , sum (quantity) as TotalQuantity from [Production].[ProductInventory]
group by cube(LocationID,Shelf)
select locationid, shelf , sum (quantity) as TotalQuantity from [Production].[ProductInventory]
group by Shelf,LocationID with cube

--14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Roll up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.
select locationid, shelf ,sum  (quantity) as TotalQuantity from [Production].[ProductInventory]
group by 
GROUPING sets 
(
(LocationID),
(Shelf),
cube((LocationID,Shelf)),
(rollup (LocationID,Shelf))
)
--or
SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) );

--15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
select LocationID,sum(quantity) as Total_qauntity from [Production].[ProductInventory]
group by rollup(LocationID)
order by LocationID

--16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.
select City,count(city) no_of_employees from [Person].[BusinessEntityAddress] B
join [Person].[Address] A
on b.AddressID = a.AddressID
group by city
order by City

--17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.  Go to the editor
select year(OrderDate),sum(SubTotal) total,sum(TotalDue) totaldue from [Sales].[SalesOrderHeader]
group by YEAR(OrderDate)
order by YEAR(orderdate)

--18  From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date. 
select year(OrderDate),sum(SubTotal) total,sum(TotalDue) totaldue from [Sales].[SalesOrderHeader]
where year(orderdate) < 2016
group by YEAR(OrderDate)
order by YEAR(orderdate)

--19.From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.
select ContactTypeID,Name from [Person].[ContactType]
where name like '%manager%'

--20 From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName. 
select b.BusinessEntityID,p.FirstName,p.LastName from [Person].[BusinessEntityContact] b
join
[Person].[ContactType] c
on b.ContactTypeID=b.ContactTypeID
inner join
[Person].[Person] p
on 
p.BusinessEntityID=b.PersonID
where c.Name like 'Purchasing Manager'
order by LastName,FirstName

--21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order

select row_number() over (order by a.postalcode) as rownumber,s. businessentityid,p.FirstName,p.LastName,s.SalesYTD,s.TerritoryID,a.PostalCode  from Sales.SalesPerson s
join 
Person.Person p 
on
s.BusinessEntityID= p.BusinessEntityID
join
Person.Address a
on
p.BusinessEntityID=a.AddressID
where s.TerritoryID is not null and 
s.SalesYTd != 0

--22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.
select b.ContactTypeID,c.Name,count( c.Name) from [Person].[BusinessEntityContact] b
join
[Person].[ContactType] c
on 
b.ContactTypeID=c.ContactTypeID
group by b.ContactTypeID,c.Name
order by count( c.Name) desc

--23.From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull. 
select  convert(date,(e.RateChangeDate)),p.LastName+' '+p.MiddleName+' '+p.LastName as full_name,40*e.Rate from [HumanResources].[EmployeePayHistory] e
join
[Person].[Person] p
on 
e.BusinessEntityID=p.BusinessEntityID
order by full_name


--24. From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull. 
select e.RateChangeDate,p.LastName+' '+p.MiddleName+' '+p.LastName as full_name,e.Rate*40 from  [HumanResources].[EmployeePayHistory] e join
[Person].[Person] p
on 
e.BusinessEntityID=p.BusinessEntityID

--25. From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.
SELECT SalesOrderID, ProductID, OrderQty
    ,SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Total Quantity"
    ,AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Avg Quantity"
    ,COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS "No of Orders"
    ,MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Min Quantity"
    ,MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Max Quantity"
    FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664);

26. From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity. 

SELECT SalesOrderID, ProductID, OrderQty
    ,SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Total Quantity"
    ,AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Avg Quantity"
    ,COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS "No of Orders"
    ,MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Min Quantity"
    ,MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS "Max Quantity"
    FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664)
and ProductID like '71%'

--27. From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.  

select * from (select SalesOrderID,sum(OrderQty * unitprice) as total_cost  from  Sales.SalesOrderDetail
group by SalesOrderID) x 
where x.total_cost>100000

--28. From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on product ID column.
select ProductID,name from Production.Product
where name like 'Lock Washer%'
order by ProductID

--29. Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. Return product ID, name, and color of the product. 
select ProductID,name,Color from Production.Product
order by  ListPrice 

--30. From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, and HireDate.
select  BusinessEntityID, JobTitle, HireDate from HumanResources.Employee
order by year(hiredate)

--31 From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.
select LastName, FirstName from [Person].[Person]
where LastName like 'R%'
order by FirstName , lastname desc

--32. From the following table write a query in SQL to ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.  Go to the editor
select BusinessEntityID, SalariedFlag 
from HumanResources.Employee
order by case when SalariedFlag='1' then BusinessEntityID end desc
,case when SalariedFlag='0' then BusinessEntityID end


--33. From the following table write a query in SQL to set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.
SELECT *  
FROM Sales.vSalesPerson 
where TerritoryName is not null
order by case when CountryRegionName like 'United States' then TerritoryName else CountryRegionName end

--34.From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.  Go to the editor
select FirstName,LastName,
row_number() over (order by a.postalcode)row_number,
RANK() over (order by a.postalcode) 'rank',
DENSE_RANK() over (order by a.postalcode) 'dense rank',
ntile(4) over (order by a.postalcode) 'quartile',
salesytd,PostalCode
from Sales.SalesPerson s join [Person].[Person] p on s.BusinessEntityID= p.BusinessEntityID 
join [Person].[Address] a on a.AddressID=p.BusinessEntityID
where s.TerritoryID is not null and s.SalesYTD != 0


--35. From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.
select  * from  HumanResources.Department
order by DepartmentID
offset 10 rows


--36. From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.  Go to the editor
select * from  HumanResources.Department
order by DepartmentID
offset 5 rows
fetch next 5 rows only

--37. From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice. 
select name,color,listprice from Production.Product
where color in ('red', 'blue')
order by ListPrice

--38. Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. Return product name, salesorderid. Sort the result set on product name column.

select p.name,s.SalesOrderID,s.orderqty  from  Sales.SalesOrderDetail s
full outer join  Production.Product p on
s.ProductID=p.ProductID
order by p.Name

--39. From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.
SELECT p.Name, s.SalesOrderID  
FROM Production.Product AS p  
LEFT OUTER JOIN Sales.SalesOrderDetail s  
ON p.ProductID = s.ProductID  
ORDER BY p.Name ;

--40.From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column. 
SELECT p.Name, s.SalesOrderID  
FROM Production.Product AS p  
join Sales.SalesOrderDetail s  
ON p.ProductID = s.ProductID  
ORDER BY p.Name ;

--41. From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether or not they are assigned a territory.
 select BusinessEntityID,ss.Name from Sales.SalesPerson sp
 left join   Sales.SalesTerritory ss
 on sp.TerritoryID= ss.TerritoryID

 --42. Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. Order the result set on lastname then by firstname.  Go to the editor
select* from person.person p
select * from HumanResources.Employee e
select * from  Person.Address a
select * from [Person].[BusinessEntity] b

--43. Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.
select x.BusinessEntityID,x.firstname, x.lastname from (select * from Person.Person
where PersonType like 'in' and LastName like 'adams') x
order by FirstName

--44. Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
select * from Person.Person
where BusinessEntityID<1500
 and lastname like 'al%'
 and FirstName like 'm%'

 --45. Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.
select x. productid, x.name, x.color from (select * from Production.Product
where name in('blade', 'crown race', 'awc logo cap')) x

--46. Create a SQL query to display the total number of sales orders each sales representative receives annually. Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID. 
 with cte_x  as 
 (select year(orderdate)yr, SalesPersonID,SalesOrderID from Sales.SalesOrderHeader
where salespersonid is not null)
select  SalesPersonID, COUNT(SalesOrderID) AS TotalSales,yr
from cte_x
group by yr, SalesPersonID

--47. From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.
with ctex as 
(select count(*) cnt from Sales.SalesOrderHeader
where SalesPersonID is not null
group by SalespersonID)
select sum(cnt) from ctex

--48. Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. The following table's columns must all be returned.  Go to the editor
select * from Production.ProductPhoto
where LargePhotoFileName like '%green_%'  


--49. Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.  Go to the editor
select a.Addressline1, a.Addressline2, a.city, a.postalcode, s.countryregioncode from  Person.Address a
join 
Person.StateProvince s on
a.stateprovinceid= s.stateprovinceid
where s.CountryRegionCode !='us'
and a.city like 'pa%'

--50. From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.  Go to the editor
select top (20)  jobtitle, hiredate from HumanResources.Employee
order by hiredate desc

--51. From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. Return all the columns from the tables.
select * from  Sales.SalesOrderHeader oh
join Sales.SalesOrderDetail od
on oh.SalesOrderID=od.SalesOrderID
 where od.OrderQty >5 or od.UnitPriceDiscount<1000
 and
 oh.TotalDue>100


 --52. From the following table write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table.
 select name,Color from Production.Product
 where name like'%red%'

--53. From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. Return name, and listprice columns from the table.  Go to the editor
select * from Production.Product
where name like '%mountain%'
and 
ListPrice = 80.99

--54. From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.  Go to the editor
select name,Color from Production.Product
where name like '%mountain%'
or name like '%road%'
 

 --55. From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.  Go to the editor
select name,Color from Production.Product
where name like '%mountain%'
and name like '%black%'

--56. From the following table write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column.  Go to the editor
select * from Production.product
where name like 'chain%'


--58. From the following table write a SQL query to output an employee's name and email address, separated by a new line character.  Go to the editor
select top (1) FirstName + +LastName+' /n ' +EmailAddress from Person.Person p
join  Person.EmailAddress e
on p. BusinessEntityID = e.BusinessEntityID

--59. From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.  Go to the editor
SELECT name,patindex('%Yellow%',name) as position
from production.product
where patindex('%Yellow%',name)>0;

--60 From the following table write a query in SQL to concatenate the name, color, and productnumber columns.  Go to the editor
select concat(name , color ,productnumber)as fullname from Production.Product

--61 Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character.  Go to the editor
select CONCAT_WS( ',', name, productnumber, color,char(10)) AS DatabaseInfo
from production.product;

--62 From the following table write a query in SQL to return the five leftmost characters of each product name.  Go to the editor
select left( name,5) from  production.product

--63 From the following table write a query in SQL to select the number of characters and the data in FirstName for people located in Australia.  Go to the editor
select len(FirstName), FirstName from  Sales.vindividualcustomer
where CountryRegionName = 'AUSTRALIA'

--64 From the following tables write a query in SQL to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.  Go to the editor
select len(c.FirstName),FirstName,LastName from Sales.vstorewithcontacts c
join
Sales.vstorewithaddresses a
on 
c.BusinessEntityID=a.BusinessEntityID
order by FirstName

--65 From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. Return product name as Lower, Upper, and also LowerUpper.  Go to the editor
select LOWER(name)as lower,upper(name)upper,lower(upper(name))as lowup from  production.Product
where ListPrice between 1000 and 1220

--66 Write a query in SQL to remove the spaces from the beginning of a string. 
 select ltrim('     five space then the text') as trimmed

 --67 From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber. Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'.  Go to the editor
 select productnumber, SUBSTRING(productnumber,3,10) trimmedproductnumber from  production.Product
 where ProductNumber like 'HN%'

 --68 68 From the following table write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T'.  Go to the editor
 select concat('0000',ProductLine), ProductLine from production.Product
 where ProductLine ='T'

--69 From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6
select businessentityid,FirstName,
case when 
BusinessEntityID <6 then REVERSE(firstname)
else
firstname
end 
from Person.Person
order by BusinessEntityID

--70 From the following table write a query in SQL to return the eight rightmost characters of each name of the product. Also return name, productnumber column. Sort the result set in ascending order on productnumber.  Go to the editor
select name,right(name,8),ProductNumber from  production.Product

--71 Write a query in SQL to remove the spaces at the end of a string.
select rtrim('spaces at end          ')

--72 From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name.  Go to the editor
select ProductNumber,name  from production.Product
where name in  ('%s')
or name like ('%M') or name like ('%L')

--or
select productnumber, name
from production.product
where RIGHT(name,1) in ('S','M','L');

--73 From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.  Go to the editor
select STRING_AGG(convert(nvarchar(max),name),',') from production.product

--74 From the following table write a query in SQL to return the names and modified date separated by commas in a single row.  Go to the editor
select  STRING_AGG( concat(convert(nvarchar(max),FirstName),convert(nvarchar,ModifiedDate)),',') from Person.Person

--75 From the following table write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows.  Go to the editor
select top (10) City, string_agg(convert(nvarchar(max),EmailAddress),',') from  Person.BusinessEntityAddress b
join
Person.Address a
on
b.AddressID=a.AddressID
join
Person.EmailAddress e
on b.BusinessEntityID=e.BusinessEntityID
group by City


--76 From the following table write a query in SQL to create a new job title called "Production Assistant" in place of "Production Supervisor".  Go to the editor
select REPLACE(x.JobTitle,'Production Supervisor','Production Assistant')from  (select * from HumanResources.Employee
where JobTitle like ('%production supervisor%'))x

--77 From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales". Return firstname, middlename, lastname and jobtitle column.  Go to the editor
select firstname, middlename,lastname, jobtitle from Person.Person p
left outer join HumanResources.Employee e
on
p.BusinessEntityID= e.BusinessEntityID
where JobTitle like 'sales%'


--78 From the following table write a query in SQL to return the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.  Go to the editor
select concat(upper(trim(LastName)),' ',FirstName) from Person.Person

--79 From the following table write a query in SQL to show a resulting expression that is too small to display. Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format.  Go to the editor
select FirstName,LastName,title, SUBSTRING( convert(nvarchar,SickLeaveHours),1,1) from HumanResources.Employee e
right join
person.Person p
on 
e.BusinessEntityID=p.BusinessEntityID

--80 From the following table write a query in SQL to retrieve the name of the products. Product, that have 33 as the first two digits of listprice.  Go to the editor
select Name, listprice from production.Product
where ListPrice like '33%'

--81 From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT). Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.  Go to the editor
select SalesYTD,CommissionPct,convert (int,round((SalesYTD/CommissionPct),0)) from  Sales.SalesPerson
where SalesYTD is not null and SalesYTD != 0
and CommissionPct != 0

--82 From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID.  Go to the editor
select firstname , lastname ,CONVERT(char(20), convert(int, s. salesytd)), p.BusinessEntityID from Person.Person p
left join 
Sales.SalesPerson s
on 
p. BusinessEntityID= s.BusinessEntityID
where SalesYTD like '2%'

--83 From the following table write a query in SQL to convert the Name column to a char(16) column. Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.  Go to the editor
select convert(char(16),name),ListPrice from production.Product
where name like 'Long-Sleeve Logo Jersey%'

-- 84 From the following table write a SQL query to determine the discount price for the salesorderid 46672. Calculate only those orders with discounts of more than.02 percent. Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).  Go to the editor
select productid, UnitPrice, UnitPriceDiscount, UnitPrice*UnitPriceDiscount as discount_price from  Sales.SalesOrderDetail
where SalesOrderID = 46672
and UnitPriceDiscount>0.02

--85 From the following table write a query in SQL to calculate the average vacation hours, and the sum of sick leave hours, that the vice presidents have used.  Go to the editor
select avg(VacationHours),sum(sickleavehours) from HumanResources.Employee
where JobTitle like 'Vice %'

--86 From the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date sales for each territory. Return territoryid, Average bonus, and YTD sales.  Go to the editor--
select territoryid,avg(bonus)bonus,sum(salesytd)sales from Sales.SalesPerson
group by TerritoryID

--87 From the following table write a query in SQL to return the average list price of products. Consider the calculation only on unique values.  Go to the editor
select avg(distinct (ListPrice)) from  production.Product

--88 From the following table write a query in SQL to return a moving average of yearly sales for each territory. Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.  Go to the editor
select BusinessEntityID, TerritoryID,year(modifieddate)year, SalesYTD, 
AVG(salesytd) over (partition by territoryid order by modifieddate) moving_avg ,
sum(salesytd) over (partition by territoryid order by modifieddate) CumulativeTotal
from Sales.SalesPerson
 where TerritoryID is not null

-- 89 From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.  Go to the editor
select BusinessEntityID, TerritoryID, year(modifieddate) as SalesYear, SalesYTD, avg(salesytd) over (partition by modifieddate order by territoryid) averagesales
,sum(salesytd) over (partition by modifieddate order by territoryid)cumulativetotal
from Sales.SalesPerson
where TerritoryID is not null

--90 From the following table write a query in SQL to return the number of different titles that employees can hold.  Go to the editor
select count(distinct(JobTitle)) from HumanResources.Employee

--91 From the following table write a query in SQL to find the total number of employees.  Go to the editor
select count(*) from HumanResources.Employee

--92 From the following table write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. Return number of salespersons, and average bonus.  Go to the editor
select avg(bonus)average,count(*) count_of_salepersons
from Sales.SalesPerson
where SalesQuota>25000


--93 From the following tables wirte a query in SQL to return aggregated values for each department. Return name, minimum salary, maximum salary, average salary, and number of employees in each department.  Go to the editor
select name,min(Rate)minsal,max(rate)maxsal ,avg (rate)avgsal ,count(name )no_od_employess from HumanResources.employeepayhistory p
join HumanResources.employeedepartmenthistory d
on
p.BusinessEntityID= d.BusinessEntityID
join
 HumanResources.Department dd
 on d. DepartmentID=dd.DepartmentID
 group by name

--94 From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.  Go to the editor

select * from (select distinct(jobtitle),count(*)count  from humanresources.employee
group by JobTitle)x
where  x.count>15

--or

select distinct(jobtitle),count(*) from humanresources.employee
group by JobTitle
having count(*)>15


--95 From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.  Go to the editor
select count(SalesOrderID)countofproduct,ProductID from  Sales.SalesOrderDetail
group by ProductID


--96 From the following table write a query in SQL to compute the statistical variance of the sales quota values for each quarter in a calendar year for a sales person. Return year, quarter, salesquota and variance of salesquota.  Go to the editor
select salesquota, datepart(qq, quotadate), var (salesquota) over (order by datepart(qq, quotadate)) from  sales.salespersonquotahistory
where year(quotadate) =2012 and BusinessEntityID=277




--97 From the following table write a query in SQL to populate the variance of all unique values as well as all values, including any duplicates values of SalesQuota column.  Go to the editor
select varp (salesquota),varp(distinct (Salesquota)) from  sales.salespersonquotahistory


--98 From the following table write a query in SQL to return the total ListPrice and StandardCost of products for each color. Products that name starts with 'Mountain' and ListPrice is more than zero. Return Color, total list price, total standardcode. Sort the result set on color in ascending order.  Go to the editor
select sum(ListPrice),sum(StandardCost),color from production.Product
where Color is not null and ListPrice != 0
and name like ('mountain%')
group by Color

--99 From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.  Go to the editor
select SalesQuota,sum(salesytd) from Sales.SalesPerson
group by 
rollup (SalesQuota)

--100 From the following table write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color. Return color, sum of ListPrice.  Go to the editor
select sum(listprice),sum(standardcost),Color from  production.Product
group by color

--101. From the following table write a query in SQL to calculate the salary percentile for each employee within a given department. Return department, last name, rate, cumulative distribution and percent rank of rate. Order the result set by ascending on department and descending on rate.  Go to the editor
select  Department, lastname, rate,CUME_DIST() over (partition by rate order by department) as cumdist,
percent_rank  () over (partition by rate order by department) as percentrank
from HumanResources.vemployeedepartmenthistory d join
HumanResources.EmployeePayHistory e
on d. BusinessEntityID= e.BusinessEntityID
order by department,rate desc 

--102 From the following table write a query in SQL to return the name of the product that is the least expensive in a given product category. Return name, list price and the first value i.e. LeastExpensive of the product.  Go to the editor
select(ListPrice),first_value (name) over (order by listprice)from production.Product
where ProductSubcategoryID =37

select name, ListPrice,FIRST_VALUE(ListPrice) over (order by listprice) from Production.Product
where ListPrice != 0
order by ListPrice 

--103. From the following table write a query in SQL to return the employee with the fewest number of vacation hours compared to other employees with the same job title. Partitions the employees by job title and apply the first value to each partition independently.  Go to the editor
select firstname , lastname ,JOBTITLE,FIRST_VALUE(LastName) over (partition by jobtitle order by vacationhours ),VacationHours  from HumanResources.Employee e
join  Person.Person p 
on 
e.BusinessEntityID= p.BusinessEntityID

--104. From the following table write a query in SQL to return the difference in sales quotas for a specific employee over previous years. Returun BusinessEntityID, sales year, current quota, and previous quota.  Go to the editor
SELECT BUSINESSENTITYID,YEAR(QUOTADATE),SALESQUOTA, LAG(SalesQuota) OVER (PARTITION BY BUSINESSENTITYID ORDER BY YEAR (QUOTADATE)) FROM Sales.SalesPersonQuotaHistory

--106. From the following tables write a query in SQL to return the hire date of the last employee in each department for the given salary (Rate). Return department, lastname, rate, hiredate, and the last value of hiredate.  Go to the editor
SELECT HIREDATE, DEPARTMENT ,RATE,LASTNAME,LAST_VALUE(HIREDATE) OVER (PARTITION BY DEPARTMENT ORDER BY RATE) FROM  HumanResources.vEmployeeDepartmentHistory DH
JOIN
HumanResources.EmployeePayHistory PH ON
DH.BUSINESSENTITYID= PH.BusinessEntityID
JOIN HumanResources.Employee E ON 
PH.BUSINESSENTITYID= E.BusinessEntityID
WHERE Department IN ('Information Services', 'Document Control');

--107. From the following table write a query in SQL to compute the difference between the sales quota value for the current quarter and the first and last quarter of the year respectively for a given number of employees. Return BusinessEntityID, quarter, year, differences between current quarter and first and last quarter. Sort the result set on BusinessEntityID, SalesYear, and Quarter in ascending order.  Go to the editor
--select BusinessEntityID,year (quotadate), datepart(qq, quotadate),SalesQuota, salesquota-lead(salesquota) over(partition by businessentityid,year (quotadate) order by year (quotadate)) from Sales.SalesPersonQuotaHistory



--108. From the following table write a query in SQL to return the statistical variance of the sales quota values for a salesperson for each quarter in a calendar year. Return quotadate, quarter, SalesQuota, and statistical variance. Order the result set in ascending order on quarter.  Go to the editor
SELECT YEAR(QUOTADATE),DATEPART(QQ,QUOTADATE),SALESQUOTA,VARP(SALESQUOTA) OVER (ORDER BY DATEPART(QQ,QUOTADATE)) FROM  Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID=277  AND YEAR(QUOTADATE) =2012
ORDER BY YEAR(QUOTADATE)

--109. From the following table write a query in SQL to return the difference in sales quotas for a specific employee over subsequent years. Return BusinessEntityID, year, SalesQuota, and the salesquota coming in next row.  Go to the editor
select SalesQuota, year(quotadate),lead(salesquota) over (order by year(quotadate)),SalesQuota- lead(salesquota) over (order by year(quotadate)) from  Sales.SalesPersonQuotaHistory
where BusinessEntityID=277



--110. From the following query write a query in SQL to compare year-to-date sales between employees for specific terrotery. Return TerritoryName, BusinessEntityID, SalesYTD, and the salesquota coming in next row.  Go to the editor
select TerritoryName, BusinessEntityID, SalesYTD, lag(salesytd) over (order by territoryname )  from Sales.vSalesPerson
where TerritoryName = 'northwest'
order by TerritoryName



--111. From the following table write a query in SQL to obtain the difference in sales quota values for a specified employee over subsequent calendar quarters. Return year, quarter, sales quota, next sales quota, and the difference in sales quota. Sort the result set on year and then by quarter, both in ascending order.  Go to the editor
select salesquota,year (QuotaDate) , datepart(qq,QuotaDate),LAG(salesquota,1) over ( order by year(quotadate),datepart(qq,QuotaDate) )
, SalesQuota-LAG(salesquota,1) over ( order by year(quotadate),datepart(qq,QuotaDate) )
from  Sales.SalesPersonQuotaHistory
where BusinessEntityID =277
and year (QuotaDate) in (2012,2013)


--112. From the following table write a query in SQL to compute the salary percentile for each employee within a given department. Return Department, LastName, Rate, CumeDist, and percentile rank. Sort the result set in ascending order on department and descending order on rate.  Go to the editor
-- The cumulative distribution calculates the relative position of a specified value in a group of values.
select Department, LastName, Rate,cume_dist () over (order by rate )  as cumdist ,PERCENT_RANK() over (order by rate )  as percrntrank from HumanResources.vEmployeeDepartmentHistory h
JOIN HumanResources.EmployeePayHistory AS e    
    ON e.BusinessEntityID = h.BusinessEntityID 
	order by Department ,rate desc

--113. From the following table write a query in SQL to add two days to each value in the OrderDate column, to derive a new column named PromisedShipDate. Return salesorderid, orderdate, and promisedshipdate column.  Go to the editor
select salesorderid, orderdate,dateadd(dd, 2,OrderDate) as PromisedShipDate from sales.salesorderheader

--114. From the following table write a query in SQL to obtain a newdate by adding two days with current date for each salespersons. Filter the result set for those salespersons whose sales value is more than zero.  Go to the editor
select dateadd(dd,2, GETDATE()) , firstname ,LastName from Sales.SalesPerson s
join Person.Person p on s.BusinessEntityID = p.BusinessEntityID join 
Person.Address a on s.TerritoryID= a. AddressID

--115. From the following table write a query in SQL to find the differences between the maximum and minimum orderdate.  Go to the editor
SELECT  MIN(ORDERDATE), MAX(ORDERDATE), DATEDIFF(DAY, MAX(orderdate), min(orderdate)) FROM  Sales.SalesOrderHeader

--116. From the following table write a query in SQL to rank the products in inventory, by the specified inventory locations, according to their quantities. Divide the result set by LocationID and sort the result set on Quantity in descending order.  Go to the editor
SELECT PRODUCTID, LOCATIONID ,QUANTITY ,DENSE_RANK() OVER (PARTITION BY LOCATIONID ORDER BY QUANTITY DESC  )
FROM  Production.ProductInventory
WHERE LocationID IN (3,4)

--117. From the following table write a query in SQL to return the top ten employees ranked by their salary.  Go to the editor
 select top (10)BusinessEntityID,Rate from HumanResources.EmployeePayHistory
 order by rate desc



--118. From the following table write a query in SQL to divide rows into four groups of employees based on their year-to-date sales. Return first name, last name, group as quartile, year-to-date sales, and postal code.  Go to the editor
SELECT P.FirstName, P.lastname , S.salesYTD, A.PostalCode,NTILE(4) OVER (ORDER BY S.SALESYTD DESC) QUARTILE FROM Sales.SalesPerson S
JOIN 
Person.Person P
ON S.BusinessEntityID=P.BusinessEntityID
JOIN
Person.Address A
ON A.AddressID= P.BusinessEntityID


--119. From the following tables write a query in SQL to rank the products in inventory the specified inventory locations according to their quantities. The result set is partitioned by LocationID and logically ordered by Quantity. Return productid, name, locationid, quantity, and rank.  Go to the editor
SELECT P.ProductID,LOCATIONID,NAME,QUANTITY,RANK() OVER (PARTITION BY LOCATIONID ORDER BY QUANTITY DESC) FROM production.productinventory i
JOIN
 production.Product P
ON I.ProductID=P.ProductID
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;

--120. From the following table write a query in SQL to find the salary of top ten employees. Return BusinessEntityID, Rate, and rank of employees by salary.  Go to the editor
 select top (10)BusinessEntityID,Rate from HumanResources.EmployeePayHistory
 order by rate desc


--121. From the following table write a query in SQL to calculate a row number for the salespeople based on their year-to-date sales ranking. Return row number, first name, last name, and year-to-date sales.  Go to the editor
SELECT FirstName,LastName, SalesYTD, ROW_NUMBER  () OVER (ORDER BY SalesYTD DESC) AS ROWNUMB FROM Sales.vSalesPerson

--122. From the following table write a query in SQL to calculate row numbers for all rows between 50 to 60 inclusive. Sort the result set on orderdate.  Go to the editor
SELECT * FROM (SELECT  ROW_NUMBER() OVER (ORDER BY ORDERDATE)ROWNUMB,* FROM  Sales.SalesOrderHeader)X
WHERE  ROWNUMB BETWEEN 50 AND 60



--123. From the following table write a query in SQL to return first name, last name, territoryname, salesytd, and row number. Partition the query result set by the TerritoryName. Orders the rows in each partition by SalesYTD. Sort the result set on territoryname in ascending order.  Go to the editor
SELECT ROW_NUMBER () OVER (PARTITION BY TERRITORYNAME ORDER BY SALESYTD),FirstName,LastName, TerritoryName, SalesYTD FROM Sales.vSalesPerson
WHERE TERRITORYNAME IS NOT NULL ORDER BY TerritoryName


--124. From the following table write a query in SQL to order the result set by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows. Return BusinessEntityID, LastName, TerritoryName, CountryRegionName.  Go to the editor
SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName FROM Sales.vSalesPerson
WHERE TERRITORYNAME IS NOT NULL
ORDER BY 
CASE WHEN 
COUNTRYREGIONNAME LIKE 'United States' THEN TERRITORYNAME 
ELSE
COUNTRYREGIONNAME
END 

--125. From the following tables write a query in SQL to return the highest hourly wage for each job title. Restricts the titles to those that are held by men with a maximum pay rate greater than 40 dollars or women with a maximum pay rate greater than 42 dollars.  Go to the editor
with ctea as (select max(rate)mrate,JobTitle,Gender from  HumanResources.Employee e
  join HumanResources.EmployeePayHistory h
  on e. BusinessEntityID= h. BusinessEntityID
  group by JobTitle,Gender)
  select * from ctea
  where mrate> 40 and gender = 'm'
  or 
  mrate> 42 and gender = 'F'

--126. From the following table write a query in SQL to sort the BusinessEntityID in descending order for those employees that have the SalariedFlag set to 'true' and in ascending order that have the SalariedFlag set to 'false'. Return BusinessEntityID, and SalariedFlag.  Go to the editor
SELECT * FROM  HumanResources.Employee
ORDER BY 
CASE WHEN SalariedFlag=1 THEN  BUSINESSENTITYID 
END
DESC, CASE WHEN SalariedFlag=0 THEN  BUSINESSENTITYID END

--127. From the following table write a query in SQL to display the list price as a text comment based on the price range for a product. Return ProductNumber, Name, and listprice. Sort the result set on ProductNumber in ascending order.  Go to the editor
SELECT ProductNumber, Name,listprice,CASE WHEN ListPrice = 0  THEN 'item not for sale'
 when ListPrice between 1 and 250 then 'item under 250$'
 when ListPrice between 251 and 1000 then 'item under 1000$'else 'above 1000'
end as pricerange
FROM production.Product

--128. From the following table write a query in SQL to change the display of product line categories to make them more understandable. Return ProductNumber, category, and name of the product. Sort the result set in ascending order on ProductNumber.  Go to the editor
select * from  production.Product


--129. From the following table write a query in SQL to evaluate whether the values in the MakeFlag and FinishedGoodsFlag columns are the same.  Go to the editor
select * from  production.Product
where MakeFlag = FinishedGoodsFlag


--130 From the following table write a query in SQL to select the data from the first column that has a nonnull value. Retrun Name, Class, Color, ProductNumber, and FirstNotNull.  Go to the editor
select ProductID,name,class, color ,coalesce (name,class, color) from  production.Product

--131. From the following table write a query in SQL to check the values of MakeFlag and FinishedGoodsFlag columns and return whether they are same or not. Return ProductID, MakeFlag, FinishedGoodsFlag, and the column that are null or not null.  Go to the editor
select MakeFlag,FinishedGoodsFlag,case when MakeFlag=FinishedGoodsFlag then null
else 
'1'
end from production.Product

SELECT ProductID, MakeFlag, FinishedGoodsFlag,   
   NULLIF(MakeFlag,FinishedGoodsFlag) AS "Null if Equal"
FROM Production.Product  
;

--132. From the following tables write a query in SQL to return any distinct values that are returned by both the query.  Go to the editor
SELECT ProductID   
FROM Production.Product  
INTERSECT  
SELECT ProductID   
FROM Production.WorkOrder ;

--or 

SELECT distinct p.ProductID   
FROM Production.Product   p
join
 Production.WorkOrder w
 on p.ProductID= w.ProductID

 --133 From the following tables write a query in SQL to return any distinct values from first query that aren't also found on the 2nd query.  Go to the editor
 SELECT ProductID   
FROM Production.Product 
EXCEPT  
SELECT ProductID   
FROM Production.WorkOrder 


--134. From the following tables write a query in SQL to fetch any distinct values from the left query that aren't also present in the query to the right.  Go to the editor
SELECT ProductID   
FROM Production.WorkOrder  
EXCEPT  
SELECT ProductID   
FROM Production.Product

--135 From the following tables write a query in SQL to fetch distinct businessentityid that are returned by both the specified query. Sort the result set by ascending order on businessentityid. 
select distinct x.BusinessEntityID from (select BusinessEntityID from Person.BusinessEntity
union
select BusinessEntityID from  Person.Person)x

or 

select BusinessEntityID from Person.BusinessEntity
intersect
select BusinessEntityID from  Person.Person

or 

select e.BusinessEntityID from Person.BusinessEntity e
inner join
Person.Person p
on 
e. BusinessEntityID= p.BusinessEntityID

--136. From the following table write a query which is the combination of two queries. Return any distinct businessentityid from the 1st query that aren't also found in the 2nd query. Sort the result set in ascending order on businessentityid. 
SELECT businessentityid   
FROM person.businessentity    
except  
SELECT businessentityid   
FROM person.person

--137. From the following tables write a query in SQL to combine the ProductModelID and Name columns. A result set includes columns for productid 3 and 4. Sort the results by name ascending.  Go to the editor
select * from (select ProductModelID,Name from  Production.ProductModel
union
select ProductModelID,Name  from  Production.Product)x
where x.ProductModelID in (3,4)

--138. From the following table write a query in SQL to find a total number of hours away from work can be calculated by adding vacation time and sick leave. Sort results ascending by Total Hours Away.  Go to the editor
select firstname,VacationHours+SickLeaveHours as 'number of hours away from work' from HumanResources.Employee e
join Person.Person p
on e. BusinessEntityID=p.BusinessEntityID
order by 2

--139. From the following table write a query in SQL to calculate the tax difference between the highest and lowest tax-rate state or province.  Go to the editor
select max(taxrate)-MIN(taxrate) from Sales.SalesTaxRate

--140. From the following tables write a query in SQL to calculate sales targets per month for salespeople.  Go to the editor
SELECT s.BusinessEntityID , FirstName, SalesQuota, SalesQuota/12 AS "Sales Target Per Month" 
FROM Sales.SalesPerson AS s   
JOIN HumanResources.Employee AS e   
    ON s.BusinessEntityID = e.BusinessEntityID  
JOIN Person.Person AS p   
    ON e.BusinessEntityID = p.BusinessEntityID;

--141. From the following table write a query in SQL to return the ID number, unit price, and the modulus (remainder) of dividing product prices. Convert the modulo to an integer value.  Go to the editor
select productid,unitprice,cast ((linetotal%UnitPrice) as int) as modulus from  Sales.SalesOrderDetail

--142. From the following table write a query in SQL to select employees who have the title of Marketing Assistant and more than 41 vacation hours.  Go to the editor
select * from  HumanResources.Employee
where JobTitle like 'Marketing Assistant' and VacationHours>41


--143. From the following tables write a query in SQL to find all rows outside a specified range of rate between 27 and 30. Sort the result in ascending order on rate.  Go to the editor
SELECT e.FirstName, e.LastName, ep.Rate  
FROM HumanResources.vEmployee e   
JOIN HumanResources.EmployeePayHistory ep   
    ON e.BusinessEntityID = ep.BusinessEntityID  
WHERE ep.Rate NOT BETWEEN 27 AND 30  
ORDER BY ep.Rate;

--144. From the follwing table write a query in SQL to retrieve rows whose datetime values are between '20111212' and '20120105'.  Go to the editor
select *, CONVERT(date,ratechangedate,0) from  HumanResources.EmployeePayHistory
where CONVERT(date,ratechangedate,0) between '20111212' and '20120105'

--145. From the following table write a query in SQL to return TRUE even if NULL is specified in the subquery. Return DepartmentID, Name and sort the result set in ascending order.  Go to the editor
select * from HumanResources.Department
where exists (select null  from HumanResources.Department)

--146. From the following tables write a query in SQL to get employees with Johnson last names. Return first name and last name.  Go to the editor
select FirstName,LastName from Person.Person
where  LastName = 'Johnson'

--147. From the following tables write a query in SQL to find stores whose name is the same name as a vendor.  Go to the editor
select * from Sales.Store s
join Purchasing.Vendor v on s.name = v.name 

--148. From the following tables write a query in SQL to find employees of departments that start with P. Return first name, last name, job title.  Go to the editor
select FirstName,LastName,d.Name from  Person.Person p
join HumanResources.Employee e on p.BusinessEntityID=e.BusinessEntityID join 
HumanResources.EmployeeDepartmentHistory h on e. BusinessEntityID= h.BusinessEntityID join
HumanResources.Department d on h. DepartmentID= d. DepartmentID
where D.name like ('P%')


--149. From the following tables write a query in SQL to find all employees that do not belong to departments whose names begin with P.  Go to the editor
select FirstName,LastName,d.Name from  Person.Person p
join HumanResources.Employee e on p.BusinessEntityID=e.BusinessEntityID join 
HumanResources.EmployeeDepartmentHistory h on e. BusinessEntityID= h.BusinessEntityID join
HumanResources.Department d on h. DepartmentID= d. DepartmentID
where D.name not like ('P%')


--150. From the following table write a query in SQL to select employees who work as design engineers, tool designers, or marketing assistant.  Go to the editor
select * from  Person.Person p
join 
 HumanResources.Employee e
 on 
 p.BusinessEntityID=e.BusinessEntityID
 where JobTitle in ('Design Engineer', 'Tool Designer', 'Marketing Assistant');



--151. From the following tables write a query in SQL to identify all SalesPerson IDs for employees with sales quotas over $250,000. Return first name, last name of the sales persons.
select firstname,lastname from  Person.Person p
 join Sales.SalesPerson s
on 
p.BusinessEntityID=s.BusinessEntityID 
where SalesQuota>250000

--152. From the following tables write a query in SQL to find the salespersons who do not have a quota greater than $250,000. Return first name and last name.  Go to the editor
select firstname,lastname from  Person.Person p
 join Sales.SalesPerson s
on 
p.BusinessEntityID=s.BusinessEntityID 
where SalesQuota<=250000

--153. From the following tables write a query in SQL to identify salesorderheadersalesreason and SalesReason tables with the same salesreasonid.  Go to the editor
select * from  Sales.salesorderheadersalesreason o
join sales.SalesReason r
on o. SalesReasonID= r.SalesReasonID




--154. From the following table write a query in SQL to find all telephone numbers that have area code 415. Returns the first name, last name, and phonenumber. Sort the result set in ascending order by lastname.  Go to the editor
select  firstname, lastname , phonenumber from  Person.Person p
join  Person.PersonPhone ph
on p. BusinessEntityID= ph.BusinessEntityID
where PhoneNumber like '415%'
order by LastName 


--155. From the following tables write a query in SQL to identify all people with the first name 'Gail' with area codes other than 415. Return first name, last name, telephone number. Sort the result set in ascending order on lastname.  Go to the editor
select  firstname, lastname , phonenumber from  Person.Person p
join  Person.PersonPhone ph
on p. BusinessEntityID= ph.BusinessEntityID
where FirstName like 'GAIL'
order by LastName 


--156. From the following tables write a query in SQL to find all Silver colored bicycles with a standard price under $400. Return ProductID, Name, Color, StandardCost.  Go to the editor
select ProductID, Name, Color, StandardCost from Production.Product
where color like 'silver'
and StandardCost <400
and ProductNumber LIKE 'BK-%'

--157 From the following table write a query in SQL to retrieve the names of Quality Assurance personnel working the evening or night shifts. Return first name, last name, shift.  Go to the editor
SELECT FirstName, LastName,Shift
FROM HumanResources.vEmployeeDepartmentHistory  
WHERE Department = 'Quality Assurance'  
and Shift in ( 'evening' ,'night')


--158. From the following table write a query in SQL to list all people with three-letter first names ending in 'an'. Sort the result set in ascending order on first name. Return first name and last name.  Go to the editor
select distinct FirstName,LastName from  Person.Person
where FirstName like '_an'
order by FirstName

--159. From the following table write a query in SQL to convert the order date in the 'America/Denver' time zone. Return salesorderid, order date, and orderdate_timezoneade.  Go to the editor
SELECT SalesOrderID, OrderDate, SWITCHOFFSET(OrderDate, '-07:00') AS OrderDate_TimeZoneADE
FROM Sales.SalesOrderHeader

--161. From the following table wirte a query in SQL to search for rows with the 'green_' character in the LargePhotoFileName column. Return all columns.  Go to the editor
SELECT * FROM Production.ProductPhoto  
WHERE LargePhotoFileName LIKE '%green_%'  

--163. From the following table write a query in SQL to specify that a JOIN clause can join multiple values. Return ProductID, product Name, and Color.  Go to the editor
SELECT ProductID, a.Name, Color  
FROM Production.Product AS a  
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
ON a.Name = b.Name;


--164. From the following table write a query in SQL to find the SalesPersonID, salesyear, totalsales, salesquotayear, salesquota, and amt_above_or_below_quota columns. Sort the result set in ascending order on SalesPersonID, and SalesYear columns.  Go to the editor



--165. From the following tables write a query in SQL to return the cross product of BusinessEntityID and Department columns.  Go to the editor
	--The following example returns the cross product of the two tables Employee and Department in the AdventureWorks2019 database. A list of all possible combinations of BusinessEntityID rows and all Department name rows are returned.
select e.BusinessEntityID, d.DepartmentID from  HumanResources.Employee e
cross join HumanResources.Department d



--166. From the following tables write a query in SQL to return the SalesOrderNumber, ProductKey, and EnglishProductName columns.  Go to the editor
select SalesOrderID, d. ProductID,NAME  from Sales.SalesOrderDetail d
join production.product  p
on 
d. productid= p.productid


--167. From the following tables write a query in SQL to return all orders with IDs greater than 60000.  Go to the editor
select * from Sales.SalesOrderDetail d
join production.product  p
on 
d. productid= p.productid
where SalesOrderID>60000


--168. From the following tables write a query in SQL to retrieve the SalesOrderid. A NULL is returned if no orders exist for a particular Territoryid. Return territoryid, countryregioncode, and salesorderid. Results are sorted by SalesOrderid, so that NULLs appear at the top. 





--169. From the following table write a query in SQL to return all rows from both joined tables but returns NULL for values that do not match from the other table. Return territoryid, countryregioncode, and salesorderid. Results are sorted by SalesOrderid.  Go to the editor
select * from  sales.salesterritory t
full outer join  sales.salesorderheader o
on t. TerritoryID= o.TerritoryID



--170. From the following tables write a query in SQL to return a cross-product. Order the result set by SalesOrderid.  Go to the editor
select t.TerritoryID, o.SalesOrderID from  sales.salesterritory t
 cross join sales.salesorderheader o

 

--171. From the following table write a query in SQL to return all customers with BirthDate values after January 1, 1970 and the last name 'Smith'. Return businessentityid, jobtitle, and birthdate. Sort the result set in ascending order on birthday.  Go to the editor
select e.BusinessEntityID, JobTitle,BirthDate  from  HumanResources.Employee e
join
Person.Person p
on e.BusinessEntityID=p.BusinessEntityID
where BirthDate>'1970-01-01'
and LastName = 'smith'
order by BirthDate



--172. From the following table write a query in SQL to return the rows with different firstname values from Adam. Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.  Go to the editor
select * from Person.Person
where FirstName != 'adam'
order by FirstName


--173. From the following table write a query in SQL to find the rows where firstname doesn't differ from Adam's firstname. Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.
select * from Person.Person
where FirstName like '%adam%'
order by FirstName

--174. From the following table write a query in SQL to find the rows where middlename differs from NULL. Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.  Go to the editor
select * from  Person.Person
where MiddleName is not null

--175. From the following table write a query in SQL to identify the rows with a middlename that is not NULL. Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.  Go to the editor
select * from  Person.Person
where MiddleName is  null

--176. From the following table write a query in SQL to fetch all products with a weight of less than 10 pounds or unknown color. Return the name, weight, and color for the product. Sort the result set in ascending order on name.  Go to the editor
select Name,Weight,Color from  Production.Product
where Weight<10
or Color is null

--177. From the following table write a query in SQL to list the salesperson whose salesytd begins with 1. Convert SalesYTD and current date in text format.  Go to the editor
select CAST(salesytd  as float) ,CAST( GETDATE() as nvarchar(50))from  Sales.SalesPerson
where SalesYTD like '1%%'

--178. From the following table write a query in SQL to return the count of employees by Name and Title, Name, and company total. Filter the results by department ID 12 or 14. For each row, identify its aggregation level in the Title column.  Go to the editor
select COUNT(jobtitle) ,jobtitle from  HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
join
HumanResources.Department d
on h.DepartmentID=d.DepartmentID
where h.DepartmentID in (12,14)
group by jobtitle
union
select COUNT(name) ,name from  HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
join
HumanResources.Department d
on h.DepartmentID=d.DepartmentID
where h.DepartmentID in (12,14)
group by rollup (name, jobtitle)  


--179. From the following tables write a query in SQL to return only rows with a count of employees by department. Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.  Go to the editor
select count(h.departmentID)department, d.Name  from  HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
join
HumanResources.Department d
on h.DepartmentID=d.DepartmentID
where h.DepartmentID in (12,14)
group by rollup (h.DepartmentID,name)

--180. From the following tables write a query in SQL to return only the rows that have a count of employees by title. Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.  Go to the editor
select count(jobtitle)JobTitlecount, JobTitle,grouping_id (name,jobtitle) from  HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID=h.BusinessEntityID
join
HumanResources.Department d
on h.DepartmentID=d.DepartmentID
where h.DepartmentID in (12,14)
group by rollup (name,JobTitle)


--181. From the following table write a query in SQL to return the difference in sales quotas for a specific employee over previous calendar quarters. Sort the results by salesperson with businessentity id 277 and quotadate year 2012 or 2013.  Go to the editor
select quotadate, salesquota, datepart(qq, QuotaDate) quat, 
lag(salesquota) over (order by quotadate),salesquota-(lag(salesquota) over (order by quotadate))
from sales.salespersonquotahistory
where BusinessEntityID=277
and year (quotadate)  in (2012,2013)

--182. From the following table write a query in SQL to return a truncated date with 4 months added to the orderdate.  Go to the editor
select orderdate,DATEADD(MONTH,4, OrderDate) from sales.salesorderheader


--183. From the following table write a query in SQL to return the orders that have sales on or after December 2011. Return salesorderid, MonthOrderOccurred, salespersonid, customerid, subtotal, Running Total, and actual order date.  Go to the editor
select SalesOrderID,month(OrderDate),SalesPersonID,CustomerID,SubTotal,sum(subtotal) over ( order by salesorderid),OrderDate from  sales.salesorderheader
where OrderDate>= 2011/12/01

--184. From the following table write a query in SQL to repeat the 0 character four times before productnumber. Return name, productnumber and newly created productnumber.  Go to the editor
select name,productnumber,CONCAT('0000', ProductNumber) from  Production.Product

--185. From the following table write a query in SQL to find all special offers. When the maximum quantity for a special offer is NULL, return MaxQty as zero.  Go to the editor
select distinct (Description),ISNULL(MaxQty,'0') from  Sales.SpecialOffer

--186. From the following table write a query in SQL to find all products that have NULL in the weight column. Return name and weight.  Go to the editor
select name, Weight from  Production.Product
where Weight is null

--187. From the following table write a query in SQL to find the data from the first column that has a non-null value. Return name, color, productnumber, and firstnotnull column.  Go to the editor
select coalesce(color, ProductNumber),name ,Color, ProductNumber from  Production.Product


--188 From the following tables write a query in SQL to return rows only when both the productid and startdate values in the two tables matches.  Go to the editors
select o.ProductID,StartDate from  Production.workorder o
join
Production.workorderrouting r
on o.ProductID=r.ProductID
and o.StartDate=r.ActualStartDate


--189. From the following tables write a query in SQL to return rows except both the productid and startdate values in the two tables matches.  Go to the editor
select ProductID,StartDate from Production.workorder except (select o.ProductID,StartDate from  Production.workorder o
join
Production.workorderrouting r
on o.ProductID=r.ProductID
and o.StartDate=r.ActualStartDate
)


--190. From the following table write a query in SQL to find all creditcardapprovalcodes starting with 1 and the third digit is 6. Sort the result set in ascending order on orderdate.  Go to the editor
SELECT salesorderid, orderdate, creditcardapprovalcode  
FROM sales.salesorderheader 
WHERE creditcardapprovalcode LIKE '1_6%'  
ORDER by orderdate;


--191. From the following table write a query in SQL to concatenate character and date data types for the order ID 50001.  Go to the editor
select CONCAT('this order is due on',' ',duedate) from sales.SalesOrderHeader
where SalesOrderID = 50001

--192. From the following table write a query in SQL to form one long string to display the last name and the first initial of the vice presidents. Sort the result set in ascending order on lastname.  Go to the editor
SELECT concat(lastname,' ',substring(FirstName, 1,1)) , JobTitle
FROM Person.Person AS p  
    JOIN HumanResources.Employee AS e  
    ON p.BusinessEntityID = e.BusinessEntityID  
WHERE e.JobTitle LIKE 'Vice%'  
ORDER BY LastName ASC;

--193. From the following table write a query in SQL to return only the rows for Product that have a product line of R and that have days to manufacture that is less than 4. Sort the result set in ascending order on name.  Go to the editor
select * from  Production.Product
where ProductLine = 'R'
and DaysToManufacture <4
order by name asc


--194. From the following tables write a query in SQL to return total sales and the discounts for each product. Sort the result set in descending order on productname.  Go to the editor
select  p. Name,(OrderQty*UnitPrice), (OrderQty*UnitPrice)*(UnitPriceDiscount)
from  Production.Product p join
Sales.SalesOrderDetail s on 
p.ProductID=s.ProductID
order by name  desc




--195. From the following tables write a query in SQL to calculate the revenue for each product in each sales order. Sort the result set in ascending order on productname.  Go to the editor
select p. productid,s.salesorderid,sum(linetotal) over (partition by p.productid, s.salesorderid) from Production.Product p
join 
Sales.SalesOrderDetail s on
p.productid=s.ProductID
order by p.ProductID

--196. From the following tables write a query in SQL to retrieve one instance of each product name whose product model is a long sleeve logo jersey, and the ProductModelID numbers match between the tables.  Go to the editor
select * from Production.Product p join 
Production.ProductModel m
on p.ProductModelID=m.ProductModelID
where p.name like '%long-sleeve%'

--197. From the following tables write a query in SQL to retrieve the first and last name of each employee whose bonus in the SalesPerson table is 5000.  Go to the editor
select FirstName,LastName from Person.Person p
join
HumanResources.Employee e
on
p.BusinessEntityID=e.BusinessEntityID
join Sales.SalesPerson s
on e.BusinessEntityID=s.BusinessEntityID
where Bonus=5000



--198. From the following table write a query in SQL to find product models where the maximum list price is more than twice the average.  Go to the editor
select ProductID from Production.Product where(
select  max(listprice) from Production.Product) >=
 2*(select avg(listprice)from Production.Product)


 --199. From the following table write a query in SQL to find the names of employees who have sold a particular product.
  SELECT DISTINCT pp.LastName, pp.FirstName 
FROM Person.Person pp JOIN HumanResources.Employee e
ON e.BusinessEntityID = pp.BusinessEntityID 
WHERE pp.BusinessEntityID IN 
(SELECT SalesPersonID 
FROM Sales.SalesOrderHeader
WHERE SalesOrderID IN 
(SELECT SalesOrderID 
FROM Sales.SalesOrderDetail
WHERE ProductID IN 
(SELECT ProductID 
FROM Production.Product p 
WHERE ProductNumber = 'BK-M68B-42')));

--or 

select distinct FirstName,LastName from  Person.Person p
join
sales.SalesOrderHeader  h
on p.BusinessEntityID=h.SalesPersonID
join
 Sales.SalesOrderDetail d
 on h.SalesOrderID=d.SalesOrderID
join  Production.Product pr
on
d.ProductID=pr.ProductID
where ProductNumber='BK-M68B-42'

-- 200. Create a table public.gloves from Production.ProductModel for the ProductModelID 3 and 4,From the following table write a query in SQL to include the contents of the ProductModelID and Name columns of both the tables.  Go to the editor
SELECT ProductModelID, Name
INTO public.Gloves
FROM Production.ProductModel
WHERE ProductModelID IN (3, 4);