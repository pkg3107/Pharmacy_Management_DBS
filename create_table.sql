drop table cart;
drop table substitutes;
drop table products;
drop table orders;
drop table seller;
drop table address;
drop table phoneNo_cust;
drop table customer;


create table customer (
custID integer primary key,
Fname varchar (20) not null,
Mname varchar (2),
Lname varchar (20),
sex varchar (1) not null,
email varchar (30) not null,
password varchar (20) not null,
constraint invalid_sex check (sex in ('M', 'F')));


create table phoneNo_cust (
customerID integer references customer (custID),
phoneNo integer);


create table address (
addName varchar (10),
ID integer not null, 
houseNo integer not null,
street varchar (20) not null,
city varchar (20) not null,
state varchar (20),
pin numeric(6),
constraint fk_add_cust foreign key (ID) references customer (custID),
constraint pk_address primary key(houseNo, street, city));


create table seller (
sellerID integer primary key,
storeAddress varchar (30),
contactNo integer);


create table orders (
customerID integer not null,
sellerID integer not null,
houseNo integer not null,
street varchar (20) not null,
city varchar (20) not null,
orderID integer primary key,
orderDate date,
oTime varchar(5), 
modeOf varchar (10),
total numeric (7,2),
constraint payMode check (modeOf in ('Cash', 'Card', 'UPI', 'NB')),
constraint timeIn check (oTime like '__:__'),
constraint fk_seller foreign key (sellerID) references seller (sellerID), 
constraint fk_cust foreign key (customerID) references customer (custID),
constraint fk_add foreign key (houseNo, street, city) references address (houseNo, street, city)); 


create table products (
prodID integer primary key,
manufacturer varchar (20),
name varchar (20),
mrp numeric (8,2) not null,
composition varchar (30));


create table substitutes (
prod integer references products (prodID),
subsID integer references products (prodID));


create table cart (
quantity integer not null,
productID integer,
ordId integer,
constraint fk_cartproduct foreign key (productID) references products (prodID),
constraint fk_cartorder foreign key (ordID) references orders (orderID),
constraint quant_check check (quantity>0));
