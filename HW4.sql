-- HOMEWORK 4
-- INNER join: orders,orderdetails,products and customers
-- Return back: orderNumber,priceEach,quantityOrdered,productName,productLine,city,country,orderDate

SELECT t1.orderNumber, t1.priceEach, t1.quantityOrdered, t3.productName, t3.productLine, t4.city, t4.country, t2.orderDate
FROM orderdetails t1
INNER join orders t2
ON t1.orderNumber = t2.orderNumber
INNER JOIN products t3
ON t1.productCode = t3.productCode
INNER JOIN customers t4
ON t2.customerNumber = t4.customerNumber;

