use classicmodels;

-- Select all records (Columns)
select * from customers;

-- Select few records (Columns)
select customerNumber, CustomerName, phone from customers;

-- Merge columns contactFirstName, contactLastName
select concat(contactFirstName,' ', contactLastName)as ContactName from customers;

-- Alias
-- alias Column
select contactFirstName, ContactLastName, concat(contactFirstName, ContactLastName) as ContactName  from customers;
-- alias Table
select contactFirstName, ContactLastName, concat(contactFirstName, ContactLastName) as ContactName  from customers as a;
-- alias Script
select concat(b.contactFirstName, b.ContactLastName) as ContactName   from (select contactFirstName, ContactLastName from customers) b;

--  17/01/2022
-- Selecting few records (10 Rows from customer table)
select * from customers
limit 10;

-- Distinct records in SQL
-- Our customers are from how many countries
select count(country) from customers;
select count(distinct(country)) from customers;

-- Ordering in SQL asc/desc
select distinct(country) from customers
order by country desc;

-- Customer Name while ordering by Contactfirstname asc and contactlastname desc
select customername,Contactfirstname,contactlastname from customers 
order by Contactfirstname asc, contactlastname desc;

-- 1st and 10th customername by credit limit
select customername, creditlimit from customers
order by creditlimit desc
limit 10;

-- Where Mainly for setting filtering condition on extracted data
-- Select col1, col2
-- from table
-- Where Condition

-- Operators =,!=,<,>,Between,>=,<=, Like,in,Not 
-- Find total records of Female customers---What db,table,column
Select * from customers
where gender= 'F';

-- Find records of Male customers from France 
select * from customers
where gender= 'M' and country='France';

-- Find customernumbers between 250 to 360
select * from customers
where customerNumber between 250 and 360;


-- Where For Update
-- Update table 
 -- set column=value 
 -- where condition
 -- Update record 350 state to London
 select * from customers where customerNumber = 350;
 update customers
 set state= 'London'
 where customerNumber = 350;
 
 -- Where in Deleting records
 -- Delete from table
-- where condition
 insert  into customers(customerNumber,customerName,contactLastName,contactFirstName,gender,phone,addressLine1,addressLine2,city,state,postalCode,country,salesRepEmployeeNumber,creditLimit) values 
(8955678,'Atelier graphique','Schmitt','Carine ','F','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'21000.00');
select * from customers where customerNumber=8955678;

delete from customers
where customerNumber=8955678;

-- Customers from France,USA and Australia
 
   select * from customers
where country = 'France''USA' and 'Australia';-- wrong

  select * from customers
where country = 'France'or'USA' or 'Australia';
  select * from customers
where country = 'France'and'USA' and 'Australia';
  select * from customers
where country = ('France','USA','Australia'); -- wrong

  select * from customers
where country = 'France'or country ='USA' or country ='Australia';
  select * from customers
where country in ('France','USA','Australia');

-- Customer with maximum credit limit
-- Maximum credit limit-- Part 1
select max(creditlimit) from customers; 
-- Who owns max(creditlimit)  10-- Part 2
select * from customers
where creditlimit= (select max(creditlimit) from customers);

-- CTE
with maxcredit as (select max(creditlimit) from customers)
select * from customers
where creditlimit= (select * from maxcredit);


-- Like Function
-- Look for customers with names starting with A
select customerName from customers
where customerName like 'A%';

select customerName from customers
where customerName like 'Au%';

-- Look for customers from country names that ends with A
select * from customers
where country like '%A';

-- Look for customer with name starting with S but ends with E.
select customerName from customers
where customerName like 'S%E';

-- Look for customer with number like _03.
select *from customers
where customerNumber like '_03';

-- 24/01/2023
use classicmodels;
-- How many employees have the firstname Leslie.
select * from employees 
where firstname = 'Leslie'; -- count(*)

-- Which employee has the highest counts of people reporting to him l her, the employee name and count of reporters.
select reportsTo,count(*) reporters from employees
group by reportsTo; -- 1102,1143;
select * from employees
where employeeNumber in (1102,1143);

-- Write a script that shows all employees with officeCode 6 and 5.
select * from employees where officecode between 5 and 6; --
select * from employees where officecode = 6 or officecode = 5; --
select * from employees where officecode in (6,5); --

-- Update employees office code of Lastname (Vanauf) and Firstname(George) to 5.
select * from employees where Lastname ='Vanauf';
update employees
set officecode=5
where employeenumber=1323;

-- Which checknumber has the least payment amount and what is the payment date.
select checknumber, paymentdate, amount from payments
where amount= (select min(amount) from payments);


-- Operators And, Or and Not

-- And & The two conditions must be true
-- Return a list of customers form USA and Stays in NYC
select *  from customers
where country= 'USA' and city= 'NYC';

-- Return a list of customers who stays in Brickhaven with creditLimit above 25000
select *  from customers
where city= 'Brickhaven' and creditlimit> 25000;


-- OR at least one conditions must be true
-- Return a list of customers form USA or Stays in NYC
select * from customers
WHERE City='NYC' or country='USA';

-- Not Negate values
-- Countries where Country in USA or France but not Australia
select distinct(country) from customers;

select distinct(country) from customers
where country = 'USA' or country = 'France' and not country ='Australia';

select distinct(country) from customers
where country in ('USA','France') and country != 'Australia';

select distinct(country) from customers
where country in ('USA','France') and country not in ('Australia');

-- Return a list of customers who stays in Brickhaven with creditLimit below 25000
select * from customers
where city = 'Brickhaven' and not creditLimit > 25000;

--  IN/Not IN and Between/ Not Between
-- In
-- Return a list of customers with customer numbers 125,128,146,145,186.
select * from customers
where customerNumber in (125,128,146,145,186);

 -- Between Range of values
-- Return a list of customers with customer numbers between 125 and 186.
select * from customers
where customerNumber between 125 and 186;

-- Between and not IN
-- Return a list of customers with customer numbers between 125 and 186 but not 125,128,146,145,186.
select * from customers
where customernumber between 125 and 186 and customernumber not in (125,128,146,145,186);

select * from customers
where customernumber between 125 and 186 or customernumber not in (125,128,146,145,186);-- Wrong

select * from customers
where customerNumber between 125 and 186 and customerNumber NOT in (125,128,146,145,186);

-- Union and Join
-- Union
-- 1st Table and second table arrangement must be thesame

-- 1 Finance
-- 2 Hr


-- Exercise: Union result of Table 1 and table 2 with colum names PersonNumber, PersonName, PersonContact
-- Customers 129, 131,141 customernumber,CustomerName, phone -- Table 1
-- Employee 1002,1056,1076 employeeNumber, Employeename, officecode  -- Table 2

-- Table 1
select customernumber PersonNumber,CustomerName as PersonName, phone PersonContact from customers
where customernumber in (129, 131,141)
union
-- Table 2
select  employeeNumber, concat(firstName,' ',lastname) Employeename, officecode,email from employees
where employeenumber in (1002,1056,1076);
-- Both tables must have equal columns.

-- 26/01/2022
-- Join
-- Used in consolidatiing (Merging) tables based on matching column values (Primary Key to Foreign key)
-- Provide the list of employees (By FirstName and LastName) and counts of customers owned, sort decending by count of customers

-- Method 1 
-- Table 1
select a.*,b.customerowned from (select employeeNumber, firstName,lastName from employees) a
join
-- Table 2
(select salesRepEmployeeNumber,count(*) customerowned from customers
where salesRepEmployeeNumber is not null
group by salesRepEmployeeNumber
order by customerowned desc) b
on a.employeeNumber=b.salesRepEmployeeNumber;

-- Method 2 
-- Table 1
select a.*,b.customerowned from (select employeeNumber, firstName,lastName from employees) a,

-- Table 2
(select salesRepEmployeeNumber,count(*) customerowned from customers
where salesRepEmployeeNumber is not null
group by salesRepEmployeeNumber
order by customerowned desc) b
where a.employeeNumber=b.salesRepEmployeeNumber;


-- Having Statement
-- It is used to return result based on aggregated funtion within our script
-- Syntax
-- Select agg(Column1),Column2, ... from table
-- group by column2
-- having agg(Column1) condition

-- Get the list of countries with more than 5 customers
-- Where cannot come after group by
select country,count(*) customerowned from customers
group by country
having count(*)>5
order by count(*);


-- Get the list of state with more than 5 customers
select state, count(*) customerowned from customers
group by state
having count(*) >5;

-- Select Columns,agg(column)
-- From tables
-- Where column condition
-- group by columns
-- having agg(column) condition
-- order by column asc|desc

-- 28/01/2023

-- Get the list of states with more than 5 customers ordering by counts of customers descending.
-- Note do not report blank states

Select state, count(customername) customercnt
from customers
where state is not null
group by state
having count(customername)>5
order by count(customername) desc;

-- Null Values
-- is null / is not null
-- Return the list of customers with null/blank address 2
select * from customers
where addressLine2 is Null;

select country, count(*) from customers
where state is Null
group by country
order by count(*); -- Hong Kong, Ireland

-- Update states to Lagos where state is null for Hong Kong and Ireland
select * from customers where state = 'Lagos' and country in ('Hong Kong','Ireland');

update customers
set state= 'Lagos'
where state is null and country in ('Hong Kong','Ireland') and customernumber <>0; -- Requesting for primary keys

-- Nested Query
select customerNumber from customers where state is null and country in ('Hong Kong','Ireland');
update customers
set state= 'Lagos'
where customerNumber in (select customerNumber from customers where state is null and country in ('Hong Kong','Ireland')); -- Cannot specify target table in subquery

-- Common Tabular Expression (CTE)
with rec as (select customerNumber from customers where state is null and country in ('Hong Kong','Ireland')),
prod as (select * from product),
cust as (select * from customers)
update customers
set state= 'Lagos'
where customerNumber in (select * from rec); -- 

-- Table
create table custnew2 as (select * from customers);

-- Nested Queries
select customernumber from (select * from customers where state is null) a;
-- Common Tabulat Expression (CTE) -- Multiple tables within a script 
-- View 
create view custnew as (select * from customers);

-- Case
-- Return Female when Gender is F and Male for others in Customer table.
-- General
select gender,
case 
	when gender= 'F' then 'Female'
    else 'Male' end as gender_disc
from customers;

-- Expression
select gender,
case gender
	when 'F' then 'Female'
    else 'Male' end as gender_disc
from customers;

-- Categorize customer credit limit to No credit (<500), Low Credit (500-50,000), 
-- medium limit (50001-150001), High Limit (150001-250000) Note use Between
select creditlimit,
case
	when creditlimit < 500 then 'No_Credit'
    when creditlimit between 500 and 50000 then 'Low_Credit'
	when creditlimit between 50001 and 150000 then 'Medium_Credit'
	else 'High_limit' end as creditlimit_cat
 from customers;
 
 -- Count customers per category having above 15 cust 
 select creditlimit_cat, count(creditlimit_cat) customerincat from (select creditlimit,
case
	when creditlimit < 500 then 'No_Credit'
    when creditlimit between 500 and 50000 then 'Low_Credit'
	when creditlimit between 50001 and 150000 then 'Medium_Credit'
	else 'High_limit' end as creditlimit_cat
 from customers) a
 group by creditlimit_cat
having count(creditlimit_cat)> 15
 order by count(creditlimit_cat);
 
 -- Rank
 select * from examresult;
 -- Rank students by mark in the examresult table
 --  Row number
 select *,
 row_number()
 over(order by marks desc) as row_num_rk
 from examresult;

 -- Rank()
 select *,
 rank()
 over(order by marks desc) as row_num_rk
 from examresult;

 -- Dense_Rank()
 select *,
 dense_rank()
 over(order by marks desc) as row_num_rk
 from examresult;

-- Rank students accross subject by mark
 --  Row number
 select *,
 row_number()
 over(partition by subject order by marks desc) as row_num_rk
 from examresult;
 
 -- Rank()
 select *,
 rank()
 over(partition by subject order by marks desc) as row_num_rk
 from examresult;

 -- Dense_Rank()
 select *,
 dense_rank()
 over(partition by subject order by marks desc) as row_num_rk
 from examresult;
 
 -- Best student accross all subject
 with rnk as ( select *,
 dense_rank()
 over(partition by subject order by marks desc) as row_num_rk
 from examresult)
 select * from rnk where row_num_rk=1 ;
 
-- 31/01/2023
 -- Index
 -- Used in optimization of table query time
 Select * from payments;
 create index checkind
 on payments (checknumber);
 
 -- Date
  Select * from payments;
  select paymentDate, now() mydate from payments;
  select paymentDate, year(paymentdate) yeardate , quarter(paymentdate) quarterdate
  , month(paymentdate) monthdate, day(paymentdate) daydate from payments;
  
  -- Get the counts and total sum of Payment transactions after 2004-12-31
select count(*) totaltransactions, sum(amount) totalpay from payments
where paymentDate > '2004-12-31';

-- Get the Customer name, count of transactions, and of payments made after 2004-12-31 
-- which customer have highest transaction count
select a.customername,b.* from
(select customernumber, customername from customers) a
join
(select customernumber,count(*) totaltransactions, sum(amount) totalpay from payments
where paymentDate > '2004-12-31'
group by customerNumber
order by count(*) desc) b
on a.customernumber=b.customernumber;

-- Get the list of Payment transactions between 2005-1-01 to 2005-06-30 (and/between) 
select * from payments
where paymentdate between '2005-1-01' and '2005-06-30';
  
  -- Quarterly payment across the year
  select year(paymentDate) Yr,quarter(paymentDate) Qtr,sum(amount) quarterlypay from payments
  group by year(paymentDate), quarter(paymentDate)
  order by year(paymentDate), quarter(paymentDate);
  
 -- Lead Function
 select *, lead(sales,1,0) over (order by Year,quarter) as Nextquartersales,
 lag(sales,1,0) over (order by Year,quarter) as Prevquartersales
 from qproductsales;
 
 -- Quarterly Increament
  select a.*, (a.sales-a.Nextquartersales) expchange,(a.sales-a.Prevquartersales) actchange 
from  (select *, lead(sales,1,0) over (order by Year,quarter) as Nextquartersales,
 lag(sales,1,0) over (order by Year,quarter) as Prevquartersales
 from qproductsales) a;
 
 