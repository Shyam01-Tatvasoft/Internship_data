INSERT INTO dbo.T112_Product 
VALUES (10,'Shirt',8,9,4,90,110,90,5,0) , 
(11,'Jeans',9,5,25,500.44,530,140,14,0) ,
(12,'Tshirt',11,4,27,800,2100,2000,2,1);

SELECT * FROM dbo.T112_Product;

-- 1
SELECT ProductID,ProductName,UnitPrice from dbo.T112_Product where UnitPrice / QuantityPerUnit < 20;
-- 2
SELECT ProductID,ProductName,UnitPrice from dbo.T112_Product where UnitPrice / QuantityPerUnit BETWEEN 20 AND 25;
-- 3
SELECT ProductName,UnitPrice from dbo.T112_Product where UnitPrice > (SELECT AVG(UnitPrice) from dbo.T112_Product);
(SELECT AVG(UnitPrice) from dbo.T112_Product);
-- 4 
SELECT TOP 10 ProductName,UnitPrice,UnitPrice / QuantityPerUnit as cost from dbo.T112_Product ORDER BY UnitPrice / QuantityPerUnit DESC;

-- 5
SELECT COUNT(Discontinued),COUNT(*) FROM dbo.T112_Product where Discontinued = 0;

-- 6
SELECT ProductName,UnitsOnOrder,UnitsInStock from dbo.T112_Product where UnitsInStock < UnitsOnOrder;

SELECT 
    SUM(CASE WHEN Discontinued = 0 THEN 1 ELSE 0 END) AS CurrentProducts,
    SUM(CASE WHEN Discontinued = 1 THEN 1 ELSE 0 END) AS DiscontinuedProducts
FROM dbo.T112_Product;


SELECT Discontinued ,COUNT(ProductName) from Products GROUP BY Discontinued;

DELETE FROM dbo.T112_Product where ProductID = 11;

drop TABLE dbo.T112_Product;



-- Assignment 2
SELECT * FROM Salesman; 
SELECT * FROM Customer;
SELECT * FROM Orders;

SELECT c.Cust_Name,s.Name from Salesman as s join Customer c ON  c.Salesman_ID = s.Salesman_ID where c.City = s.City;

SELECT o.Ord_No,o.Purch_Amt,c.Cust_Name,c.City FROM Customer c Right join Orders o ON c.Customer_ID = o.Customer_ID where o.Purch_Amt BETWEEN 500 AND 2000;

-- 1
SELECT s.Name , c.Cust_Name , s.city from Salesman s join Customer c on s.Salesman_ID = c.Salesman_ID where s.City = c.City;
-- 2
SELECT Orders.ord_no, Orders.purch_amt, Customer.cust_name, Customer.city FROM Orders, Customer WHERE Orders.purch_amt between 500 and 2000;

-- 1
SELECT s.Name , c.Cust_Name , s.city from Salesman s join Customer c on s.Salesman_ID = c.Salesman_ID where s.City = c.City;
-- 3
SELECT c.Cust_Name,c.City, s.Name, s.Commission from Customer c INNER join Salesman s ON c.Salesman_ID = s.Salesman_ID;
-- 4
SELECT c.Cust_Name,c.City , s.Name,s.Commission from Customer c join Salesman s ON s.Salesman_ID = c.Salesman_ID  where s.Commission > 12;
-- 5
SELECT c.Cust_Name,c.City , s.Name,s.City ,s.Commission FROM Customer c INNER JOIN Salesman s ON s.Salesman_ID = c.Salesman_ID  WHERE s.Commission > 12 AND NOT s.City = c.City;
-- 6
SELECT o.Ord_No, o.Ord_Date, o.Purch_Amt, c.Cust_Name, c.Grade, s.Name, s.Commission from Orders o INNER JOIN Customer C ON O.Customer_ID = c.Customer_ID INNER JOIN Salesman s on o.Salesman_ID = s.Salesman_ID;
-- 7
SELECT o.Ord_No, o.Ord_Date, o.Purch_Amt, c.Customer_ID, c.Cust_Name, c.Grade,c.City, s.Salesman_ID, s.Name, s.Commission from Orders o INNER JOIN Customer C ON O.Customer_ID = c.Customer_ID INNER JOIN Salesman s on o.Salesman_ID = s.Salesman_ID;
-- 8
SELECT c.Cust_Name,c.City, c.Grade, s.Name, s.City from Orders o INNER JOIN Customer C ON O.Customer_ID = c.Customer_ID INNER JOIN Salesman s on o.Salesman_ID = s.Salesman_ID ORDER BY c.Customer_ID;
-- 9
SELECT c.Cust_Name,c.City, c.Grade, s.Name, s.City from Orders o INNER JOIN Customer C ON O.Customer_ID = c.Customer_ID INNER JOIN Salesman s on o.Salesman_ID = s.Salesman_ID WHERE c.Grade < 300 ORDER BY c.Customer_ID;
-- 10
SELECT c.Cust_Name,c.City, o.Ord_No,o.Ord_Date,o.Purch_Amt from Customer c RIGHT JOIN Orders o ON c.Customer_ID = o.Customer_ID ORDER BY o.Ord_Date ASC;
-- 11
SELECT  c.Cust_Name,c.City,o.Ord_No,o.Ord_Date,s.Name,s.Commission from Customer c LEFT OUTER JOIN Orders o on c.Customer_ID = o.Customer_ID LEFT OUTER JOIN Salesman s ON c.Salesman_ID = s.Salesman_ID;
-- 12
SELECT * FROM Customer c RIGHT JOIN Salesman s ON c.Salesman_ID = s.Salesman_ID ORDER BY s.Salesman_ID;
-- 13
SELECT c.Cust_Name, c.City, c.Grade, s.Name as "Salseman name", o.Ord_No,o.Ord_Date,o.Purch_Amt  
FROM Customer c RIGHT OUTER JOIN Salesman s ON c.Salesman_ID = s.Salesman_ID 
RIGHT OUTER JOIN Orders o ON c.Customer_ID = o.Customer_ID;

-- 14
SELECT  c.Cust_Name , c.City , c.Grade , s.Name, o.Ord_No, o.Ord_Date, o.Purch_Amt FROM Customer c RIGHT OUTER JOIN Salesman s ON c.Salesman_ID = s.Salesman_ID LEFT OUTER JOIN Orders o ON c.Customer_ID = o.Customer_ID WHERE o.Purch_Amt > 2000  AND c.Grade IS NOT NULL;

-- 15
SELECT C.Cust_Name, C.City, C.Grade, S.Name, O.Ord_No, O.Ord_Date, O.Purch_Amt from Customer c RIGHT OUTER JOIN Salesman s on c.Salesman_ID = s.Salesman_ID LEFT OUTER JOIN Orders o ON c.Customer_ID = o.Customer_ID WHERE o.Purch_Amt >= 2000 AND c.Grade IS NOT NULL;

-- 16
SELECT a.cust_name, a.city, b.ord_no, b.ord_date, b.purch_amt AS "Order Amount" FROM customer a 
FULL OUTER JOIN orders b ON a.customer_id = b.customer_id 
WHERE a.grade IS NOT NULL;

-- 17
select * from Salesman CROSS JOIN Customer;

-- 18
SELECT * FROM Salesman CROSS JOIN Customer WHERE Salesman.City = Customer.City;

-- 19
SELECT * FROM Salesman CROSS JOIN Customer WHERE Salesman.City IS NOT NULL AND Customer.Grade IS NOT  NULL;

-- 20
SELECT * FROM Salesman CROSS JOIN Customer WHERE Salesman.City != Customer.City AND Customer.Grade IS NOT  NULL;
