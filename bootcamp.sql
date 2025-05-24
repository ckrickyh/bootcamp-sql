create database bootcamp_2504;

use bootcamp_2504;
-- MYSQL -> case insensitive
-- Oracle, PostgreSQL -> case sensitive

create table Person(
	name varchar(50),
    age integer,
    salary numeric(10,2) -- 整數位10，小數位2
);

insert into Person (name, age, salary) values ('John', 13, 25000.5);
insert into Person (name, age, salary) values ('Peter', 18, 35000);

-- * means all columns
select * from Person;
select name from person;
select name, salary from person;

-- update teh data in harddisk
update person set age = 19 where name = 'John';

select * from person;

delete from person where salary > 30000;

select * from person;

-- =====================================================
create table cat(
	id bigint,
    age integer,
    weight numeric(10,2)
);

insert into cat values (1, 13, 9);
insert into cat 
insert into cat (id, age) values (2, 18);
insert into cat values
	(3, 18, 3), -- , not ;
    (4, 18, 3),
    (3, 18, 3);

select * from cat;

-- ====== update 2 cat by condition
-- update cat set name = concat('super', name) where age > 9;
select * from cat;

delete from cat where age is null;
select * from cat;

-- alias
select c.* from cat c;

-- update
select * from person;
update person set age = 18 where name = "John";

-- add column
alter table cat add column email varchar(50);
update cat set email ="xxx@gmail.com" where id = 1;
update cat set email ="xxx@gmail.com" where age = 12;

-- modify colum
alter table cat modify email varchar(70);

-- ordering
select *
from cat 
where name = 'Lucas' or name = 'Steven'
order by age desc;

select *
from cat 
order by age desc, name desc;

select f.*
from cat f
where length(f.name) > 4  
order by f.age desc, f.name desc;

-- string functions
-- substring
select substring(f.name, 1,2) -- start from first, not 0, how much character you need 
from cat f;

select upper(f.name), lower(f.name), f.name 
from cat f;

select replace(f.name, 's', 'x'), f.name
from cat f;

-- case insensitive
select * from person c where c.name = 'John';
-- case non-insensitive
select * from person c where binary c.name = 'John';


-- Math
CREATE TABLE CIRCLES (
	id bigint, -- big integer
	RADIUS DECIMAL(3, 2), -- same as numeric
    COLOR VARCHAR(20)
);

INSERT INTO CIRCLES VALUES (1, 3.5, 'RED');
INSERT INTO CIRCLES VALUES (2, 4.1, 'YELLOW');

SELECT * FROM CIRCLES;

SELECT ROUND(c.radius * c.radius * 3.14, 3), 
	c.radius * c.radius *3.14,
    power(c.radius, 2) * PI(),
    ceil(c.radius * c.radius * 3.14),
    floor(c.radius * c.radius * 3.14),
    c.radius
from circles c;


-- Table design / Data
-- 1. user request (datetime)
-- 2. resutlof processing (datetime)

create table customer_order_requests (
	id bigint,
    order_datatime datetime,
    customer_id bigint,
    order_id bigint
);

insert into customer_order_requests values (1, '2024-10-31 14:30:35', 23, 90);
insert into customer_order_requests values (2, STR_TO_DATE('2025-01-31 19:00:00', '%Y-%m-%d %H:%i:%s'), 20, 150);
insert into customer_order_rerquests values (3, NOW(), 10, 400);

select * from customer_order_requests;

create table customers (
	id bigint,
    first_name varchar(50),
    last_name varchar(50),
    dob date,
    gender varchar(1)
);

insert into customers values (1, 'Lucas', 'Chan', Str_to_date('2000-01-31', '%Y-%m-%d'), 'M');
insert into customers values (2, 'Peter' , 'Lau', Str_to_date('2005-02-20', '%Y-%m-%d'), 'M');
insert into customers values (3, 'Sally' , 'Lau', Str_to_date('1998-12-20', '%Y-%m-%d'), 'F');

select * from customers;
-- find the customer, whose last_name = lau and dob > 2000-01-01;


select * from customers where dob > str_to_date('2000-01-01', '%Y-%m-%d') and dob < date_sub(dob, interval 200 month);

select c.* from customers c where last_name = 'lau' and dob > str_to_date(2000-01-01, '%Y-%m-%d');

select date_add(c.dob, interval 3 month), c.* from customers c;
select date_sub(c.dob, interval 3 month), c.* from customers c;
select datediff(now(), c.dob), c.* from customers c;

-- Aggregation Functions
-- count, max, min, avg, sum
select * from customers where dob > str_to_date('2000-01-01', '%Y-%m-%d');
select count(*) from customers where dob > str_to_date('2000-01-01', '%Y-%m-%d');
select min(dob) from customers c;

select age from cat;
select * from customers where dob = min(dob);

select * from cat;

-- GroupBy

create table books(
	title varchar(50),
    genre varchar(50),
    price numeric(10,2)
);
select * from books;

insert into books values('book1', 'adventure', 11.90);
insert into books values('book2', 'fantasy', 8.49);
insert into books values('book3', 'romance', 9.99);
insert into books values('book4', 'adventure', 9.99);
insert into books values('book5', 'fantasy', 7.99);
insert into books values('book6', 'romance', 5.88);

-- where > filter record
-- having -> filter group
select b.genre, avg(b.price) as avg_price -- step 3
from books b
where b.genre <> 'adventure' -- step 1 filter record
group by b.genre having avg(b.price) > 6; -- step 2 // 徒汰 group

-- Table relationships (One to Many)
select * from customers;

create table orders (
	id bigint,
	order_date date,
    amount decimal(6,2),
    customer_id bigint
);

insert into orders values (1, '2025-05-01', 999.9, 2);
insert into orders values (2, '2025-05-09', 1500, 3);
insert into orders values (3, '2025-05-18', 80, 2);

select * from orders;
select * from customers;

-- exists
-- filter table linking from anoter table
select *
from customers c
where not exists (select * from orders o where o.customer_id = c.id);

select *
from customers c
where exists (select * from orders o where o.customer_id = c.id);

select *
from customers c
where exists (select * from orders o where o.customer_id = c.id and o.order_date between '2025-05-09' and '2025-5-15');

-- join tables (customers + orders)
-- select c.*, avg(o.amount)
select c.*, o.amount
from customers c inner join orders o on c.id = o.customer_id -- inner join
where o.order_date between '2025-05-09' and '2025-05-15';
-- group by c.id;

-- left join
select c.first_name, c.last_name, c.dob, c.gender, avg(o.amount)
from customers c left join orders o on c.id = o.customer_id
group by c.first_name, c.last_name, c.dob, c.gender;

select * from customers;
select * from orders;
    




