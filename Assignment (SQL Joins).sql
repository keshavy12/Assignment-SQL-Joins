use company_db;

# Table 1: Customers

create table Customers
(CustomerID int Primary Key,
CountryName Varchar(50),
City Varchar (50));

alter table Customers
rename column CountryName to CustomerName;

select * from Customers;

insert into Customers
values
(1, "John Smith", "New York"),
(2, "Mary Johnson", "Chicago"),
(3, "Peter Adams", "Los Angeles"),
(4, "Nancy Miller", "Houston"),
(5, "Robert White", "Miami");

select * from Customers;

# Table 2: Orders

create table Orders
(OrderID int Primary Key,
CustomerID int,
OrderDate Date,
Amount int,
Foreign Key (CustomerID) references Customers(CustomerID));

select * from Orders;

insert into Orders
values
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 5, '2024-10-12', 400);

select * from Orders;

# Table 3: Payments

create table Payments
(PaymentID Varchar(10) Primary Key,
CustomerID int,
PaymentDate Date,
Amount int,
Foreign Key (CustomerID) references Customers(CustomerID));

select * from Payments;

insert into Payments
values
("P001", 1, '2024-10-02', 250),
("P002", 2, '2024-10-06', 300),
("P003", 3, '2024-10-11', 450),
("P004", 4, '2024-10-15', 200);

select * from Payments;

# Table 4: Employees

create table Employees
(EmployeeID int Primary Key,
EmployeeName Varchar(50),
ManagerID int);

select * from Employees;

insert into Employees
values
(1, "Alex Green", Null),
(2, "Brian Lee", 1),
(3, "Carol Ray", 1),
(4, "David Kim", 2),
(5, "Eva Smith", 2);

select * from Employees;

# Question 1. Retrieve all customers who have placed at least one order.

select distinct C.CustomerID, C.CustomerName
from Customers as C
Inner Join Orders as O
on C.CustomerID = O.CustomerID;

# Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

select C.CustomerID, C.CustomerName, O.OrderID, O.Amount
from Customers as C
Left Join Orders as O
on C.CustomerID = O.CustomerID;

# Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.

select C.CustomerName, O.OrderID, O.Amount
from Customers as C
Right Join Orders as O
on C.CustomerID = O.CustomerID;

# Question 4. Display all customers and orders, whether matched or not.

select C.CustomerID, C.CustomerName, O.OrderID
from Customers as C
Left Join Orders as O on C.CustomerID = O.CustomerID

Union

select C.CustomerID, C.CustomerName, O.OrderID
from Customers as C
Right Join Orders as O on C.CustomerID = O.CustomerID;

# Question 5. Find customers who have not placed any orders.

select C.CustomerID, C.CustomerName
from Customers as C
Left Join Orders as O
on C.CustomerID = O.CustomerID
Where O.OrderID is Null;

# Question 6. Retrieve customers who made payments but did not place any orders.

select C.CustomerID, C.CustomerName
from Customers as C
Inner Join Payments as P on C.CustomerID = P.CustomerID
Left Join Orders as O on C.CustomerID = O.CustomerID
Where O.OrderID is Null;

# Question 7. Generate a list of all possible combinations between Customers and Orders.

select C.CustomerName, O.OrderID
from Customers as C
Cross Join Orders as O;

# Question 8. Show all customers along with order and payment amounts in one table.

select C.CustomerName,
O.Amount as OrderAmount,
P.Amount as PaymentAmount
from Customers as C
Left Join Orders as O on C.CustomerID = O.CustomerID
Left Join Payments as P on C.CustomerID = P.CustomerID;

# Question 9. Retrieve all customers who have both placed orders and made payments.

select distinct C.CustomerID, C.CustomerName
from Customers as C
Inner Join Orders as O on C.CustomerID = O.CustomerID
Inner Join Payments as P on C.CustomerID = P.CustomerID;