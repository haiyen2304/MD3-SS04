create database s04_bt2;
use s04_bt2;
create table customer(
	c_id int primary key auto_increment,
    c_name varchar(255),
    c_age int
);
create table orders(
	o_id int primary key auto_increment,
    c_id int,
    o_date datetime,
    o_totalprice double,
    constraint fk_04 foreign key (c_id) references customer(c_id)
);
create table products(
	p_id int primary key auto_increment,
    p_name varchar(255),
    p_price double
);
create table order_detail(
	o_id int,
    p_id int,
    od_QTY int,
    primary key(o_id,p_id),
    constraint fk_05 foreign key (o_id) references orders(o_id),
    constraint fk_06 foreign key (p_id) references products(p_id)
);
insert into customer(c_name,c_age) values
('Minh Quan',10),('Ngoc Oanh',20),('Hong Ha',50);
insert into orders(c_id,o_date,o_totalprice) values
(1,str_to_date('3/21/2006','%c/%d/%Y'),150000),(2,str_to_date('3/23/2006','%c/%d/%Y'),200000),(1,str_to_date('3/16/2006','%c/%d/%Y'),170000);
insert into products(p_name,p_price) values
('May Giat',300),('Tu Lanh',500),('Dieu Hoa',700),('Quat',100),('Bep Dien',200),('May Hut Mui',500);
insert into order_detail(o_id,p_id,od_QTY) values
(1,1,3),(1,3,7),(1,4,2),(2,1,1),(3,1,8),(2,5,4),(2,3,3);

select c.*,o.o_totalprice from customer as c
inner join orders as o on c.c_id = o.c_id
where o.o_totalprice > 150000;

select * from products where p_id NOT IN (select p_id from order_detail); 
select * from orders
where o_id IN (select o_id as soluong from order_detail 
group by o_id
having count(o_id)>2);

select * from orders where o_totalprice = (select Max(o_totalprice) from orders);

select c_name,count(c_name) as totalBepdien 
from(
	select c.c_name from order_detail as od 
	inner join orders as o on o.o_id = od.o_id
	inner join customer as c on c.c_id = o.c_id
	inner join products as p on od.p_id = p.p_id
	where p.p_name LIKE '%MAY GIAT%'
) as bepdien
group by c_name 
order by totalBepdien desc limit 1



