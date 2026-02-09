SELECT * FROM category;

insert into category(name,description,isdeleted,createdby) values
('Sandwich','Sandwich',false,'1'),
('Pasta','Pasta',false,'1'),
('Sides and Appetizers','Sides and Appetizers',false,'1'),
('Salads','Salads',false,'1'),
('Dips and Sauces','Dips and Sauces',false,'1'),
('pizza','pizza',false,'1'),
('Desserts','Desserts',false,'1'),
('burger','burger',false,'1');



SELECT * FROM menuitem;


INSERT INTO menuitem ("name",categoryid,itemtype,rate,quantity,isavailable)
VALUES ('Vegitable Sandwich',1,'Veg',50.00,10,true),
('Chees Grill Sandwich',1,'Veg',100.00,12,true),
('Club Sandwich',1,'Veg',180.00,15,true),
('Italian Pizza',6,'Veg',300.00,8,true),
('Margerita Pizza',6,'Veg',250.00,12,true);



SELECT * FROM unit;

INSERT INTO unit ("name",shortname)
VALUES('Piece','Pc'),
('Small','Sm'),
('Medium','Md'),
('Large','Lg'),
('Gram','Gm'),
('Kilogram','Kg'),
('Mililiter','Ml');


SELECT * FROM modifiergroup;

INSERT INTO modifiergroup ("name",description,isdeleted)
VALUES ('Veggies','Veggies',FALSE),
('Crust Option','Crust Option',FALSE),
('Cheese Option','Cheese Option',FALSE),
('Sauce Option','Sauce Option',FALSE),
('Topping Options','Topping Options',FALSE),
('Size Options','Size Options',FALSE);


SELECT * FROM modifier;
INSERT INTO modifier ("name",rate,quantity,isdeleted,description,modifiergroupid,unitid)
VALUES('Regular',80,10,FALSE,'Regular Size',6,2),
('Medium',150,15,FALSE,'Medium Size',6,3),
('Large',300,10,FALSE,'Large Size',6,4),
('Capsicum',30,15,FALSE,'Capsicum',1,1),
('Tomato',20,15,FALSE,'Tomato',1,1),
('Onion',10,25,FALSE,'Onion',1,1),
('Baby Corn',25,12,FALSE,'Baby Corn',1,1),
('Mushrom',30,11,FALSE,'Mushrom',1,1),
('cheddar crus',40,15,FALSE,'cheddar crus',3,5),
('mozzarella',60,15,FALSE,'mozzarella',3,5),
('provolone',30,15,FALSE,'provolone',3,5),
('monty jack',66,15,FALSE,'monty jack',3,5),
('pepper jack',42,15,FALSE,'pepper jack',3,5),
('muenster',55,15,FALSE,'muenster',3,5),
('parmesan',48,15,FALSE,'parmesan',3,5);



INSERT INTO modifier ("name",rate,quantity,isdeleted,description,modifiergroupid,unitid) VALUES('Cabbage',10,50,FALSE,'Cabbage',1,1);


SELECT * FROM section;

INSERT INTO section (name,isdeleted,description,createdBy)
VALUES('Ground Floor',false,'Ground Floor',1),
('First Floor',false,'Ground Floor',1);



SELECT * FROM tables;

INSERT INTO tables (name,sectionid,capacity,status,isavailable,isdeleted,createdby)
VALUES('T1',1,6,'Occupied',true,false,1),
('T1',1,6,'Available',true,false,1),
('T2',1,6,'Available',true,false,1),
('T3',2,6,'Available',true,false,1),
('T1',2,6,'Occupied',true,false,1),
('T2',2,6,'Available',true,false,1);



INSERT INTO public.customer(
	id, name, email, phone, date, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Shyam', 'Shyam@gmail.com', '9988554477', '2025-03-25 15:03:05.217578', default, 'Admin', default, 'Admin');
INSERT INTO public.customer(
	id, name, email, phone, date, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Suman', 'Suman@gmail.com', '9988554478', '2025-03-25 15:03:15.217578', default, 'Admin', default, 'Admin');
INSERT INTO public.customer(
	id, name, email, phone, date, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Raj', 'Raj@gmail.com', '9988554479', '2025-03-25 15:03:25.217578', default, 'Admin', default, 'Admin');
INSERT INTO public.customer(
	id, name, email, phone, date, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Parthiv', 'Parthiv@gmail.com', '9988554470', '2025-03-25 15:03:35.217578', default, 'Admin', default, 'Admin');
INSERT INTO public.customer(
	id, name, email, phone, date, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Mudit', 'Mudit@gmail.com', '9988554487', '2025-03-25 15:03:45.217578', default, 'Admin', default, 'Admin');

select * from customer order by id;

INSERT INTO public.invoice(
	id, orderid, modifierid, quantityofmodifier, rateofmodifier, totalamount, createddate, createdby, updateddate, updatedby)
	VALUES (default, null, 1, 3, 30, 90, default, 'Admin', default, 'Admin');

INSERT INTO public.invoice(
	id, orderid, modifierid, quantityofmodifier, rateofmodifier, totalamount, createddate, createdby, updateddate, updatedby)
	VALUES (default, null, 2, 2, 20, 40, default, 'Admin', default, 'Admin');

INSERT INTO public.invoice(
	id, orderid, modifierid, quantityofmodifier, rateofmodifier, totalamount, createddate, createdby, updateddate, updatedby)
	VALUES (default, null, 3, 4, 20, 80, default, 'Admin', default, 'Admin');

INSERT INTO public.invoice(
	id, orderid, modifierid, quantityofmodifier, rateofmodifier, totalamount, createddate, createdby, updateddate, updatedby)
	VALUES (default, null, 4, 3, 50, 150, default, 'Admin', default, 'Admin');

select * from invoice;


SELECT * FROM payment;

INSERT INTO public.payment(
	id, method, amount, status, invoiceid, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Online', 200, 'Pending', 1, default, 'Admin', default, 'Admin');

INSERT INTO public.payment(
	id, method, amount, status, invoiceid, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Card', 300, 'In Progress', 2, default, 'admin', default, 'admin');

INSERT INTO public.payment(
	id, method, amount, status, invoiceid, createddate, createdby, updateddate, updatedby)
	VALUES (default, 'Cash', 213, 'Served', 3, default, 'Admin', default, 'Admin');

select * from payment;

INSERT INTO public."order"(
	id, customerid, subtotalamount, totalamount, tax, discount, notes, status, isgstselected, isdeleted, createddate, createdby, updateddate, updatedby, paymentid)
	VALUES (default, 1, 350, 392, 12, 0, 'extra vegitables','Pending', false, false, default, 'admin', default, 'admin', 1);

INSERT INTO public."order"(
	id, customerid, subtotalamount, totalamount, tax, discount, notes, status, isgstselected, isdeleted, createddate, createdby, updateddate, updatedby, paymentid)
	VALUES (default, 2, 750, 825, 10, 0, 'extra butter','In Progress', false, false, default, 'admin', default, 'admin', 2);

INSERT INTO public."order"(
	id, customerid, subtotalamount, totalamount, tax, discount, notes, status, isgstselected, isdeleted, createddate, createdby, updateddate, updatedby, paymentid)
	VALUES (default, 3, 120, 130, 8, 0, 'extra cheese','Served', false, false, default, 'admin', default, 'admin', 3);

select * from "order";
