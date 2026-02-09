CREATE OR REPLACE PROCEDURE public.update_customer(
	IN customer_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  UPDATE customer
  SET 
  phone = customer_data->>'Phone',
  name = customer_data->>'Name',
  updateddate = (customer_data->>'Updateddate')::TimeStamp , 
  updatedby = customer_data->>'Updatedby'
  WHERE id = (customer_data->>'Id')::INT;
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.add_customer(
	IN customer_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  insert into customer (name,email,phone,date,createddate,createdby,updateddate,updatedby) values 
  (customer_data->>'Name',customer_data->>'Email',customer_data->>'Phone',(customer_data->>'Date')::TimeStamp,(customer_data->>'Createddate')::TimeStamp,customer_data->>'Createdby',(customer_data->>'Updateddate')::TimeStamp,customer_data->>'Updatedby');
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.add_waiting_token(
	IN waiting_token_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  insert into waitingtoken(customerid,isdeleted,isassigned,sectionid,noofpersons,createddate,createdby) values 
  ((waiting_token_data->>'Customerid')::INT,(waiting_token_data->>'Isdeleted')::boolean,(waiting_token_data->>'Isassigned')::boolean,(waiting_token_data->>'Sectionid')::INT,(waiting_token_data->>'Noofpersons')::INT,(waiting_token_data->>'Createddate')::TimeStamp,waiting_token_data->>'Createdby');
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.update_waiting_token(
	IN waiting_token_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  UPDATE waitingtoken
  SET
  isassigned = (waiting_token_data->>'Isassigned')::boolean,
  sectionid = (waiting_token_data->>'Sectionid')::int,
  noofpersons = (waiting_token_data->>'Noofpersons')::int,
  updateddate = (waiting_token_data->>'Updateddate')::TimeStamp , 
  updatedby = waiting_token_data->>'Updatedby'
  WHERE id = (waiting_token_data->>'Id')::INT;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.delete_waiting_token(
	IN waiting_token_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  UPDATE waitingtoken
  SET isdeleted = (waiting_token_data->>'Isdeleted')::boolean,
  updateddate = (waiting_token_data->>'Updateddate')::TimeStamp , 
  updatedby = waiting_token_data->>'Updatedby'
  WHERE id = (waiting_token_data->>'Id')::INT;
END;
$BODY$;




CREATE OR REPLACE PROCEDURE public.update_order_items(
	IN orderitem_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  UPDATE orderitem
  SET 
  menuitemid = (orderitem_data->>'Menuitemid')::INT,
  orderid = (orderitem_data->>'Orderid')::INT,
  status = orderitem_data->>'Status',
  comment = orderitem_data->>'Comment',
  name = orderitem_data->>'Name',
  quantity = (orderitem_data->>'Quantity')::INT,
  rate = (orderitem_data->>'Rate')::Numeric(10,2),
  amount = (orderitem_data->>'Amount')::Numeric(18,2),
  totalmodifieramount = (orderitem_data->>'Totalmodifieramount')::Numeric(18,2),
  tax = (orderitem_data->>'Tax')::Numeric,
  totalamount = (orderitem_data->>'Totalamount')::Numeric,
  instruction = orderitem_data->>'Instruction',
  readyitemquantity = (orderitem_data->>'Readyitemquantity')::INT,
  isdeleted = (orderitem_data->>'Isdeleted')::boolean,
  updateddate = (orderitem_data->>'Updateddate')::TimeStamp , 
  updatedby = orderitem_data->>'Updatedby'
  WHERE id = (orderitem_data->>'Id')::INT;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.add_order_item(
	IN orderitem_data json)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  INSERT INTO orderitem (menuitemid,orderid,status,"comment","name",quantity,rate,amount,totalmodifieramount,tax,totalamount,instruction,readyitemquantity,isdeleted,createdby,createddate,updateddate,updatedby)
  VALUES(
  (orderitem_data->>'Menuitemid')::INT,
(orderitem_data->>'Orderid')::INT,
(orderitem_data->>'Status'),
(orderitem_data->>'Comment'),
(orderitem_data->>'Name'),
(orderitem_data->>'Quantity')::INT,
(orderitem_data->>'Rate')::Numeric(10,2),
(orderitem_data->>'Amount')::Numeric(18,2),
(orderitem_data->>'Totalmodifieramount')::Numeric(18,2),
(orderitem_data->>'Tax')::Numeric,
(orderitem_data->>'Totalamount')::Numeric,
(orderitem_data->>'Instruction'),
(orderitem_data->>'Readyitemquantity')::INT,
(orderitem_data->>'Isdeleted')::boolean,
(orderitem_data->>'Createdby'),
(orderitem_data->>'Createddate')::TimeStamp,
(orderitem_data->>'Updateddate')::TimeStamp , 
(orderitem_data->>'Updatedby')
  );
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.orderitem_modifier_mapping(
	IN orderitem_modifier_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO orderitemmodifiermapping (modifierid,orderitemid,quantityofmodifier,rateofmodifier,totalamount,updatedby,updateddate,createdby,createddate,isdeleted)
	VALUES(
	(orderitem_modifier_data->>'Modifierid')::INT,
	(orderitem_modifier_data->>'Orderitemid')::INT,
	(orderitem_modifier_data->>'Quantityofmodifier')::SMALLINT,
	(orderitem_modifier_data->>'Rateofmodifier')::Numeric,
	(orderitem_modifier_data->>'Totalamount')::Numeric,
	(orderitem_modifier_data->>'Updatedby'),
	(orderitem_modifier_data->>'Updateddate')::TimeStamp,
	(orderitem_modifier_data->>'Createdby'),
	(orderitem_modifier_data->>'Createddate')::TimeStamp,
	(orderitem_modifier_data->>'Isdeleted')::boolean
	);
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.add_order_tax_mapping(
	IN order_tax_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO ordertaxmapping(orderid,taxid,taxvalue,createdby,createddate,updatedby,updateddate,isdeleted)
	VALUES(
	(order_tax_data->>'Orderid')::INT,
	(order_tax_data->>'Taxid')::INT,
	(order_tax_data->>'Taxvalue')::Numeric,
	(order_tax_data->>'Createdby'),
	(order_tax_data->>'Createddate')::TimeStamp,
	(order_tax_data->>'Updatedby'),
	(order_tax_data->>'Updateddate')::TimeStamp,
	(order_tax_data->>'Isdeleted')::boolean
	);
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.update_order_tax_mapping(
	IN order_tax_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE ordertaxmapping
	SET
	orderid = (order_tax_data->>'Orderid')::INT,
	taxid = (order_tax_data->>'Taxid')::INT,
	taxvalue = (order_tax_data->>'Taxvalue')::Numeric,
	createdby = (order_tax_data->>'Createdby'),
	createddate = (order_tax_data->>'Createddate')::TimeStamp,
	updatedby = (order_tax_data->>'Updatedby'),
	updateddate = (order_tax_data->>'Updateddate')::TimeStamp,
	isdeleted = (order_tax_data->>'Isdeleted')::boolean
	WHERE id = (order_tax_data->>'Id')::INT;
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.create_order(
	IN order_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	INSERT INTO "order" (customerid,notes,paymentid,status,subtotalamount,tax,totalamount,isgstselected,isdeleted,discount,createdby,createddate,updatedby,updateddate)
	VALUES(
	(order_data->>'Customerid')::INT,
	(order_data->>'Notes'),
	(order_data->>'Paymentid')::INT,
	(order_data->>'Status'),
	(order_data->>'Subtotalamount')::Numeric,
	(order_data->>'Tax')::Numeric,
	(order_data->>'Totalamount')::Numeric,
	(order_data->>'Isgstselected')::boolean,
	(order_data->>'Isdeleted')::boolean,
	(order_data->>'Discount')::Numeric,
	(order_data->>'Createdby'),
	(order_data->>'Createddate')::TimeStamp,
	(order_data->>'Updatedby'),
	(order_data->>'Updateddate')::TimeStamp
	);
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.update_order(
	IN order_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	UPDATE "order" SET
	customerid = (order_data->>'Customerid')::INT,
	notes = (order_data->>'Notes'),
	paymentid = (order_data->>'Paymentid')::INT,
	status =  (order_data->>'Status'),
	subtotalamount = (order_data->>'Subtotalamount')::Numeric,
	tax = (order_data->>'Tax')::Numeric,
	totalamount =(order_data->>'Totalamount')::Numeric,
	isgstselected =(order_data->>'Isgstselected')::boolean,
	isdeleted = (order_data->>'Isdeleted')::boolean,
	discount = (order_data->>'Discount')::Numeric,
	createdby =(order_data->>'Createdby'),
	createddate = (order_data->>'Createddate')::TimeStamp,
	updatedby = (order_data->>'Updatedby'),
	updateddate = (order_data->>'Updateddate')::TimeStamp
	WHERE id = (order_data->>'Id')::INT;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.add_payment(
	IN payment_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	INSERT INTO payment ("method",amount,invoiceid,status,createdby,createddate,updatedby,updateddate)
	VALUES(
	(payment_data->>'Method'),
	(payment_data->>'Amount')::Numeric,
	(payment_data->>'Invoiceid')::INT,
	(payment_data->>'Status'),
	(payment_data->>'Createdby'),
	(payment_data->>'Createddate')::TimeStamp,
	(payment_data->>'Updatedby'),
	(payment_data->>'Updateddate')::TimeStamp
	);
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.create_invoice(
	IN invoice_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	INSERT INTO invoice (orderid,createdby,createddate,updatedby,updateddate)
	VALUES(
	(invoice_data->>'Orderid')::INT,
	(invoice_data->>'Createdby'),
	(invoice_data->>'Createddate')::TimeStamp,
	(invoice_data->>'Updatedby'),
	(invoice_data->>'Updateddate')::TimeStamp
	);
END;
$BODY$;



CREATE OR REPLACE PROCEDURE public.add_table_order_mapping(
	IN mapping_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	INSERT INTO tableordermapping (noofpersons,orderid,tableid,isdeleted,createdby,createddate,updatedby,updateddate)
	VALUES(
	(mapping_data->>'Noofpersons')::INT,
	(mapping_data->>'Orderid')::INT,
	(mapping_data->>'Tableid')::INT,
	(mapping_data->>'Isdeleted')::boolean,
	(mapping_data->>'Createdby'),
	(mapping_data->>'Createddate')::TimeStamp,
	(mapping_data->>'Updatedby'),
	(mapping_data->>'Updateddate')::TimeStamp
	);
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.update_table(
	IN table_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	UPDATE "tables" SET
	"name" = (table_data->>'Name'),
	capacity = (table_data->>'Capacity')::INT,
	isavailable = (table_data->>'Isavailable')::boolean,
	sectionid = (table_data->>'Sectionid')::INT,
	status = (table_data->>'Status'),
	isdeleted = (table_data->>'Isdeleted')::boolean,
	createdby = (table_data->>'Createdby'),
	createddate = (table_data->>'Createddate')::TimeStamp,
	updatedby = (table_data->>'Updatedby'),
	updateddate = (table_data->>'Updateddate')::TimeStamp
	WHERE id = (table_data->>'Id')::INT;
END;
$BODY$;


CREATE OR REPLACE PROCEDURE public.add_customer_feedback(
	IN feedback_data JSON)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN 
	INSERT INTO feedback ("comment",ambience,service,food,avgrating,orderid,createdby,createddate,updatedby,updateddate)
	VALUES(
	(feedback_data->>'Comment'),
	(feedback_data->>'Ambience')::SMALLINT,
	(feedback_data->>'Service')::SMALLINT,
	(feedback_data->>'Food')::SMALLINT,
	(feedback_data->>'Avgrating')::Numeric,
	(feedback_data->>'Orderid')::INT,
	(feedback_data->>'Createdby'),
	(feedback_data->>'Createddate')::TimeStamp,
	(feedback_data->>'Updatedby'),
	(feedback_data->>'Updateddate')::TimeStamp
	);
END;
$BODY$;
