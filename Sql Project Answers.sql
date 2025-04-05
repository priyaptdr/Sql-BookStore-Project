-- create database 
create database OnlineBookstrore;
use OnlineBookstrore;
-- create table 

drop table if exists Books;

-- create books table 
create table Books (
Book_ID serial primary key,
Title varchar (100),
Author varchar(100),
Genre varchar(50),
Publisher_Year int ,
Price numeric(10,2),
Stock int
);

-- create customers table 
create table customers (
customers_ID serial primary key,
Name varchar (100),
Email varchar(100),
Phone varchar(50),
City  varchar(50) ,
Country varchar(50)
);

-- create orders table 
create table orders (
Order_ID serial primary key,
customers_ID int references customers(customers_ID),
Book_ID int references Books(Book_ID),
Order_date date,
Quantity  int,
Total_Amount numeric(10,2)
);

select * from Books;
select * from customers;
select * from orders;

-- import data into book table 

-- COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
-- FROM 'C:\Users\dell\OneDrive\Desktop\csv\Customers.csv' 
-- CSV HEADER;

-- 1) Retrieve all books in the "Fiction" genre:
select * from Books where Genre = 'Fiction';

-- 2) Find books published after the year 1950:
select * from Books where Published_Year >1950;

-- 3) List all customers from the Canada:
select * from customers where Country = 'Canada';

-- 4) Show orders placed in November 2023:
 select * from orders where Order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:	
select sum(Stock) as Total_stock  from Books ;

-- 6) Find the details of the most expensive book:

-- select max(Price)  from Books;
select * from Books order by Price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
-- select * from customers 
-- join orders on customers.customers_ID= orders.customers_ID 
-- where Quantity >=1

select * from orders 
where  Quantity >1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders 
where Total_amount >20;

-- 9) List all genres available in the Books table:
select distinct Genre from Books ;

-- 10) Find the book with the lowest stock:
select * from Books order by Stock limit 1; 
 
-- 11) Calculate the total revenue generated from all orders:
select sum(Total_amount) as Revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select sum(Quantity), Books.Genre from orders join Books 
on Books.Book_ID = orders.Book_Id group by Books.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(Price ) as avg_price from Books where Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
select customers_ID,count(Order_ID) as order_count 
from  orders 
group by customers_ID 
having count(Order_ID)>=2;

select * from orders; 
-- 4) Find the most frequently ordered book:

select Book_ID , count(Order_ID) as order_count from orders
group by Book_ID 
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from Books 
where Genre =  'Fantasy'
order by Price desc
 limit 3 ;
-- 6) Retrieve the total quantity of books sold by each author:
select b.Author , sum(o.Quantity) as total_quantity from Books b
join orders o on b.Book_ID = o.Book_ID  group by b.Author;

-- 7) List the cities where customers who spent over $30 are located:
-- select c.City , b.Stock from customers c join orders o
-- on c.customers_ID = o.customers_ID join Books b 
-- on b.Book_ID = o.Book_ID 
-- where b.Stock > 30 ;

select distinct c.City , o.Total_amount  from customers c join orders o
on c.customers_ID = o.customers_ID 
where o.Total_amount > 30;

-- 8) Find the customer who spent the most on orders:

select c.customers_ID, c.Name, sum(o.Total_Amount) as total_spent  from customers c 
join orders o on c.customers_ID = o.customers_ID  group by c.customers_ID,c.Name
order by total_spent desc limit 1;







